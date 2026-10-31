"""
==============================================================================
RAPORT DZIELNIKA (2Div)
------------------------------------------------------------------------------
Analogiczny do plot_vco.py, ale:
  - NIE rysuje wykresow (zgodnie z wymaganiem),
  - dla zegara wejsciowego (clk) liczy czestotliwosc i duty cycle,
  - dla kazdej galezi div2..div128 liczy czestotliwosc i duty cycle,
    nastepnie sprawdza poprawnosc podzialu:
        dzielnik_zmierzony = f_clk / f_divN   (powinien wynosic N)
  - galaz dostaje zielony ✓ gdy:
        dzielnik zgadza sie z N   ORAZ   duty cycle = 50% ±5%
    w przeciwnym razie czerwony ✗.
  - raport HTML zawiera tabele (podsumowanie po cornerach + szczegoly
    per kombinacja PVT).
==============================================================================
"""

import sys
import os
import glob
import numpy as np

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')
os.makedirs(RESULTS_DIR, exist_ok=True)

SIM_NAME = 'divider'

# ── Konfiguracja sygnalow ──────────────────────────────────────────────────────
# Kolejnosc MUSI sie zgadzac z linia wrdata w run_sweep.sh:
#   wrdata <dat> v(clk) v(div2) v(div4) v(div8) v(div16) v(div32) v(div64) v(div128)
SIGNAL_ORDER = ['clk', 'div2', 'div4', 'div8', 'div16', 'div32', 'div64', 'div128']

# Galaz -> oczekiwany dzielnik wzgledem clk
EXPECTED_DIV = {
    'div2':   2,
    'div4':   4,
    'div8':   8,
    'div16':  16,
    'div32':  32,
    'div64':  64,
    'div128': 128,
}

# Tolerancje
DUTY_TARGET = 50.0      # %
DUTY_TOL    = 5.0       # % — warunek na zielony checkmark (duty = 50 ±5)
DIV_REL_TOL = 0.10      # wzgledna tolerancja dla zgodnosci dzielnika

# Analizujemy ostatnia czesc symulacji (lancuch FF musi sie ustabilizowac).
# Przy tran ...4u i div128 ~2.5 MHz (okres 400 ns) ostatnie 50% to ~5 okresow.
LAST_FRACTION = 0.5


# ── Wczytanie pliku .dat (format ngspice wrdata: pary t,sygnal) ─────────────────
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


# ── Analiza pojedynczego sygnalu ────────────────────────────────────────────────
def _crossings(t_arr, v_arr, level, direction):
    """Interpolowane przejscia przez poziom; direction = +1 narastajace, -1 opadajace."""
    above = (v_arr >= level).astype(int)
    edges = np.diff(above)
    idxs  = np.where(edges == direction)[0]
    res = []
    for i in idxs:
        v0, v1 = v_arr[i], v_arr[i + 1]
        if v1 != v0:
            res.append(t_arr[i] + (level - v0) * (t_arr[i + 1] - t_arr[i]) / (v1 - v0))
    return np.array(res)


def analyze_signal(time, voltage, vdd, last_fraction=LAST_FRACTION):
    """
    Zwraca (freq_hz, duty_pct). None,None gdy sygnal nie przelacza
    (np. zawieszona galaz) albo za malo krawedzi do pomiaru.
    Czestotliwosc i duty usredniane po wszystkich okresach w oknie analizy.
    """
    vmin, vmax = float(voltage.min()), float(voltage.max())
    amp = vmax - vmin

    # Wymagamy realnego przelaczania (>=40% szyny) — odrzuca zawieszone wezly.
    try:
        thr = 0.40 * float(vdd)
    except Exception:
        thr = 0.40
    if amp < max(0.10, thr):
        return None, None

    v50 = vmin + 0.5 * amp

    t_start = time[-1] * (1.0 - last_fraction)
    mask = time >= t_start
    t = time[mask]
    v = voltage[mask]

    rising  = _crossings(t, v, v50, +1)
    falling = _crossings(t, v, v50, -1)

    if len(rising) < 2:
        return None, None

    # Czestotliwosc: srednia z okresow miedzy kolejnymi narastajacymi zboczami
    periods = np.diff(rising)
    period = float(np.mean(periods))
    if period <= 0:
        return None, None
    freq = 1.0 / period

    # Duty cycle: dla kazdego narastajacego zbocza czas do najblizszego opadajacego
    duties = []
    for k in range(len(rising) - 1):
        tr   = rising[k]
        tr_n = rising[k + 1]
        f_after = falling[(falling > tr) & (falling < tr_n)]
        if len(f_after) == 0:
            continue
        per  = tr_n - tr
        high = f_after[0] - tr
        if per > 0 and 0 < high < per:
            duties.append(high / per)
    duty = 100.0 * float(np.mean(duties)) if duties else None

    return freq, duty


# ── Parsowanie taga (corner_Ttemp_Vpvdd) ─────────────────────────────────────────
def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p[1:]  for p in parts
                 if p.startswith('T') and len(p) > 1
                 and p[1].lstrip('-').replace('.', '').isdigit()), '?')
    vp   = next((p[2:]  for p in parts if p.startswith('Vp')), '?')
    return corner, temp, vp


# ── Ocena galezi ─────────────────────────────────────────────────────────────────
def eval_branch(freq_clk, freq_div, duty_div, expected_n):
    """
    Zwraca dict z ocena galezi:
      ratio       — zmierzony dzielnik (f_clk/f_div) lub None
      ratio_int   — zaokraglony dzielnik lub None
      div_ok      — czy dzielnik zgadza sie z expected_n
      duty_ok     — czy duty = 50 ±DUTY_TOL
      passed      — div_ok AND duty_ok
    """
    ratio = None
    ratio_int = None
    div_ok = False
    if freq_clk and freq_div and freq_div > 0:
        ratio = freq_clk / freq_div
        ratio_int = int(round(ratio))
        div_ok = abs(ratio - expected_n) <= DIV_REL_TOL * expected_n
    duty_ok = duty_div is not None and abs(duty_div - DUTY_TARGET) <= DUTY_TOL
    return {
        'ratio': ratio,
        'ratio_int': ratio_int,
        'div_ok': div_ok,
        'duty_ok': duty_ok,
        'passed': bool(div_ok and duty_ok),
    }


# ── Formatowanie ─────────────────────────────────────────────────────────────────
def fmth(v, scale=1, unit='', dec=3):
    if v is None:
        return 'N/A'
    try:
        s = f'{v * scale:.{dec}f}'
        return f'{s} {unit}'.strip()
    except Exception:
        return 'N/A'


def duty_color(dc):
    if dc is None:
        return '#ffffff'
    try:
        d = abs(float(dc) - DUTY_TARGET)
        if d > 2 * DUTY_TOL:
            return '#ffcccc'   # czerwony — duze odchylenie
        elif d > DUTY_TOL:
            return '#ffe5cc'   # pomaranczowy — poza tolerancja na ✓
    except Exception:
        pass
    return '#ffffff'


CHECK = '<span style="color:#1a9c1a;font-weight:bold;font-size:16px">&#10004;</span>'
CROSS = '<span style="color:#d00;font-weight:bold;font-size:16px">&#10008;</span>'


# ── Glowna petla ─────────────────────────────────────────────────────────────────
dat_files = sorted(glob.glob(os.path.join(DATA_DIR, f'{SIM_NAME}_*.dat')))
if not dat_files:
    print(f"Brak plikow .dat w {DATA_DIR}")
    sys.exit(1)

summary = []   # (tag, corner, temp, vp, result_dict)
total_files = len(dat_files)

for idx, filepath in enumerate(dat_files, 1):
    tag = os.path.basename(filepath).replace(f'{SIM_NAME}_', '').replace('.dat', '')
    corner, temp, vp = parse_tag(tag)
    d = load_dat(filepath)

    result = {'clk': None, 'branches': {}}

    if d is not None:
        f_clk, dc_clk = analyze_signal(d['time_clk'], d['clk'], vp)
        clk_duty_ok = dc_clk is not None and abs(dc_clk - DUTY_TARGET) <= DUTY_TOL
        result['clk'] = {'freq': f_clk, 'duty': dc_clk, 'duty_ok': clk_duty_ok}

        for name, n in EXPECTED_DIV.items():
            f_div, dc_div = analyze_signal(d[f'time_{name}'], d[name], vp)
            ev = eval_branch(f_clk, f_div, dc_div, n)
            ev['freq'] = f_div
            ev['duty'] = dc_div
            ev['expected_n'] = n
            ev['expected_freq'] = (f_clk / n) if f_clk else None
            result['branches'][name] = ev

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


# ── Podsumowanie w terminalu ─────────────────────────────────────────────────────
print()
current_corner = None
for tag, corner, temp, vp, res in summary:
    if corner != current_corner:
        current_corner = corner
        print(f'\n{corner}')
        print(f"  {'TEMP':>6}  {'VDD':>6}  {'f_clk':>11}  {'DC clk':>8}  {'OK div':>8}")
        print('  ' + '-' * 48)
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    dc_clk = clk['duty'] if clk else None
    branches = res.get('branches', {})
    n_ok = sum(1 for b in branches.values() if b['passed'])
    n_tot = len(EXPECTED_DIV)
    print(f"  {temp+'C':>6}  {vp+'V':>6}  "
          f"{fmth(f_clk, 1e-6, 'MHz', 3):>11}  "
          f"{fmth(dc_clk, 1, '%', 1):>8}  "
          f"{f'{n_ok}/{n_tot}':>8}")
print()


# ── HTML: zakladki ───────────────────────────────────────────────────────────────
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
for tag, corner, temp, vp, _ in summary:
    label = f'{corner} T{temp} {vp}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'


# ── HTML: tabela podsumowania (po cornerach) ─────────────────────────────────────
summary_rows = ''
current_corner = None
for tag, corner, temp, vp, res in summary:
    if corner != current_corner:
        current_corner = corner
        summary_rows += f'<tr class="corner-header"><td colspan="6"><b>{corner}</b></td></tr>\n'
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    dc_clk = clk['duty'] if clk else None
    branches = res.get('branches', {})
    n_ok = sum(1 for b in branches.values() if b['passed'])
    n_tot = len(EXPECTED_DIV)
    all_ok = (n_ok == n_tot)
    status = CHECK if all_ok else CROSS
    summary_rows += f'''<tr>
        <td>{temp} °C</td><td>{vp} V</td>
        <td>{fmth(f_clk, 1e-6, "MHz", 3)}</td>
        <td style="background:{duty_color(dc_clk)} !important">{fmth(dc_clk, 1, "%", 1)}</td>
        <td>{n_ok} / {n_tot}</td>
        <td>{status}</td>
    </tr>'''

html_summary_panel = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie — dzielnik po cornerach</h2>
    <table class="summary">
        <thead><tr>
            <th>TEMP</th><th>VDD</th>
            <th>f<sub>clk</sub></th><th>DC clk</th>
            <th>Galezie OK</th><th>Status</th>
        </tr></thead>
        <tbody>{summary_rows}</tbody>
    </table>
    <div class="legend">
        <span>{CHECK} galaz/kombinacja spelnia wymagania (dzielnik + duty 50% ±{DUTY_TOL:.0f}%)</span>
        <span>{CROSS} nie spelnia</span>
    </div>
</div>'''


# ── HTML: panele szczegolowe (jedna tabela na kombinacje PVT) ────────────────────
def branch_table(res):
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    dc_clk = clk['duty'] if clk else None

    rows = ''
    # Wiersz zegara (referencja)
    clk_status = CHECK if (clk and clk['duty_ok']) else CROSS
    rows += f'''<tr class="clk-row">
        <td><b>clk</b></td>
        <td>{fmth(f_clk, 1e-6, "MHz", 4)}</td>
        <td>—</td>
        <td>÷1 (ref)</td>
        <td>÷1</td>
        <td style="background:{duty_color(dc_clk)}">{fmth(dc_clk, 1, "%", 1)}</td>
        <td>{clk_status}</td>
    </tr>'''

    branches = res.get('branches', {})
    for name in EXPECTED_DIV:
        b = branches.get(name)
        if b is None:
            rows += f'<tr><td>{name}</td><td colspan="6">brak danych</td></tr>'
            continue
        meas_div = f'÷{b["ratio_int"]}' if b['ratio_int'] is not None else 'N/A'
        # podswietl niezgodny dzielnik na czerwono
        div_bg = '' if b['div_ok'] else ' style="background:#ffcccc"'
        status = CHECK if b['passed'] else CROSS
        rows += f'''<tr>
            <td><b>{name}</b></td>
            <td>{fmth(b["freq"], 1e-6, "MHz", 4)}</td>
            <td>{fmth(b["expected_freq"], 1e-6, "MHz", 4)}</td>
            <td>÷{b["expected_n"]}</td>
            <td{div_bg}>{meas_div}</td>
            <td style="background:{duty_color(b["duty"])}">{fmth(b["duty"], 1, "%", 1)}</td>
            <td>{status}</td>
        </tr>'''

    return f'''
    <table class="detail">
        <thead><tr>
            <th>Sygnal</th>
            <th>f zmierzona</th>
            <th>f oczekiwana</th>
            <th>Dzielnik oczekiwany</th>
            <th>Dzielnik zmierzony</th>
            <th>Duty cycle</th>
            <th>Status</th>
        </tr></thead>
        <tbody>{rows}</tbody>
    </table>'''


html_detail_panels = ''
for tag, corner, temp, vp, res in summary:
    clk = res.get('clk')
    f_clk = clk['freq'] if clk else None
    branches = res.get('branches', {})
    n_ok = sum(1 for b in branches.values() if b['passed'])
    n_tot = len(EXPECTED_DIV)
    head_status = CHECK if n_ok == n_tot else CROSS
    inner = f'''
    <h2>{corner} — T={temp}°C — VDD={vp}V</h2>
    <h3>f<sub>clk</sub> = {fmth(f_clk, 1e-6, "MHz", 4)}
        &nbsp;|&nbsp; galezie poprawne: {n_ok}/{n_tot} {head_status}</h3>
    {branch_table(res)}'''
    html_detail_panels += f'<div id="{tag}" class="panel">{inner}</div>\n'


# ── Pelny dokument HTML ──────────────────────────────────────────────────────────
html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Divider Sweep Report</title>
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
<h1>Divider Sweep Report</h1>
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
