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
DATA_DIR    = os.path.join(PROJECT_DIR, 'charge_pump/results_mc/data')
RESULTS_DIR = os.path.join(PROJECT_DIR, 'charge_pump/results_mc')

UP_DN_THRESHOLD = 0.5

data_files = sorted(
    glob.glob(os.path.join(DATA_DIR, 'cp_mc_data_mc_*.txt')),
    key=lambda p: int(re.search(r'mc_(\d+)\.txt', p).group(1))
)
if not data_files:
    print(f"BLAD: brak plikow cp_mc_data_mc_*.txt w {DATA_DIR}")
    raise SystemExit(1)


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
    return (d[:, 0], d[:, 1], d[:, 3], d[:, 5], d[:, 7], d[:, 9], d[:, 11], d[:, 13])


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


def time_avg_window(values, time_vec, mask):

    t_win = time_vec[mask]
    v_win = values[mask]
    if len(t_win) < 2:
        return float(np.mean(v_win)) if len(v_win) else float('nan')
    trapz_fn = getattr(np, 'trapezoid', None) or np.trapz
    return float(trapz_fn(v_win, t_win) / (t_win[-1] - t_win[0]))


def robust_range(arr, lo_pct=1, hi_pct=99, pad_frac=0.10):
   
    lo = float(np.percentile(arr, lo_pct))
    hi = float(np.percentile(arr, hi_pct))
    span = hi - lo
    pad = span * pad_frac if span > 0 else max(abs(hi), 1e-9)
    lo_view, hi_view = lo - pad, hi + pad
    n_outside = int(np.sum((arr < lo_view) | (arr > hi_view)))
    return lo_view, hi_view, n_outside


iup_list = []
idn_list = []
iref_list = []
pct_list = []          # rozbieznosc surowa (juz niezalezna od skali - patrz docstring)
ratio_up_list = []     # Iup / Iref tej samej iteracji
ratio_dn_list = []     # Idn / Iref tej samej iteracji
run_ids = []

for fpath in data_files:
    m = re.search(r'mc_(\d+)\.txt', fpath)
    run_id = int(m.group(1))
    try:
        time, vout, vbias, i_iref, i_iup, i_idn, v_up, v_dn = read_data(fpath)
    except Exception as exc:
        print(f"  pominieto run {run_id}: {exc}")
        continue

    time_us = time * 1e6
    i_iref_uA = i_iref * 1e6
    i_iup_uA = i_iup * 1e6
    i_idn_uA = i_idn * 1e6

    up_active = v_up > UP_DN_THRESHOLD
    dn_active = v_dn > UP_DN_THRESHOLD

    iup_avg = time_avg_active(i_iup_uA, time_us, up_active)
    idn_avg = time_avg_active(i_idn_uA, time_us, dn_active)

    # Iref - sygnal ciagly (nie impulsowy), usredniony z ostatnich 20% symulacji
    # (stan ustalony), niezaleznie od dokladnej dlugosci tran
    steady_mask = time_us >= (0.8 * time_us.max())
    iref_avg = time_avg_window(i_iref_uA, time_us, steady_mask)

    if np.isnan(iup_avg) or np.isnan(idn_avg) or np.isnan(iref_avg):
        print(f"  UWAGA: run {run_id} ma NaN w iup/idn/iref, pomijam")
        continue
    if iref_avg == 0:
        print(f"  UWAGA: run {run_id} ma Iref=0, pomijam (dzielenie przez zero)")
        continue

    abs_iup, abs_idn = abs(iup_avg), abs(idn_avg)
    denom = max(abs_iup, abs_idn)
    pct = (abs_iup - abs_idn) / denom * 100 if denom != 0 else 0.0

    iup_list.append(iup_avg)
    idn_list.append(idn_avg)
    iref_list.append(iref_avg)
    pct_list.append(pct)
    ratio_up_list.append(iup_avg / iref_avg)
    ratio_dn_list.append(idn_avg / iref_avg)
    run_ids.append(run_id)

if not pct_list:
    print("BLAD: brak poprawnych wynikow do analizy")
    raise SystemExit(1)

iup_arr = np.array(iup_list)
idn_arr = np.array(idn_list)
iref_arr = np.array(iref_list)
pct_arr = np.array(pct_list)
ratio_up_arr = np.array(ratio_up_list)
ratio_dn_arr = np.array(ratio_dn_list)
n = len(pct_arr)

# korelacja rozbieznosci % z poziomem Iref - czy mismatch zalezy od punktu pracy
corr_pct_iref = float(np.corrcoef(pct_arr, iref_arr)[0, 1]) if n > 1 else float('nan')

stats = {
    'n':          n,
    'iup_mean':   float(np.mean(iup_arr)),
    'iup_std':    float(np.std(iup_arr)),
    'idn_mean':   float(np.mean(idn_arr)),
    'idn_std':    float(np.std(idn_arr)),
    'iref_mean':  float(np.mean(iref_arr)),
    'iref_std':   float(np.std(iref_arr)),
    'pct_mean':   float(np.mean(pct_arr)),
    'pct_std':    float(np.std(pct_arr)),
    'pct_min':    float(np.min(pct_arr)),
    'pct_max':    float(np.max(pct_arr)),
    'pct_3sigma': float(np.mean(pct_arr) + 3 * np.std(pct_arr)),
    'corr_pct_iref': corr_pct_iref,
}

print(f"N = {stats['n']}")
print(f"Iup:  mean={stats['iup_mean']:.4f} uA, std={stats['iup_std']:.4f} uA")
print(f"Idn:  mean={stats['idn_mean']:.4f} uA, std={stats['idn_std']:.4f} uA")
print(f"Iref: mean={stats['iref_mean']:.4f} uA, std={stats['iref_std']:.4f} uA")
print(f"Rozbieznosc [%]: mean={stats['pct_mean']:.2f}, std={stats['pct_std']:.2f}, "
      f"min={stats['pct_min']:.2f}, max={stats['pct_max']:.2f}, "
      f"3-sigma={stats['pct_3sigma']:.2f}")
print(f"Korelacja rozbieznosc[%] vs Iref: {stats['corr_pct_iref']:.3f} "
      f"(blisko 0 = mismatch NIE zalezy od punktu pracy, "
      f"|>0.3| = zauwazalna zaleznosc)")

iup_lo, iup_hi, iup_n_out = robust_range(iup_arr)
idn_lo, idn_hi, idn_n_out = robust_range(idn_arr)
print(f"Iup: {iup_n_out} pkt poza widocznym zakresem wykresu ({iup_lo:.4f} .. {iup_hi:.4f} uA)")
print(f"Idn: {idn_n_out} pkt poza widocznym zakresem wykresu ({idn_lo:.4f} .. {idn_hi:.4f} uA)")
if iup_n_out > 0 or idn_n_out > 0:
    print("  UWAGA: powyzsze punkty NIE sa usuniete z danych/statystyk (tabela")
    print("  i stats powyzej licza sie z pelnego zbioru) - sa tylko przyciete")
    print("  z WIDOKU wykresu, zeby reszta rozkladu byla czytelna. Jesli to")
    print("  wiecej niz pojedyncze iteracje, warto sprawdzic ich logi ngspice.")

# ---------------------------------------------------------------------------
# Wykres 1 : histogram rozbieznosci Iup vs Idn
# ---------------------------------------------------------------------------
fig_pct, ax_pct = plt.subplots(figsize=(8, 5.5))
ax_pct.hist(pct_arr, bins=30, color='#2ca02c', alpha=0.8, edgecolor='white')
ax_pct.axvline(stats['pct_mean'], color='k', linestyle='--', linewidth=1.2, label='mean')
ax_pct.axvline(stats['pct_mean'] + 3 * stats['pct_std'], color='r', linestyle=':', linewidth=1.2, label='+3sigma')
ax_pct.axvline(stats['pct_mean'] - 3 * stats['pct_std'], color='b', linestyle=':', linewidth=1.2, label='-3sigma')
ax_pct.set_title(f"Rozbieznosc Iup vs Idn [%]  (mean={stats['pct_mean']:.2f}, std={stats['pct_std']:.2f}, "
                  f"3-sigma={stats['pct_3sigma']:.2f}%)", fontsize=12)
ax_pct.set_xlabel('(|Iup|-|Idn|)/max * 100 [%]')
ax_pct.set_ylabel('liczba iteracji')
ax_pct.legend(fontsize=9)
ax_pct.grid(True, alpha=0.3)
plt.tight_layout()
pct_hist_path = os.path.join(RESULTS_DIR, 'mc_pct_histogram.png')
plt.savefig(pct_hist_path, dpi=140, bbox_inches='tight')
plt.close()

# ---------------------------------------------------------------------------
# Wykres 2: Iup/Idn 
# ---------------------------------------------------------------------------
combined_lo, combined_hi, combined_n_out = robust_range(np.concatenate([iup_arr, idn_arr]))
bins = np.linspace(combined_lo, combined_hi, 31)

fig_iu, (ax_iu, ax_raw) = plt.subplots(1, 2, figsize=(15, 5.5))

ax_iu.hist(iup_arr, bins=bins, color='#ff7f0e', alpha=0.55, edgecolor='white', label='Iup')
ax_iu.hist(idn_arr, bins=bins, color='#9467bd', alpha=0.55, edgecolor='white', label='Idn')
ax_iu.axvline(stats['iup_mean'], color='#ff7f0e', linestyle='--', linewidth=1.2)
ax_iu.axvline(stats['idn_mean'], color='#9467bd', linestyle='--', linewidth=1.2)
ax_iu.set_title(f"Iup (mean={stats['iup_mean']:.3f}, std={stats['iup_std']:.3f})  vs  "
                 f"Idn (mean={stats['idn_mean']:.3f}, std={stats['idn_std']:.3f})  [uA]",
                 fontsize=11)
ax_iu.set_xlabel('Prad [uA]')
ax_iu.set_ylabel('liczba iteracji')
ax_iu.legend(fontsize=9)
ax_iu.grid(True, alpha=0.3)

ax_raw.scatter(iup_arr, idn_arr, s=12, alpha=0.6, color='#1f77b4')
lims = [min(iup_arr.min(), idn_arr.min()), max(iup_arr.max(), idn_arr.max())]
ax_raw.plot(lims, lims, 'k--', linewidth=1, label='Iup = Idn (idealne)')
ax_raw.set_xlim(iup_lo, iup_hi)
ax_raw.set_ylim(idn_lo, idn_hi)
ax_raw.set_xlabel('Iup [uA]')
ax_raw.set_ylabel('Idn [uA]')
ax_raw.set_title('Iup vs Idn\n(dryf referencji)')
ax_raw.legend(fontsize=9)
ax_raw.grid(True, alpha=0.3)

plt.tight_layout()
iupidn_hist_path = os.path.join(RESULTS_DIR, 'mc_iup_idn_histogram.png')
plt.savefig(iupidn_hist_path, dpi=140, bbox_inches='tight')
plt.close()

# ---------------------------------------------------------------------------
# Wykres 3: znormalizowany 
# ---------------------------------------------------------------------------
ratio_up_lo, ratio_up_hi, ratio_up_n_out = robust_range(ratio_up_arr)
ratio_dn_lo, ratio_dn_hi, ratio_dn_n_out = robust_range(ratio_dn_arr)

fig3, (ax2, ax3) = plt.subplots(1, 2, figsize=(13, 5.5))

ax2.scatter(ratio_up_arr, ratio_dn_arr, s=12, alpha=0.6, color='#2ca02c')
lims2 = [min(ratio_up_arr.min(), ratio_dn_arr.min()), max(ratio_up_arr.max(), ratio_dn_arr.max())]
ax2.plot(lims2, lims2, 'k--', linewidth=1, label='Iup/Iref = Idn/Iref (idealne)')
ax2.set_xlim(ratio_up_lo, ratio_up_hi)
ax2.set_ylim(ratio_dn_lo, ratio_dn_hi)
ax2.set_xlabel('Iup / Iref (tej samej iteracji)')
ax2.set_ylabel('Idn / Iref (tej samej iteracji)')
ax2.set_title('Znormalizowane wzgledem Iref\n')
ax2.legend(fontsize=9)
ax2.grid(True, alpha=0.3)

ax3.scatter(iref_arr, pct_arr, s=14, alpha=0.6, color='#d62728')
ax3.axhline(0, color='k', linewidth=0.8)
ax3.set_xlabel('Iref [uA] (tej samej iteracji)')
ax3.set_ylabel('Rozbieznosc Iup vs Idn [%]')
ax3.set_title(f'Rozbieznosc vs punkt pracy\n(korelacja r={stats["corr_pct_iref"]:.3f})')
ax3.grid(True, alpha=0.3)

plt.tight_layout()
scatter_row_path = os.path.join(RESULTS_DIR, 'mc_scatter_row.png')
plt.savefig(scatter_row_path, dpi=140, bbox_inches='tight')
plt.close()

# ---------------------------------------------------------------------------
# Raport HTML
# ---------------------------------------------------------------------------
html_out = os.path.join(RESULTS_DIR, 'mc_report.html')

html = f'''<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="utf-8">
<title>Charge pump - Monte Carlo schematic (mismatch)</title>
<style>
body {{ font-family: Arial, sans-serif; font-size: 14px; margin: 20px; color: #111; }}
h1 {{ font-size: 18px; }}
h2 {{ font-size: 15px; margin-top: 28px; }}
table {{ border-collapse: collapse; margin-bottom: 24px; }}
td, th {{ border: 1px solid #ccc; padding: 4px 10px; text-align: right; }}
th {{ background: #eee; }}
td:first-child, th:first-child {{ text-align: left; }}
img {{ max-width: 100%; border: 1px solid #ccc; margin-bottom: 20px; }}
.note {{ background: #fff8e1; padding: 10px 14px; border-left: 3px solid #f0ad4e; margin-bottom: 20px; }}
</style>
</head>
<body>
<h1>Charge pump - Monte Carlo schematic (mos_tt_mismatch)</h1>
<p>N = {stats['n']} iteracji.
Iup/Idn liczone srednia wazona czasem tylko gdy odpowiedni
sygnal UP/DN jest aktywny. Iref usredniony w ostatnich 20%
symulacji.</p>

<table>
<tr><th>Wielkosc</th><th>srednia</th><th>odchylenie std</th><th>min</th><th>max</th></tr>
<tr><td>Iup [uA]</td><td>{stats['iup_mean']:.4f}</td><td>{stats['iup_std']:.4f}</td>
    <td>{iup_arr.min():.4f}</td><td>{iup_arr.max():.4f}</td></tr>
<tr><td>Idn [uA]</td><td>{stats['idn_mean']:.4f}</td><td>{stats['idn_std']:.4f}</td>
    <td>{idn_arr.min():.4f}</td><td>{idn_arr.max():.4f}</td></tr>
<tr><td>Iref [uA]</td><td>{stats['iref_mean']:.4f}</td><td>{stats['iref_std']:.4f}</td>
    <td>{iref_arr.min():.4f}</td><td>{iref_arr.max():.4f}</td></tr>
<tr><td>Rozbieznosc [%]</td><td>{stats['pct_mean']:.2f}</td><td>{stats['pct_std']:.2f}</td>
    <td>{stats['pct_min']:.2f}</td><td>{stats['pct_max']:.2f}</td></tr>
</table>
<p><b>Rozbieznosc 3-sigma (worst-case estymacja):</b> {stats['pct_3sigma']:.2f}%</p>
<p><b>Korelacja rozbieznosci [%] z Iref:</b> r = {stats['corr_pct_iref']:.3f}
({'BRAK zaleznosci od punktu pracy' if abs(stats['corr_pct_iref']) < 0.3 else 'WYRAZNA zaleznosc od punktu pracy - patrz wykres nizej'})</p>

<h2>Rozbieznosc Iup vs Idn</h2>
<img src="mc_pct_histogram.png">

<h2>Iup/Idn - wspolny histogram oraz surowy scatter</h2>
<img src="mc_iup_idn_histogram.png">

<h2>Znormalizowany (Iup/Iref vs Idn/Iref) oraz rozbieznosc vs Iref</h2>
<img src="mc_scatter_row.png">

</body>
</html>
'''

with open(html_out, 'w', encoding='utf-8') as fh:
    fh.write(html)

print(f"\nZapisano raport: {html_out}")
