#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data

SPICE=$PROJECT_DIR/charge_pump/simulations/NEW_500n_tran_tb.spice
DATA_DIR=$PROJECT_DIR/charge_pump/results/data

mkdir -p $DATA_DIR

rm -f $DATA_DIR/charge_pump_data_*.txt
rm -f $RESULTS_DIR/charge_pump_*.png
rm -f $RESULTS_DIR/charge_pump_report.html

for CORNER in $corners; do
    for TEMP in $t_min $t_nom $t_max; do
        for VP in $vp_min $vp_nom $vp_max; do

            TAG="${CORNER}_T${TEMP}_Vp${VP}"
            OUT=$DATA_DIR/charge_pump_data_${TAG}.txt
            echo "=== Corner: $CORNER Temp: $TEMP Vp: $VP ==="

            sed "s/\.temp=.*/.temp=$TEMP/" $SPICE | \
            sed "s/\.param Vp=.*/.param Vp=$VP/" | \
            sed "s/cornerMOSlv\.lib .*/cornerMOSlv.lib $CORNER/" \
            > /tmp/charge_pump_run.spice

            ngspice -b /tmp/charge_pump_run.spice &>/dev/null

            # ngspice zapisuje cp_test.txt w miejscu skąd jest odpalany
            cp cp_test.txt $OUT

            echo "Done: $TAG"

        done
    done
done

python3 $SCRIPT_DIR/parse_cp.py
python3 $SCRIPT_DIR/plot_cp.py
