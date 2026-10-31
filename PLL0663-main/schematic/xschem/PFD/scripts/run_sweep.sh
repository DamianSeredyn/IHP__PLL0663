#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../../../" && pwd)"

source $PROJECT_DIR/configs/corner_data

SPICE=$PROJECT_DIR/schematics/PFD/simulations/PFD_tb.spice
DATA_DIR=$PROJECT_DIR/schematics/PFD/results/data
T_US=31.25
STEPS=50



mkdir -p $DATA_DIR

rm -f $DATA_DIR/pfd_linearity_*.txt
rm -f $RESULTS_DIR/pfd_*.png
rm -f $RESULTS_DIR/pfd_report.html

for CORNER in $corners; do
for TEMP in $t_min $t_nom $t_max; do
for VP in $vp_min $vp_nom $vp_max; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    OUT=$DATA_DIR/pfd_linearity_${TAG}.txt
    rm -f $OUT
    echo "dly pw_up pw_down" > $OUT
    echo "=== Corner: $CORNER Temp: $TEMP Vp: $VP ==="

    for i in $(seq 0 $((STEPS-1))); do
        DLY=$(echo "scale=6; $i * $T_US / ($STEPS-1)" | bc)
        DLY_U="${DLY}u"

        sed "s/\.param dly=.*/.param dly=$DLY_U/" $SPICE | \
	sed "s/\.temp=.*/.temp=$TEMP/" | \
        sed "s/\.param Vp=.*/.param Vp=$VP/" | \
        sed "s/cornerMOSlv\.lib .*/cornerMOSlv.lib $CORNER/" \
        > /tmp/pfd_run.spice

        RESULT=$(ngspice -b /tmp/pfd_run.spice 2>/dev/null)
        PW_UP=$(echo "$RESULT" | grep "pw_up" | awk '{print $3}')
        PW_DOWN=$(echo "$RESULT" | grep "pw_down" | awk '{print $3}')
        echo "$DLY_U $PW_UP $PW_DOWN" >> $OUT
        echo "Done: $TAG dly=$DLY_U"
    done

done
done
done

python3 $SCRIPT_DIR/plot_pfd.py
