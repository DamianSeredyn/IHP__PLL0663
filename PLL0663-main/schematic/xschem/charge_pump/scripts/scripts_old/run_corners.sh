#!/bin/bash
# run_corners_new500n.sh – symulacja cornerów PVT dla charge pump NEW_500n
# Wszystkie parametry są zdefiniowane wewnątrz skryptu.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# ===== KONFIGURACJA =====
# Ścieżki
SPICE="$PROJECT_DIR/charge_pump/simulations/NEW_500n_tran_tb.spice"
SIM_DIR="$PROJECT_DIR/charge_pump/simulations"
DATA_DIR="$PROJECT_DIR/charge_pump/results_new500n/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results_new500n/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results_new500n"

# Listy parametrów (możesz dowolnie zmieniać)
corners="mos_tt mos_ss mos_ff mos_sf mos_fs"
t_min="-25"
t_nom="27"
t_max="125"
vp_min="1.08"
vp_nom="1.2"
vp_max="1.32"

# ===== PRZYGOTOWANIE =====
mkdir -p "$DATA_DIR" "$LOG_DIR" "$RESULTS_DIR"
rm -f "$DATA_DIR"/cp_new500n_data_*.txt
rm -f "$RESULTS_DIR"/cp_new500n_*.png "$RESULTS_DIR"/cp_new500n_report.html

echo "=== Rozpoczynam symulacje cornerów NEW_500n ==="

for CORNER in $corners; do
    for TEMP in $t_min $t_nom $t_max; do
        for VP in $vp_min $vp_nom $vp_max; do
            TAG="${CORNER}_T${TEMP}_Vp${VP}"
            OUT="$DATA_DIR/cp_new500n_data_${TAG}.txt"
            LOG="$LOG_DIR/ngspice_new500n_${TAG}.log"
            TMP="$SIM_DIR/temp_new500n_$$.spice"

            echo "--- $TAG ---"

            # Przygotuj tymczasową netlistę z podmienionymi parametrami
            cp "$SPICE" "$TMP"
            sed -i "s/\.temp .*/.temp $TEMP/"   "$TMP"
            sed -i "s/\.param Vp=.*/.param Vp=$VP/"         "$TMP"
            sed -i "s/\.lib cornerMOSlv\.lib .*/\.lib cornerMOSlv\.lib $CORNER/" "$TMP"

            # Uruchom ngspice w katalogu symulacji (tam powstanie cp_test.txt)
            (cd "$SIM_DIR" && ngspice -b "$(basename "$TMP")") > "$LOG" 2>&1

            if [ -f "$SIM_DIR/cp_test.txt" ]; then
                cp "$SIM_DIR/cp_test.txt" "$OUT"
                echo "  OK → $OUT"
                rm -f "$SIM_DIR/cp_test.txt"
            else
                echo "  BŁĄD – brak cp_test.txt. Log: $LOG"
                tail -5 "$LOG"
            fi

            rm -f "$TMP"
        done
    done
done

echo ""
echo "=== Symulacje zakończone. Generuję wykresy i raport ==="
python3 "$SCRIPT_DIR/plot_cp_new2.py"
echo "Gotowe. Raport HTML: $RESULTS_DIR/cp_new500n_report.html"
