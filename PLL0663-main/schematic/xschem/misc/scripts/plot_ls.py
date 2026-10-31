import numpy as np
import matplotlib.pyplot as plt
import os

data_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../results/data')
results_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../results')
in_file = os.path.join(data_dir, 'ls_results.txt')

if not os.path.exists(in_file):
    print("Brak pliku", in_file)
    exit(1)

def load_file(filepath):
    rows = []
    with open(filepath) as f:
        next(f)  # header
        for line in f:
            parts = line.strip().split()
            if len(parts) != 6:
                continue
            corner, temp, vp, vph, vmax, vavg = parts
            try:
                rows.append({
                    'corner': corner,
                    'temp': float(temp),
                    'vp': float(vp),
                    'vph': float(vph),
                    'vout_max': float(vmax),
                    'vout_avg': float(vavg),
                })
            except ValueError:
                continue
    return rows

def compute_stats(row):
    vph = row['vph']
    vmax = row['vout_max']
    vavg = row['vout_avg']

    vmax_err = abs(vmax - vph)
    vmax_err_pct = (vmax_err / vph * 100) if vph != 0 else float('nan')

    duty = (vavg / vph * 100) if vph != 0 else float('nan')
    duty_err_pct = abs(duty - 50.0)

    row.update({
        'vmax_err': vmax_err,
        'vmax_err_pct': vmax_err_pct,
        'duty': duty,
        'duty_err_pct': duty_err_pct,
    })
    return row

def cell_color(pct):
    if pct > 10:
        return '#ffcccc'
    elif pct > 5:
        return '#ffe5cc'
    return '#ffffff'

def text_color(pct):
    if pct > 10:
        return '#d00'
    elif pct > 5:
        return '#e80'
    return '#2a2'

rows = load_file(in_file)
if not rows:
    print("Brak danych w", in_file)
    exit(1)

rows = [compute_stats(r) for r in rows]

corner_order_cache = {}
def corner_key(c):
    if c not in corner_order_cache:
        priority = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
        corner_order_cache[c] = priority.get(c, 99)
    return corner_order_cache[c]

rows.sort(key=lambda r: (corner_key(r['corner']), r['temp'], r['vp'], r['vph']))

# ---------- Wykres podsumowujacy (blad Vmax i duty cycle dla kazdego przypadku) ----------
labels = [f"{r['corner']}\nT{r['temp']:g} Vp{r['vp']:g} Vph{r['vph']:g}" for r in rows]
vmax_errs = [r['vmax_err_pct'] for r in rows]
duty_errs = [r['duty_err_pct'] for r in rows]
x = np.arange(len(rows))

fig, axes = plt.subplots(2, 1, figsize=(max(12, len(rows)*0.35), 10))

colors_vmax = ['#d00' if e > 10 else '#e80' if e > 5 else '#2a2' for e in vmax_errs]
axes[0].bar(x, vmax_errs, color=colors_vmax)
axes[0].axhline(5, color='orange', linestyle='--', linewidth=1)
axes[0].axhline(10, color='red', linestyle='--', linewidth=1)
axes[0].set_ylabel('Blad Vout_max vs Vph [%]')
axes[0].set_title('Blad amplitudy Vout_max wzgledem Vph')
axes[0].set_xticks(x)
axes[0].set_xticklabels(labels, rotation=90, fontsize=6)
axes[0].grid(True, alpha=0.3, axis='y')

colors_duty = ['#d00' if e > 10 else '#e80' if e > 5 else '#2a2' for e in duty_errs]
axes[1].bar(x, duty_errs, color=colors_duty)
axes[1].axhline(5, color='orange', linestyle='--', linewidth=1)
axes[1].axhline(10, color='red', linestyle='--', linewidth=1)
axes[1].set_ylabel('Blad Duty Cycle vs 50% [%]')
axes[1].set_title('Blad duty cycle wzgledem idealnych 50%')
axes[1].set_xticks(x)
axes[1].set_xticklabels(labels, rotation=90, fontsize=6)
axes[1].grid(True, alpha=0.3, axis='y')

plt.tight_layout()
png_path = os.path.join(results_dir, 'ls_summary.png')
plt.savefig(png_path, dpi=150)
plt.close()
print(f"Zapisano: {png_path}")

# ---------- HTML raport ----------
table_rows = ''
current_corner = None
for r in rows:
    if r['corner'] != current_corner:
        current_corner = r['corner']
        table_rows += f'<tr class="corner-header"><td colspan="8"><b>{current_corner}</b></td></tr>\n'
    table_rows += f'''<tr>
        <td>{r['temp']:g} &deg;C</td>
        <td>{r['vp']:g} V</td>
        <td>{r['vph']:g} V</td>
        <td>{r['vout_max']:.4f} V</td>
        <td style="background:{cell_color(r['vmax_err_pct'])};color:{text_color(r['vmax_err_pct'])};font-weight:bold">
            {r['vmax_err']:.4f} V ({r['vmax_err_pct']:.2f}%)
        </td>
        <td>{r['vout_avg']:.4f} V</td>
        <td>{r['duty']:.2f}%</td>
        <td style="background:{cell_color(r['duty_err_pct'])};color:{text_color(r['duty_err_pct'])};font-weight:bold">
            {r['duty_err_pct']:.2f} %
        </td>
    </tr>'''

worst_vmax = max(rows, key=lambda r: r['vmax_err_pct'])
worst_duty = max(rows, key=lambda r: r['duty_err_pct'])

html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Level Shifter Report</title>
<style>
    body {{ font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }}
    h1 {{ color: #222; }}
    h2 {{ color: #333; border-bottom: 2px solid #4a90d9; padding-bottom: 6px; }}
    .panel {{ background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); margin-bottom: 20px; }}
    table.summary {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
    table.summary th {{ background: #4a90d9; color: white; padding: 8px; text-align: center; }}
    table.summary td {{ padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
    tr.corner-header td {{ background: #e8eef8; font-size: 14px; padding: 8px; text-align: left; }}
    .legend {{ margin-top: 12px; display: flex; gap: 20px; font-size: 13px; }}
    .leg-ok {{ color: #2a2; }}
    .leg-warn {{ color: #e80; }}
    .leg-err {{ color: #d00; }}
    .worst {{ font-size: 13px; margin-bottom: 6px; }}
</style>
</head>
<body>
<h1>Level Shifter Report</h1>

<div class="panel">
    <h2>Podsumowanie</h2>
    <p class="worst"><b>Najwiekszy blad Vout_max:</b> {worst_vmax['corner']} T{worst_vmax['temp']:g} Vp{worst_vmax['vp']:g} Vph{worst_vmax['vph']:g}
        &rarr; <span style="color:{text_color(worst_vmax['vmax_err_pct'])};font-weight:bold">{worst_vmax['vmax_err_pct']:.2f}%</span></p>
    <p class="worst"><b>Najwiekszy blad Duty Cycle:</b> {worst_duty['corner']} T{worst_duty['temp']:g} Vp{worst_duty['vp']:g} Vph{worst_duty['vph']:g}
        &rarr; <span style="color:{text_color(worst_duty['duty_err_pct'])};font-weight:bold">{worst_duty['duty_err_pct']:.2f} pp</span></p>
    <div class="legend">
        <span class="leg-ok">&#9632; OK (&lt;5%)</span>
        <span class="leg-warn">&#9632; Ostrzezenie (&gt;5%)</span>
        <span class="leg-err">&#9632; Przekroczenie (&gt;10%)</span>
    </div>
</div>

<div class="panel">
    <h2>Wykres bledow dla wszystkich przypadkow</h2>
    <img src="ls_summary.png" style="max-width:100%">
</div>

<div class="panel">
    <h2>Tabela wynikow</h2>
    <table class="summary">
        <thead><tr>
            <th>Temp</th><th>Vp</th><th>Vph</th>
            <th>Vout_max</th><th>Blad Vout_max vs Vph</th>
            <th>Vout_avg</th><th>Duty Cycle</th><th>Blad Duty vs 50%</th>
        </tr></thead>
        <tbody>{table_rows}</tbody>
    </table>
</div>

</body>
</html>'''

html_path = os.path.join(results_dir, 'ls_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
