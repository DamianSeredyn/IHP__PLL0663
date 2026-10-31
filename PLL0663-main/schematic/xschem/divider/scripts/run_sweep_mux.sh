#!/bin/bash
# ==============================================================================
# SWEEP MUX 8:1 — corner / temperature / VDD
# ==============================================================================
# Simulates MUX_8to1_tb.spice and stores the input clock (clk) and the MUX
# output (out) waveforms.
#
# The MUX address is driven by sources V3/V4/V5 (nodes a1/a0/a2). The address
# switches every fixed time interval, so the output shows clk, clk/2, clk/4,
# ... clk/128 in turn. Before simulating, this script PARSES V3/V4/V5 and
# writes the measurement-slot plan to mux_slots.json — plot_mux.py uses it to
# know which frequency is expected in which time window.
#
# USAGE
#   run_sweep_mux.sh                      full sweep (all corners / T / VDD)
#   run_sweep_mux.sh -c typ|hot|cold      PVT presets
#   run_sweep_mux.sh -c mos_tt mos_ss     explicit corners
#   run_sweep_mux.sh -t t_min t_nom       temperatures (names or values)
#   run_sweep_mux.sh -v vp_min 1.2        supply voltages (names or values)
#   run_sweep_mux.sh -h                   this help
#
# Presets:
#   typ  -> mos_tt, t_nom, vp_nom
#   hot  -> mos_ss, t_max, vp_min
#   cold -> mos_ff, t_min, vp_max
# ==============================================================================
# Expected hierarchy (the mux shares the divider block's folders):
#   /foss/designs/CHIP-PLL/schematics/divider/scripts/<this file>
#   SCRIPT_DIR  -> .../CHIP-PLL/schematics/divider/scripts
#   DIVIDER_DIR -> .../CHIP-PLL/schematics/divider        (1 level up)
#   ROOT_DIR    -> .../CHIP-PLL                           (2 levels above DIVIDER_DIR)
#   Testbench   -> divider/simulations/MUX_8to1_tb.spice
#   Results     -> divider/results/data  (mux_*.dat, mux_slots.json), divider/results
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIVIDER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT_DIR="$(cd "$DIVIDER_DIR/../.." && pwd)"

source $ROOT_DIR/configs/corner_data

# ── Argument parsing ───────────────────────────────────────────────────────────
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
PRESET=""

resolve_var() {
    local name="$1"
    case "$name" in
        t_min)  echo "$t_min"  ;;
        t_nom)  echo "$t_nom"  ;;
        t_max)  echo "$t_max"  ;;
        vp_min) echo "$vp_min" ;;
        vp_nom) echo "$vp_nom" ;;
        vp_max) echo "$vp_max" ;;
        *)      echo "$name"   ;;
    esac
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c)
            shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)
                        PRESET="$PRESET typ"
                        FILTER_CORNERS="$FILTER_CORNERS mos_tt"
                        FILTER_TEMPS="$FILTER_TEMPS $t_nom"
                        FILTER_VPS="$FILTER_VPS $vp_nom"
                        ;;
                    hot)
                        PRESET="$PRESET hot"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ss"
                        FILTER_TEMPS="$FILTER_TEMPS $t_max"
                        FILTER_VPS="$FILTER_VPS $vp_min"
                        ;;
                    cold)
                        PRESET="$PRESET cold"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ff"
                        FILTER_TEMPS="$FILTER_TEMPS $t_min"
                        FILTER_VPS="$FILTER_VPS $vp_max"
                        ;;
                    *)
                        FILTER_CORNERS="$FILTER_CORNERS $1"
                        ;;
                esac
                shift
            done
            ;;
        -t)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -t requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do
                FILTER_TEMPS="$FILTER_TEMPS $(resolve_var "$1")"
                shift
            done
            ;;
        -v)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -v requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do
                FILTER_VPS="$FILTER_VPS $(resolve_var "$1")"
                shift
            done
            ;;
        -h|--help)
            sed -n '/^# USAGE/,/^# ===/p' "$0" | sed 's/^# \?//' | head -40
            exit 0
            ;;
        *)
            echo "Error: unknown option '$1'"
            echo "Run with -h for usage."
            exit 1
            ;;
    esac
done

# ── Deduplicate lists ──────────────────────────────────────────────────────────
dedup() {
    echo "$1" | tr ' ' '\n' | grep -v '^$' | awk '!seen[$0]++' | tr '\n' ' '
}
FILTER_CORNERS=$(dedup "$FILTER_CORNERS")
FILTER_TEMPS=$(dedup "$FILTER_TEMPS")
FILTER_VPS=$(dedup "$FILTER_VPS")

# ── Fall back to full range ────────────────────────────────────────────────────
if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

# ── Filter corners ─────────────────────────────────────────────────────────────
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
        echo "Error: no corner matches for: $FILTER_CORNERS"
        echo "Available corners: $corners"
        exit 1
    fi
    corners=$(dedup "$filtered")
fi

# ── Configuration ──────────────────────────────────────────────────────────────
SIM_NAME="mux"
SPICE=$DIVIDER_DIR/simulations/MUX_8to1_tb.spice
DATA_DIR=$DIVIDER_DIR/results/data
RESULTS_DIR=$DIVIDER_DIR/results

if [[ ! -f "$SPICE" ]]; then
    echo "Error: testbench not found: $SPICE"
    exit 1
fi

echo "=========================================================================="
echo "MUX 8:1 SWEEP"
echo "=========================================================================="
echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
[[ -n "$PRESET" ]] && echo "Preset(s)   :$PRESET"
echo "Testbench   : $SPICE"
echo "Results     : $RESULTS_DIR"
echo ""

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

# ── Derive measurement slots from V3/V4/V5 → mux_slots.json ───────────────────
echo ""
echo "Measurement slots (from V3/V4/V5):"
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

# === USER EDIT === address source names (LSB->MSB order does not matter here;
# the order is derived from the PULSE period, so just list them).
ADDR_SOURCES = ['V3', 'V4', 'V5']

# Measurement window inside each slot (skip the start right after the address
# switches, and the very end before the next switch).
MEAS_FRAC_LO = 0.15
MEAS_FRAC_HI = 0.95

bits = []
for nm in ADDR_SOURCES:
    m = re.search(rf'^{nm}\s+\S+\s+\S+\s+PULSE\s*\(([^)]*)\)', spice, re.IGNORECASE | re.MULTILINE)
    if not m:
        continue
    a = m.group(1).split()             # PULSE(V1 V2 TD TR TF PW PER)
    bits.append({'name': nm, 'td': spice_num(a[2]), 'pw': spice_num(a[5]), 'per': spice_num(a[6])})

if not bits:
    print("Error: no PULSE address sources found for", ADDR_SOURCES)
    sys.exit(1)

# bit0 = shortest period (LSB)
bits.sort(key=lambda b: b['per'])
W = bits[0]['pw']                      # slot width = code hold time (PW of LSB)
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
    inp  = 8 - addr                    # which input inN is selected
    div  = 2 ** (7 - addr)             # divider ratio at output (from MUX decoding)
    bitstr = ''.join(str(a[i]) for i in reversed(range(len(a))))  # MSB..LSB
    slots.append({'k': k, 't0': t0, 't1': t1, 'addr': addr,
                  'bits': bitstr, 'input': inp, 'expected_div': div})
    print(f"  slot {k}: {t0*1e6:6.2f}..{t1*1e6:6.2f} us  A2A1A0={bitstr}  "
          f"in{inp}  /{div}")

with open(json_path, 'w') as f:
    json.dump({'slot_width': W, 'num_slots': nslots,
               'meas_frac_lo': MEAS_FRAC_LO, 'meas_frac_hi': MEAS_FRAC_HI,
               'slots': slots}, f, indent=2)
PYEOF
[[ $? -ne 0 ]] && exit 1

# ── Count total simulations ────────────────────────────────────────────────────
TOTAL=0
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TOTAL=$((TOTAL + 1))
done; done; done

echo ""
echo "Total simulations: $TOTAL"
echo "=========================================================================="
echo ""

# Remove previous results only for the PVT points we are about to (re)run
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    rm -f $DATA_DIR/${SIM_NAME}_${TAG}.dat
done; done; done
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

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

# 1. Remove existing .control block
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Replace swept parameters
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice, flags=re.IGNORECASE)

# 3. Select corner from cornerMOSlv.lib
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+',
               r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 4. Remove existing .options TEMP lines
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

# 5. Insert .options TEMP before .end
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 6. .control block — save input clock and MUX output.
#    Order MUST match SIGNAL_ORDER in plot_mux.py
control_block = f"""
.control
tran 50p 12.01u
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

echo ""
echo "=========================================================================="
echo "All simulations done. Generating report..."
echo "=========================================================================="
python3 $SCRIPT_DIR/plot_mux.py
