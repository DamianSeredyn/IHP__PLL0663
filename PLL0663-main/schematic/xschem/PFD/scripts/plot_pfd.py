import numpy as np
import matplotlib.pyplot as plt
import glob
import os

data_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../results/data')
results_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../results')
files = sorted(glob.glob(os.path.join(data_dir, 'pfd_linearity_*.txt')))

if not files:
    print("Brak plikow w", data_dir)
    exit(1)

T = 31.25e-6

def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p.replace('T','') for p in parts if p.startswith('T')), '?')
    vp = next((p.replace('Vp','') for p in parts if p.startswith('Vp')), '?')
    return corner, temp, vp

def load_file(filepath):
    data = []
    with open(filepath) as f:
        next(f)
        for line in f:
            parts = line.strip().split()
            if len(parts) == 3:
                try:
                    dly = float(parts[0].replace('u','e-6'))
                    pw_up = float(parts[1])
                    pw_down = float(parts[2])
                    data.append((dly, pw_up, pw_down))
                except:
                    continue
    if len(data) == 0:
        return None, None, None, None
    data = np.array(data)
    dly   = data[:,0]
    pw_up = data[:,1]
    pw_dn = data[:,2]
    delta = pw_up - pw_dn
    phi_deg = (dly / T - 0.5) * 360
    idx = np.argsort(phi_deg)
    return phi_deg[idx], delta[idx], pw_up[idx], pw_dn[idx]

def compute_stats(phi_deg, delta, vp):
    scale = float(vp) / 2.0
    delta_ideal_at_sim = phi_deg / 180.0 * scale
    error_abs = np.abs(delta - delta_ideal_at_sim)
    mask = np.abs(phi_deg) < 160
    error_clean = error_abs[mask]
    phi_clean = phi_deg[mask]
    return {
        'scale': scale,
        'error_abs': error_clean,
        'phi_clean': phi_clean,
        'max_error': np.max(error_clean)*1000,
        'min_error': np.min(error_clean)*1000,
        'avg_error': np.mean(error_clean)*1000,
        'max_error_pct': np.max(error_clean/scale*100),
        'min_error_pct': np.min(error_clean/scale*100),
        'avg_error_pct': np.mean(error_clean/scale*100),
        'rms_error': np.sqrt(np.mean(error_clean**2))*1000,
    }

def make_plot(phi_deg, delta, pw_up, pw_dn, stats, tag, out_path):
    corner, temp, vp = parse_tag(tag)
    phi_ideal = np.linspace(-180, 180, 1000)
    delta_ideal = phi_ideal / 180.0 * stats['scale']

    fig = plt.figure(figsize=(14, 10))
    fig.suptitle(f'PFD Charakterystyka — {tag}', fontsize=13, fontweight='bold')

    ax1 = fig.add_subplot(2, 2, 1)
    ax1.plot(phi_deg, delta*1000, 'o-', color='royalblue',
             linewidth=2, markersize=4, label='PFD symulacja')
    ax1.plot(phi_ideal, delta_ideal*1000, '--', color='tomato',
             linewidth=1.5, label='Idealna PFD')
    ax1.axhline(0, color='gray', linewidth=0.8, linestyle=':')
    ax1.axvline(0, color='gray', linewidth=0.8, linestyle=':')
    ax1.set_xlabel('Roznica faz [deg]')
    ax1.set_ylabel('UP - DOWN [mV avg]')
    ax1.set_title('Charakterystyka liniowosci PFD')
    ax1.set_xticks(range(-180, 181, 45))
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    ax2 = fig.add_subplot(2, 2, 2)
    ax2.plot(phi_deg, pw_up*1000, 'o-', color='green',
             linewidth=2, markersize=4, label='avg UP')
    ax2.plot(phi_deg, pw_dn*1000, 's-', color='orange',
             linewidth=2, markersize=4, label='avg DOWN')
    ax2.axvline(0, color='gray', linewidth=0.8, linestyle=':')
    ax2.set_xlabel('Roznica faz [deg]')
    ax2.set_ylabel('Srednie napiecie [mV]')
    ax2.set_title('Srednie napiecie UP i DOWN vs faza')
    ax2.set_xticks(range(-180, 181, 45))
    ax2.legend()
    ax2.grid(True, alpha=0.3)

    ax3 = fig.add_subplot(2, 2, 3)
    ax3.plot(stats['phi_clean'], stats['error_abs']*1000, 'o-', color='purple',
             linewidth=2, markersize=4, label='|Blad|')
    ax3.axhline(0, color='gray', linewidth=0.8, linestyle=':')
    ax3.axvline(0, color='gray', linewidth=0.8, linestyle=':')
    ax3.fill_between(stats['phi_clean'], stats['error_abs']*1000, 0,
                     alpha=0.2, color='purple')
    ax3.set_xlabel('Roznica faz [deg]')
    ax3.set_ylabel('|Blad| [mV avg]')
    ax3.set_title('Blad bezwzgledny wzgledem idealnej')
    ax3.set_xticks(range(-180, 181, 45))
    ax3.legend()
    ax3.grid(True, alpha=0.3)

    ax4 = fig.add_subplot(2, 2, 4)
    ax4.axis('off')
    rows = [
        ['Corner',             corner],
        ['Temperatura [C]',    temp],
        ['Vp [V]',             vp],
        ['T [us]',             f'{T*1e6:.2f}'],
        ['Liczba punktow',     f'{len(phi_deg)}'],
        ['Max |blad| [mV]',    f'{stats["max_error"]:.3f}'],
        ['Min |blad| [mV]',    f'{stats["min_error"]:.3f}'],
        ['Avg |blad| [mV]',    f'{stats["avg_error"]:.3f}'],
        ['Max |blad| [%]',     f'{stats["max_error_pct"]:.2f}'],
        ['Avg |blad| [%]',     f'{stats["avg_error_pct"]:.2f}'],
        ['RMS blad [mV]',      f'{stats["rms_error"]:.3f}'],
    ]
    table = ax4.table(cellText=rows,
                      colLabels=['Parametr', 'Wartosc'],
                      cellLoc='center', loc='center',
                      colWidths=[0.6, 0.4])
    table.auto_set_font_size(False)
    table.set_fontsize(10)
    table.scale(1, 1.6)

    for i, row in enumerate(rows):
        if '%' in row[0]:
            try:
                val = float(row[1])
                if val > 10:
                    table[i+1, 1].set_facecolor('#ffcccc')
                elif val > 5:
                    table[i+1, 1].set_facecolor('#ffe5cc')
            except:
                pass

    ax4.set_title('Parametry symulacji i statystyki', pad=10)
    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()
    print(f"Zapisano: {out_path}")

# Zbierz dane
summary = []
for filepath in files:
    tag = os.path.basename(filepath).replace('pfd_linearity_','').replace('.txt','')
    phi_deg, delta, pw_up, pw_dn = load_file(filepath)
    if phi_deg is None:
        print(f"Pomijam (brak danych): {tag}")
        continue
    corner, temp, vp = parse_tag(tag)
    stats = compute_stats(phi_deg, delta, vp)
    out_path = os.path.join(results_dir, f'pfd_{tag}.png')
    make_plot(phi_deg, delta, pw_up, pw_dn, stats, tag, out_path)
    summary.append((tag, corner, temp, vp, stats))

corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
summary.sort(key=lambda x: (corner_order.get(x[1], 99), float(x[2]), float(x[3])))

def cell_color(pct):
    if pct > 10:
        return '#ffcccc'
    elif pct > 5:
        return '#ffe5cc'
    return '#ffffff'

# HTML
html_tabs = '<button class="tab active" onclick="showTab(\'summary\')">Podsumowanie</button>\n'
for tag, corner, temp, vp, stats in summary:
    label = f'{corner} T{temp} {vp}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\')">{label}</button>\n'

html_panels = ''

# Panel podsumowania
summary_rows = ''
current_corner = None
for tag, corner, temp, vp, stats in summary:
    max_pct = stats['max_error_pct']
    avg_pct = stats['avg_error_pct']
    if corner != current_corner:
        current_corner = corner
        summary_rows += f'<tr class="corner-header"><td colspan="7"><b>{corner}</b></td></tr>\n'
    summary_rows += f'''<tr>
        <td>{temp} °C</td>
        <td>{vp} V</td>
        <td>{stats["max_error"]:.2f}</td>
        <td>{stats["min_error"]:.2f}</td>
        <td>{stats["avg_error"]:.2f} ({avg_pct:.2f}%)</td>
        <td style="background:{cell_color(max_pct)};font-weight:bold">{max_pct:.2f}%</td>
        <td>{stats["rms_error"]:.2f}</td>
    </tr>'''

html_panels += f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie — blad liniowosci PFD</h2>
    <table class="summary">
        <thead><tr>
            <th>Temp</th><th>Vp</th>
            <th>Max |blad| [mV]</th><th>Min |blad| [mV]</th>
            <th>Avg |blad| [mV] (%)</th>
            <th>Max |blad| [%]</th><th>RMS [mV]</th>
        </tr></thead>
        <tbody>{summary_rows}</tbody>
    </table>
    <div class="legend">
        <span class="leg-ok">&#9632; OK (&lt;5%)</span>
        <span class="leg-warn">&#9632; Ostrzezenie (&gt;5%)</span>
        <span class="leg-err">&#9632; Przekroczenie (&gt;10%)</span>
    </div>
</div>'''

# Osobna zakladka na kazda kombinacje
for tag, corner, temp, vp, stats in summary:
    png_name = f'pfd_{tag}.png'
    pct = stats['max_error_pct']
    color = 'red' if pct > 10 else 'orange' if pct > 5 else 'green'
    inner = f'''
    <h2>{corner} — T={temp}°C — Vp={vp}V</h2>
    <div class="card">
        <h3>Max|blad|=<span style="color:{color};font-weight:bold">{pct:.2f}%</span></h3>
        <img src="{png_name}" style="max-width:100%">
    </div>'''
    html_panels += f'<div id="{tag}" class="panel">{inner}</div>\n'

html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>PFD Linearity Report</title>
<style>
    body {{ font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }}
    h1 {{ color: #222; }}
    h2 {{ color: #333; border-bottom: 2px solid #4a90d9; padding-bottom: 6px; }}
    h3 {{ color: #555; margin: 8px 0; }}
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
    .legend {{ margin-top: 12px; display: flex; gap: 20px; font-size: 13px; }}
    .leg-ok {{ color: #2a2; }}
    .leg-warn {{ color: #e80; }}
    .leg-err {{ color: #d00; }}
</style>
</head>
<body>
<h1>PFD Linearity Report</h1>
<div class="tabs">
{html_tabs}
</div>
{html_panels}
<script>
function showTab(id) {{
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.getElementById(id).classList.add('active');
    event.target.classList.add('active');
}}
</script>
</body>
</html>'''

html_path = os.path.join(results_dir, 'pfd_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
