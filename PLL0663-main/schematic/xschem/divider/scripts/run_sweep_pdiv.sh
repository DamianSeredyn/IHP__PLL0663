#!/bin/bash
# ==============================================================================
# SWEEP PROGRAMMABLE DIVIDER (pdiv) — corner / temperature / VDD / division value
# ==============================================================================
# ngspice crashes for simulations longer than ~14 µs (known environment issue).
# Strategy: run one short simulation per division value N (0-63) with d0-d5
# hardwired as DC voltages, each simulation ≤ 4 µs.
# plot_divider_pdiv.py merges all N chunks per PVT condition into one report row.
#
# File naming: pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat  (nn = 00..63)
#
# Place in divider/scripts/ and run from there.
#
# ------------------------------------------------------------------------------
# USAGE
# ------------------------------------------------------------------------------
#
#   Full sweep (all corners × all temps × all VDDs):
#     ./run_sweep_pdiv.sh
#
#   Named presets (corner + temp + VDD in one word):
#     ./run_sweep_pdiv.sh -c typ            # mos_tt  t_nom  vp_nom
#     ./run_sweep_pdiv.sh -c hot            # mos_ss  t_max  vp_min
#     ./run_sweep_pdiv.sh -c cold           # mos_ff  t_min  vp_max
#     ./run_sweep_pdiv.sh -c typ hot cold   # several presets at once
#
#   Explicit corner + temperature + VDD (single point):
#     ./run_sweep_pdiv.sh -c sf -t t_min -v vp_max
#     ./run_sweep_pdiv.sh -c tt -t t_nom -v vp_nom
#
#   Corner only (all temps × all VDDs for that corner):
#     ./run_sweep_pdiv.sh -c ff
#
#   Corner + temperature only (all VDDs):
#     ./run_sweep_pdiv.sh -c ss -t t_max
#
#   Corner + VDD only (all temps):
#     ./run_sweep_pdiv.sh -c tt -v vp_min
#
#   Multiple explicit corners with shared temp/VDD:
#     ./run_sweep_pdiv.sh -c tt ss -t t_nom -v vp_nom
#
#   Mix preset and explicit:
#     ./run_sweep_pdiv.sh -c typ -c sf -t t_min -v vp_max
#
# Flags:
#   -c <name ...>   Corner substring(s) or preset names (typ/hot/cold).
#                   Multiple -c flags are additive.
#   -t <value>      Temperature value (must match a value in corner_data,
#                   e.g. t_min, t_nom, t_max, or a literal like 27).
#                   Repeatable: -t t_min -t t_max
#   -v <value>      VDD value (vp_min, vp_nom, vp_max, or literal).
#                   Repeatable: -v vp_min -v vp_max
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data

# ── Argument parsing ───────────────────────────────────────────────────────────
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""

# Resolve a symbolic name (t_min, vp_nom, …) to its numeric value from
# corner_data, or return the value unchanged if it is already numeric.
resolve_var() {
    local name="$1"
    # If it looks like a shell variable name, try to expand it
    case "$name" in
        t_min)  echo "$t_min"  ;;
        t_nom)  echo "$t_nom"  ;;
        t_max)  echo "$t_max"  ;;
        vp_min) echo "$vp_min" ;;
        vp_nom) echo "$vp_nom" ;;
        vp_max) echo "$vp_max" ;;
        *)      echo "$name"   ;;   # already a literal value
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
                        # Plain corner substring — no temp/VDD implied
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
            sed -n '/#.*USAGE/,/^# ====/p' "$0" | sed 's/^# \?//'
            exit 0
            ;;
        *)
            echo "Error: unknown option '$1'"
            echo "Run with -h for usage."
            exit 1
            ;;
    esac
done

# ── Deduplicate lists (preserve order) ────────────────────────────────────────
dedup() {
    echo "$1" | tr ' ' '\n' | grep -v '^$' | awk '!seen[$0]++' | tr '\n' ' '
}
FILTER_CORNERS=$(dedup "$FILTER_CORNERS")
FILTER_TEMPS=$(dedup "$FILTER_TEMPS")
FILTER_VPS=$(dedup "$FILTER_VPS")

# ── Fall back to full range for unspecified dimensions ─────────────────────────
# Only fall back if the dimension was not set by ANY argument (preset or -t/-v).
# Presets inject into FILTER_TEMPS/FILTER_VPS above, so an empty value here
# means "user did not constrain this dimension".
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

# ── Validate -t / -v values against corner_data ───────────────────────────────
VALID_TEMPS="$t_min $t_nom $t_max"
VALID_VPS="$vp_min $vp_nom $vp_max"

for T in $FILTER_TEMPS; do
    found=0
    for VT in $VALID_TEMPS; do
        [[ "$T" == "$VT" ]] && found=1 && break
    done
    if [[ $found -eq 0 ]]; then
        echo "Warning: temperature '$T' not in corner_data ($VALID_TEMPS) — using anyway"
    fi
done

for V in $FILTER_VPS; do
    found=0
    for VV in $VALID_VPS; do
        [[ "$V" == "$VV" ]] && found=1 && break
    done
    if [[ $found -eq 0 ]]; then
        echo "Warning: VDD '$V' not in corner_data ($VALID_VPS) — using anyway"
    fi
done

# ── Summary ────────────────────────────────────────────────────────────────────
SIM_NAME="pdiv"
SPICE=$PROJECT_DIR/divider/simulations/pdiv_sym_tb.spice
DATA_DIR=$PROJECT_DIR/divider/results/data
RESULTS_DIR=$PROJECT_DIR/divider/results

TSTEP="50p"
TSTOP="4u"
N_VALUES=$(seq 0 63)

echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
echo "Division N  : 0..63 (64 runs per PVT point)"
echo "Per-run time: $TSTOP  step: $TSTEP"
echo ""

# Count total simulations
TOTAL=0
for CORNER in $corners;       do
for TEMP   in $FILTER_TEMPS;  do
for VP     in $FILTER_VPS;    do
    for N in $N_VALUES; do TOTAL=$((TOTAL + 1)); done
done; done; done

echo "Total simulations: $TOTAL"
echo ""

mkdir -p $DATA_DIR

# Remove previous results only for the PVT points we are about to (re)run,
# so a partial sweep does not wipe data from other corners.
for CORNER in $corners;      do
for TEMP   in $FILTER_TEMPS; do
for VP     in $FILTER_VPS;   do
    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    rm -f $DATA_DIR/${SIM_NAME}_${TAG}_N*.dat
done; done; done
# Always regenerate the report from whatever data is present afterwards
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

CURRENT=0

for CORNER in $corners;      do
for TEMP   in $FILTER_TEMPS; do
for VP     in $FILTER_VPS;   do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    echo "=== PVT: $TAG ==="

    for N in $N_VALUES; do
        NN=$(printf "%02d" $N)
        DAT=$DATA_DIR/${SIM_NAME}_${TAG}_N${NN}.dat

        D0=$(( (N >> 0) & 1 ))
        D1=$(( (N >> 1) & 1 ))
        D2=$(( (N >> 2) & 1 ))
        D3=$(( (N >> 3) & 1 ))
        D4=$(( (N >> 4) & 1 ))
        D5=$(( (N >> 5) & 1 ))

        python3 - "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" \
                   "$D0" "$D1" "$D2" "$D3" "$D4" "$D5" \
                   "$TSTEP" "$TSTOP" "$VP" <<'PYEOF'
import re, sys

(spice_path, corner, temp, vp, dat_path,
 d0, d1, d2, d3, d4, d5,
 tstep, tstop, vdd) = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice)
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+',
               r'\g<1>' + corner, spice, flags=re.IGNORECASE)
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

vdd_v = float(vdd)
def dc_src(val, vdd_v):
    return f"{vdd_v:.4f}" if int(val) else "0"

spice = re.sub(r'(V11\s+d0\s+0\s+)PULSE\([^)]*\)',
               r'\g<1>DC ' + dc_src(d0, vdd_v), spice)
spice = re.sub(r'(V10\s+d1\s+0\s+)PULSE\([^)]*\)',
               r'\g<1>DC ' + dc_src(d1, vdd_v), spice)
spice = re.sub(r'(V12\s+d2\s+0\s+)PULSE\([^)]*\)',
               r'\g<1>DC ' + dc_src(d2, vdd_v), spice)
spice = re.sub(r'(V7\s+d3\s+0\s+)\S+',
               r'\g<1>' + dc_src(d3, vdd_v), spice)
spice = re.sub(r'(V8\s+d4\s+0\s+)\S+',
               r'\g<1>' + dc_src(d4, vdd_v), spice)
spice = re.sub(r'(V9\s+d5\s+0\s+)\S+',
               r'\g<1>' + dc_src(d5, vdd_v), spice)

spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

control_block = f"""
.control
tran {tstep} {tstop}
wrdata {dat_path} v(clk) v(out) v(out_div) v(div2) v(div4) v(div8) v(div16) v(div32) v(div64)
exit
.endc
"""

with open('/tmp/pdiv_run.spice', 'w') as f:
    f.write(spice + control_block)
PYEOF

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
echo "All simulations done. Generating report..."
python3 $SCRIPT_DIR/plot_divider_pdiv.py