#!/usr/bin/env python3


import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os
import re

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))
DATA_DIR    = os.path.join(PROJECT_DIR, 'charge_pump/results_tran_sch/data')
RESULTS_DIR = os.path.join(PROJECT_DIR, 'charge_pump/results_tran_sch')

# Prog powyzej ktorego v(up)/v(dn) uznajemy za aktywny
UP_DN_THRESHOLD = 0.6

# Okno czasowe (w mikrosekundach) do usredniania Vout/Vbias/Iref
AVG_T_MIN, AVG_T_MAX = 90, 100

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
                if len(vals) >= 14:
                    rows.append(vals[:14])
            except ValueError:
                pass
    if not rows:
        raise ValueError(f"Brak danych numerycznych: {filepath}")
    d = np.array(rows)
    # time, vout, vbias, iref, iup, idn, v_up, v_dn
    return (d[:, 0], d[:, 1], d[:, 3], d[:, 5], d[:, 7], d[:, 9], d[:, 11], d[:, 13])


def time_avg(values, time_vec, mask):
    t_win = time_vec[mask]
    v_win = values[mask]
    if len(t_win) < 2:
        return float(np.mean(v_win)) if len(v_win) else float('nan')
    trapz_fn = getattr(np, 'trapezoid', None) or np.trapz
    return float(trapz_fn(v_win, t_win) / (t_win[-1] - t_win[0]))


def find_active_segments(active_mask):
    idx = np.where(active_mask)[0]
    if len(idx) < 2:
        return []
    breaks = np.where(np.diff(idx) != 1)[0]
    return [g for g in np.split(idx, breaks + 1) if len(g) >= 2]


def time_avg_active(values, time_vec, active_mask):
   
    trapz_fn = getattr(np, 'trapezoid', None) or np.trapz
    segments = find_active_segments(active_mask)
    if not segments:
        return float('nan')
    total_integral = 0.0
    total_duration = 0.0
    for g in segments:
        t_g = time_vec[g]
        v_g = values[g]
        total_integral += trapz_fn(v_g, t_g)
        total_duration += (t_g[-1] - t_g[0])
    if total_duration == 0:
        return float('nan')
    return total_integral / total_duration


summary = []

for fpath in data_files:
    corner, temp, vp = parse_tag(fpath)
    tag = f"{corner}_T{temp}_Vp{vp}"
    print(f"Przetwarzam: {tag}")

    try:
        time, vout, vbias, i_iref, i_iup, i_idn, v_up, v_dn = read_data(fpath)
    except Exception as exc:
        print(f"  pominieto: {exc}")
        continue

    time_us = time * 1e6
    i_iref_uA = i_iref * 1e6
    i_iup_uA = i_iup * 1e6
    i_idn_uA = i_idn * 1e6

    # okno stanu ustalonego dla Vout/Vbias/Iref
    win_mask = (time_us >= AVG_T_MIN) & (time_us <= AVG_T_MAX)
    if not np.any(win_mask):
        print(f"  UWAGA: brak probek w oknie {AVG_T_MIN}-{AVG_T_MAX}us dla {tag}, "
              f"uzywam calego przebiegu jako fallback")
        win_mask = np.ones_like(time_us, dtype=bool)

    up_active = v_up > UP_DN_THRESHOLD
    dn_active = v_dn > UP_DN_THRESHOLD

    avgs = {
        'vout':  time_avg(vout, time_us, win_mask),
        'vbias': time_avg(vbias, time_us, win_mask),
        'iref':  time_avg(i_iref_uA, time_us, win_mask),
        'iup':   time_avg_active(i_iup_uA, time_us, up_active),
        'idn':   time_avg_active(i_idn_uA, time_us, dn_active),
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

    axes[2].plot(time_us, i_iref_uA, color='#2ca02c', linewidth=1, label='iref')
    axes[2].plot(time_us, i_iup_uA, color='#ff7f0e', linewidth=1, label='iup')
    axes[2].plot(time_us, i_idn_uA, color='#9467bd', linewidth=1, label='idn')
    axes[2].set_ylabel('I [uA]')
    axes[2].legend(fontsize=9)
    axes[2].grid(True, alpha=0.3)

    axes[3].plot(time_us, i_iup_uA, color='#ff7f0e', linewidth=1.2, label='iup')
    axes[3].plot(time_us, i_idn_uA, color='#9467bd', linewidth=1.2, label='idn')
    combined = np.concatenate([i_iup_uA, i_idn_uA])
    lo = np.percentile(combined, 5)
    hi = np.percentile(combined, 95)
    span = hi - lo
    pad = span * 0.15 if span > 0 else max(abs(hi), 1e-6)
    axes[3].set_ylim(lo - pad, hi + pad)
    for mask_arr, color in ((up_active, '#ff7f0e'), (dn_active, '#9467bd')):
        for g in find_active_segments(mask_arr):
            axes[3].axvspan(time_us[g[0]], time_us[g[-1]], color=color, alpha=0.1)
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
    if v is None or (isinstance(v, float) and np.isnan(v)):
        return '-'
    return f"{v:.{d}f}"


def pct_diff(idn, iup):
    if idn is None or iup is None or np.isnan(idn) or np.isnan(iup):
        return None
    abs_idn = abs(idn)
    abs_iup = abs(iup)
    denom = max(abs_idn, abs_iup)
    if denom == 0:
        return None
    return (abs_iup - abs_idn) / denom * 100


def fmt_pct_cell(idn, iup):
    val = pct_diff(idn, iup)
    if val is None:
        return '<td>-</td>'
    if val > 5:
        style = ' style="background:#f8d0d0;"'
    elif val < -5:
        style = ' style="background:#cfe0f7;"'
    else:
        style = ''
    return f'<td{style}>{val:.2f}</td>'


rows_html = ''
for tag, corner, temp, vp, a in summary:
    rows_html += (
        f'<tr>'
        f'<td>{corner}</td><td>{temp}</td><td>{vp}</td>'
        f'<td>{fmt(a["vout"])}</td><td>{fmt(a["vbias"])}</td>'
        f'<td>{fmt(a["iref"], 3)}</td><td>{fmt(a["iup"], 3)}</td><td>{fmt(a["idn"], 3)}</td>'
        f'{fmt_pct_cell(a["idn"], a["iup"])}'
        f'<td><a href="#" onclick="show(\'{tag}\');return false;">wykres</a></td>'
        f'</tr>\n'
    )

panels_html = ''
tabs_html = ''
for tag, corner, temp, vp, a in summary:
    tabs_html += f'<a href="#" onclick="show(\'{tag}\');return false;">{corner} T{temp} Vp{vp}</a>\n'
    panels_html += f'''
<div id="{tag}" class="panel">
  <p>{corner} | T={temp}C | Vp={vp}V |
     V(out)={fmt(a["vout"])}V, V(vbias)={fmt(a["vbias"])}V (okno {AVG_T_MIN}-{AVG_T_MAX}us),
     Iref={fmt(a["iref"],3)}uA (okno {AVG_T_MIN}-{AVG_T_MAX}us),
     Iup={fmt(a["iup"],3)}uA,
     Idn={fmt(a["idn"],3)}uA </p>
  <img src="cp_layout_{tag}.png">
</div>
'''

html = f'''<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="utf-8">
<title>Charge Pump - tran PVT</title>
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
<h1>Charge pump - schematic, sweep PVT</h1>
<p>Vout/Vbias/Iref: srednia wazona czasem w oknie {AVG_T_MIN}-{AVG_T_MAX}us.
Iup/Idn: srednia wazona czasem (trapez), liczona tylko w oknach, gdy
odpowiednie zrodlo sterujace (UP/DN) jest aktywne </p>

<table>
<thead>
<tr><th>Corner</th><th>T [C]</th><th>Vp [V]</th><th>Vout [V]</th><th>Vbias [V]</th>
<th>Iref [uA]</th><th>Iup [uA]</th><th>Idn [uA]</th><th>Rozbieżność [%]</th><th></th></tr>
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
