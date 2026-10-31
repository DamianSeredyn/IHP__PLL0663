"""
==============================================================================
RAPORT MUX 8:1
------------------------------------------------------------------------------
  - mierzy czestotliwosc i duty cycle zegara wejsciowego clk,
  - dla 8 przedzialow czasu (wyznaczonych z V3/V4/V5 i zapisanych w
    mux_slots.json przez run_sweep_mux.sh) mierzy czestotliwosc i duty
    cycle wyjscia out,
  - w kazdym przedziale adres MUX-a wybiera inne wejscie, wiec na out
    spodziewamy sie clk / expected_div (clk, clk/2, ... clk/128).
  - galaz (przedzial) dostaje zielony ✓ gdy:
        zmierzony dzielnik = oczekiwany   ORAZ   duty cycle = 50% ±5%
    w przeciwnym razie czerwony ✗.
  - raport HTML zawiera tabele (podsumowanie po cornerach + szczegoly
    per kombinacja PVT). Bez wykresow.
==============================================================================
"""

import sys
import os
import glob
import json
import numpy as np

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')
os.makedirs(RESULTS_DIR, exist_ok=True)

SIM_NAME = 'mux'

# Kolejnosc MUSI sie zgadzac z linia wrdata w run_sweep_mux.sh:
#   wrdata <dat> v(clk) v(out)
SIGNAL_ORDER = ['clk', 'out']

DUTY_TARGET = 50.0      # %
DUTY_TOL    = 5.0       # % — warunek na zielony checkmark
DIV_REL_TOL = 0.10      # wzgledna tolerancja zgodnosci dzielnika


# ── Plan przedzialow z mux_slots.json ────────────────────────────────────────
def load_slots():
    path = os.path.join(DATA_DIR, 'mux_slots.json')
    if not os.path.exists(path):
        print(f"Brak {path} — uruchom najpierw run_sweep_mux.sh")
        sys.exit(1)
    with open(path) as f:
        plan = json.load(f)

    # Code -> division mapping (from MUX_8to1.sch):
    #   A2A1A0 = 111 -> in8 -> /128,  110 -> in7 -> /64, ... 001 -> in2 -> /2,  000 -> in1 -> /1
    for s in plan['slots']:
        addr = int(s['bits'], 2)
        s['addr'] = addr
        s['input'] = addr + 1
        s['expected_div'] = 2 ** addr
    return plan

# ── Wczytanie pliku .dat (format ngspice wrdata: pary t,sygnal) ───────────────
def load_dat(path):
    expected_cols = 2 * len(SIGNAL_ORDER)
    try:
        data = np.loadtxt(path, skiprows=1)
        if data.ndim < 2 or data.shape[1] < expected_cols:
            print(f"  [WARN] {path}: oczekiwano {expected_cols} kolumn, jest {data.shape}")
            return None
        out = {}
        for i, name in enumerate(SIGNAL_ORDER):
            out[f'time_{name}'] = data[:, 2 * i]
            out[name]          = data[:, 2 * i + 1]
        return out
    except Exception as e:
        print(f"  [WARN] Nie mozna odczytac {path}: {e}")
        return None


# ── Analiza sygnalu w zadanym oknie czasowym [t_lo, t_hi] ─────────────────────
def _crossings(t_arr, v_arr, level, direction):
    above = (v_arr >= level).astype(int)
    edges = np.diff(above)
    idxs  = np.where(edges == direction)[0]
    res = []
    for i in idxs:
        v0, v1 = v_arr[i], v_arr[i + 1]
        if v1 != v0:
            res.append(t_arr[i] + (level - v0) * (t_arr[i + 1] - t_arr[i]) / (v1 - v0))
    return np.array(res)


def analyze_window(time, voltage, t_lo, t_hi, vdd):
    """
    Zwraca (freq_hz, duty_pct) liczone na probkach z [t_lo, t_hi].
    None,None gdy sygnal nie przelacza albo za malo krawedzi.
    Czestotliwosc i duty usredniane po wszystkich okresach w oknie.
    """
    mask = (time >= t_lo) & (time <= t_hi)
    t = time[mask]
    v = voltage[mask]
    if len(t) < 4:
        return None, None

    vmin, vmax = float(v.min()), float(v.max())
    amp = vmax - vmin
    try:
        thr = 0.40 * float(vdd)
    except Exception:
        thr = 0.40
    if amp < max(0.10, thr):
        return None, None

    v50 = vmin + 0.5 * amp
    rising  = _crossings(t, v, v50, +1)
    falling = _crossings(t, v, v50, -1)

    if len(rising) < 2:
        return None, None

    period = float(np.mean(np.diff(rising)))
    if period <= 0:
        return None, None
    freq = 1.0 / period

    duties = []
    for k in range(len(rising) - 1):
        tr, tr_n = rising[k], rising[k + 1]
        f_after = falling[(falling > tr) & (falling < tr_n)]
        if len(f_after) == 0:
            continue
        per  = tr_n - tr
        high = f_after[0] - tr
        if per > 0 and 0 < high < per:
            duties.append(high / per)
    duty = 100.0 * float(np.mean(duties)) if duties else None
    return freq, duty


# ── Parsowanie taga (corner_Ttemp_Vpvdd) ──────────────────────────────────────
def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p[1:]  for p in parts
                 if p.startswith('T') and len(p) > 1
                 and p[1].lstrip('-').replace('.', '').isdigit()), '?')
    vp   = next((p[2:]  for p in parts if p.startswith('Vp')), '?')
    return corner, temp, vp


def eval_slot(freq_clk, freq_out, duty_out, expected_n):
    ratio = None
    ratio_int = None
    div_ok = False
    if freq_clk and freq_out and freq_out > 0:
        ratio = freq_clk / freq_out
        ratio_int = int(round(ratio))
        div_ok = abs(ratio - expected_n) <= DIV_REL_TOL * expected_n
    duty_ok = duty_out is not None and abs(duty_out - DUTY_TARGET) <= DUTY_TOL
    return {'ratio': ratio, 'ratio_int': ratio_int,
            'div_ok': div_ok, 'duty_ok': duty_ok,
            'passed': bool(div_ok and duty_ok)}


# ── Formatowanie ──────────────────────────────────────────────────────────────
def fmth(v, scale=1, unit='', dec=3):
    if v is None:
        return 'N/A'
    try:
        return f'{v * scale:.{dec}f} {unit}'.strip()
    except Exception:
        return 'N/A'


def duty_color(dc):
    if dc is None:
        return '#ffffff'
    try:
        d = abs(float(dc) - DUTY_TARGET)
        if d > 2 * DUTY_TOL:
            return '#ffcccc'
        elif d > DUTY_TOL:
            return '#ffe5cc'
    except Exception:
        pass
    return '#ffffff'


CHECK = '<span style="color:#1a9c1a;font-weight:bold;font-size:16px">&#10004;</span>'
CROSS = '<span style="color:#d00;font-weight:bold;font-size:16px">&#10008;</span>'


# ── Glowna petla ──────────────────────────────────────────────────────────────
plan = load_slots()
SLOTS = plan['slots']
W = plan['slot_width']
FLO = plan['meas_frac_lo']
FHI = plan['meas_frac_hi']

dat_files = sorted(glob.glob(os.path.join(DATA_DIR, f'{SIM_NAME}_*.dat')))
if not dat_files:
    print(f"Brak plikow .dat w {DATA_DIR}")
    sys.exit(1)

summary = []
total_files = len(dat_files)

for idx, filepath in enumerate(dat_files, 1):
    tag = os.path.basename(filepath).replace(f'{SIM_NAME}_', '').replace('.dat', '')
    corner, temp, vp = parse_tag(tag)
    d = load_dat(filepath)

    result = {'clk': None, 'slots': []}

    if d is not None:
        # clk — stabilny przez cala symulacje; mierzymy w szerokim oknie
        tmax = d['time_clk'][-1]
        f_clk, dc_clk = analyze_window(d['time_clk'], d['clk'],
                                       0.05 * tmax, 0.95 * tmax, vp)
        clk_duty_ok = dc_clk is not None and abs(dc_clk - DUTY_TARGET) <= DUTY_TOL
        result['clk'] = {'freq': f_clk, 'duty': dc_clk, 'duty_ok': clk_duty_ok}

        for s in SLOTS:
            t_lo = s['t0'] + FLO * W
            t_hi = s['t0'] + FHI * W
            f_out, dc_out = analyze_window(d['time_out'], d['out'], t_lo, t_hi, vp)
            if f_out is None:
                m = (d['time_out'] >= t_lo) & (d['time_out'] <= t_hi)
                v = d['out'][m]
                print(f"  [{tag}] slot {s['k']}: n={m.sum()} "
                      f"vmin={v.min():.3f} vmax={v.max():.3f}" if m.any()
                      else f"  [{tag}] slot {s['k']}: no samples")
            ev = eval_slot(f_clk, f_out, dc_out, s['expected_div'])
            ev.update({
                'k': s['k'], 't0': s['t0'], 't1': s['t1'],
                'bits': s['bits'], 'addr': s['addr'], 'input': s['input'],
                'expected_div': s['expected_div'],
                'expected_freq': (f_clk / s['expected_div']) if f_clk else None,
                'freq': f_out, 'duty': dc_out,
            })
            result['slots'].append(ev)

    summary.append((tag, corner, temp, vp, result))

    pct = idx * 100 // total_files
    print(f"\r{pct}% of report done", end='', flush=True)

print()

corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}


def _num(s):
    try:
        return float(s)
    except (ValueError, TypeError):
        return 0.0


summary.sort(key=lambda x: (corner_order.get(x[1], 99), _num(x[2]), _num(x[3])))


# ── Podsumowanie w terminalu ──────────────────────────────────────────────────
print()
current_corner = None
for tag, corner, temp, vp, res in summary:
    if corner != current_corner:
        current_corner = corner
        print(f'\n{corner}')
        print(f"  {'TEMP':>6}  {'VDD':>6}  {'f_clk':>11}  {'DC clk':>8}  {'OK slot':>8}")
        print('  ' + '-' * 48)
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    dc_clk = clk['duty'] if clk else None
    slots = res.get('slots', [])
    n_ok = sum(1 for s in slots if s['passed'])
    n_tot = len(SLOTS)
    print(f"  {temp+'C':>6}  {vp+'V':>6}  "
          f"{fmth(f_clk, 1e-6, 'MHz', 3):>11}  "
          f"{fmth(dc_clk, 1, '%', 1):>8}  "
          f"{f'{n_ok}/{n_tot}':>8}")
print()


# ── HTML: zakladki ────────────────────────────────────────────────────────────
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
for tag, corner, temp, vp, _ in summary:
    label = f'{corner} T{temp} {vp}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'


# ── HTML: tabela podsumowania ─────────────────────────────────────────────────
summary_rows = ''
current_corner = None
for tag, corner, temp, vp, res in summary:
    if corner != current_corner:
        current_corner = corner
        summary_rows += f'<tr class="corner-header"><td colspan="6"><b>{corner}</b></td></tr>\n'
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    dc_clk = clk['duty'] if clk else None
    slots = res.get('slots', [])
    n_ok = sum(1 for s in slots if s['passed'])
    n_tot = len(SLOTS)
    status = CHECK if n_ok == n_tot else CROSS
    summary_rows += f'''<tr>
        <td>{temp} °C</td><td>{vp} V</td>
        <td>{fmth(f_clk, 1e-6, "MHz", 3)}</td>
        <td style="background:{duty_color(dc_clk)} !important">{fmth(dc_clk, 1, "%", 1)}</td>
        <td>{n_ok} / {n_tot}</td>
        <td>{status}</td>
    </tr>'''

html_summary_panel = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie — MUX 8:1 po cornerach</h2>
    <table class="summary">
        <thead><tr>
            <th>TEMP</th><th>VDD</th>
            <th>f<sub>clk</sub></th><th>DC clk</th>
            <th>Przedzialy OK</th><th>Status</th>
        </tr></thead>
        <tbody>{summary_rows}</tbody>
    </table>
    <div class="legend">
        <span>{CHECK} przedzial spelnia wymagania (dzielnik + duty 50% ±{DUTY_TOL:.0f}%)</span>
        <span>{CROSS} nie spelnia</span>
    </div>
</div>'''


# ── HTML: panele szczegolowe (tabela 8 przedzialow na kombinacje PVT) ─────────
def slot_table(res):
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    dc_clk = clk['duty'] if clk else None

    rows = ''
    clk_status = CHECK if (clk and clk['duty_ok']) else CROSS
    rows += f'''<tr class="clk-row">
        <td>clk</td><td>—</td>
        <td><b>clk (we)</b></td><td>—</td><td>÷1</td>
        <td>{fmth(f_clk, 1e-6, "MHz", 4)}</td>
        <td>{fmth(f_clk, 1e-6, "MHz", 4)}</td>
        <td>÷1</td>
        <td style="background:{duty_color(dc_clk)}">{fmth(dc_clk, 1, "%", 1)}</td>
        <td>{clk_status}</td>
    </tr>'''

    for s in res.get('slots', []):
        meas_div = f'÷{s["ratio_int"]}' if s['ratio_int'] is not None else 'N/A'
        div_bg = '' if s['div_ok'] else ' style="background:#ffcccc"'
        status = CHECK if s['passed'] else CROSS
        rng = f'{s["t0"]*1e6:.2f}–{s["t1"]*1e6:.2f}'
        rows += f'''<tr>
            <td>{s["k"]}</td>
            <td>{rng}</td>
            <td>in{s["input"]}</td>
            <td>{s["bits"]}</td>
            <td>÷{s["expected_div"]}</td>
            <td>{fmth(s["expected_freq"], 1e-6, "MHz", 4)}</td>
            <td>{fmth(s["freq"], 1e-6, "MHz", 4)}</td>
            <td{div_bg}>{meas_div}</td>
            <td style="background:{duty_color(s["duty"])}">{fmth(s["duty"], 1, "%", 1)}</td>
            <td>{status}</td>
        </tr>'''

    return f'''
    <table class="detail">
        <thead><tr>
            <th>Slot</th>
            <th>Przedzial [µs]</th>
            <th>Wejscie</th>
            <th>Adres A2A1A0</th>
            <th>Dzielnik oczek.</th>
            <th>f oczekiwana</th>
            <th>f zmierzona</th>
            <th>Dzielnik zmierz.</th>
            <th>Duty out</th>
            <th>Status</th>
        </tr></thead>
        <tbody>{rows}</tbody>
    </table>'''


html_detail_panels = ''
for tag, corner, temp, vp, res in summary:
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    slots = res.get('slots', [])
    n_ok = sum(1 for s in slots if s['passed'])
    n_tot = len(SLOTS)
    head_status = CHECK if n_ok == n_tot else CROSS
    inner = f'''
    <h2>{corner} — T={temp}°C — VDD={vp}V</h2>
    <h3>f<sub>clk</sub> = {fmth(f_clk, 1e-6, "MHz", 4)}
        &nbsp;|&nbsp; przedzialy poprawne: {n_ok}/{n_tot} {head_status}</h3>
    {slot_table(res)}'''
    html_detail_panels += f'<div id="{tag}" class="panel">{inner}</div>\n'


# ── Pelny dokument HTML ───────────────────────────────────────────────────────
html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MUX 8:1 Sweep Report</title>
<style>
    body {{ font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }}
    h1 {{ color: #222; }}
    h2 {{ color: #333; border-bottom: 2px solid #27ae60; padding-bottom: 6px; }}
    h3 {{ color: #555; margin: 8px 0; }}
    .tabs {{ display: flex; flex-wrap: wrap; gap: 4px; margin-bottom: 16px; }}
    .tab {{ padding: 8px 14px; background: #ddd; border: none; cursor: pointer;
            border-radius: 4px; font-size: 12px; }}
    .tab:hover {{ background: #bbb; }}
    .tab.active {{ background: #27ae60; color: white; }}
    .panel {{ display: none; background: white; padding: 20px; border-radius: 8px;
              box-shadow: 0 2px 6px rgba(0,0,0,0.1); }}
    .panel.active {{ display: block; }}
    table.summary, table.detail {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
    table.summary th, table.detail th {{ background: #27ae60; color: white; padding: 8px; text-align: center; }}
    table.summary td, table.detail td {{ padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
    tr.corner-header td {{ background: #e8f5e9; font-size: 14px; padding: 8px; text-align: left; }}
    tr.clk-row td {{ background: #eef3fb; }}
    .legend {{ margin-top: 12px; display: flex; gap: 24px; font-size: 13px; flex-wrap: wrap; }}
</style>
</head>
<body>
<h1>MUX 8:1 Sweep Report</h1>
<div class="tabs">
{html_tabs}
</div>
{html_summary_panel}
{html_detail_panels}
<script>
function showTab(id, btn) {{
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.getElementById(id).classList.add('active');
    if (btn) btn.classList.add('active');
}}
</script>
</body>
</html>'''

html_path = os.path.join(RESULTS_DIR, f'{SIM_NAME}_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
