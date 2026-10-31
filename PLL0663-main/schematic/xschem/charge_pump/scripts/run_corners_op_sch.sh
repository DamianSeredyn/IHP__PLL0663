#!/bin/bash
# run_op_sweep_schematic.sh
# Symulacja PUNKTU PRACY (op, bez tran) na netliście SCHEMATOWEJ (bez ekstrakcji,
# bez parazytów). Analogiczne do run_op_sweep.sh (post-layout), ale inne nazwy
# instancji tranzystorów i węzeł biasu.
# Sweep: corner x temperatura x Vp x Vout (Vout wymuszone zrodlem DC na wezle
# "vout"). Mierzone: v(vout), v(bias), iref, iup, idn.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SIM_DIR="$PROJECT_DIR/charge_pump/simulations"


NETLIST_SRC="/foss/designs/simulations/charge_pump_op_tb.spice"

DATA_DIR="$PROJECT_DIR/charge_pump/results_op_schematic/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results_op_schematic/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results_op_schematic"
TMP_NETLIST="$SIM_DIR/temp_op_sch_run_$$.spice"

# ---------------------------------------------------------------------------
# Parametry sweepu (identyczne jak w wersji post-layout)
# ---------------------------------------------------------------------------
corners="mos_tt mos_ss mos_ff mos_sf mos_fs"
t_min="-40"
t_nom="27"
t_max="125"
vp_min="1.08"
vp_nom="1.2"
vp_max="1.32"
vout_values="0.2 0.4 0.6 0.8 1.0"

# ---------------------------------------------------------------------------
# Sygnały do pomiaru
# ---------------------------------------------------------------------------

SIG_VOUT="v(vout)"
SIG_VBIAS="v(x1.bias)"
SIG_IREF="@n.x1.xm12.nsg13_lv_pmos[ids]"
SIG_IUP="@n.x1.xm5.nsg13_lv_pmos[ids]"
SIG_IDN="@n.x1.xm13.nsg13_lv_nmos[ids]"

mkdir -p "$DATA_DIR" "$LOG_DIR" "$RESULTS_DIR"

if [ ! -f "$NETLIST_SRC" ]; then
    echo "BLAD: nie znaleziono pliku netlisty: $NETLIST_SRC"
    echo "      sprawdz sciezke i popraw zmienna NETLIST_SRC na gorze skryptu."
    exit 1
fi

rm -f "$RESULTS_DIR"/cp_op_schematic_report.html

# ---------------------------------------------------------------------------
# Przygotowanie netlisty dla jednego przypadku (corner/temp/Vp/Vout)
# ---------------------------------------------------------------------------
prepare_netlist() {
    local corner=$1
    local temp=$2
    local vp=$3
    local vout=$4
    local out=$5

    cp "$NETLIST_SRC" "$out"

    # jeśli .param (np. rsh_rppd) siedzi wewnątrz oryginalnego .control -
    # zachowaj je przed usunięciem bloku (tak jak w wersji PEX). W netliście
    # schematowej może tego w ogóle nie być (brak modelu rppd bez ekstrakcji),
    # ale zostawiamy zabezpieczenie na wszelki wypadek - nieszkodliwe jeśli
    # plik .params wyjdzie pusty.
    awk '
        /^[[:space:]]*\.control/ { inctrl=1 }
        inctrl && /^[[:space:]]*\.param/ { print }
        /^[[:space:]]*\.endc/ { inctrl=0 }
    ' "$out" > "$out.params"

    # usuń istniejący blok .control ... .endc (dopuszczamy wcięcie)
    sed -i '/^[[:space:]]*\.control/,/^[[:space:]]*\.endc/d' "$out"

    if [ -s "$out.params" ]; then
        cat "$out.params" >> "$out"
    fi
    rm -f "$out.params"

    # temperatura, Vp, corner - dopuszczamy wiodące białe znaki
    sed -i -E "s/^([[:space:]]*)\.temp .*/\1.temp $temp/" "$out"
    sed -i -E "s/^([[:space:]]*)\.param Vp=.*/\1.param Vp=$vp/" "$out"
    sed -i -E "s/^([[:space:]]*\.lib .*cornerMOSlv\.lib) [^ ]+$/\1 $corner/" "$out"

    # źródło Vout - zakładam ten sam format co w netliście PEX: "Vup1 vout 0 0.6"
    # (bez slowa DC). Jeśli w schemacie ma inną nazwę/format, zweryfikuj:
    #   grep -in "vout" plik.spice
    sed -i -E "s/^([[:space:]]*Vup1[[:space:]]+vout[[:space:]]+0[[:space:]]+)[0-9.eE+-]+/\1$vout/" "$out"

    # blok .control - TYLKO op, bez tran, bez wrdata
    cat >> "$out" <<EOF
.control
save $SIG_VOUT $SIG_VBIAS
op
print $SIG_VOUT
print $SIG_VBIAS
print $SIG_IREF
print $SIG_IUP
print $SIG_IDN
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
            for VOUT in $vout_values; do
                TAG="${CORNER}_T${TEMP}_Vp${VP}_Vout${VOUT}"
                LOG_FILE="$LOG_DIR/ngspice_op_sch_${TAG}.log"

                echo "=== $TAG ==="
                if ! prepare_netlist "$CORNER" "$TEMP" "$VP" "$VOUT" "$TMP_NETLIST"; then
                    echo "  POMINIETO - blad przygotowania netlisty"
                    rm -f "$TMP_NETLIST"
                    continue
                fi

                (cd "$SIM_DIR" && ngspice -b "$(basename "$TMP_NETLIST")") > "$LOG_FILE" 2>&1
                echo "  log -> $LOG_FILE"
                rm -f "$TMP_NETLIST"
            done
        done
    done
done

# ---------------------------------------------------------------------------
# Post-processing - tabela HTML (bez wykresów)
# ---------------------------------------------------------------------------
if [ -f "$SCRIPT_DIR/table_op_sch.py" ]; then
    python3 "$SCRIPT_DIR/table_op_sch.py"
fi

echo "Gotowe. Raport HTML: $RESULTS_DIR/cp_op_schematic_report.html"
