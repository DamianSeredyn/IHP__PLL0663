#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data

# ── Presety (-c <preset lub corner>) ──────────────────────────────────────────
# Dostępne presety:
#   typ   → mos_tt,  t_nom,        vp_nom        (typowe warunki)
#   hot   → mos_ss,  t_max,        vp_min        (najgorsze warunki gorące)
#   cold  → mos_ff,  t_min,        vp_max        (najgorsze warunki zimne)
#
# Można też podać nazwy cornerów bezpośrednio: -c tt ss ff
# Bez argumentów: symulowane są wszystkie cornery i wszystkie PVT
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

# Jeśli nie podano presetów temp/vp, użyj pełnego zakresu
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

SPICE=$PROJECT_DIR/divider/simulations/input_register_no_sym_tb.spice
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

# Usuń wszystkie poprzednie wyniki przed każdą symulacją
rm -f $DATA_DIR/input_register_*.dat
rm -f $RESULTS_DIR/input_register_*.png
rm -f $RESULTS_DIR/input_register_report.html

# Policz łączną liczbę kombinacji
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
    DAT=$DATA_DIR/input_register_${TAG}.dat

    python3 - "$SPICE" "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" <<'PYEOF'
import re, sys
spice_path, _, corner, temp, vp, dat_path = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice)
spice = re.sub(r'\.lib\s+(\S+)\s+\S+',  f'.lib \\1 {corner}',  spice)


# Wstaw .options TEMP przed .end
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

control_block = f"""
.control
tran 50p 300n
wrdata {dat_path} v(d) v(clk_buf) v(data_en) v(d0) v(d1) v(d2) v(d3) v(d4) v(d5) v(d6) v(d7) v(d8) v(d9) v(d10) v(d11) v(d12)
exit
.endc
"""

with open('/tmp/input_register_run.spice', 'w') as f:
    f.write(spice + control_block)
PYEOF

    ngspice -b /tmp/input_register_run.spice >/dev/null 2>&1

    CURRENT=$((CURRENT + 1))
    PCT=$(( CURRENT * 100 / TOTAL ))
    printf "%-45s — done %3d%% of simulation finished\n" "${TAG}" "${PCT}"

done
done
done

echo "Generating plots and report..."
python3 $SCRIPT_DIR/plot_input_register.py
