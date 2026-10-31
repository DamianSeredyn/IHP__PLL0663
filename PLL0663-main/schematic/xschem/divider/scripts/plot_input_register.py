import sys
import re
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')
SPICE_PATH  = os.path.join(PROJECT_DIR, 'divider', 'simulations',
                           'input_register_no_sym_tb.spice')
os.makedirs(RESULTS_DIR, exist_ok=True)

# ── Konfiguracja sygnalow ─────────────────────────────────────────────────────
# wrdata zapisuje 16 sygnalow → 32 kolumny:
#   v(d) v(clk_buf) v(data_en) v(d0)..v(d12)
# Kolejnosc MUSI byc zgodna z linia wrdata w run_sweep_input_register.sh

N_FF = 13  # liczba przerzutnikow (d0..d12)
SIGNALS = ['d', 'clk_buf', 'data_en'] + [f'd{i}' for i in range(N_FF)]

# ── Konfiguracja probkowania ──────────────────────────────────────────────────
BIT_PERIOD_NS         = 10.0   # czas jednego bitu na wejsciu V3
# Okno probkowania d0..d12 jest wyliczane automatycznie z V4 (data_en).
# Start = data_en_fall + SAMPLE_MARGIN_NS,  szerokosc = SAMPLE_WIDTH_NS.
# Dzieki temu zmiana V3/V4 nie wymaga edycji skryptu.
SAMPLE_MARGIN_NS      = 8.0    # odstep od zbocza data_en do poczatku okna
SAMPLE_WIDTH_NS       = 10.0   # szerokosc okna probkowania
# Fallback gdy V4 brak / nie ma opadajacego zbocza — uzyj stalego okna:
SAMPLE_FALLBACK_START_NS = 280.0
SAMPLE_FALLBACK_END_NS   = 290.0

# Mapowanie pozycji w sekwencji szeregowej do numeru przerzutnika.
# Sekwencja jest wsuwana MSB-first: pierwszy bit dochodzi do d12, ostatni zostaje w d0.
# bit_index 0 = pierwszy wsuniety = d12,  bit_index N-1 = ostatni = d0
def expected_ff_for_bit(bit_index, n_bits):
    return n_bits - 1 - bit_index   # bit 0 → d(N-1), bit N-1 → d0

# ── Parsowanie PWL z netlisty V3 ──────────────────────────────────────────────
def _scale(suffix):
    return {'': 1.0, 'f': 1e-15, 'p': 1e-12, 'n': 1e-9, 'u': 1e-6,
            'm': 1e-3, 'k': 1e3, 'meg': 1e6, 'g': 1e9}.get(suffix.lower(), 1.0)

def _to_float(token):
    m = re.match(r'^([-+]?\d*\.?\d+(?:[eE][-+]?\d+)?)([a-zA-Z]*)$', token.strip())
    if not m:
        return None
    val = float(m.group(1))
    suf = m.group(2)
    if suf:
        # ngspice quirk: trailing letters after the unit are ignored (e.g. "10ns" → 10n)
        for s in ('meg', 'f', 'p', 'n', 'u', 'm', 'k', 'g'):
            if suf.lower().startswith(s):
                return val * _scale(s)
    return val

def collect_params(spice_path):
    """Zbiera wszystkie .param name=value z netlisty (gdzie value to liczba lub
    odniesienie do innego parametru). Zwraca dict {name_lower: float}.
    Obsluga prosta — bez wyrazen arytmetycznych, tylko literaly i {odniesienia}."""
    params = {}
    with open(spice_path) as f:
        src = f.read()
    # Sklej kontynuacje
    lines = []
    for line in src.splitlines():
        if line.startswith('+') and lines:
            lines[-1] += ' ' + line.lstrip('+').strip()
        else:
            lines.append(line)

    # Mozemy potrzebowac wielu przebiegow zeby rozwiazac lancuchy odniesien
    raw = {}
    for line in lines:
        # Akceptuj kilka .param w jednej linii, np. ".param a=1 b=2"
        # Najpierw upewnij sie ze linia zaczyna sie od .param
        m_head = re.match(r'^\s*\.param\b(.*)', line, flags=re.IGNORECASE)
        if not m_head:
            continue
        rest = m_head.group(1)
        for m in re.finditer(r'(\w+)\s*=\s*(\{[^}]+\}|\S+)', rest):
            name = m.group(1).lower()
            val  = m.group(2).strip()
            raw[name] = val

    # Rozwiazujemy wartosci: jesli to {ref}, podstaw juz rozwiazany param;
    # w przeciwnym razie probuj _to_float.
    for _ in range(8):  # max 8 przebiegow — w praktyce wystarczy 1-2
        progress = False
        for name, val in list(raw.items()):
            if name in params:
                continue
            v = val
            # {ref} → wartosc innego parametru
            m_brace = re.match(r'^\{(\w+)\}$', v)
            if m_brace:
                ref = m_brace.group(1).lower()
                if ref in params:
                    params[name] = params[ref]
                    progress = True
                continue
            # Literal liczbowy
            fv = _to_float(v)
            if fv is not None:
                params[name] = fv
                progress = True
        if not progress:
            break

    return params

def _resolve_token(token, params):
    """Zamien token na float — obsluga literalu liczbowego lub {param}."""
    token = token.strip()
    m = re.match(r'^\{(\w+)\}$', token)
    if m:
        return params.get(m.group(1).lower())
    # Goly identyfikator parametru (bez nawiasow) — tez akceptujemy
    if re.match(r'^[A-Za-z_]\w*$', token):
        return params.get(token.lower())
    return _to_float(token)

def parse_pwl(spice_path, src_name, params=None):
    """Wyciaga z netlisty linie <src_name> ... PWL(...) i zwraca liste (t, v).
    src_name to nazwa zrodla, np. 'V3', 'V4' (case-insensitive).
    params: opcjonalny dict z .param zebranymi przez collect_params() — pozwala
    rozwiazac {vdd} i podobne odniesienia w PWL."""
    if params is None:
        params = collect_params(spice_path)
    with open(spice_path) as f:
        src = f.read()
    # Sklej kontynuacje (+) w jedna linie
    lines = []
    for line in src.splitlines():
        if line.startswith('+') and lines:
            lines[-1] += ' ' + line.lstrip('+').strip()
        else:
            lines.append(line)

    pattern = re.compile(
        rf'^\s*{re.escape(src_name)}\s+\S+\s+\S+\s+PWL\s*\((.*)\)\s*$',
        flags=re.IGNORECASE)
    for line in lines:
        m = pattern.match(line)
        if m:
            tokens = re.split(r'[\s,]+', m.group(1).strip())
            tokens = [t for t in tokens if t]
            pts = []
            for i in range(0, len(tokens) - 1, 2):
                t = _resolve_token(tokens[i], params)
                v = _resolve_token(tokens[i+1], params)
                if t is None or v is None:
                    continue
                pts.append((t, v))
            return pts
    return None

# Wsteczna kompatybilnosc
def parse_v3_pwl(spice_path):
    return parse_pwl(spice_path, 'V3')

def find_falling_edge(pwl_pts, vdd):
    """Zwraca czas pierwszego opadajacego zbocza (przejscie ponizej vdd/2),
    lub None gdy brak. Uzywane do znalezienia 'data_en falls'."""
    if not pwl_pts or len(pwl_pts) < 2:
        return None
    threshold = vdd * 0.5
    t_arr = np.array([p[0] for p in pwl_pts])
    v_arr = np.array([p[1] for p in pwl_pts])
    above = v_arr > threshold
    for i in range(1, len(above)):
        if above[i-1] and not above[i]:
            # interpolacja liniowa miedzy probkami i-1 a i
            t0, t1 = t_arr[i-1], t_arr[i]
            v0, v1 = v_arr[i-1], v_arr[i]
            if v1 == v0:
                return t1
            return t0 + (threshold - v0) * (t1 - t0) / (v1 - v0)
    return None

def decode_pwl_to_bits(pwl_pts, bit_period_s, vdd, end_time_s=None):
    """
    Decoduje PWL na sekwencje bitow probkowana co bit_period_s.
    Punkt startowy = pierwsze rosnace zbocze (poziom > vdd/2).
    Probkujemy w srodku kazdego okna bitowego.
    end_time_s: jesli podane, dekoduj az ostatnia probka <= end_time_s.
                Jesli None, dekoduj do konca PWL (i obcinamy koncowe zera —
                tryb fallback gdy nie znamy konca danych).
    Zwraca: (bits_str, start_time_s, sample_times_list)
    """
    if not pwl_pts or len(pwl_pts) < 2:
        return '', None, []

    threshold = vdd * 0.5
    t_arr = np.array([p[0] for p in pwl_pts])
    v_arr = np.array([p[1] for p in pwl_pts])

    # Pierwsze przekroczenie progu w gore
    above = v_arr > threshold
    rising = None
    for i in range(1, len(above)):
        if above[i] and not above[i-1]:
            rising = t_arr[i]
            break
    if rising is None:
        return '', None, []

    # Granica probkowania: koniec danych (data_en fall) albo koniec PWL
    t_limit = end_time_s if end_time_s is not None else t_arr[-1]

    sample_times = []
    bits = []
    k = 0
    while True:
        # srodek k-tego okna: rising + (k + 0.5) * bit_period
        t_sample = rising + (k + 0.5) * bit_period_s
        if t_sample > t_limit:
            break
        v = np.interp(t_sample, t_arr, v_arr)
        bits.append('1' if v > threshold else '0')
        sample_times.append(t_sample)
        k += 1

    bits_str = ''.join(bits)

    if end_time_s is None:
        # Fallback: bez znanego konca obcinamy koncowe zera
        s = bits_str.rstrip('0')
        if not s:
            return bits_str, rising, sample_times
        last_one = len(s)
        return bits_str[:last_one], rising, sample_times[:last_one]

    # Z znanym koncem zwracamy pelna sekwencje (zera tez sie licza)
    return bits_str, rising, sample_times


# ── Wczytanie pliku .dat ──────────────────────────────────────────────────────
def load_dat(path):
    expected_cols = 2 * len(SIGNALS)
    try:
        data = np.loadtxt(path, skiprows=1)
        if data.ndim < 2 or data.shape[1] < expected_cols:
            print(f"  [WARN] {path}: oczekiwano {expected_cols} kolumn, jest {data.shape}")
            return None
        out = {}
        for i, key in enumerate(SIGNALS):
            out[f'time_{key}'] = data[:, 2*i]
            out[key]           = data[:, 2*i + 1]
        return out
    except Exception as e:
        print(f"  [WARN] Nie mozna odczytac {path}: {e}")
        return None


# ── Probkowanie d0..d12 w oknie 280-290 ns ────────────────────────────────────
def sample_ff_outputs(d, vdd, t_start_s, t_end_s):
    """Zwraca {ff_name: (v_avg, bit_str)} dla kazdego d0..d12."""
    threshold = vdd * 0.5
    result = {}
    for i in range(N_FF):
        key = f'd{i}'
        if key not in d:
            result[key] = (None, '?')
            continue
        t = d[f'time_{key}']
        v = d[key]
        mask = (t >= t_start_s) & (t <= t_end_s)
        if not np.any(mask):
            result[key] = (None, '?')
            continue
        v_avg = float(np.mean(v[mask]))
        bit = '1' if v_avg > threshold else '0'
        result[key] = (v_avg, bit)
    return result


# ── Porownanie oczekiwane vs zmierzone ────────────────────────────────────────
def compare_bits(expected_bits, ff_samples):
    """
    expected_bits: string '1101000101001' (MSB-first, bit 0 = pierwszy wsuniety = d12)
    ff_samples:    dict {dN: (v, bit)}
    Zwraca: list of (bit_index, ff_name, expected, measured, ok)
    """
    rows = []
    n = len(expected_bits)
    for bit_idx, exp_bit in enumerate(expected_bits):
        ff_idx = expected_ff_for_bit(bit_idx, n)
        ff_name = f'd{ff_idx}'
        v_avg, meas_bit = ff_samples.get(ff_name, (None, '?'))
        ok = (meas_bit == exp_bit)
        rows.append((bit_idx, ff_name, exp_bit, meas_bit, v_avg, ok))
    return rows


# ── Parsowanie taga ───────────────────────────────────────────────────────────
def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p.replace('T','')  for p in parts if p.startswith('T')
                 and p != parts[0] and p != parts[1]), '?')
    vp   = next((p.replace('Vp','') for p in parts if p.startswith('Vp')), '?')
    return corner, temp, vp


# ── Wykres ────────────────────────────────────────────────────────────────────
def make_plot(d, expected_bits, cmp_rows, tag, out_path, vdd,
              sample_start_ns, sample_end_ns):
    corner, temp, vp = parse_tag(tag)

    fig = plt.figure(figsize=(16, 9))
    fig.suptitle(f'Input Register — {tag}', fontsize=13, fontweight='bold')

    def safe(arr):
        a = np.array(arr, dtype=np.float64)
        a[~np.isfinite(a)] = np.nan
        return a

    # Ax1: V3 input + clk_buf + data_en (caly przebieg)
    ax1 = fig.add_subplot(2, 3, 1)
    if d is not None:
        ax1.plot(safe(d['time_d'])*1e9, safe(d['d']),
                 color='royalblue', linewidth=0.8, label='v(d) — V3')
        ax1.plot(safe(d['time_clk_buf'])*1e9, safe(d['clk_buf']),
                 color='gray', linewidth=0.5, alpha=0.5, label='clk_buf')
        ax1.plot(safe(d['time_data_en'])*1e9, safe(d['data_en']),
                 color='green', linewidth=0.8, label='data_en')
        try:
            ax1.set_ylim(-0.1, float(vp)+0.15)
        except Exception:
            pass
    ax1.set_xlabel('Czas [ns]')
    ax1.set_ylabel('Napiecie [V]')
    ax1.set_title('Sygnaly wejsciowe')
    ax1.legend(fontsize=8, loc='upper right')
    ax1.grid(True, alpha=0.3)

    # Ax2: d0..d12 (caly przebieg, ulozone pionowo z offsetem)
    ax2 = fig.add_subplot(2, 3, 2)
    if d is not None:
        try:
            vdd_f = float(vp)
        except Exception:
            vdd_f = 1.2
        offset = vdd_f * 1.1
        cmap = plt.get_cmap('viridis')
        for i in range(N_FF):
            key = f'd{i}'
            if key in d:
                y = safe(d[key]) + i * offset
                ax2.plot(safe(d[f'time_{key}'])*1e9, y,
                         color=cmap(i / max(N_FF-1, 1)), linewidth=0.6)
                ax2.text(0, i * offset + vdd_f/2, key, fontsize=7,
                         va='center', ha='right', color=cmap(i / max(N_FF-1, 1)))
        # zaznacz okno probkowania (auto-derived)
        ax2.axvspan(sample_start_ns, sample_end_ns,
                    color='orange', alpha=0.2, label='okno probki')
        ax2.legend(fontsize=8, loc='lower right')
    ax2.set_xlabel('Czas [ns]')
    ax2.set_ylabel('FF (offset)')
    ax2.set_title('Wyjscia d0..d12 (ulozone)')
    ax2.grid(True, alpha=0.3)
    ax2.set_yticks([])

    # Ax3: tabela bit-by-bit comparison
    ax3 = fig.add_subplot(2, 3, 3)
    ax3.axis('off')
    table_rows = []
    for bit_idx, ff_name, exp, meas, v_avg, ok in cmp_rows:
        v_str = f'{v_avg:.3f}' if v_avg is not None else 'N/A'
        table_rows.append([
            str(bit_idx), ff_name, exp, meas, v_str, 'PASS' if ok else 'FAIL'
        ])
    if table_rows:
        t3 = ax3.table(cellText=table_rows,
                       colLabels=['bit#', 'FF', 'exp', 'meas', 'v_avg [V]', 'status'],
                       cellLoc='center', loc='center',
                       colWidths=[0.10, 0.13, 0.10, 0.12, 0.20, 0.18])
        t3.auto_set_font_size(False); t3.set_fontsize(8); t3.scale(1, 1.15)
        # koloruj pass/fail
        for i, row in enumerate(table_rows):
            color = '#ccffcc' if row[5] == 'PASS' else '#ffcccc'
            t3[i+1, 5].set_facecolor(color)
    ax3.set_title('Porownanie bitow (oczekiwany vs zmierzony)', pad=10)

    # Ax4: sekwencja jako tekst + wynik
    ax4 = fig.add_subplot(2, 3, 4)
    ax4.axis('off')
    measured_bits = ''.join(r[3] for r in cmp_rows)
    n_pass = sum(1 for r in cmp_rows if r[5])
    n_total = len(cmp_rows)
    overall = 'PASS' if n_pass == n_total and n_total > 0 else 'FAIL'
    rows4 = [
        ['Oczekiwana sekwencja (bit0..N)', _fmt_bits(expected_bits)],
        ['Zmierzona  sekwencja (bit0..N)', _fmt_bits(measured_bits)],
        ['Bity zgodne',                    f'{n_pass} / {n_total}'],
        ['Wynik calosci',                  overall],
    ]
    t4 = ax4.table(cellText=rows4,
                   colLabels=['Parametr', 'Wartosc'],
                   cellLoc='left', loc='center', colWidths=[0.35, 0.65])
    t4.auto_set_font_size(False); t4.set_fontsize(9); t4.scale(1, 1.6)
    color = '#ccffcc' if overall == 'PASS' else '#ffcccc'
    t4[4, 1].set_facecolor(color)
    ax4.set_title('Sekwencja wejscia i wynik', pad=10)

    # Ax5: warunki symulacji
    ax5 = fig.add_subplot(2, 3, 5)
    ax5.axis('off')
    rows5 = [
        ['Corner',          corner],
        ['Temperatura [C]', temp],
        ['VDD [V]',         vp],
        ['Bit period [ns]', f'{BIT_PERIOD_NS:.1f}'],
        ['Okno probki',     f'{sample_start_ns:.2f}–{sample_end_ns:.2f} ns'],
        ['Prog logiczny',   f'{vdd*0.5:.3f} V'],
        ['Mapowanie',       'bit0 → d12, bitN → d0'],
    ]
    t5 = ax5.table(cellText=rows5,
                   colLabels=['Parametr', 'Wartosc'],
                   cellLoc='left', loc='center', colWidths=[0.5, 0.5])
    t5.auto_set_font_size(False); t5.set_fontsize(10); t5.scale(1, 1.55)
    ax5.set_title('Warunki symulacji', pad=10)

    # Ax6: puste miejsce (mozna potem dodac dodatkowe metryki)
    ax6 = fig.add_subplot(2, 3, 6)
    ax6.axis('off')

    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()


def _fmt_bits(bits):
    """Wstawia spacje co 4 bity dla czytelnosci."""
    return ' '.join(bits[i:i+4] for i in range(0, len(bits), 4))


if __name__ == '__main__':
    # ── Wczytaj V3 (dane) i V4 (data_en) z netlisty ──────────────────────────
    pwl_params = collect_params(SPICE_PATH)
    pwl_v3 = parse_pwl(SPICE_PATH, 'V3', pwl_params)
    pwl_v4 = parse_pwl(SPICE_PATH, 'V4', pwl_params)
    if pwl_v3 is None:
        print(f"BLAD: nie znaleziono V3 PWL w {SPICE_PATH}")
        sys.exit(1)

    # Do dekodowania PWL uzywamy nominalnego vdd (PWL ma poziomy 0/1.2);
    # faktyczny prog dla probkowania d0..d12 uzywa vp z taga.
    _VDD_NOMINAL = 1.2

    # Znajdz opadajace zbocze data_en (V4) — to konczy okno przyjmowania danych
    data_en_fall_s = None
    if pwl_v4 is not None:
        data_en_fall_s = find_falling_edge(pwl_v4, _VDD_NOMINAL)

    if data_en_fall_s is not None:
        # Decoduj dokladnie do data_en_fall, nie obcinaj koncowych zer
        expected_bits, t_start_pwl, _ = decode_pwl_to_bits(
            pwl_v3, BIT_PERIOD_NS * 1e-9, _VDD_NOMINAL,
            end_time_s=data_en_fall_s)
        sample_start_s = data_en_fall_s + SAMPLE_MARGIN_NS * 1e-9
        sample_end_s   = sample_start_s + SAMPLE_WIDTH_NS * 1e-9
        window_source = f'data_en fall @ {data_en_fall_s*1e9:.2f} ns'
    else:
        # Fallback: bez V4 stripujemy koncowe zera i bierzemy stale okno
        print("[WARN] V4/data_en nie znalezione — fallback do staticznego okna.")
        expected_bits, t_start_pwl, _ = decode_pwl_to_bits(
            pwl_v3, BIT_PERIOD_NS * 1e-9, _VDD_NOMINAL)
        sample_start_s = SAMPLE_FALLBACK_START_NS * 1e-9
        sample_end_s   = SAMPLE_FALLBACK_END_NS   * 1e-9
        window_source = 'fallback (stale okno)'

    sample_start_ns = sample_start_s * 1e9
    sample_end_ns   = sample_end_s   * 1e9

    print(f"Sekwencja V3 (bit0 = pierwszy wsuniety): {_fmt_bits(expected_bits)}")
    print(f"Liczba bitow: {len(expected_bits)}")
    if t_start_pwl is not None:
        print(f"Start sekwencji (1. zbocze V3): {t_start_pwl*1e9:.2f} ns")
    else:
        print("Start sekwencji: BRAK rosnacego zbocza w V3 PWL")
    print(f"Okno probkowania d0..d12: {sample_start_ns:.2f}–{sample_end_ns:.2f} ns "
          f"({window_source})")
    print()

    if not expected_bits:
        print("BLAD: nie udalo sie zdekodowac zadnych bitow z V3 PWL.")
        print("Sprawdz czy V3 jest poprawnie zdefiniowane i czy parametry")
        print("uzyte w PWL (np. {vdd}) sa zdefiniowane przez .param.")
        sys.exit(1)


    # ── Glowna petla po plikach .dat ──────────────────────────────────────────────
    dat_files = sorted(glob.glob(os.path.join(DATA_DIR, 'input_register_*.dat')))
    if not dat_files:
        print("Brak plikow .dat w", DATA_DIR)
        sys.exit(1)

    summary = []
    total_files = len(dat_files)
    for idx, filepath in enumerate(dat_files, 1):
        tag = os.path.basename(filepath).replace('input_register_', '').replace('.dat', '')
        corner, temp, vp = parse_tag(tag)

        d = load_dat(filepath)
        cmp_rows = []
        n_pass = 0
        overall = 'FAIL'

        try:
            vdd_f = float(vp)
        except Exception:
            vdd_f = _VDD_NOMINAL

        if d is not None:
            samples = sample_ff_outputs(
                d, vdd_f, sample_start_s, sample_end_s)
            cmp_rows = compare_bits(expected_bits, samples)
            n_pass = sum(1 for r in cmp_rows if r[5])
            overall = 'PASS' if n_pass == len(cmp_rows) and len(cmp_rows) > 0 else 'FAIL'

        out_png = os.path.join(RESULTS_DIR, f'input_register_{tag}.png')
        try:
            make_plot(d, expected_bits, cmp_rows, tag, out_png, vdd_f,
                      sample_start_ns, sample_end_ns)
        except Exception as e:
            sys.stderr.write(f"  [WARN] Blad wykresu {tag}: {e}\n")
            plt.close('all')

        pct = idx * 100 // total_files
        print(f"\r{pct}% of report done", end='', flush=True)

        measured_bits = ''.join(r[3] for r in cmp_rows) if cmp_rows else ''
        summary.append({
            'tag': tag, 'corner': corner, 'temp': temp, 'vp': vp,
            'cmp_rows': cmp_rows,
            'measured': measured_bits,
            'n_pass': n_pass,
            'n_total': len(cmp_rows),
            'overall': overall,
        })

    print()

    corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
    summary.sort(key=lambda x: (corner_order.get(x['corner'], 99),
                                float(x['temp']) if x['temp'] != '?' else 0,
                                float(x['vp'])   if x['vp']   != '?' else 0))


    # ── Terminal summary ──────────────────────────────────────────────────────────
    print()
    current_corner_t = None
    for s in summary:
        if s['corner'] != current_corner_t:
            current_corner_t = s['corner']
            print(f"\n{s['corner']}")
            print(f"  {'TEMP':>6}  {'VDD':>5}  {'BITS PASS':>10}  {'STATUS':>7}  measured")
            print('  ' + '-' * 70)
        status_str = s['overall']
        pass_str = f"{s['n_pass']}/{s['n_total']}"
        print(f"  {s['temp']+'°C':>6}  {s['vp']+'V':>5}  "
              f"{pass_str:>10}  "
              f"{status_str:>7}  {_fmt_bits(s['measured'])}")
    print()
    print(f"Oczekiwana sekwencja: {_fmt_bits(expected_bits)}")
    print()


    # ── HTML ──────────────────────────────────────────────────────────────────────
    def status_color(ok_str):
        return '#ccffcc' if ok_str == 'PASS' else '#ffcccc'

    # Zakladki
    html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
    for s in summary:
        label = f'{s["corner"]} T{s["temp"]} {s["vp"]}V'
        html_tabs += f'<button class="tab" onclick="showTab(\'{s["tag"]}\', this)">{label}</button>\n'

    # Tabela podsumowania
    summary_rows = ''
    current_corner = None
    for s in summary:
        if s['corner'] != current_corner:
            current_corner = s['corner']
            summary_rows += (
                f'<tr class="corner-header"><td colspan="6">'
                f'<b>{s["corner"]}</b></td></tr>\n')
        summary_rows += f'''<tr>
            <td>{s["temp"]} °C</td>
            <td>{s["vp"]} V</td>
            <td>{s["n_pass"]} / {s["n_total"]}</td>
            <td style="background:{status_color(s["overall"])} !important">
                <b>{s["overall"]}</b>
            </td>
            <td style="font-family:monospace">{_fmt_bits(expected_bits)}</td>
            <td style="font-family:monospace">{_fmt_bits(s["measured"])}</td>
        </tr>'''

    html_summary_panel = f'''
    <div id="summary" class="panel active">
        <h2>Podsumowanie — Input Register</h2>
        <p>Oczekiwana sekwencja:
           <code style="font-size:14px">{_fmt_bits(expected_bits)}</code>
           ({len(expected_bits)} bitow, MSB-first wsuwana, bit0 → d{N_FF-1})</p>
        <p>Okno probkowania: <b>{sample_start_ns:.2f}–{sample_end_ns:.2f} ns</b></p>
        <table class="summary">
            <thead><tr>
                <th>TEMP</th><th>VDD</th>
                <th>Bity zgodne</th><th>Status</th>
                <th>Oczekiwana sekwencja</th><th>Zmierzona sekwencja</th>
            </tr></thead>
            <tbody>{summary_rows}</tbody>
        </table>
    </div>'''

    # Panel dla kazdej kombinacji
    html_detail_panels = ''
    for s in summary:
        png_name = f'input_register_{s["tag"]}.png'
        rows_html = ''
        for bit_idx, ff_name, exp, meas, v_avg, ok in s['cmp_rows']:
            v_str = f'{v_avg:.3f}' if v_avg is not None else 'N/A'
            bg = '#ccffcc' if ok else '#ffcccc'
            rows_html += (
                f'<tr><td>{bit_idx}</td><td>{ff_name}</td>'
                f'<td>{exp}</td><td>{meas}</td><td>{v_str}</td>'
                f'<td style="background:{bg}">{"PASS" if ok else "FAIL"}</td></tr>'
            )
        inner = f'''
        <h2>{s["corner"]} — T={s["temp"]}°C — VDD={s["vp"]}V</h2>
        <div class="card">
            <h3>Wynik: <span style="color:{
                "#2a7" if s["overall"]=="PASS" else "#c22"
            };font-weight:bold">{s["overall"]}</span>
            ({s["n_pass"]} / {s["n_total"]} bitow zgodnych)</h3>
            <img src="{png_name}" style="max-width:100%">
        </div>
        <div class="card">
            <h3>Bit-by-bit</h3>
            <table class="bits">
                <thead><tr>
                    <th>bit#</th><th>FF</th><th>exp</th><th>meas</th>
                    <th>v_avg [V]</th><th>status</th>
                </tr></thead>
                <tbody>{rows_html}</tbody>
            </table>
        </div>'''
        html_detail_panels += f'<div id="{s["tag"]}" class="panel">{inner}</div>\n'

    html = f'''<!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8">
    <title>Input Register Sweep Report</title>
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
        table.summary, table.bits {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
        table.summary th, table.bits th {{
            background: #27ae60; color: white; padding: 8px; text-align: center; }}
        table.summary td, table.bits td {{
            padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
        tr.corner-header td {{ background: #e8f5e9; font-size: 14px;
                               padding: 8px; text-align: left; }}
        code {{ background: #f4f4f4; padding: 2px 6px; border-radius: 3px;
                font-family: monospace; }}
    </style>
    </head>
    <body>
    <h1>Input Register Sweep Report</h1>
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

    html_path = os.path.join(RESULTS_DIR, 'input_register_report.html')
    with open(html_path, 'w') as f:
        f.write(html)
    print(f"Zapisano raport: {html_path}")
