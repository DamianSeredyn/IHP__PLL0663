#!/usr/bin/env python3
r"""
table_op_layout_schematic.py
Wersja dla netlisty SCHEMATOWEJ (bez ekstrakcji). Identyczna logika jak
table_op_layout.py, inne nazwy wektorów: XM3/XM17/XM18, v(x1.bias).
Wiersze dla Vout = 0.2 V i 1.0 V są w całości szare.

UWAGA: format linii "print" w ngspice to zwykle "nazwa_wektora = wartość".
Jeśli parsowanie zwraca same None, sprawdź log ręcznie, np.:
    grep -i "bias\|xm3\|xm17\|xm18" results_op_schematic/logs/ngspice_op_sch_*.log | head -20
"""

import glob
import os
import re

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))
LOG_DIR     = os.path.join(PROJECT_DIR, 'charge_pump/results_op_schematic/logs')
RESULTS_DIR = os.path.join(PROJECT_DIR, 'charge_pump/results_op_schematic')

# Nazwy wektorów, dokładnie takie jak SIG_* w run_op_sweep_schematic.sh
VEC_VOUT  = 'vout'
VEC_VBIAS = 'x1.bias'
VEC_IREF  = r'x1\.xm12\.nsg13_lv_pmos\[ids\]'
VEC_IUP   = r'x1\.xm5\.nsg13_lv_pmos\[ids\]'
VEC_IDN   = r'x1\.xm13\.nsg13_lv_nmos\[ids\]'

html_out = os.path.join(RESULTS_DIR, 'cp_op_schematic_report.html')
if os.path.exists(html_out):
    os.remove(html_out)

log_files = sorted(glob.glob(os.path.join(LOG_DIR, 'ngspice_op_sch_*.log')))
if not log_files:
    print(f"BLAD: brak plikow ngspice_op_sch_*.log w {LOG_DIR}")
    raise SystemExit(1)

CORNER_ORDER = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}


def to_float(s):
    """Konwertuje tag z nazwy pliku na liczbe: '0p2', '0,2', '1.0', 'm40' -> float.
    Zwraca None gdy sie nie da."""
    if s is None:
        return None
    t = str(s).strip().replace(',', '.')
    neg = False
    if re.match(r'^[mM]\d', t):      # 'm40' -> -40
        neg = True
        t = t[1:]
    t = t.replace('p', '.').replace('P', '.')
    try:
        v = float(t)
    except ValueError:
        return None
    return -v if neg else v


def parse_tag(filename):
    basename = os.path.basename(filename)
    m = re.search(r'ngspice_op_sch_(.+)_T(.+)_Vp(.+)_Vout(.+)\.log', basename)
    if not m:
        return None
    return m.group(1), m.group(2), m.group(3), m.group(4)


def extract_value(text, vecname):
    # dopasowanie "nazwa = wartosc", z anchorem zeby nie zlapac vecname jako
    # fragmentu dluzszej nazwy (np. "vout" wewnatrz "x1.vout.t0")
    pattern = r'(?<![\w.])' + re.escape(vecname) + r'(?![\w.])\s*=?\s*([\-+0-9]*\.?[0-9]+(?:[eE][\-+]?[0-9]+)?)'
    m = re.search(pattern, text)
    return float(m.group(1)) if m else None


def extract_current(text, vecpattern):
    # vecpattern to juz gotowy regex (fragment @device[ids]), nie literal
    pattern = vecpattern + r'\s*=?\s*([\-+0-9]*\.?[0-9]+(?:[eE][\-+]?[0-9]+)?)'
    m = re.search(pattern, text)
    return float(m.group(1)) if m else None


rows = []
missing_count = 0

for fpath in log_files:
    parsed = parse_tag(fpath)
    if not parsed:
        continue
    corner, temp, vp, vout_target = parsed

    with open(fpath, 'r', errors='ignore') as fh:
        text = fh.read()

    vout_meas = extract_value(text, VEC_VOUT)
    vbias     = extract_value(text, VEC_VBIAS)
    iref      = extract_current(text, VEC_IREF)
    iup       = extract_current(text, VEC_IUP)
    idn       = extract_current(text, VEC_IDN)

    if None in (vout_meas, vbias, iref, iup, idn):
        missing_count += 1

    rows.append((corner, temp, vp, vout_target, vout_meas, vbias, iref, iup, idn))

if missing_count:
    print(f"UWAGA: {missing_count} z {len(rows)} wierszy ma brakujace wartosci "
          f"- sprawdz format 'print' w logu (patrz docstring skryptu).")


def _num(s):
    v = to_float(s)
    return v if v is not None else float('inf')


rows.sort(key=lambda r: (CORNER_ORDER.get(r[0], 99), _num(r[1]), _num(r[2]), _num(r[3])))


def fmt(v, d=4):
    if v is None:
        return '-'
    return f"{v:.{d}f}"


def fmt_uA(v):
    if v is None:
        return '-'
    return f"{v * 1e6:.4f}"


def pct_diff(idn, iup):
    # Rozbieżność ZE ZNAKIEM: (|Iup| - |Idn|) / max(|Idn|,|Iup|) * 100.
    # Dodatnia -> Iup > Idn. Ujemna -> Idn > Iup.
    if idn is None or iup is None:
        return None
    abs_idn = abs(idn)
    abs_iup = abs(iup)
    denom = max(abs_idn, abs_iup)
    if denom == 0:
        return None
    return (abs_iup - abs_idn) / denom * 100


GRAY_BG = '#e0e0e0'
GRAY_VOUT_VALUES = (0.2, 1.0)
GRAY_TOL = 1e-6


def is_gray_vout(vout_t):
    v = to_float(vout_t)
    if v is None:
        return False
    return any(abs(v - gv) < GRAY_TOL for gv in GRAY_VOUT_VALUES)


def fmt_pct_cell(idn, iup, force_gray=False):
    val = pct_diff(idn, iup)
    if force_gray:
        style = f' style="background:{GRAY_BG};"'
        return f'<td{style}>{"-" if val is None else f"{val:.2f}"}</td>'
    if val is None:
        return '<td>-</td>'
    if val > 2:
        style = ' style="background:#f8d0d0;"'   # czerwone: Iup > Idn o >2%
    elif val < -2:
        style = ' style="background:#cfe0f7;"'   # niebieskie: Idn > Iup o >2%
    else:
        style = ''
    return f'<td{style}>{val:.2f}</td>'


NCOLS = 9

rows_html = ''
current_corner = None
for corner, temp, vp, vout_t, vout_m, vbias, iref, iup, idn in rows:
    if corner != current_corner:
        current_corner = corner
        rows_html += f'<tr class="corner-header"><td colspan="{NCOLS}"><b>{corner}</b></td></tr>\n'
    gray = is_gray_vout(vout_t)
    td_style = f' style="background:{GRAY_BG};"' if gray else ''
    rows_html += (
        f'<tr>'
        f'<td{td_style}>{temp}</td><td{td_style}>{vp}</td><td{td_style}>{vout_t}</td>'
        f'<td{td_style}>{fmt(vout_m)}</td><td{td_style}>{fmt(vbias)}</td>'
        f'<td{td_style}>{fmt_uA(iref)}</td><td{td_style}>{fmt_uA(iup)}</td><td{td_style}>{fmt_uA(idn)}</td>'
        f'{fmt_pct_cell(idn, iup, force_gray=gray)}'
        f'</tr>\n'
    )

html = f'''<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="utf-8">
<title>Charge pump (schematic) - punkt pracy (op), sweep PVT + Vout</title>
<style>
body {{ font-family: Arial, sans-serif; font-size: 14px; margin: 20px; color: #111; }}
h1 {{ font-size: 18px; }}
table {{ border-collapse: collapse; }}
td, th {{ border: 1px solid #ccc; padding: 4px 8px; text-align: right; }}
th {{ background: #eee; }}
tr.corner-header td {{ background: #dce8f5; text-align: left; }}
</style>
</head>
<body>
<h1>Charge pump (schematic) - punkt pracy (op), sweep corner x T x Vp x Vout</h1>
<table>
<thead>
<tr>
  <th>T [C]</th><th>Vp [V]</th><th>Vout zadane [V]</th>
  <th>Vout zmierzone [V]</th><th>Vbias [V]</th>
  <th>Iref [uA]</th><th>Iup [uA]</th><th>Idn [uA]</th><th>Rozbieżność [%]</th>
</tr>
</thead>
<tbody>
{rows_html}
</tbody>
</table>
</body>
</html>
'''

with open(html_out, 'w', encoding='utf-8') as fh:
    fh.write(html)

print(f"Zapisano raport: {html_out}")
print(f"Wierszy: {len(rows)}")
