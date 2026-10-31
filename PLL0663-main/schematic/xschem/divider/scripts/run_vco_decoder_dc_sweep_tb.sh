#!/bin/bash
# ==============================================================================
# VCO DECODER — DC sweep variant: one sub-simulation PER CODE (512 total)
# ==============================================================================
# Unlike run_vco_decoder_tb.sh (one long transient with binary-weighted PULSE
# sources sweeping all 512 codes in time), this script hardwires c0,c1,c2,
# f0-f5 as plain DC sources and re-runs ngspice once per code, exactly like
# run_sweep_pdiv_optimized.sh does for the divider's N values. Trade-off vs
# the PULSE-based testbench:
#   + no timing windows / settling-fraction guesswork, no PULSE edge glitches
#   + a single bad code can't break the rest of the sweep (its ngspice call
#     just fails on its own; everything else still runs)
#   + works cleanly on the ideal-gate schematic netlist (this script assumes
#     that one, NOT the PEX/transistor-level netlist)
#   - no dynamic/glitch/propagation-delay coverage across code transitions
#     (a real functional risk at slow/cold/low-VDD corners is invisible here)
#   - 512 ngspice invocations per PVT point instead of 1 -> slower wall time
#
# code(0..511): bit0=f0 ... bit5=f5, bit6=c0, bit7=c1, bit8=c2
#   coarse = code >> 6   (0..7)
#   fine   = code & 0x3F (0..63)
#
# File naming: vcodec_dc_<corner>_T<temp>_Vp<vp>_code<NNN>.dat  (NNN=000..511)
#
# Place in vco_decoder/scripts/ and run from there (mirrors divider/scripts/).
# Requires an already-netlisted VCO_decoder_tb.spice (schematic/ideal-gate
# version) — this script does not invoke xschem itself. See --spice below.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DECODER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT_DIR="$(cd "$DECODER_DIR/../.." && pwd)"

source $ROOT_DIR/configs/corner_data

# ── Argument parsing (same -c/-t/-v convention as the other scripts) ──────────
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
SPICE_OVERRIDE=""

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
                    typ)  FILTER_CORNERS="$FILTER_CORNERS mos_tt"; FILTER_TEMPS="$FILTER_TEMPS $t_nom"; FILTER_VPS="$FILTER_VPS $vp_nom" ;;
                    hot)  FILTER_CORNERS="$FILTER_CORNERS mos_ff"; FILTER_TEMPS="$FILTER_TEMPS $t_min"; FILTER_VPS="$FILTER_VPS $vp_min" ;;
                    cold) FILTER_CORNERS="$FILTER_CORNERS mos_ff"; FILTER_TEMPS="$FILTER_TEMPS $t_nom"; FILTER_VPS="$FILTER_VPS $vp_max" ;;
                    *)    FILTER_CORNERS="$FILTER_CORNERS $1" ;;
                esac
                shift
            done
            ;;
        -t)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -t requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_TEMPS="$FILTER_TEMPS $(resolve_var "$1")"; shift; done
            ;;
        -v)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -v requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_VPS="$FILTER_VPS $(resolve_var "$1")"; shift; done
            ;;
        --spice)
            shift
            [[ $# -eq 0 ]] && { echo "Error: --spice requires a path"; exit 1; }
            SPICE_OVERRIDE="$1"
            shift
            ;;
        -h|--help)
            sed -n '/^# ===/,/^# ===/p' "$0" | sed 's/^# \?//' | head -40
            echo "Extra option: --spice <path>   override path to the netlisted VCO_decoder_tb.spice"
            exit 0
            ;;
        *)
            echo "Error: unknown option '$1'"
            echo "Run with -h for usage."
            exit 1
            ;;
    esac
done

dedup() { echo "$1" | tr ' ' '\n' | grep -v '^$' | awk '!seen[$0]++' | tr '\n' ' '; }
FILTER_CORNERS=$(dedup "$FILTER_CORNERS")
FILTER_TEMPS=$(dedup "$FILTER_TEMPS")
FILTER_VPS=$(dedup "$FILTER_VPS")

if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

if [[ -n "$FILTER_CORNERS" ]]; then
    filtered=""
    for C in $corners; do
        for F in $FILTER_CORNERS; do
            if [[ "$C" == *"$F"* ]]; then filtered="$filtered $C"; break; fi
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
SIM_NAME="vcodec_dc"
NETLIST="${SPICE_OVERRIDE:-$DECODER_DIR/simulations/VCO_decoder_tb.spice}"
DATA_DIR=$DECODER_DIR/results/data
RESULTS_DIR=$DECODER_DIR/results

TSTEP="20p"
TSTOP="200p"    # sources are plain DC -> circuit is already settled at t=0;
                # this just gives wrdata a few identical points to write

if [[ ! -f "$NETLIST" ]]; then
    echo "Error: netlist not found: $NETLIST"
    echo "Netlist VCO_decoder_tb.sch (the SCHEMATIC/ideal-gate version, not the"
    echo "PEX one) to VCO_decoder_tb.spice first, or point at it with --spice <path>."
    exit 1
fi
if grep -q 'sg13_lv_nmos ad=' "$NETLIST"; then
    echo "WARNING: this netlist looks like the PEX/transistor-level extraction"
    echo "         (ad=/pd=/as=/ps= geometry on the MOS instances). This script"
    echo "         is meant for the ideal-gate schematic netlist. It may still"
    echo "         work, but was not what it was designed/tested against."
fi

echo "=========================================================================="
echo "VCO DECODER — DC SWEEP (one sub-simulation per code, 512 codes per PVT)"
echo "=========================================================================="
echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
echo "Timestep    : $TSTEP   TSTOP: $TSTOP (settle only, sources are static DC)"
echo ""

TOTAL_PVT=0
for CORNER in $corners; do for TEMP in $FILTER_TEMPS; do for VP in $FILTER_VPS; do TOTAL_PVT=$((TOTAL_PVT+1)); done; done; done
TOTAL=$((TOTAL_PVT * 512))
echo "Total simulations: $TOTAL ($TOTAL_PVT PVT point(s) x 512 codes each)"
echo "This is ~8x more ngspice invocations than the PULSE-based testbench —"
echo "expect longer wall-clock time."
echo "=========================================================================="
echo ""

mkdir -p $DATA_DIR
rm -f $DATA_DIR/${SIM_NAME}_*.dat
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

CURRENT=0

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    echo "=== PVT: $TAG ==="

    for CODE in $(seq 0 511); do
        NNN=$(printf "%03d" $CODE)
        DAT=$DATA_DIR/${SIM_NAME}_${TAG}_code${NNN}.dat

        # Extract c0,c1,c2,f0..f5 bits from the 9-bit code
        # bit0=f0 ... bit5=f5, bit6=c0, bit7=c1, bit8=c2
        F0=$(( (CODE >> 0) & 1 )); F1=$(( (CODE >> 1) & 1 )); F2=$(( (CODE >> 2) & 1 ))
        F3=$(( (CODE >> 3) & 1 )); F4=$(( (CODE >> 4) & 1 )); F5=$(( (CODE >> 5) & 1 ))
        C0=$(( (CODE >> 6) & 1 )); C1=$(( (CODE >> 7) & 1 )); C2=$(( (CODE >> 8) & 1 ))

        python3 - "$NETLIST" "$CORNER" "$TEMP" "$VP" "$DAT" "$TSTEP" "$TSTOP" \
                   "$C0" "$C1" "$C2" "$F0" "$F1" "$F2" "$F3" "$F4" "$F5" <<'PYEOF'
import re, sys

(netlist_path, corner, temp, vp, dat_path, tstep, tstop,
 c0, c1, c2, f0, f1, f2, f3, f4, f5) = sys.argv[1:]

with open(netlist_path) as f:
    spice = f.read()

spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice, flags=re.IGNORECASE)
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+', r'\g<1>' + corner, spice, flags=re.IGNORECASE)

spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

vdd_v = float(vp)
def dc_level(bit):
    return f"{vdd_v:.4f}" if int(bit) else "0"

bits = {'c0': c0, 'c1': c1, 'c2': c2,
        'f0': f0, 'f1': f1, 'f2': f2, 'f3': f3, 'f4': f4, 'f5': f5}
for sig, bit in bits.items():
    # matches "V_<sig> <sig> 0 {vdd}" or "V_<sig> <sig> 0 PULSE(...)" or
    # any prior DC value -> replace RHS with a plain DC level for this code
    pattern = rf'(V_{sig}\s+{sig}\s+0)\s+.*'
    spice = re.sub(pattern, lambda m, lvl=dc_level(bit): f'{m.group(1)} DC {lvl}',
                   spice, count=1, flags=re.IGNORECASE)

sigs = ['c0', 'c1', 'c2', 'f0', 'f1', 'f2', 'f3', 'f4', 'f5',
        'VCO_sel', 'VCO2_5_sel', 'VCO2_11_sel',
        'VCO3_5_sel', 'VCO3_11_sel', 'VCO4_5_sel', 'VCO4_11_sel', 'VCO5_11_sel']
wrdata_sigs = ' '.join(f'v({s})' for s in sigs)

control_block = f"""
.control
save all
tran {tstep} {tstop}
wrdata {dat_path} {wrdata_sigs}
exit
.endc
"""

with open('/tmp/vcodec_dc_run.spice', 'w') as f:
    f.write(spice + control_block)
PYEOF

        ngspice -b /tmp/vcodec_dc_run.spice >/tmp/vcodec_dc_${TAG}_code${NNN}.log 2>&1
        CURRENT=$((CURRENT+1))
        if [[ ! -s "$DAT" ]]; then
            echo "  code $NNN FAILED — see /tmp/vcodec_dc_${TAG}_code${NNN}.log"
        fi

        if (( CODE % 64 == 0 )); then
            PCT=$(( CURRENT * 100 / TOTAL ))
            echo "  ...code $NNN done (${PCT}% total)"
        fi
    done  # code loop

done
done
done  # PVT loops

echo ""
echo "=========================================================================="
echo "All simulations done. Generating report..."
echo "=========================================================================="
python3 $SCRIPT_DIR/plot_vco_decoder_dc.py
