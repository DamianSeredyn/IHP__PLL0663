SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SIM_DIR="$PROJECT_DIR/charge_pump/simulations"


#NETLIST_SRC="/foss/designs/CHIP-PLL/schematics/charge_pump/simulations/charge_pump_tran_tb.spice"
NETLIST_SRC="/foss/designs/simulations/charge_pump_tran_tb.spice"

DATA_DIR="$PROJECT_DIR/charge_pump/results_tran_sch/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results_tran_sch/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results_tran_sch"
TMP_NETLIST="$SIM_DIR/temp_run_$$.spice"

# ---------------------------------------------------------------------------
# Parametry sweepu
# ---------------------------------------------------------------------------
corners="mos_tt mos_ss mos_ff mos_sf mos_fs"
#corners="mos_tt mos_ss"
t_min="-25"
t_nom="27"
t_max="125"
vp_min="1.08"
vp_nom="1.2"
vp_max="1.32"

# ---------------------------------------------------------------------------
# Sygnały do pomiaru
# ---------------------------------------------------------------------------

SIG_VOUT="v(vout)"
SIG_VBIAS="v(x1.bias)"
SIG_IREF="v.x1.viref#branch"
SIG_IUP="v.x1.viup#branch"
SIG_IDN="v.x1.vidn#branch"
# v(up)/v(dn) - potrzebne w Pythonie do liczenia sredniej iup/idn TYLKO gdy
# dany sygnal sterujacy jest aktywny (PULSE wysoki)
SIG_UP="v(up)"
SIG_DN="v(dn)"

mkdir -p "$DATA_DIR" "$LOG_DIR" "$RESULTS_DIR"

if [ ! -f "$NETLIST_SRC" ]; then
    echo "BLAD: nie znaleziono pliku netlisty: $NETLIST_SRC"
    echo "      sprawdz sciezke i popraw zmienna NETLIST_SRC na gorze skryptu."
    exit 1
fi

rm -f "$DATA_DIR"/cp_layout_data_*.txt
rm -f "$RESULTS_DIR"/cp_layout_*.png "$RESULTS_DIR"/cp_layout_report.html

# ---------------------------------------------------------------------------
# Przygotowanie netlisty dla jednego przypadku
# ---------------------------------------------------------------------------
prepare_netlist() {
    local corner=$1
    local temp=$2
    local vp=$3
    local out=$4

    cp "$NETLIST_SRC" "$out"

    # usuń istniejący blok .control ... .endc
    sed -i '/^[[:space:]]*\.control/,/^[[:space:]]*\.endc/d' "$out"

    # temperatura (netlista ma ".temp 125" w tym przykladzie) - dopuszczamy
    # wiodace biale znaki
    sed -i -E "s/^([[:space:]]*)\.temp .*/\1.temp $temp/" "$out"

    # Vp (netlista ma ".param Vp=1.32" w tym przykladzie) - dopuszczamy
    # wiodace biale znaki
    sed -i -E "s/^([[:space:]]*)\.param Vp=.*/\1.param Vp=$vp/" "$out"

    # corner - podmieniamy tylko ostatnie słowo w linii .lib cornerMOSlv.lib
    # UWAGA: linia w prawdziwym pliku ma wiodącą spację, dlatego dopuszczamy
    # opcjonalne białe znaki na początku
    sed -i -E "s/^([[:space:]]*\.lib .*cornerMOSlv\.lib) [^ ]+$/\1 $corner/" "$out"

    # nowy blok .control dopisany na końcu pliku
    # WAŻNE: "save" (bez "all") ogranicza się tylko do wskazanych wektorów -
    # ngspice nie akumuluje reszty parazytycznych węzłów/gałęzi w pamięci
    # ani w pliku wynikowym.
    cat >> "$out" <<EOF
.control
save $SIG_VOUT $SIG_VBIAS $SIG_IREF $SIG_IUP $SIG_IDN $SIG_UP $SIG_DN
tran 100n 245u
set filetype=ascii
wrdata cp_test.txt $SIG_VOUT $SIG_VBIAS $SIG_IREF $SIG_IUP $SIG_IDN $SIG_UP $SIG_DN
quit
.endc
EOF
}

# ---------------------------------------------------------------------------
# Główna pętla
# ---------------------------------------------------------------------------
for CORNER in $corners; do
    for TEMP in $t_min $t_nom $t_max; do
        for VP in $vp_min $vp_nom $vp_max; do
            TAG="${CORNER}_T${TEMP}_Vp${VP}"
            OUT_FILE="$DATA_DIR/cp_layout_data_${TAG}.txt"
            LOG_FILE="$LOG_DIR/ngspice_${TAG}.log"

            echo "=== $TAG ==="
            if ! prepare_netlist "$CORNER" "$TEMP" "$VP" "$TMP_NETLIST"; then
                echo "  POMINIETO - blad przygotowania netlisty (patrz komunikat wyzej)"
                rm -f "$TMP_NETLIST"
                continue
            fi

            (cd "$SIM_DIR" && ngspice -b "$(basename "$TMP_NETLIST")") > "$LOG_FILE" 2>&1

            if [ -f "$SIM_DIR/cp_test.txt" ]; then
                cp "$SIM_DIR/cp_test.txt" "$OUT_FILE"
                echo "  OK -> $OUT_FILE"
                rm -f "$SIM_DIR/cp_test.txt"
            else
                echo "  BLAD: brak cp_test.txt. Log: $LOG_FILE"
                tail -20 "$LOG_FILE"
            fi
            rm -f "$TMP_NETLIST"
        done
    done
done

# ---------------------------------------------------------------------------
# Post-processing
# ---------------------------------------------------------------------------
if [ -f "$SCRIPT_DIR/plot_cp_tran_sch.py" ]; then
    python3 "$SCRIPT_DIR/plot_cp_tran_sch.py"
fi

echo "Gotowe. Raport HTML: $RESULTS_DIR/cp_layout_report.html"
