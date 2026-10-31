#!/bin/bash
# run_montecarlo.sh
# Symulacja Monte Carlo (mismatch, NIE corner sweep) charge pumpa - N iteracji
# z rozna losowoscia (rndseed), corner nominalny mos_tt_mismatch (mm_ok=1 juz
# jest w netliscie na kazdym tranzystorze). Cel: zobaczyc rozklad rozbieznosci
# Iup/Idn wynikajacy z lokalnego niedopasowania miedzy sasiadujacymi
# tranzystorami, a NIE z globalnego przesuniecia procesowego (to bada corner
# sweep, ktory juz masz w run_corners_layout.sh - inny mechanizm, inny cel).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SIM_DIR="$PROJECT_DIR/charge_pump/simulations"

NETLIST_SRC="/foss/designs/simulations/charge_pump_tran_tb.spice"

DATA_DIR="$PROJECT_DIR/charge_pump/results_mc/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results_mc/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results_mc"
TMP_NETLIST="$SIM_DIR/temp_mc_run_$$.spice"

# ---------------------------------------------------------------------------
# Parametry Monte Carlo
# ---------------------------------------------------------------------------
N_ITER=100                  # liczba iteracji

CORNER_MC="mos_tt_mismatch"  # nominalny corner + mismatch (potwierdzone w
                             # cornerMOSlv.lib: .LIB mos_tt_mismatch)
TEMP_NOM="27"
VP_NOM="1.2"

# ---------------------------------------------------------------------------
# Sygnały do pomiaru - identyczne jak w run_corners_layout.sh (netlista ma
# wbudowane zrodla Viref/Viup/Vidn)
# ---------------------------------------------------------------------------
SIG_VOUT="v(vout)"
SIG_VBIAS="v(x1.bias)"
SIG_IREF="v.x1.viref#branch"
SIG_IUP="v.x1.viup#branch"
SIG_IDN="v.x1.vidn#branch"
SIG_UP="v(up)"
SIG_DN="v(dn)"

mkdir -p "$DATA_DIR" "$LOG_DIR" "$RESULTS_DIR"

if [ ! -f "$NETLIST_SRC" ]; then
    echo "BLAD: nie znaleziono pliku netlisty: $NETLIST_SRC"
    echo "      sprawdz sciezke i popraw zmienna NETLIST_SRC na gorze skryptu."
    exit 1
fi

rm -f "$DATA_DIR"/cp_mc_data_*.txt
rm -f "$RESULTS_DIR"/mc_report.html "$RESULTS_DIR"/mc_histogram*.png

# ---------------------------------------------------------------------------
# Przygotowanie netlisty dla jednej iteracji MC (rozny rndseed za kazdym razem)
# ---------------------------------------------------------------------------
prepare_netlist_mc() {
    local seed=$1
    local out=$2

    cp "$NETLIST_SRC" "$out"

    # usuń istniejący blok .control ... .endc
    sed -i '/^[[:space:]]*\.control/,/^[[:space:]]*\.endc/d' "$out"

    # temperatura i Vp - nominalne (MC bada rozrzut WOKOL typowego punktu)
    sed -i -E "s/^([[:space:]]*)\.temp .*/\1.temp $TEMP_NOM/" "$out"
    sed -i -E "s/^([[:space:]]*)\.param Vp=.*/\1.param Vp=$VP_NOM/" "$out"

    # corner - podmieniamy na mos_tt_mismatch (nominalny + wlaczony mismatch)
    sed -i -E "s/^([[:space:]]*\.lib .*cornerMOSlv\.lib) [^ ]+$/\1 $CORNER_MC/" "$out"

    # blok .control - "set rndseed" PRZED tran, zeby kazda iteracja miala inna
    # losowosc (agauss w modelu odwoluje sie do wewnetrznego RNG ngspice -
    # bez jawnego rndseed kolejne uruchomienia moglyby dac ten sam wynik,
    # jesli seed domyslny nie zmienia sie miedzy procesami)
    cat >> "$out" <<EOF
.control
set rndseed=$seed
save $SIG_VOUT $SIG_VBIAS $SIG_IREF $SIG_IUP $SIG_IDN $SIG_UP $SIG_DN
tran 100n 50u
set filetype=ascii
wrdata cp_test.txt $SIG_VOUT $SIG_VBIAS $SIG_IREF $SIG_IUP $SIG_IDN $SIG_UP $SIG_DN
quit
.endc
EOF
}

# ---------------------------------------------------------------------------
# Główna pętla Monte Carlo
# ---------------------------------------------------------------------------
for i in $(seq 1 "$N_ITER"); do
    TAG="mc_${i}"
    OUT_FILE="$DATA_DIR/cp_mc_data_${TAG}.txt"
    LOG_FILE="$LOG_DIR/ngspice_${TAG}.log"

    echo "=== iteracja $i / $N_ITER ==="
    prepare_netlist_mc "$i" "$TMP_NETLIST"

    (cd "$SIM_DIR" && ngspice -b "$(basename "$TMP_NETLIST")") > "$LOG_FILE" 2>&1

    if [ -f "$SIM_DIR/cp_test.txt" ]; then
        cp "$SIM_DIR/cp_test.txt" "$OUT_FILE"
        rm -f "$SIM_DIR/cp_test.txt"
    else
        echo "  BLAD: brak cp_test.txt dla iteracji $i. Log: $LOG_FILE"
        tail -20 "$LOG_FILE"
    fi
    rm -f "$TMP_NETLIST"
done

# ---------------------------------------------------------------------------
# Post-processing - histogram + statystyka
# ---------------------------------------------------------------------------
if [ -f "$SCRIPT_DIR/plot_montecarlo_sch.py" ]; then
    python3 "$SCRIPT_DIR/plot_montecarlo_sch.py"
fi

echo "Gotowe. Raport HTML: $RESULTS_DIR/mc_report.html"
