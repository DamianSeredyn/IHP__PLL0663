#!/bin/bash
# ==============================================================================
# SWEEP MUX 8:1 — corner / temperatura / VDD
# ------------------------------------------------------------------------------
# Analogiczny do run_sweep.sh dzielnika. Symuluje MUX_8to1_tb.spice i zapisuje
# przebiegi zegara wejsciowego (clk) oraz wyjscia (out).
#
# Adres MUX-a steruja zrodla V3/V4/V5 (wezly a1/a0/a2). Adres przelacza sie
# co staly odstep czasu, dzieki czemu na wyjsciu pojawia sie kolejno clk,
# clk/2, clk/4, ... clk/128. Przed symulacjami skrypt PARSUJE V3/V4/V5 i
# zapisuje plan przedzialow pomiarowych do mux_slots.json — plot_mux.py
# uzywa go, by wiedziec w ktorym oknie czasowym jaka czestotliwosc jest
# oczekiwana. Dzieki temu przedzialy sa "dobrane na podstawie ustawien V3/V4/V5".
#
# Plik wklej do  mux/scripts/  (lub innego bloku) i uruchamiaj stamtad.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data

# ── Presety (-c <preset lub corner>) ──────────────────────────────────────────
#   typ → mos_tt, t_nom, vp_nom | hot → mos_ss, t_max, vp_min | cold → mos_ff, t_min, vp_max
#   mozna podac cornery wprost: -c tt ss ff ; bez argumentow → pelny sweep
# ──────────────────────────────────────────────────────────────────────────────

FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
PRESET=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c) shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)
                        PRESET="typ"
                        FILTER_CORNERS="$FILTER_CORNERS mos_tt"
                        FILTER_TEMPS="$t_nom"
                        FILTER_VPS="$vp_nom"
                        ;;
                    hot)
                        PRESET="hot"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ss"
                        FILTER_TEMPS="$t_max"
                        FILTER_VPS="$vp_min"
                        ;;
                    cold)
                        PRESET="cold"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ff"
                        FILTER_TEMPS="$t_min"
                        FILTER_VPS="$vp_max"
                        ;;
                    *)
                        FILTER_CORNERS="$FILTER_CORNERS $1"
                        ;;
                esac
                shift
            done ;;
        *) echo "Nieznana opcja: $1"; exit 1 ;;
    esac
done

if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

if [[ -n "$FILTER_CORNERS" ]]; then
    filtered=""
    for C in $corners; do
        for F in $FILTER_CORNERS; do
            if [[ "$C" == *"$F"* ]]; then
                filtered="$filtered $C"
                break
            fi
        done
    done
    if [[ -z "$filtered" ]]; then
        echo "Błąd: żaden corner nie pasuje do: $FILTER_CORNERS"
        echo "Dostępne cornery: $corners"
        exit 1
    fi
    corners="$filtered"
fi

SIM_NAME="mux"
SPICE=$PROJECT_DIR/divider/simulations/MUX_8to1_tb.spice
DATA_DIR=$PROJECT_DIR/divider/results/data
RESULTS_DIR=$PROJECT_DIR/divider/results

if [[ -n "$PRESET" ]]; then
    echo "Preset: $PRESET → corners:$corners  temp: $FILTER_TEMPS  vp: $FILTER_VPS"
else
    echo "Symulowane cornery: wszystkie ($corners)"
fi

echo "Simulation parameters:"
python3 - "$SPICE" <<'PYEOF'
import re, sys
spice_path = sys.argv[1]
skip = {'temp', 'vdd'}
with open(spice_path) as f:
    for line in f:
        m = re.match(r'\.param\s+(\w+)\s*=\s*(\S+)', line.strip(), re.IGNORECASE)
        if m and m.group(1).lower() not in skip:
            print(f"  {m.group(1)}={m.group(2)}")
PYEOF

mkdir -p $DATA_DIR

# ── Wyznacz przedzialy pomiarowe z V3/V4/V5 → mux_slots.json ──────────────────
echo "Przedzialy pomiarowe (z V3/V4/V5):"
python3 - "$SPICE" "$DATA_DIR/mux_slots.json" <<'PYEOF'
import re, sys, json
spice_path, json_path = sys.argv[1:]

def spice_num(s):
    s = s.strip()
    suff = {'f':1e-15,'p':1e-12,'n':1e-9,'u':1e-6,'m':1e-3,'k':1e3,'g':1e9,'t':1e12}
    m = re.match(r'^([-+]?[\d.]+(?:[eE][-+]?\d+)?)\s*([a-zA-Z]*)$', s)
    if not m:
        return None
    val = float(m.group(1)); u = m.group(2).lower()
    if u.startswith('meg'): val *= 1e6
    elif u and u[0] in suff: val *= suff[u[0]]
    return val

spice = open(spice_path).read()

# === USER EDIT === nazwy zrodel adresowych (LSB->MSB nie ma znaczenia,
# kolejnosc wyznaczana jest po okresie PULSE; tu wystarczy je wymienic).
ADDR_SOURCES = ['V3', 'V4', 'V5']

# Okno pomiaru wewnatrz kazdego przedzialu (pomijamy poczatek przy przelaczeniu
# adresu oraz sam koniec przed kolejnym przelaczeniem).
MEAS_FRAC_LO = 0.15
MEAS_FRAC_HI = 0.9

bits = []
for nm in ADDR_SOURCES:
    m = re.search(rf'^{nm}\s+\S+\s+\S+\s+PULSE\s*\(([^)]*)\)', spice, re.IGNORECASE | re.MULTILINE)
    if not m:
        continue
    a = m.group(1).split()             # PULSE(V1 V2 TD TR TF PW PER)
    bits.append({'name': nm, 'td': spice_num(a[2]), 'pw': spice_num(a[5]), 'per': spice_num(a[6])})

# bit0 = najkrotszy okres (LSB)
bits.sort(key=lambda b: b['per'])
W = bits[0]['pw']                      # szerokosc przedzialu = czas trzymania kodu (PW LSB)
nslots = 2 ** len(bits)

def level(b, t):
    if t < b['td']:
        return 0
    return 1 if ((t - b['td']) % b['per']) < b['pw'] else 0

slots = []
for k in range(nslots):
    t0, t1, tc = k * W, (k + 1) * W, (k + 0.5) * W
    a = [level(bits[i], tc) for i in range(len(bits))]   # a[0]=LSB
    addr = sum(a[i] << i for i in range(len(a)))
    inp  = 8 - addr                    # ktore wejscie inN jest wybrane
    div  = 2 ** (7 - addr)             # dzielnik na wyjsciu (z dekodowania MUX-a)
    bitstr = ''.join(str(a[i]) for i in reversed(range(len(a))))  # MSB..LSB
    slots.append({'k': k, 't0': t0, 't1': t1, 'addr': addr,
                  'bits': bitstr, 'input': inp, 'expected_div': div})
    print(f"  slot {k}: {t0*1e6:6.2f}..{t1*1e6:6.2f} us  A2A1A0={bitstr}  "
          f"in{inp}  ÷{div}")

with open(json_path, 'w') as f:
    json.dump({'slot_width': W, 'num_slots': nslots,
               'meas_frac_lo': MEAS_FRAC_LO, 'meas_frac_hi': MEAS_FRAC_HI,
               'slots': slots}, f, indent=2)
PYEOF

# Usuń poprzednie wyniki
rm -f $DATA_DIR/${SIM_NAME}_*.dat
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

# Policz kombinacje
TOTAL=0
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TOTAL=$((TOTAL + 1))
done; done; done

CURRENT=0

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    DAT=$DATA_DIR/${SIM_NAME}_${TAG}.dat

    python3 - "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" <<'PYEOF'
import re, sys
spice_path, corner, temp, vp, dat_path = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

# 1. Usun istniejacy blok .control
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Podmien parametry sweepowane
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice)

# 3. Wybierz corner z biblioteki cornerMOSlv.lib
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+',
               r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 4. Usun istniejace linie .options TEMP
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

# 5. Wstaw .options TEMP przed .end
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 6. Blok .control — zapisujemy zegar wejsciowy i wyjscie multipleksera.
#    Kolejnosc MUSI sie zgadzac z SIGNAL_ORDER w plot_mux.py
control_block = f"""
.control
tran 50p 12.1u
wrdata {dat_path} v(clk) v(out)
exit
.endc
"""

with open('/tmp/mux_run.spice', 'w') as f:
    f.write(spice + control_block)
PYEOF

    ngspice -b /tmp/mux_run.spice >/dev/null 2>&1

    CURRENT=$((CURRENT + 1))
    PCT=$(( CURRENT * 100 / TOTAL ))
    printf "%-45s — done %3d%% of simulation finished\n" "${TAG}" "${PCT}"

done
done
done

echo "Generating report..."
python3 $SCRIPT_DIR/plot_mux.py
