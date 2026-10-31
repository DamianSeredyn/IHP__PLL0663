#!/bin/bash
# ==============================================================================
# SWEEP PROGRAMMABLE DIVIDER (pdiv) — corner / temperature / VDD / division value
# ==============================================================================
# ngspice crashes for simulations longer than ~14 µs (known environment issue).
# Strategy: run one short simulation per division value N (0-63) with d0-d5
# hardwired as DC voltages, each simulation ≤ 8 µs (allows ~10 periods even for N=63).
# plot_divider_pdiv.py merges all N chunks per PVT condition into one report row.
#
# IMPORTANT: Measures from out_div (not out) because:
#   - out has very short pulses (narrow pulse train, poor for duty cycle measurement)
#   - out_div is the /2 version of out, giving ~50% duty cycle
#   - out_div is more reliable for frequency and duty cycle analysis
#
# File naming: pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat  (nn = 00..63)
#
# Place in divider/scripts/ and run from there.
#
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data

# ── Argument parsing ───────────────────────────────────────────────────────────
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""

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
                        FILTER_CORNERS="$FILTER_CORNERS mos_tt"
                        FILTER_TEMPS="$FILTER_TEMPS $t_nom"
                        FILTER_VPS="$FILTER_VPS $vp_nom"
                        ;;
                    hot)
                        FILTER_CORNERS="$FILTER_CORNERS mos_ss"
                        FILTER_TEMPS="$FILTER_TEMPS $t_max"
                        FILTER_VPS="$FILTER_VPS $vp_min"
                        ;;
                    cold)
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
if [[ -z "$FILTER_VPS" ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

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
SIM_NAME="pdiv"
SPICE=$PROJECT_DIR/divider/simulations/pdiv_sym_tb.spice
DATA_DIR=$PROJECT_DIR/divider/results/data
RESULTS_DIR=$PROJECT_DIR/divider/results

# Simulation parameters: 8µs allows ~10 periods for N=63 at ~320 MHz
# 20ps timestep for better accuracy on small signals
TSTEP="20p"
TSTOP="8u"
N_VALUES=$(seq 0 63)

echo "=========================================================================="
echo "PROGRAMMABLE DIVIDER SWEEP"
echo "=========================================================================="
echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
echo "Division N  : 0..63 (64 runs per PVT point)"
echo "Per-run time: $TSTOP  |  step: $TSTEP"
echo "Measurement : out_div (NOT out, which has very short pulses)"
echo ""

# Count total simulations
TOTAL=0
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    for N in $N_VALUES; do TOTAL=$((TOTAL + 1)); done
done; done; done

echo "Total simulations: $TOTAL"
echo "=========================================================================="
echo ""

mkdir -p $DATA_DIR

# Remove previous results only for the PVT points we are about to (re)run
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    rm -f $DATA_DIR/${SIM_NAME}_${TAG}_N*.dat
done; done; done
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

CURRENT=0

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    echo "=== PVT: $TAG ==="

    for N in $N_VALUES; do
        NN=$(printf "%02d" $N)
        DAT=$DATA_DIR/${SIM_NAME}_${TAG}_N${NN}.dat

        # Extract data bits from N (0-63)
        D0=$(( (N >> 0) & 1 ))
        D1=$(( (N >> 1) & 1 ))
        D2=$(( (N >> 2) & 1 ))
        D3=$(( (N >> 3) & 1 ))
        D4=$(( (N >> 4) & 1 ))
        D5=$(( (N >> 5) & 1 ))

        # Generate SPICE netlist with DC-biased data inputs
        python3 - "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" \
                   "$D0" "$D1" "$D2" "$D3" "$D4" "$D5" \
                   "$TSTEP" "$TSTOP" "$VP" <<'PYEOF'
import re, sys

(spice_path, corner, temp, vp, dat_path,
 d0_str, d1_str, d2_str, d3_str, d4_str, d5_str,
 tstep, tstop, vdd_str) = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

# 1. Remove existing .control block
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Replace temperature and VDD parameters
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice, flags=re.IGNORECASE)

# 3. Select corner from library
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+',
               r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 4. Remove existing .options TEMP
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

# 5. Convert vdd to float for DC source values
vdd_v = float(vdd_str)
def dc_level(bit_val):
    return f"{vdd_v:.4f}" if int(bit_val) else "0"

# 6. Replace data input sources with DC levels
#    These patterns match voltage source definitions for the data bits.
#    If your testbench uses different source names, modify these patterns.
#    Example: change V11 to whatever your d0 source is named in pdiv_sym_tb.spice
#
#    The pattern matches: SourceName  node+  node-  [definition]
#    Then replaces the definition part with DC <value>

replacements = [
    # Pattern                              # Replacement (change V11, V10, etc. to match your testbench)
    (r'(V11\s+d0\s+gnd)\s+.*', lambda: f'\\1 DC {dc_level(d0_str)}'),
    (r'(V10\s+d1\s+gnd)\s+.*', lambda: f'\\1 DC {dc_level(d1_str)}'),
    (r'(V12\s+d2\s+gnd)\s+.*', lambda: f'\\1 DC {dc_level(d2_str)}'),
    (r'(V7\s+d3\s+gnd)\s+.*',  lambda: f'\\1 DC {dc_level(d3_str)}'),
    (r'(V8\s+d4\s+gnd)\s+.*',  lambda: f'\\1 DC {dc_level(d4_str)}'),
    (r'(V9\s+d5\s+gnd)\s+.*',  lambda: f'\\1 DC {dc_level(d5_str)}'),
]

for pattern, replacement in replacements:
    spice = re.sub(pattern, replacement(), spice, flags=re.IGNORECASE)

# Alternative: if the above doesn't match, try even more flexible patterns
# (in case sources use ground reference like "0" instead of "gnd")
if 'DC' not in spice:  # Fallback if no replacements were made
    replacements_fallback = [
        (r'(V11\s+[^0]+\s+0)\s+.*', f'\\1 DC {dc_level(d0_str)}'),
        (r'(V10\s+[^0]+\s+0)\s+.*', f'\\1 DC {dc_level(d1_str)}'),
        (r'(V12\s+[^0]+\s+0)\s+.*', f'\\1 DC {dc_level(d2_str)}'),
        (r'(V7\s+[^0]+\s+0)\s+.*',  f'\\1 DC {dc_level(d3_str)}'),
        (r'(V8\s+[^0]+\s+0)\s+.*',  f'\\1 DC {dc_level(d4_str)}'),
        (r'(V9\s+[^0]+\s+0)\s+.*',  f'\\1 DC {dc_level(d5_str)}'),
    ]
    for pattern, replacement in replacements_fallback:
        spice = re.sub(pattern, replacement, spice, flags=re.IGNORECASE)

# 7. Add .options TEMP
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 8. Create .control block with measurement from out_div (not out)
control_block = f"""
.control
tran {tstep} {tstop}
wrdata {dat_path} v(clk) v(out_div) v(div2) v(div4) v(div8) v(div16) v(div32) v(div64)
exit
.endc
"""

with open('/tmp/pdiv_run.spice', 'w') as f:
    f.write(spice + control_block)

PYEOF

        # Run ngspice
        ngspice -b /tmp/pdiv_run.spice >/dev/null 2>&1

        CURRENT=$((CURRENT + 1))
        PCT=$(( CURRENT * 100 / TOTAL ))
        printf "  N=%02d (d5..d0=%d%d%d%d%d%d) — %3d%% total\n" \
               $N $D5 $D4 $D3 $D2 $D1 $D0 $PCT

    done  # N loop

done
done
done  # PVT loops

echo ""
echo "=========================================================================="
echo "All simulations done. Generating report..."
echo "=========================================================================="
python3 $SCRIPT_DIR/plot_divider_pdiv.py
