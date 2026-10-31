#!/usr/bin/env python3
"""
plot_cp_layout.py
Wykresy + raport HTML dla symulacji cornerów PVT na netliście post-layout (PEX).

Plik danych (wrdata) zawiera 5 sygnałów -> 10 kolumn (para: skala_czasu, wartosc):
  col0=time col1=vout
  col2=time col3=vbias
  col4=time col5=i_iref   (M9)
  col6=time col7=i_iup    (M17, suma pradow drenow X19+X50 - liczona w bashu)
  col8=time col9=i_idn    (M18)

Srednie w tabeli/opisie liczone w oknie czasowym AVG_T_MIN..AVG_T_MAX (w us),
a nie z ostatniej cwiartki symulacji jak wczesniej.
"""

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os
import re

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))
DATA_DIR    = os.path.join(PROJECT_DIR, 'charge_pump/results_layout/data')
RESULTS_DIR = os.path.join(PROJECT_DIR, 'charge_pump/results_layout')

# Okno czasowe do usredniania iup/idn (w mikrosekundach)
AVG_T_MIN = 275.0
AVG_T_MAX = 295.0

for f in glob.glob(os.path.join(RESULTS_DIR, 'cp_layout_*.png')):
    os.remove(f)
html_out = os.path.join(RESULTS_DIR, 'cp_layout_report.html')
if os.path.exists(html_out):
    os.remove(html_out)

data_files = sorted(glob.glob(os.path.join(DATA_DIR, 'cp_layout_data_*.txt')))
if not data_files:
    print(f"BLAD: brak plikow cp_layout_data_*.txt w {DATA_DIR}")
    raise SystemExit(1)

CORNER_ORDER = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}


def parse_tag(filename):
    basename = os.path.basename(filename)
    m = re.search(r'cp_layout_data_(.+)_T(.+)_Vp(.+)\.txt', basename)
    return m.group(1), m.group(2), m.group(3)


def read_data(filepath):
    rows = []
    with open(filepath, 'r') as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                vals = [float(v) for v in line.split()]
                if len(vals) >= 10:
                    rows.append(vals[:10])
            except ValueError:
                pass
    if not rows:
        raise ValueError(f"Brak danych numerycznych: {filepath}")
    d = np.array(rows)
    return d[:, 0], d[:, 1], d[:, 3], d[:, 5], d[:, 7], d[:, 9]


summary = []

for fpath in data_files:
    corner, temp, vp = parse_tag(fpath)
    tag = f"{corner}_T{temp}_Vp{vp}"
    print(f"Przetwarzam: {tag}")

    try:
        time, vout, vbias, i_iref, i_iup, i_idn = read_data(fpath)
    except Exception as exc:
        print(f"  pominieto: {exc}")
        continue

    time_us = time * 1e6
    i_iref_uA = i_iref * 1e6
    i_iup_uA = i_iup * 1e6
    i_idn_uA = i_idn * 1e6

    # Okno usredniania 275-295us (zamiast ostatniej cwiartki symulacji)
    mask = (time_us >= AVG_T_MIN) & (time_us <= AVG_T_MAX)
    if not np.any(mask):
        print(f"  UWAGA: brak probek w oknie {AVG_T_MIN}-{AVG_T_MAX}us dla {tag}, "
              f"uzywam calego przebiegu jako fallback")
        mask = np.ones_like(time_us, dtype=bool)

    avgs = {
        'vout':  float(np.mean(vout[mask])),
        'vbias': float(np.mean(vbias[mask])),
        'iref':  float(np.mean(i_iref_uA[mask])),
        'iup':   float(np.mean(i_iup_uA[mask])),
        'idn':   float(np.mean(i_idn_uA[mask])),
    }
    summary.append((tag, corner, temp, vp, avgs))

    fig, axes = plt.subplots(4, 1, figsize=(11, 12), sharex=True)
    fig.suptitle(f'{corner}  T={temp}C  Vp={vp}V', fontsize=12)

    axes[0].plot(time_us, vout, color='#1f77b4', linewidth=1)
    axes[0].set_ylabel('V(out) [V]')
    axes[0].grid(True, alpha=0.3)

    axes[1].plot(time_us, vbias, color='#d62728', linewidth=1)
    axes[1].set_ylabel('V(vbias) [V]')
    axes[1].grid(True, alpha=0.3)

    axes[2].plot(time_us, i_iref_uA, color='#2ca02c', linewidth=1, label='iref (M9)')
    axes[2].plot(time_us, i_iup_uA, color='#ff7f0e', linewidth=1, label='iup (M17 = X19+X50)')
    axes[2].plot(time_us, i_idn_uA, color='#9467bd', linewidth=1, label='idn (M18)')
    axes[2].set_ylabel('I [uA]')
    axes[2].legend(fontsize=9)
    axes[2].grid(True, alpha=0.3)

    # Panel 4 - tylko iup vs idn, skala osi Y liczona z zakresu percentyli
    # (5-95%), a nie min/max - piki ladowania/rozladowania wychodza wtedy
    # poza widoczny zakres, zamiast splaszczac caly wykres wokol typowych wartosci.
    axes[3].plot(time_us, i_iup_uA, color='#ff7f0e', linewidth=1.2, label='iup (X19+X50)')
    axes[3].plot(time_us, i_idn_uA, color='#9467bd', linewidth=1.2, label='idn (M18)')
    combined = np.concatenate([i_iup_uA, i_idn_uA])
    lo = np.percentile(combined, 5)
    hi = np.percentile(combined, 95)
    span = hi - lo
    pad = span * 0.15 if span > 0 else max(abs(hi), 1e-6)
    axes[3].set_ylim(lo - pad, hi + pad)
    axes[3].axvspan(AVG_T_MIN, AVG_T_MAX, color='gray', alpha=0.15)
    axes[3].set_ylabel('I [uA]')
    axes[3].set_xlabel('Czas [us]')
    axes[3].legend(fontsize=9)
    axes[3].grid(True, alpha=0.3)

    plt.tight_layout(rect=[0, 0, 1, 0.95])
    out_img = os.path.join(RESULTS_DIR, f'cp_layout_{tag}.png')
    plt.savefig(out_img, dpi=140, bbox_inches='tight')
    plt.close()

summary.sort(key=lambda x: (CORNER_ORDER.get(x[1], 99), float(x[2]), float(x[3])))


def fmt(v, d=4):
    return f"{v:.{d}f}"


rows_html = ''
for tag, corner, temp, vp, a in summary:
    rows_html += (
        f'<tr>'
        f'<td>{corner}</td><td>{temp}</td><td>{vp}</td>'
        f'<td>{fmt(a["vout"])}</td><td>{fmt(a["vbias"])}</td>'
        f'<td>{fmt(a["iref"], 3)}</td><td>{fmt(a["iup"], 3)}</td><td>{fmt(a["idn"], 3)}</td>'
        f'<td><a href="#" onclick="show(\'{tag}\');return false;">wykres</a></td>'
        f'</tr>\n'
    )

panels_html = ''
tabs_html = ''
for tag, corner, temp, vp, a in summary:
    tabs_html += f'<a href="#" onclick="show(\'{tag}\');return false;">{corner} T{temp} Vp{vp}</a>\n'
    panels_html += f'''
<div id="{tag}" class="panel">
  <p>{corner} | T={temp}C | Vp={vp}V | srednie liczone w oknie {AVG_T_MIN}-{AVG_T_MAX}us:
     V(out)={fmt(a["vout"])}V, V(vbias)={fmt(a["vbias"])}V,
     Iref={fmt(a["iref"],3)}uA, Iup={fmt(a["iup"],3)}uA (X19+X50), Idn={fmt(a["idn"],3)}uA</p>
  <img src="cp_layout_{tag}.png">
</div>
'''

html = f'''<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="utf-8">
<title>Charge Pump - post-layout PVT</title>
<style>
body {{ font-family: Arial, sans-serif; font-size: 14px; margin: 20px; color: #111; }}
h1 {{ font-size: 18px; }}
table {{ border-collapse: collapse; margin-bottom: 24px; }}
td, th {{ border: 1px solid #ccc; padding: 4px 8px; text-align: right; }}
th {{ background: #eee; }}
td:first-child, th:first-child {{ text-align: left; }}
.tabs {{ margin-bottom: 16px; }}
.tabs a {{ margin-right: 10px; font-size: 12px; }}
.panel {{ display: none; }}
.panel.active {{ display: block; }}
img {{ max-width: 900px; border: 1px solid #ccc; }}
</style>
</head>
<body>
<h1>Charge pump - post-layout, sweep PVT</h1>
<p>Srednie prady Iup/Idn liczone w oknie {AVG_T_MIN}-{AVG_T_MAX}us (zaznaczone szarym pasem na wykresach).
Iup = suma pradow drenow X19 + X50.</p>

<table>
<thead>
<tr><th>Corner</th><th>T [C]</th><th>Vp [V]</th><th>Vout [V]</th><th>Vbias [V]</th>
<th>Iref [uA]</th><th>Iup [uA]</th><th>Idn [uA]</th><th></th></tr>
</thead>
<tbody>
{rows_html}
</tbody>
</table>

<div class="tabs">{tabs_html}</div>
{panels_html}

<script>
function show(id) {{
  document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
  document.getElementById(id).classList.add('active');
}}
</script>
</body>
</html>
'''

with open(html_out, 'w', encoding='utf-8') as fh:
    fh.write(html)

print(f"Zapisano raport: {html_out}")
print(f"Wygenerowano wykresow: {len(summary)}")
