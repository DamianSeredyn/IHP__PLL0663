import numpy as np
import matplotlib.pyplot as plt
import glob
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')

# Usuń stare pliki
for f in glob.glob(os.path.join(RESULTS_DIR, 'cp_*.png')):
    os.remove(f)
if os.path.exists(os.path.join(RESULTS_DIR, 'cp_report.html')):
    os.remove(os.path.join(RESULTS_DIR, 'cp_report.html'))

files = sorted(glob.glob(os.path.join(DATA_DIR, 'cp_parsed_*.txt')))
if not files:
    print("Brak plików cp_parsed_*.txt w", DATA_DIR)
    exit(1)

def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p.replace('T', '') for p in parts if p.startswith('T')), '?')
    vp = next((p.replace('Vp', '') for p in parts if p.startswith('Vp')), '?')
    return corner, temp, vp

def make_plot(filepath):
    tag = os.path.basename(filepath).replace('cp_parsed_', '').replace('.txt', '')
    corner, temp, vp = parse_tag(tag)

    data = np.loadtxt(filepath, skiprows=1)
    # Kolumny: 0:time, 1:vout, 2:biasn, 3:i_viup, 4:i_vidn
    time = data[:, 0] * 1e6          # µs
    vout = data[:, 1]
    biasn = data[:, 2]
    i_viup = data[:, 3] * 1e9       # A -> µA
    i_vidn = data[:, 4] * 1e9        # A -> µA

    # Średnie z ostatniej 1/4 czasu
    n = len(time)
    q = n - n // 4
    avg_vout = np.mean(vout[q:])
    avg_biasn = np.mean(biasn[q:])
    avg_i_viup = np.mean(i_viup[q:])
    avg_i_vidn = np.mean(i_vidn[q:])

    avgs = {
        'vout': avg_vout,
        'biasn': avg_biasn,
        'i_Viup': avg_i_viup,
        'i_Vidn': avg_i_vidn
    }

    # Wykresy
    fig, axes = plt.subplots(4, 1, figsize=(12, 10), sharex=True)
    fig.suptitle(f'Charge Pump — {corner}  T={temp}°C  Vp={vp}V', fontsize=14)

    axes[0].plot(time, vout, 'b', linewidth=1)
    axes[0].set_ylabel('Vout [V]')
    axes[0].set_title('Napięcie wyjściowe')
    axes[0].grid(True, alpha=0.3)

    axes[1].plot(time, biasn, 'r', linewidth=1)
    axes[1].set_ylabel('V(biasn) [V]')
    axes[1].set_title('Napięcie polaryzacji')
    axes[1].grid(True, alpha=0.3)

    axes[2].plot(time, i_viup, 'g', linewidth=1)
    axes[2].set_ylabel('i(Viup) [µA]')
    axes[2].set_title('Prąd źródła Viup')
    axes[2].grid(True, alpha=0.3)

    axes[3].plot(time, i_vidn, 'm', linewidth=1)
    axes[3].set_ylabel('i(Vidn) [µA]')
    axes[3].set_title('Prąd źródła Vidn')
    axes[3].set_xlabel('Czas [µs]')
    axes[3].grid(True, alpha=0.3)

    plt.tight_layout(rect=[0, 0, 1, 0.96])
    out_path = os.path.join(RESULTS_DIR, f'cp_{tag}.png')
    plt.savefig(out_path, dpi=150)
    plt.close()
    print(f"Zapisano wykres: {out_path}")
    return tag, corner, temp, vp, avgs

summary = []
for filepath in files:
    tag, corner, temp, vp, avgs = make_plot(filepath)
    summary.append((tag, corner, temp, vp, avgs))

# Sortowanie
corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
summary.sort(key=lambda x: (corner_order.get(x[1], 99), float(x[2]), float(x[3])))

# HTML
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
for tag, corner, temp, vp, avgs in summary:
    label = f'{corner} T{temp} {vp}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'

def fmt(val, decimals=4):
    return f"{val:.{decimals}f}"

summary_rows = ''
current_corner = None
for tag, corner, temp, vp, avgs in summary:
    if corner != current_corner:
        current_corner = corner
        summary_rows += f'<tr class="corner-header"><td colspan="6"><b>{corner}</b></td></tr>\n'
    summary_rows += f'''
        <tr>
            <td>{temp} °C</td>
            <td>{vp} V</td>
            <td>{fmt(avgs["vout"])}</td>
            <td>{fmt(avgs["biasn"])}</td>
            <td>{fmt(avgs["i_Viup"])}</td>
            <td>{fmt(avgs["i_Vidn"])}</td>
            <td><a href="#" onclick="showTabById(\'{tag}\'); return false;">Zobacz wykres</a></td>
        </tr>
    '''

html_panels = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie – Charge Pump PVT</h2>
    <p style="font-size:12px;color:#666;">Średnie z ostatniej 1/4 czasu symulacji</p>
    <table class="summary">
        <thead>
            <tr>
                <th>Temp</th>
                <th>Vp</th>
                <th>Vout [V]</th>
                <th>V(biasn) [V]</th>
                <th>i(Viup) [µA]</th>
                <th>i(Vidn) [µA]</th>
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
    <h2>{corner} — T={temp}°C — Vp={vp}V</h2>
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
