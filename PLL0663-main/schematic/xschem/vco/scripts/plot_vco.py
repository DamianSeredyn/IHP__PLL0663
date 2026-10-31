import sys
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os
from collections import defaultdict

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')
os.makedirs(RESULTS_DIR, exist_ok=True)

# Tryb pomiaru KVCO wlaczany flaga --meas (przekazywana z run_vco.sh -meas)
USE_MEAS  = '--meas'  in sys.argv[1:]
USE_DEBUG = '--debug' in sys.argv[1:]

def dbg(*args):
    """Wypisuje komunikat debugowania na stderr tylko gdy USE_DEBUG=1."""
    if USE_DEBUG:
        sys.stderr.write('[DEBUG] ' + ' '.join(str(a) for a in args) + '\n')

if USE_DEBUG:
    dbg('plot_vco.py w trybie debug.')
    dbg('USE_MEAS =', USE_MEAS)
    dbg('DATA_DIR =', DATA_DIR)
    dbg('RESULTS_DIR =', RESULTS_DIR)

# ── Wczytanie pliku .dat (format ngspice wrdata) ───────────────────────────────
# wrdata zapisuje kolumny parami (t, wartosc). Kolejnosc sygnalow:
#   v(out_pb), v(out), i(V2), v(x2.pgt)   -> 8 kolumn (4 pary)
# Starszy format (bez pgt) mial 6 kolumn; obslugujemy oba.
def load_dat(path):
    try:
        data = np.loadtxt(path, skiprows=1)
        if data.ndim < 2 or data.shape[1] < 6:
            print(f"  [WARN] {path}: oczekiwano >=6 kolumn, jest {data.shape}")
            return None
        d = {
            'time_pb':  data[:, 0],
            'v_out_pb': data[:, 1],
            'time_out': data[:, 2],
            'v_out':    data[:, 3],
            'time_i':   data[:, 4],
            'i_v2':     data[:, 5],
        }
        # Kolumny pgt obecne tylko w nowym formacie (tryb -meas)
        if data.shape[1] >= 8:
            d['time_pgt'] = data[:, 6]
            d['v_pgt']    = data[:, 7]
        else:
            d['time_pgt'] = None
            d['v_pgt']    = None
        dbg(f'load_dat {os.path.basename(path)}: shape={data.shape}, '
            f'pgt={"tak" if d["v_pgt"] is not None else "nie"}')
        return d
    except Exception as e:
        print(f"  [WARN] Nie mozna odczytac {path}: {e}")
        return None


# ── Wczytanie pliku .acdat (analiza .ac, jeden punkt 1 MHz) ────────────────────
# wrdata dla .ac zapisuje: freq  real(i(v1))  freq  imag(i(v1))  -> 4 kolumny.
# Zwraca (freq, re, im) lub None.
def load_acdat(path):
    try:
        data = np.loadtxt(path)
        data = np.atleast_2d(data)
        if data.shape[1] < 4:
            dbg(f'load_acdat {os.path.basename(path)}: za malo kolumn {data.shape}')
            return None
        freq = float(data[0, 0])
        re_i = float(data[0, 1])
        im_i = float(data[0, 3])
        dbg(f'load_acdat {os.path.basename(path)}: f={freq:.3e} '
            f're(i)={re_i:.3e} im(i)={im_i:.3e}')
        return freq, re_i, im_i
    except Exception as e:
        dbg(f'load_acdat {os.path.basename(path)}: blad {e}')
        return None


# C = |Im(i(V1))| / (2*pi*f). Zwraca C w faradach lub None.
def extract_c(acdat_path):
    r = load_acdat(acdat_path)
    if r is None:
        return None
    freq, re_i, im_i = r
    if freq <= 0:
        return None
    c = abs(im_i) / (2.0 * np.pi * freq)
    return c

# ── Analiza sygnalu — ostatnie 30% symulacji ───────────────────────────────────
def analyze_signal(time, voltage, last_fraction=0.3):
    """
    Zwraca (freq_hz, duty_pct, tr_ps, tf_ps) liczone na ostatnich
    last_fraction czasu symulacji. None jesli sygnal plaski / za malo krawedzi.
    """
    vmin, vmax = voltage.min(), voltage.max()
    if (vmax - vmin) < 0.05:
        return None, None, None, None

    v10 = vmin + 0.10 * (vmax - vmin)
    v50 = vmin + 0.50 * (vmax - vmin)
    v90 = vmin + 0.90 * (vmax - vmin)

    t_start = time[-1] * (1.0 - last_fraction)
    mask = time >= t_start
    t = time[mask]
    v = voltage[mask]

    def crossings(t_arr, v_arr, level, direction):
        above = (v_arr >= level).astype(int)
        edges = np.diff(above)
        idxs  = np.where(edges == direction)[0]
        result = []
        for i in idxs:
            t0, t1 = t_arr[i], t_arr[i+1]
            v0, v1 = v_arr[i], v_arr[i+1]
            if v1 != v0:
                result.append(t0 + (level - v0) * (t1 - t0) / (v1 - v0))
        return np.array(result)

    rising_50  = crossings(t, v, v50, +1)
    falling_50 = crossings(t, v, v50, -1)

    if len(rising_50) < 2 or len(falling_50) < 1:
        return None, None, None, None

    t_r0 = rising_50[0]
    f_after = falling_50[falling_50 > t_r0]
    if len(f_after) == 0:
        return None, None, None, None
    t_f0 = f_after[0]
    r_after = rising_50[rising_50 > t_f0]
    if len(r_after) == 0:
        return None, None, None, None
    t_r1 = r_after[0]

    period = t_r1 - t_r0
    if period <= 0:
        return None, None, None, None

    freq_hz    = 1.0 / period
    duty_pct   = 100.0 * (t_f0 - t_r0) / period

    # Czas narastania 10%→90%
    rising_10 = crossings(t, v, v10, +1)
    rising_90 = crossings(t, v, v90, +1)
    r10_before = rising_10[rising_10 <= t_r0]
    r90_after  = rising_90[rising_90 >= t_r0]
    if len(r10_before) > 0 and len(r90_after) > 0:
        dt = r90_after[0] - r10_before[-1]
        tr_ps = dt * 1e12 if 0 < dt < period / 2 else None
    else:
        tr_ps = None

    # Czas opadania 90%→10%
    falling_10 = crossings(t, v, v10, -1)
    falling_90 = crossings(t, v, v90, -1)
    f90_before = falling_90[falling_90 <= t_f0]
    f10_after  = falling_10[falling_10 >= t_f0]
    if len(f90_before) > 0 and len(f10_after) > 0:
        dt = f10_after[0] - f90_before[-1]
        tf_ps = dt * 1e12 if 0 < dt < period / 2 else None
    else:
        tf_ps = None

    return freq_hz, duty_pct, tr_ps, tf_ps

# ── Parsowanie taga ────────────────────────────────────────────────────────────
def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p.replace('T','')   for p in parts if p.startswith('T')   and p != parts[0] and p != parts[1]), '?')
    vp   = next((p.replace('Vp','')  for p in parts if p.startswith('Vp')),  '?')
    vin  = next((p.replace('Vin','') for p in parts if p.startswith('Vin')), '?')
    return corner, temp, vp, vin

# ── Generowanie wykresow ───────────────────────────────────────────────────────
def make_plot(d, metrics, tag, out_path):
    corner, temp, vp, vin = parse_tag(tag)

    fig = plt.figure(figsize=(16, 10))
    fig.suptitle(f'VCO Charakterystyka - {tag}', fontsize=13, fontweight='bold')

    def safe(arr):
        a = np.array(arr, dtype=np.float64)
        a[~np.isfinite(a)] = np.nan
        return a

    # Ax1: v(out) — caly czas
    ax1 = fig.add_subplot(2, 3, 1)
    if d is not None:
        ax1.plot(safe(d['time_out'])*1e9, safe(d['v_out']), color='royalblue', linewidth=0.8)
        try:
            ax1.set_ylim(-0.05, float(vp)+0.05)
        except Exception:
            pass
    else:
        ax1.text(0.5, 0.5, 'Brak danych', ha='center', va='center',
                 transform=ax1.transAxes, color='gray')
    ax1.set_xlabel('Czas [ns]')
    ax1.set_ylabel('Napiecie [V]')
    ax1.set_title('Przebieg v(out)')
    ax1.grid(True, alpha=0.3)

    # Ax2: v(out_pb) — caly czas
    ax2 = fig.add_subplot(2, 3, 2)
    if d is not None:
        ax2.plot(safe(d['time_pb'])*1e9, safe(d['v_out_pb']), color='darkorange', linewidth=0.8)
        try:
            ax2.set_ylim(-0.05, float(vp)+0.05)
        except Exception:
            pass
    else:
        ax2.text(0.5, 0.5, 'Brak danych', ha='center', va='center',
                 transform=ax2.transAxes, color='gray')
    ax2.set_xlabel('Czas [ns]')
    ax2.set_ylabel('Napiecie [V]')
    ax2.set_title('Przebieg v(out_pb)')
    ax2.grid(True, alpha=0.3)

    # Ax3: i(V2) — caly czas
    ax3 = fig.add_subplot(2, 3, 3)
    i_avg = metrics.get('i_avg_v2')
    i_max = metrics.get('i_max_v2')
    if d is not None:
        iv = -safe(d['i_v2']) * 1e3  # znak: prad pobierany z VDD > 0
        ax3.plot(safe(d['time_i'])*1e9, iv, color='crimson', linewidth=0.8)
        if i_avg is not None:
            ax3.axhline(i_avg, color='navy', linewidth=1.5, linestyle='--',
                        label=f'Avg={i_avg:.2f} mA')
        if i_max is not None:
            ax3.axhline(i_max, color='green', linewidth=1.5, linestyle=':',
                        label=f'Max={i_max:.2f} mA')
        ax3.legend(fontsize=9)
    else:
        ax3.text(0.5, 0.5, 'Brak danych', ha='center', va='center',
                 transform=ax3.transAxes, color='gray')
    ax3.set_xlabel('Czas [ns]')
    ax3.set_ylabel('Prad [mA]')
    ax3.set_title('Prad zrodla V2 (VDD)')
    ax3.grid(True, alpha=0.3)

    def fmtv(v, scale=1, unit='', dec=3):
        if v is None:
            return 'N/A'
        return f'{v*scale:.{dec}f} {unit}'.strip()

    # Ax4: metryki v(out)
    ax4 = fig.add_subplot(2, 3, 4)
    ax4.axis('off')
    rows4 = [
        ['Czestotliwosc [MHz]', fmtv(metrics.get('freq_out'), 1e-6, '', 3)],
        ['Duty cycle [%]',      fmtv(metrics.get('dc_out'),   1,    '', 1)],
    ]
    t4 = ax4.table(cellText=rows4, colLabels=['Parametr v(out)', 'Wartosc'],
                   cellLoc='center', loc='center', colWidths=[0.65, 0.35])
    t4.auto_set_font_size(False); t4.set_fontsize(10); t4.scale(1, 1.8)
    _color_dc(t4, rows4)
    ax4.set_title('Parametry v(out)', pad=10)

    # Ax5: metryki v(out_pb)
    ax5 = fig.add_subplot(2, 3, 5)
    ax5.axis('off')
    rows5 = [
        ['Czestotliwosc [MHz]',  fmtv(metrics.get('freq_pb'),   1e-6, '', 3)],
        ['Czas narastania [ps]', fmtv(metrics.get('tr_pb'),     1,    '', 1)],
        ['Czas opadania [ps]',   fmtv(metrics.get('tf_pb'),     1,    '', 1)],
        ['Duty cycle [%]',       fmtv(metrics.get('dc_pb'),     1,    '', 1)],
    ]
    t5 = ax5.table(cellText=rows5, colLabels=['Parametr v(out_pb)', 'Wartosc'],
                   cellLoc='center', loc='center', colWidths=[0.65, 0.35])
    t5.auto_set_font_size(False); t5.set_fontsize(10); t5.scale(1, 1.8)
    _color_dc(t5, rows5)
    ax5.set_title('Parametry v(out_pb)', pad=10)

    # Ax6: warunki + prad
    ax6 = fig.add_subplot(2, 3, 6)
    ax6.axis('off')
    pdiss = None
    if i_avg is not None:
        try:
            pdiss = i_avg * float(vp)
        except Exception:
            pass
    rows6 = [
        ['Corner',          corner],
        ['Temperatura [C]', temp],
        ['VDD [V]',         vp],
        ['Vin [V]',         vin],
        ['Avg Ivdd [mA]',   fmtv(i_avg)],
        ['Max Ivdd [mA]',   fmtv(i_max)],
        ['Avg Pdiss [mW]',  fmtv(pdiss)],
    ]
    t6 = ax6.table(cellText=rows6, colLabels=['Parametr', 'Wartosc'],
                   cellLoc='center', loc='center', colWidths=[0.6, 0.4])
    t6.auto_set_font_size(False); t6.set_fontsize(10); t6.scale(1, 1.8)
    ax6.set_title('Warunki symulacji', pad=10)

    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()


def _color_dc(table, rows):
    for i, row in enumerate(rows):
        if 'Duty cycle' in row[0] and row[1] != 'N/A':
            try:
                dc = float(row[1])
                if abs(dc - 50.0) > 10:
                    table[i+1, 1].set_facecolor('#ffcccc')
                elif abs(dc - 50.0) > 5:
                    table[i+1, 1].set_facecolor('#ffe5cc')
            except Exception:
                pass


# ── KVCO: nachylenie f(out) vs Vin, grupowane po (corner, temp, vp) ─────────────
def compute_kvco(summary):
    """
    Grupuje wyniki po (corner, temp, vp), sortuje po Vin i liczy KVCO:
      - kvco_fit    : nachylenie z dopasowania liniowego po calym zakresie [Hz/V]
      - kvco_local  : lokalne nachylenia miedzy sasiednimi punktami [Hz/V]
    Uzywa freq_out (sygnal z bufora, czysty pelny swing).
    """
    groups = defaultdict(list)
    for tag, corner, temp, vp, vin, m in summary:
        f = m.get('freq_out')
        if f is None:
            continue
        try:
            groups[(corner, temp, vp)].append((float(vin), f))
        except (TypeError, ValueError):
            continue

    results = {}
    for key, pts in groups.items():
        # usun ewentualne duplikaty Vin (ostatni wygrywa), potem sortuj
        dedup = {}
        for v, f in pts:
            dedup[v] = f
        pts = sorted(dedup.items())
        if len(pts) < 2:
            continue
        v = np.array([p[0] for p in pts])
        f = np.array([p[1] for p in pts])
        slope, intercept = np.polyfit(v, f, 1)     # Hz/V
        local = np.diff(f) / np.diff(v)            # Hz/V
        results[key] = {
            'v': v,
            'f': f,
            'kvco_fit': float(slope),
            'intercept': float(intercept),
            'kvco_local': local,
            'v_mid': (v[:-1] + v[1:]) / 2,
        }
    return results


def plot_kvco_curve(key, r, out_path):
    corner, temp, vp = key
    fig, (axf, axk) = plt.subplots(1, 2, figsize=(12, 5))
    fig.suptitle(f'KVCO - {corner} T{temp}C VDD{vp}V', fontweight='bold')

    # lewy panel: krzywa strojenia + linia dopasowania
    axf.plot(r['v'], r['f']/1e6, 'o', color='royalblue', label='symulacja')
    v_fit = np.linspace(r['v'].min(), r['v'].max(), 100)
    f_fit = (r['kvco_fit'] * v_fit + r['intercept']) / 1e6
    axf.plot(v_fit, f_fit, '-', color='navy', alpha=0.7,
             label=f"fit: {r['kvco_fit']/1e6:.2f} MHz/V")
    axf.set_xlabel('Vin [V]')
    axf.set_ylabel('f(out) [MHz]')
    axf.set_title('Krzywa strojenia')
    axf.legend(fontsize=9)
    axf.grid(True, alpha=0.3)

    # prawy panel: lokalne KVCO
    axk.plot(r['v_mid'], r['kvco_local']/1e6, 's-', color='crimson')
    axk.set_xlabel('Vin [V]')
    axk.set_ylabel('lokalne KVCO [MHz/V]')
    axk.set_title('Lokalne nachylenie vs Vin')
    axk.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()


def _fmt(v, scale=1.0, unit=''):
    if v is None or not np.isfinite(v):
        return 'N/A'
    return f'{v*scale:.3g} {unit}'.strip()


# ── R/C i wzmocnienia VCO: rozdzielczosc per (corner, temp, vp) ─────────────────
def compute_rc(summary):
    """
    Dla kazdej grupy (corner, temp, vp) sortuje po Vin i liczy (roznice skonczone
    miedzy sasiednimi punktami Vin, ocena w srodku przedzialu v_mid):

      K       = d f_out / d Vin           [Hz/V]   (wzmocnienie napieciowe VCO)
      gm_vco  = d i_osc / d Vin           [A/V]    (transkonduktancja V2I)
      K_CCO   = d f_out / d i_osc         [Hz/A]   (wzmocnienie pradowe CCO)
      r_vco   = d v_osc / d i_osc         [Ohm]    (dv amplitudy / di rdzenia)

    Oraz punktowo (bez roznicy):
      C_in(Vin)  z analizy .ac            [F]

    i_osc w [A] (metrics['i_osc']), v_osc w [V] (pk-pk v(out)).
    Punkty z brakiem danych (None/NaN) sa pomijane w roznicach; potrzeba >=2 pkt.
    """
    groups = defaultdict(list)
    for tag, corner, temp, vp, vin, m in summary:
        try:
            vinf = float(vin)
        except (TypeError, ValueError):
            continue
        groups[(corner, temp, vp)].append({
            'vin':   vinf,
            'f':     m.get('freq_out'),
            'i_osc': m.get('i_osc'),
            'v_osc': m.get('v_osc'),
            'v_pgt': m.get('v_pgt'),
            'c_in':  m.get('c_in'),
        })

    results = {}
    for key, pts in groups.items():
        dd = {}
        for p in pts:
            dd[p['vin']] = p
        pts = [dd[k] for k in sorted(dd)]

        vin = np.array([p['vin'] for p in pts], dtype=float)

        def col(name):
            return np.array([np.nan if p[name] is None else float(p[name])
                             for p in pts], dtype=float)

        f     = col('f')
        i_osc = col('i_osc')
        v_osc = col('v_osc')
        v_pgt = col('v_pgt')
        c_in  = col('c_in')

        dbg(f'compute_rc {key}: vin={vin.tolist()}')
        dbg(f'   f     ={f.tolist()}')
        dbg(f'   i_osc ={i_osc.tolist()}')
        dbg(f'   v_osc ={v_osc.tolist()}')
        dbg(f'   c_in  ={c_in.tolist()}')

        v_mid = (vin[:-1] + vin[1:]) / 2.0

        def safe_diff_ratio(num, den):
            dn = np.diff(num)
            dd_ = np.diff(den)
            with np.errstate(divide='ignore', invalid='ignore'):
                out = dn / dd_
            out[~np.isfinite(out)] = np.nan
            return out

        K     = safe_diff_ratio(f,     vin)     # Hz/V
        gm    = safe_diff_ratio(i_osc, vin)     # A/V
        k_cco = safe_diff_ratio(f,     i_osc)   # Hz/A
        r_vco = safe_diff_ratio(v_osc, i_osc)   # Ohm

        def rep(a):
            a = a[np.isfinite(a)]
            return float(np.median(a)) if a.size else None

        results[key] = {
            'vin':   vin, 'v_mid': v_mid,
            'f': f, 'i_osc': i_osc, 'v_osc': v_osc, 'v_pgt': v_pgt, 'c_in': c_in,
            'K': K, 'gm': gm, 'k_cco': k_cco, 'r_vco': r_vco,
            'K_rep':     rep(K),
            'gm_rep':    rep(gm),
            'k_cco_rep': rep(k_cco),
            'r_vco_rep': rep(r_vco),
            'c_in_rep':  rep(c_in),
        }
    return results


def plot_rc_curves(key, r, out_path):
    corner, temp, vp = key
    fig, axes = plt.subplots(2, 3, figsize=(16, 9))
    fig.suptitle(f'VCO R/C i wzmocnienia - {corner} T{temp}C VDD{vp}V',
                 fontweight='bold')

    vm = r['v_mid']
    vin = r['vin']

    def plot_ax(ax, x, y, ylabel, title, color, scale=1.0, marker='o-'):
        yy = np.array(y, dtype=float) * scale
        ax.plot(x, yy, marker, color=color)
        ax.set_xlabel('Vin [V]')
        ax.set_ylabel(ylabel)
        ax.set_title(title)
        ax.grid(True, alpha=0.3)

    plot_ax(axes[0, 0], vm, r['K'], 'K [Hz/V]',
            f"K (df/dVin), med={_fmt(r['K_rep'],1,'Hz/V')}", 'navy', 1)
    plot_ax(axes[0, 1], vm, r['gm'], 'gm [mA/V]',
            f"gm_vco (di/dVin), med={_fmt(r['gm_rep'],1e3,'mA/V')}", 'teal', 1e3)
    # Hz/A -> THz/A : scale 1e-12
    plot_ax(axes[0, 2], vm, r['k_cco'], 'K_CCO [THz/A]',
            f"K_CCO (df/di), med={_fmt(r['k_cco_rep'],1e-12,'THz/A')}",
            'purple', 1e-12)
    plot_ax(axes[1, 0], vm, r['r_vco'], 'r_vco [kOhm]',
            f"r_vco (dv_osc/di), med={_fmt(r['r_vco_rep'],1e-3,'kOhm')}",
            'crimson', 1e-3)
    plot_ax(axes[1, 1], vin, r['c_in'], 'C_in [fF]',
            f"C_in @1MHz, med={_fmt(r['c_in_rep'],1e15,'fF')}",
            'darkorange', 1e15)

    ax = axes[1, 2]
    ax.plot(vin, np.array(r['v_osc'], dtype=float), 'o-', color='royalblue',
            label='v_osc pk-pk')
    ax.set_xlabel('Vin [V]')
    ax.set_ylabel('v_osc [V]', color='royalblue')
    ax.tick_params(axis='y', labelcolor='royalblue')
    ax.grid(True, alpha=0.3)
    ax2 = ax.twinx()
    ax2.plot(vin, np.array(r['i_osc'], dtype=float)*1e3, 's--', color='green',
             label='i_osc')
    ax2.set_ylabel('i_osc [mA]', color='green')
    ax2.tick_params(axis='y', labelcolor='green')
    ax.set_title('Amplituda v(out) i prad rdzenia')

    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()




# ── Metryki duzosygnalowe w oknie ustalonym (ostatnie last_fraction) ────────────
def settled_metrics(d, last_fraction=0.3):
    """
    Liczy w oknie ustalonym:
      i_osc   [A]  = srednia z i(V2) (prad rdzenia; znak: pobierany z VDD > 0)
      v_osc   [V]  = amplituda peak-peak v(out) (amplituda na inwerterach)
      v_pgt   [V]  = srednia v(x2.pgt) (wezel lustra; do debugu/referencji)
    Zwraca slownik z tymi wartosciami (None gdy brak danych).
    """
    out = {'i_osc': None, 'v_osc': None, 'v_pgt': None}
    if d is None:
        return out

    # i_osc ze sladu i(V2)
    t_i = d['time_i']
    i_v2 = d['i_v2']
    t0 = t_i[-1] * (1.0 - last_fraction)
    m = t_i >= t0
    if np.any(m):
        out['i_osc'] = float(-np.mean(i_v2[m]))   # A, dodatni = pobór z VDD

    # v_osc jako pk-pk v(out) w oknie ustalonym
    t_o = d['time_out']
    v_o = d['v_out']
    m2 = t_o >= (t_o[-1] * (1.0 - last_fraction))
    if np.any(m2):
        seg = v_o[m2]
        out['v_osc'] = float(seg.max() - seg.min())   # V, peak-peak

    # v_pgt srednia (jesli dostepne)
    if d.get('v_pgt') is not None:
        t_p = d['time_pgt']
        v_p = d['v_pgt']
        m3 = t_p >= (t_p[-1] * (1.0 - last_fraction))
        if np.any(m3):
            out['v_pgt'] = float(np.mean(v_p[m3]))

    return out


# ── Glowna petla ───────────────────────────────────────────────────────────────
dat_files = sorted(glob.glob(os.path.join(DATA_DIR, 'vco_*.dat')))
if not dat_files:
    print("Brak plikow .dat w", DATA_DIR)
    exit(1)

summary = []
total_files = len(dat_files)
for idx, filepath in enumerate(dat_files, 1):
    tag = os.path.basename(filepath).replace('vco_', '').replace('.dat', '')
    corner, temp, vp, vin = parse_tag(tag)

    d = load_dat(filepath)
    metrics = {}

    if d is not None:
        freq_out, dc_out, tr_out, tf_out = analyze_signal(d['time_out'], d['v_out'])
        freq_pb,  dc_pb,  tr_pb,  tf_pb  = analyze_signal(d['time_pb'],  d['v_out_pb'])
        i_avg = float(-np.mean(d['i_v2']) * 1e3)
        i_max = float(-np.min(d['i_v2'])  * 1e3)
        metrics = {
            'freq_out': freq_out,
            'dc_out':   dc_out,
            'tr_out':   tr_out,
            'tf_out':   tf_out,
            'freq_pb':  freq_pb,
            'dc_pb':    dc_pb,
            'tr_pb':    tr_pb,
            'tf_pb':    tf_pb,
            'i_avg_v2': i_avg,
            'i_max_v2': i_max,
        }

        # Metryki dla ekstrakcji R/C (tylko potrzebne w -meas, ale liczymy zawsze
        # jesli dane sa dostepne; sa tanie).
        sm = settled_metrics(d)
        metrics['i_osc'] = sm['i_osc']    # A (srednia i(V2) w oknie ustalonym)
        metrics['v_osc'] = sm['v_osc']    # V (pk-pk v(out))
        metrics['v_pgt'] = sm['v_pgt']    # V (srednia v(x2.pgt), debug/ref)

        # C z analizy .ac (tylko gdy -meas i istnieje plik .acdat)
        if USE_MEAS:
            acdat = filepath[:-4] + '.acdat'   # vco_<tag>.dat -> vco_<tag>.acdat
            if os.path.isfile(acdat):
                c_val = extract_c(acdat)
                metrics['c_in'] = c_val       # F
                dbg(f'{tag}: C_in = {c_val}')
            else:
                metrics['c_in'] = None
                dbg(f'{tag}: brak {os.path.basename(acdat)} - C_in=None')

        if USE_DEBUG:
            dbg(f'{tag}: f_out={freq_out}, i_osc={sm["i_osc"]}, '
                f'v_osc(pkpk)={sm["v_osc"]}, v_pgt={sm["v_pgt"]}')

    out_png = os.path.join(RESULTS_DIR, f'vco_{tag}.png')
    try:
        make_plot(d, metrics, tag, out_png)
    except Exception as e:
        sys.stderr.write(f"  [WARN] Blad wykresu {tag}: {e}\n")
        plt.close('all')

    pct = idx * 100 // total_files
    print(f"\r{pct}% of report done", end='', flush=True)

    summary.append((tag, corner, temp, vp, vin, metrics))

print()  # nowa linia po zakonczeniu petli

corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
summary.sort(key=lambda x: (corner_order.get(x[1], 99), float(x[4]), float(x[2]), float(x[3])))

# ── KVCO: obliczenie i wykresy per grupa (corner, temp, vp) ─────────────────────
# Tylko w trybie -meas. Bez niego kvco pozostaje puste i sekcje KVCO sa pomijane.
kvco = {}
rc = {}
if USE_MEAS:
    kvco = compute_kvco(summary)
    for key, r in sorted(kvco.items()):
        corner, temp, vp = key
        png = os.path.join(RESULTS_DIR, f'kvco_{corner}_T{temp}_Vp{vp}.png')
        try:
            plot_kvco_curve(key, r, png)
        except Exception as e:
            sys.stderr.write(f"  [WARN] Blad wykresu KVCO {key}: {e}\n")
            plt.close('all')

    # R/C i wzmocnienia (K, gm_vco, K_CCO, r_vco) + C_in
    rc = compute_rc(summary)
    for key, r in sorted(rc.items()):
        corner, temp, vp = key
        png = os.path.join(RESULTS_DIR, f'rc_{corner}_T{temp}_Vp{vp}.png')
        try:
            plot_rc_curves(key, r, png)
        except Exception as e:
            sys.stderr.write(f"  [WARN] Blad wykresu R/C {key}: {e}\n")
            if USE_DEBUG:
                import traceback
                traceback.print_exc()
            plt.close('all')


# ── HTML ───────────────────────────────────────────────────────────────────────
def fmth(v, scale=1, unit='', dec=3):
    if v is None:
        return 'N/A'
    try:
        return f'{v*scale:.{dec}f} {unit}'.strip()
    except Exception:
        return 'N/A'

def dc_color(dc):
    """dc to surowa wartosc float (nie string)."""
    if dc is None:
        return '#ffffff'
    try:
        v = float(dc)
        if abs(v - 50.0) > 10:
            return '#ffcccc'
        elif abs(v - 50.0) > 5:
            return '#ffe5cc'
    except Exception:
        pass
    return '#ffffff'

# ── Terminal summary ───────────────────────────────────────────────────────────
COL_W = [6, 5, 5, 9, 9, 10, 10, 7, 9, 10, 10]
HEADERS = ['TEMP', 'VDD', 'Vin', 'fout', 'fout_pb', 'trout_pb', 'tfout_pb',
           'DCout', 'DCout_pb', 'iavgVDD', 'imaxVDD']

def _row_str(vals):
    return '  '.join(str(v).rjust(w) for v, w in zip(vals, COL_W))

print()
current_corner_t = None
current_vin_t    = None
for tag, corner, temp, vp, vin, m in summary:
    if corner != current_corner_t:
        current_corner_t = corner
        current_vin_t    = None
        print(f'\n{corner}')
        print('  ' + _row_str(HEADERS))
        print('  ' + '-' * (sum(COL_W) + 2 * len(COL_W)))
    if vin != current_vin_t:
        current_vin_t = vin
        if current_corner_t == corner:
            print(f'  -- Vin = {vin} V --')
    row = [
        f'{temp}C',
        f'{vp}V',
        f'{vin}V',
        fmth(m.get('freq_out'), 1e-6, 'MHz', 3),
        fmth(m.get('freq_pb'),  1e-6, 'MHz', 3),
        fmth(m.get('tr_pb'),    1,    'ps',  1),
        fmth(m.get('tf_pb'),    1,    'ps',  1),
        fmth(m.get('dc_out'),   1,    '%',   1),
        fmth(m.get('dc_pb'),    1,    '%',   1),
        fmth(m.get('i_avg_v2'), 1,    'mA',  3),
        fmth(m.get('i_max_v2'), 1,    'mA',  3),
    ]
    print('  ' + _row_str(row))
print()

# ── Terminal KVCO summary ──────────────────────────────────────────────────────
if kvco:
    print("\nKVCO (dopasowanie liniowe po calym zakresie Vin):")
    for (corner, temp, vp), r in sorted(kvco.items()):
        print(f"  {corner} T{temp}C VDD{vp}V: "
              f"KVCO = {r['kvco_fit']/1e6:8.2f} MHz/V  "
              f"(f: {r['f'].min()/1e6:.1f} - {r['f'].max()/1e6:.1f} MHz, "
              f"{len(r['v'])} pkt)")
    print()

# ── Terminal R/C summary ───────────────────────────────────────────────────────
if rc:
    print("\nParametry R/C VCO (mediana po sweepie Vin):")
    print("  {:<26} {:>12} {:>12} {:>14} {:>12} {:>10}".format(
        'corner/T/VDD', 'K[Hz/V]', 'gm[mA/V]', 'K_CCO[THz/A]',
        'r_vco[kOhm]', 'C[fF]'))
    print("  " + "-" * 90)
    for (corner, temp, vp), r in sorted(rc.items()):
        def s(v, sc, fmt='.3g'):
            return f'{v*sc:{fmt}}' if (v is not None and np.isfinite(v)) else 'N/A'
        print("  {:<26} {:>12} {:>12} {:>14} {:>12} {:>10}".format(
            f'{corner} T{temp} {vp}V',
            s(r['K_rep'],     1),      # Hz/V
            s(r['gm_rep'],    1e3),    # mA/V  (A/V * 1e3)
            s(r['k_cco_rep'], 1e-12),  # THz/A (Hz/A * 1e-12)
            s(r['r_vco_rep'], 1e-3),   # kOhm
            s(r['c_in_rep'],  1e15),   # fF
        ))
    print()
    print("  Uwaga: K = df/dVin [Hz/V], gm = di_osc/dVin [mA/V],")
    print("         K_CCO = df/di_osc [THz/A], r_vco = dv_osc(pk-pk)/di_osc [kOhm],")
    print("         C = |Im(i(V1))|/(2pi f) @1MHz [fF].")
    print("         Wartosci to mediana lokalnych roznic po sweepie Vin.")
    print()

# ── HTML tabs ──────────────────────────────────────────────────────────────────
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
if kvco:
    html_tabs += '<button class="tab" onclick="showTab(\'kvco\', this)">KVCO</button>\n'
if rc:
    html_tabs += '<button class="tab" onclick="showTab(\'rc\', this)">R/C</button>\n'
for tag, corner, temp, vp, vin, _ in summary:
    label = f'{corner} T{temp} {vp}V Vin{vin}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'

# ── HTML summary table ─────────────────────────────────────────────────────────
summary_rows = ''
current_corner = None
current_vin    = None
for tag, corner, temp, vp, vin, m in summary:
    if corner != current_corner:
        current_corner = corner
        current_vin    = None
        summary_rows += f'<tr class="corner-header"><td colspan="11"><b>{corner}</b></td></tr>\n'
    if vin != current_vin:
        current_vin = vin
        summary_rows += f'<tr class="vin-header"><td colspan="11">Vin = {vin} V</td></tr>\n'
    dc_out = m.get('dc_out')
    dc_pb  = m.get('dc_pb')
    summary_rows += f'''<tr>
        <td>{temp} C</td><td>{vp} V</td><td>{vin} V</td>
        <td>{fmth(m.get("freq_out"), 1e-6, "MHz", 3)}</td>
        <td>{fmth(m.get("freq_pb"),  1e-6, "MHz", 3)}</td>
        <td>{fmth(m.get("tr_pb"),    1,    "ps",  1)}</td>
        <td>{fmth(m.get("tf_pb"),    1,    "ps",  1)}</td>
        <td style="background:{dc_color(dc_out)} !important">{fmth(dc_out, 1, "%", 1)}</td>
        <td style="background:{dc_color(dc_pb)} !important">{fmth(dc_pb,  1, "%", 1)}</td>
        <td>{fmth(m.get("i_avg_v2"), 1, "mA", 3)}</td>
        <td>{fmth(m.get("i_max_v2"), 1, "mA", 3)}</td>
    </tr>'''

html_summary_panel = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie - VCO po cornerach</h2>
    <table class="summary">
        <thead><tr>
            <th>TEMP</th><th>VDD</th><th>Vin</th>
            <th>f<sub>out</sub> [MHz]</th><th>f<sub>out_pb</sub> [MHz]</th>
            <th>t<sub>r</sub> out_pb [ps]</th><th>t<sub>f</sub> out_pb [ps]</th>
            <th>DC out [%]</th><th>DC out_pb [%]</th>
            <th>I<sub>avg</sub> VDD [mA]</th><th>I<sub>max</sub> VDD [mA]</th>
        </tr></thead>
        <tbody>{summary_rows}</tbody>
    </table>
    <div class="legend">
        <span class="leg-ok">&#9632; DC OK (&lt;5% od 50%)</span>
        <span class="leg-warn">&#9632; DC ostrzezenie (&gt;5%)</span>
        <span class="leg-err">&#9632; DC przekroczenie (&gt;10%)</span>
    </div>
</div>'''

# ── HTML KVCO panel ────────────────────────────────────────────────────────────
html_kvco_panel = ''
if kvco:
    kvco_rows = ''
    kvco_imgs = ''
    for (corner, temp, vp), r in sorted(kvco.items()):
        kvco_rows += f'''<tr>
            <td>{corner}</td><td>{temp} C</td><td>{vp} V</td>
            <td><b>{r['kvco_fit']/1e6:.2f}</b></td>
            <td>{r['f'].min()/1e6:.2f}</td>
            <td>{r['f'].max()/1e6:.2f}</td>
            <td>{len(r['v'])}</td>
        </tr>'''
        png_name = f'kvco_{corner}_T{temp}_Vp{vp}.png'
        kvco_imgs += f'''<div class="card">
            <h3>{corner} - T={temp}C - VDD={vp}V</h3>
            <img src="{png_name}" style="max-width:100%">
        </div>'''

    html_kvco_panel = f'''
<div id="kvco" class="panel">
    <h2>KVCO - wzmocnienie strojenia VCO</h2>
    <table class="summary">
        <thead><tr>
            <th>Corner</th><th>TEMP</th><th>VDD</th>
            <th>KVCO [MHz/V]</th><th>f<sub>min</sub> [MHz]</th>
            <th>f<sub>max</sub> [MHz]</th><th>Punkty</th>
        </tr></thead>
        <tbody>{kvco_rows}</tbody>
    </table>
    <p style="font-size:13px;color:#555;margin-top:10px">
        KVCO liczone jako nachylenie dopasowania liniowego f(out) vs Vin
        po calym zakresie sweepa. Krzywe strojenia ponizej pokazuja tez
        lokalne nachylenie (liniowosc strojenia).
    </p>
    {kvco_imgs}
</div>'''

# ── HTML R/C panel ─────────────────────────────────────────────────────────────
html_rc_panel = ''
if rc:
    def sc(v, scale):
        return f'{v*scale:.3g}' if (v is not None and np.isfinite(v)) else 'N/A'
    rc_rows = ''
    rc_imgs = ''
    for (corner, temp, vp), r in sorted(rc.items()):
        rc_rows += f'''<tr>
            <td>{corner}</td><td>{temp} C</td><td>{vp} V</td>
            <td><b>{sc(r['K_rep'], 1)}</b></td>
            <td>{sc(r['gm_rep'], 1e3)}</td>
            <td>{sc(r['k_cco_rep'], 1e-12)}</td>
            <td>{sc(r['r_vco_rep'], 1e-3)}</td>
            <td>{sc(r['c_in_rep'], 1e15)}</td>
        </tr>'''
        png_name = f'rc_{corner}_T{temp}_Vp{vp}.png'
        rc_imgs += f'''<div class="card">
            <h3>{corner} - T={temp}C - VDD={vp}V</h3>
            <img src="{png_name}" style="max-width:100%">
        </div>'''

    html_rc_panel = f'''
<div id="rc" class="panel">
    <h2>R/C i wzmocnienia VCO</h2>
    <table class="summary">
        <thead><tr>
            <th>Corner</th><th>TEMP</th><th>VDD</th>
            <th>K [Hz/V]</th><th>gm [mA/V]</th>
            <th>K<sub>CCO</sub> [THz/A]</th><th>r<sub>vco</sub> [kOhm]</th>
            <th>C [fF]</th>
        </tr></thead>
        <tbody>{rc_rows}</tbody>
    </table>
    <p style="font-size:13px;color:#555;margin-top:10px">
        Definicje: K = df/dVin [Hz/V], gm = di<sub>osc</sub>/dVin [mA/V],
        K<sub>CCO</sub> = df/di<sub>osc</sub> [THz/A],
        r<sub>vco</sub> = dv<sub>osc</sub>(pk-pk)/di<sub>osc</sub> [kOhm].
        i<sub>osc</sub> = srednia i(V2) (prad rdzenia), v<sub>osc</sub> = amplituda
        pk-pk v(out). C z analizy .ac: C = |Im(i(V1))| / (2&pi;f) przy f = 1 MHz.
        Wartosci w tabeli to mediana lokalnych roznic po sweepie Vin; krzywe
        ponizej pokazuja zaleznosc od Vin.
    </p>
    {rc_imgs}
</div>'''

html_detail_panels = ''
for tag, corner, temp, vp, vin, m in summary:
    png_name = f'vco_{tag}.png'
    freq_out = m.get('freq_out')
    color = '#2a2' if freq_out else 'gray'
    inner = f'''
    <h2>{corner} - T={temp}C - VDD={vp}V - Vin={vin}V</h2>
    <div class="card">
        <h3>f<sub>out</sub> = <span style="color:{color};font-weight:bold">
        {fmth(freq_out, 1e-6, "MHz", 3)}</span></h3>
        <img src="{png_name}" style="max-width:100%">
    </div>
    <div class="metrics-grid">
        <div class="mcard">
            <div class="mcard-title">v(out)</div>
            <div class="mrow"><span>Czestotliwosc</span><span>{fmth(m.get("freq_out"), 1e-6, "MHz", 3)}</span></div>
            <div class="mrow"><span>Czas narastania</span><span>{fmth(m.get("tr_out"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Czas opadania</span><span>{fmth(m.get("tf_out"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Duty cycle</span><span>{fmth(m.get("dc_out"), 1, "%", 1)}</span></div>
        </div>
        <div class="mcard">
            <div class="mcard-title">v(out_pb)</div>
            <div class="mrow"><span>Czestotliwosc</span><span>{fmth(m.get("freq_pb"), 1e-6, "MHz", 3)}</span></div>
            <div class="mrow"><span>Czas narastania</span><span>{fmth(m.get("tr_pb"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Czas opadania</span><span>{fmth(m.get("tf_pb"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Duty cycle</span><span>{fmth(m.get("dc_pb"), 1, "%", 1)}</span></div>
        </div>
        <div class="mcard">
            <div class="mcard-title">Zasilanie V2 (VDD={vp}V)</div>
            <div class="mrow"><span>Avg I<sub>vdd</sub></span><span>{fmth(m.get("i_avg_v2"), 1, "mA", 3)}</span></div>
            <div class="mrow"><span>Max I<sub>vdd</sub></span><span>{fmth(m.get("i_max_v2"), 1, "mA", 3)}</span></div>
            <div class="mrow"><span>Avg P<sub>diss</sub></span><span>{
                fmth(m.get("i_avg_v2") * float(vp) if m.get("i_avg_v2") is not None else None, 1, "mW", 3)
            }</span></div>
        </div>
    </div>'''
    html_detail_panels += f'<div id="{tag}" class="panel">{inner}</div>\n'

html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>VCO Sweep Report</title>
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
    .card {{ margin-bottom: 20px; border: 1px solid #ddd; border-radius: 6px; padding: 12px; }}
    table.summary {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
    table.summary th {{ background: #27ae60; color: white; padding: 8px; text-align: center; }}
    table.summary td {{ padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
    tr.corner-header td {{ background: #e8f5e9; font-size: 14px; padding: 8px; text-align: left; }}
    tr.vin-header td {{ background: #f0f7ff; font-size: 12px; padding: 5px 10px; text-align: left; color: #555; font-style: italic; }}
    .legend {{ margin-top: 12px; display: flex; gap: 20px; font-size: 13px; }}
    .leg-ok   {{ color: #2a2; }}
    .leg-warn {{ color: #e80; }}
    .leg-err  {{ color: #d00; }}
    .metrics-grid {{ display: flex; gap: 16px; flex-wrap: wrap; margin-top: 16px; }}
    .mcard {{ flex: 1; min-width: 200px; border: 1px solid #ddd; border-radius: 6px;
              padding: 12px; background: #fafafa; }}
    .mcard-title {{ font-weight: bold; color: #27ae60; margin-bottom: 8px;
                    font-size: 14px; border-bottom: 1px solid #ddd; padding-bottom: 4px; }}
    .mrow {{ display: flex; justify-content: space-between; padding: 4px 0;
             font-size: 13px; border-bottom: 1px solid #f0f0f0; }}
    .mrow span:last-child {{ font-weight: bold; color: #333; }}
</style>
</head>
<body>
<h1>VCO Sweep Report</h1>
<div class="tabs">
{html_tabs}
</div>
{html_summary_panel}
{html_kvco_panel}
{html_rc_panel}
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

html_path = os.path.join(RESULTS_DIR, 'vco_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
