SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SIM_DIR="$PROJECT_DIR/charge_pump/simulations"


NETLIST_SRC="/foss/designs/simulations/charge_pump_tran_tb.spice"

DATA_DIR="$PROJECT_DIR/charge_pump/results_layout/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results_layout/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results_layout"
TMP_NETLIST="$SIM_DIR/temp_run_$$.spice"

# ---------------------------------------------------------------------------
# Parametry sweepu 
# ---------------------------------------------------------------------------
corners="mos_tt mos_ss mos_ff mos_sf mos_fs"
t_min="-40"
t_nom="27"
t_max="125"
vp_min="1.08"
vp_nom="1.2"
vp_max="1.32"

# ---------------------------------------------------------------------------
# Sygnały napięciowe 
# ---------------------------------------------------------------------------
SIG_VOUT="v(vout)"
SIG_VBIAS="v(x1.bias)"

# ---------------------------------------------------------------------------
# Pomiar prądów drenów — ammeter (0V), NIE parametr OSDI @...[ids]
# ---------------------------------------------------------------------------
# @n...[ids] to odpyt parametru WEWNĘTRZNEGO modelu OSDI/PSP - ngspice liczy
# go raz, w ostatnim punkcie analizy, i NIE śledzi go w czasie (stąd stała
# wartość w pliku wrdata). Zamiast tego wstawiamy w kopii netlisty (tylko do
# symulacji, oryginalny plik PEX zostaje nietknięty) źródło napięciowe 0V
# szeregowo w dren każdego tranzystora - i(Vxxx) to natywna wielkość SPICE,
# śledzona w KAŻDYM punkcie czasowym tran, dokładnie jak napięcia węzłów.
#
# Mapowanie (potwierdzone):
#   X43 -> M9  (iref)
#   X19 -> M17 (iup, czesc 1)
#   X50 -> M17 (iup, czesc 2 - IUP = suma drenow X19+X50)
#   X20 -> M18 (idn)
declare -A AMMETERS=( [X43]=Viref [X19]=Viup1 [X50]=Viup2 [X20]=Vidn )

# ngspice dla źródeł napięciowych zagnieżdżonych w subcircuicie zwraca prąd
# pod nazwą "v.<hierarchia>.<nazwa>#branch" (potwierdzone w logu ngspice),
# a NIE "i(<hierarchia>.<nazwa>)" - stąd błąd "no such function as i".
SIG_IREF="v.x1.viref#branch"
SIG_IUP1="v.x1.viup1#branch"
SIG_IUP2="v.x1.viup2#branch"
SIG_IDN="v.x1.vidn#branch"
# Nazwa finalnego, policzonego wektora iup (suma X19+X50) - patrz "let" w
# bloku .control ponizej. To ta nazwa trafia do wrdata, NIE SIG_IUP1/IUP2
# osobno.
SIG_IUP="itotal_up"

# ---------------------------------------------------------------------------
# Wstawienie ammetera 0V w dren wskazanej instancji X, TYLKO wewnątrz bloku
# .subckt charge_pump_cell (żeby nie trafić w tożsamo nazwaną instancję
# w innym, zagnieżdżonym subcircuit np. vbias/curr_source).
# ---------------------------------------------------------------------------
insert_ammeter() {
    local netfile=$1
    local xname=$2   # np. X43
    local vname=$3   # np. Viref
    local errfile
    errfile=$(mktemp)

    # tolower() na .subckt/.ends - niektóre narzędzia ekstrakcji pisą je
    # wielkimi literami (.SUBCKT/.ENDS). Dopasowanie instancji ($1==xname)
    # zostaje wrażliwe na wielkość liter, bo nazwy instancji X.. muszą się
    # zgadzać dokładnie z tym co podał użytkownik.
    awk -v xname="$xname" -v vname="$vname" '
        BEGIN { found=0 }
        tolower($0) ~ /^\.subckt[ \t]+charge_pump_cell([ \t]|$)/ { inblk=1; print; next }
        tolower($0) ~ /^\.ends/ && inblk { inblk=0; print; next }
        inblk && $1 == xname {
            orig_drain = $2
            newnode = xname "_drain_probe"
            $2 = newnode
            print
            print vname, newnode, orig_drain, "DC 0"
            found=1
            next
        }
        { print }
        END { if (!found) print "MISSING:" xname > "/dev/stderr" }
    ' "$netfile" > "$netfile.tmp" 2>"$errfile"

    if [ -s "$errfile" ]; then
        echo "BLAD: nie znaleziono instancji $xname wewnatrz charge_pump_cell w $netfile" >&2
        echo "      sprawdz recznie: grep -in '^${xname} ' $netfile" >&2
        echo "      i: grep -in '^\.subckt charge_pump_cell' $netfile" >&2
        rm -f "$errfile" "$netfile.tmp"
        return 1
    fi

    mv "$netfile.tmp" "$netfile"
    rm -f "$errfile"
    return 0
}

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

    # temperatura (netlista ma ".temp 25") - dopuszczamy wiodące białe znaki,
    # tak jak w .lib powyżej
    sed -i -E "s/^([[:space:]]*)\.temp .*/\1.temp $temp/" "$out"

    # Vp (netlista ma ".param Vp=1.2") - dopuszczamy wiodące białe znaki
    sed -i -E "s/^([[:space:]]*)\.param Vp=.*/\1.param Vp=$vp/" "$out"

    # corner - podmieniamy tylko ostatnie słowo w linii .lib
    # UWAGA: linia w prawdziwym pliku ma wiodącą spację (" .lib cornerMOSlv.lib mos_tt"),
    # dlatego dopuszczamy opcjonalne białe znaki na początku - inaczej sed nigdy
    # nie trafiał i corner zawsze zostawał tym z oryginalnego pliku (mos_tt)
    sed -i -E "s/^([[:space:]]*\.lib .*cornerMOSlv\.lib) [^ ]+$/\1 $corner/" "$out"

    # wstawienie ammeterów 0V w dreny wskazanych tranzystorów (patrz AMMETERS)
    # jeśli którykolwiek się nie uda - przerywamy TU, zanim ngspice dostanie
    # netlistę bez ammetera i zwróci mylący błąd "i(...) is not available"
    for xname in "${!AMMETERS[@]}"; do
        if ! insert_ammeter "$out" "$xname" "${AMMETERS[$xname]}"; then
            return 1
        fi
    done

    # nowy blok .control dopisany na końcu pliku
    # WAŻNE: "save" (bez "all") ogranicza się tylko do wskazanych wektorów -
    # ngspice nie akumuluje reszty parazytycznych węzłów/gałęzi w pamięci
    # ani w pliku wynikowym. To jedyny sposób, żeby plik nie ważył 100+ MB
    # na tak dużej post-layout netliście.
    # "let itotal_up" sumuje prad drenow X19 i X50 (razem = M17). Ta suma
    # jest liczona PO tran (elementwise na juz zapisanych wektorach czasowych),
    # wiec itotal_up ma pelna historie w czasie, tak samo jak reszta sygnalow.
    cat >> "$out" <<EOF
.control
save $SIG_VOUT $SIG_VBIAS $SIG_IREF $SIG_IUP1 $SIG_IUP2 $SIG_IDN
tran 10n 300u
let itotal_up = $SIG_IUP1 + $SIG_IUP2
set filetype=ascii
wrdata cp_test.txt $SIG_VOUT $SIG_VBIAS $SIG_IREF $SIG_IUP $SIG_IDN
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
if [ -f "$SCRIPT_DIR/plot_cp_layout.py" ]; then
    python3 "$SCRIPT_DIR/plot_cp_layout.py"
fi

echo "Gotowe. Raport HTML: $RESULTS_DIR/cp_layout_report.html"
