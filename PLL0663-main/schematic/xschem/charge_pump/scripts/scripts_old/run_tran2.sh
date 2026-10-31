#!/bin/bash
# run_corners.sh - Symulacja cornerów PVT bez ingerencji w ścieżkę biblioteki

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

SIM_DIR="$PROJECT_DIR/charge_pump/simulations"
NETLIST_SRC="$SIM_DIR/NEW_500n_tran_tb.spice"

DATA_DIR="$PROJECT_DIR/charge_pump/results/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results"

TMP_NETLIST="$SIM_DIR/temp_run_$$.spice"

# Parametry symulacji (dostosuj)
corners="mos_tt mos_ss mos_ff mos_sf mos_fs"
t_min="-40"
t_nom="27"
t_max="125"
vp_min="1.08"
vp_nom="1.2"
vp_max="1.32"

mkdir -p "$DATA_DIR" "$LOG_DIR" "$RESULTS_DIR"
rm -f "$DATA_DIR"/charge_pump_data_*.txt
rm -f "$RESULTS_DIR"/cp_*.png "$RESULTS_DIR"/cp_report.html

# Funkcja przygotowująca netlistę dla jednego przypadku
prepare_netlist() {
    local corner=$1
    local temp=$2
    local vp=$3
    local out=$4

    cp "$NETLIST_SRC" "$out"

    # Usunięcie istniejących bloków .control ... .endc
    sed -i '/^\.control/,/^\.endc/d' "$out"

    # Podmiana parametrów temperatury i napięcia (jeśli istnieją)
    sed -i -e "s/\.param temp=.*/.param temp=$temp/" \
           -e "s/\.param Vp=.*/.param Vp=$vp/" "$out"

    # Zmiana tylko ostatniego słowa w linii .lib (corner)
    sed -i -E "s/^(\.lib .*cornerMOSlv\.lib) [^ ]+$/\1 $corner/" "$out"

    # Wstawienie nowego bloku .control (bez v(biasp), z .options temp)
    if grep -q "^\.ends" "$out"; then
        sed -i "/^\.ends/i\\
**** begin user architecture code\\
.options temp=$temp\\
.control\\
op\\
tran 1n 60u\\
save all\\
set filetype=ascii\\
wrdata cp_test.txt time v(vout) i(vip) i(vin) v(biasn) i(Vdn2) i(Vup2) i(Vvp) v(up) v(dn)\\
quit\\
.endc\\
**** end user architecture code" "$out"
    else
        cat >> "$out" <<EOF

**** begin user architecture code
.options temp=$temp
.control
op
tran 1n 60u
save all
set filetype=ascii
wrdata cp_test.txt time v(vout) i(vip) i(vin) v(biasn) i(Vdn2) i(Vup2) i(Vvp) v(up) v(dn)
quit
.endc
**** end user architecture code
EOF
    fi
}

# Główna pętla
for CORNER in $corners; do
    for TEMP in $t_min $t_nom $t_max; do
        for VP in $vp_min $vp_nom $vp_max; do
            TAG="${CORNER}_T${TEMP}_Vp${VP}"
            OUT_FILE="$DATA_DIR/charge_pump_data_${TAG}.txt"
            LOG_FILE="$LOG_DIR/ngspice_${TAG}.log"

            echo "=== $TAG ==="
            prepare_netlist "$CORNER" "$TEMP" "$VP" "$TMP_NETLIST"

            # Uruchom ngspice w katalogu symulacji (tam jest netlista i domyślnie .lib)
            (cd "$SIM_DIR" && ngspice -b "$(basename "$TMP_NETLIST")") > "$LOG_FILE" 2>&1

            if [ -f "$SIM_DIR/cp_test.txt" ]; then
                cp "$SIM_DIR/cp_test.txt" "$OUT_FILE"
                echo "  OK → $OUT_FILE"
                rm -f "$SIM_DIR/cp_test.txt"
            else
                echo "  BŁĄD: brak cp_test.txt. Log: $LOG_FILE"
                tail -20 "$LOG_FILE"
            fi
            rm -f "$TMP_NETLIST"
        done
    done
done

# Post-processing
if [ -f "$SCRIPT_DIR/parse_cp.py" ]; then
    python3 "$SCRIPT_DIR/parse_cp.py"
fi
if [ -f "$SCRIPT_DIR/plot_cp.py" ]; then
    python3 "$SCRIPT_DIR/plot_cp.py"
fi

echo "Gotowe. Raport HTML: $RESULTS_DIR/cp_report.html"
