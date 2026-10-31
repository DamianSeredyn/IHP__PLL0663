import numpy as np
import matplotlib.pyplot as plt
import glob
import os

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')

for f in glob.glob(os.path.join(RESULTS_DIR, 'cp_*.png')):
    os.remove(f)
if os.path.exists(os.path.join(RESULTS_DIR, 'cp_report.html')):
    os.remove(os.path.join(RESULTS_DIR, 'cp_report.html'))

print("Usunieto stare wykresy i html")

files = sorted(glob.glob(os.path.join(DATA_DIR, 'cp_parsed_*.txt')))

if not files:
    print("Brak plikow w", DATA_DIR)
    exit(1)

def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p.replace('T','') for p in parts if p.startswith('T')), '?')
    vp   = next((p.replace('Vp','') for p in parts if p.startswith('Vp')), '?')
    return corner, temp, vp

def make_plot(filepath):
    tag = os.path.basename(filepath).replace('cp_parsed_','').replace('.txt','')
    corner, temp, vp = parse_tag(tag)

    data  = np.loadtxt(filepath, skiprows=1)
    ncols = data.shape[1]

    # Kolumny bazowe (zawsze obecne)
    # 0:time  1:vout  2:i_vip  3:i_vin  4:v_bias_p  5:v_bias_n
    time      = data[:, 0] * 1e6
    vout      = data[:, 1]
    i_vip     = data[:, 2] * 1e6
    i_vin     = data[:, 3] * 1e6
    v_bias_p  = data[:, 4]
    v_bias_n  = data[:, 5]

    # Nowe kolumny -- obecne jesli parser je zapisal
    # 6:i_vdn2  7:i_vup2  8:i_vvp  9:v_up  10:v_dn
    i_vdn2 = data[:, 6] * 1e6 if ncols > 6  else None
    i_vup2 = data[:, 7] * 1e6 if ncols > 7  else None
    i_vvp  = data[:, 8] * 1e6 if ncols > 8  else None
    v_up   = data[:, 9]       if ncols > 9  else None
    v_dn   = data[:, 10]      if ncols > 10 else None

    # --- srednie z ostatniej 1/4 czasu symulacji ---
    n = len(time)
    q = n - n // 4

    avgs = {
        'vout':   np.mean(vout[q:]),
        'i_vip':  np.mean(i_vip[q:]),
        'i_vin':  np.mean(i_vin[q:]),
        'bias_p': np.mean(v_bias_p[q:]),
        'bias_n': np.mean(v_bias_n[q:]),
        'i_vdn2': np.mean(i_vdn2[q:]) if i_vdn2 is not None else None,
        'i_vup2': np.mean(i_vup2[q:]) if i_vup2 is not None else None,
        'i_vvp':  np.mean(i_vvp[q:])  if i_vvp  is not None else None,
    }

    # --- lista subplot-ow: bazowe + opcjonalne ---
    subplot_specs = [
        (vout,     'royalblue',  'Vout [V]',    'Napiecie wyjsciowe [V]'),
        (i_vip,    'green',      'i_vip [uA]',  'Prad i_vip'),
        (i_vin,    'orange',     'i_vin [uA]',  'Prad i_vin'),
    ]
    if v_up is not None:
        subplot_specs.append((v_up, 'purple',     'v_up [V]', 'Napiecie v(up)'))
    if v_dn is not None:
        subplot_specs.append((v_dn, 'darkorange', 'v_dn [V]', 'Napiecie v(dn)'))
    subplot_specs += [
        (v_bias_p, 'red',        'Napiecie [V]', 'Napiecie bias_p'),
        (v_bias_n, 'darkred',    'Napiecie [V]', 'Napiecie bias_n'),
    ]

    n_plots = len(subplot_specs)
    fig, axes = plt.subplots(n_plots, 1, figsize=(15, 3 * n_plots), sharex=False)
    if n_plots == 1:
        axes = [axes]

    fig.suptitle(f'Charge Pump — {corner} T={temp}°C Vp={vp}V', fontsize=13, fontweight='bold')

    for ax, (signal, color, ylabel, title) in zip(axes, subplot_specs):
        ax.plot(time, signal, color=color, linewidth=1)
        ax.set_ylabel(ylabel)
        ax.set_title(title)
        ax.set_xlabel('Czas [us]')
        ax.grid(True, alpha=0.3)
    plt.tight_layout(rect=[0, 0, 1, 0.96])

    out_path = os.path.join(RESULTS_DIR, f'cp_{tag}.png')
    plt.savefig(out_path, dpi=150)
    plt.close()
    print(f"Zapisano: {out_path}")
    return tag, corner, temp, vp, avgs

# --- generuj wykresy i zbierz dane ---
summary = []
for filepath in files:
    tag, corner, temp, vp, avgs = make_plot(filepath)
    summary.append((tag, corner, temp, vp, avgs))

corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
summary.sort(key=lambda x: (corner_order.get(x[1], 99), float(x[2]), float(x[3])))

# --- HTML ---
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
for tag, corner, temp, vp, avgs in summary:
    label = f'{corner} T{temp} {vp}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'

def fmt(val, decimals=4):
    return f"{val:.{decimals}f}" if val is not None else "&#8212;"

# panel podsumowania
summary_rows = ''
current_corner = None
for tag, corner, temp, vp, avgs in summary:
    if corner != current_corner:
        current_corner = corner
        summary_rows += (
            f'<tr class="corner-header"><td colspan="11"><b>{corner}</b></td></tr>\n'
        )
    summary_rows += f'''<tr>
        <td>{temp} °C</td>
        <td>{vp} V</td>
        <td>{fmt(avgs["vout"])}</td>
        <td>{fmt(avgs["i_vip"])}</td>
        <td>{fmt(avgs["i_vin"])}</td>
        <td>{fmt(avgs["bias_p"])}</td>
        <td>{fmt(avgs["bias_n"])}</td>
        <td>{fmt(avgs["i_vdn2"])}</td>
        <td>{fmt(avgs["i_vup2"])}</td>
        <td>{fmt(avgs["i_vvp"])}</td>
        <td><a href="#" onclick="showTabById(\'{tag}\'); return false;">Zobacz wykres</a></td>
    </tr>'''

html_panels = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie &mdash; Charge Pump PVT</h2>
    <p style="font-size:12px;color:#666;">Srednie z ostatniej 1/4 czasu symulacji</p>
    <table class="summary">
        <thead>
            <tr>
                <th>Temp</th>
                <th>Vp</th>
                <th>Vout [V]</th>
                <th>i_vip [&micro;A]</th>
                <th>i_vin [&micro;A]</th>
                <th>bias_p [V]</th>
                <th>bias_n [V]</th>
                <th>i_vdn2 [&micro;A]</th>
                <th>i_vup2 [&micro;A]</th>
                <th>i_vvp [&micro;A]</th>
                <th>Wykres</th>
            </tr>
        </thead>
        <tbody>{summary_rows}</tbody>
    </table>
</div>'''

for tag, corner, temp, vp, avgs in summary:
    png_name = f'cp_{tag}.png'
    html_panels += f'''
<div id="{tag}" class="panel">
    <h2>{corner} &mdash; T={temp}&deg;C &mdash; Vp={vp}V</h2>
    <div class="card">
        <img src="{png_name}" style="max-width:100%">
    </div>
</div>'''

html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Charge Pump Report</title>
<style>
    body {{ font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }}
    h1 {{ color: #222; }}
    h2 {{ color: #333; border-bottom: 2px solid #4a90d9; padding-bottom: 6px; }}
    .tabs {{ display: flex; flex-wrap: wrap; gap: 4px; margin-bottom: 16px; }}
    .tab {{ padding: 8px 14px; background: #ddd; border: none; cursor: pointer; border-radius: 4px; font-size: 12px; }}
    .tab:hover {{ background: #bbb; }}
    .tab.active {{ background: #4a90d9; color: white; }}
    .panel {{ display: none; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }}
    .panel.active {{ display: block; }}
    .card {{ margin-bottom: 30px; border: 1px solid #ddd; border-radius: 6px; padding: 12px; }}
    table.summary {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
    table.summary th {{ background: #4a90d9; color: white; padding: 8px; text-align: center; }}
    table.summary td {{ padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
    tr.corner-header td {{ background: #e8eef8; font-size: 14px; padding: 8px; text-align: left; }}
</style>
</head>
<body>
<h1>Charge Pump Report</h1>
<div class="tabs">
{html_tabs}
</div>
{html_panels}
<script>
function showTab(id, el) {{
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.getElementById(id).classList.add('active');
    if (el) el.classList.add('active');
}}
function showTabById(id) {{
    const btn = [...document.querySelectorAll('.tab')].find(t => t.getAttribute('onclick').includes("'" + id + "'"));
    showTab(id, btn);
}}
</script>
</body>
</html>'''

html_path = os.path.join(RESULTS_DIR, 'cp_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
print("Done.")