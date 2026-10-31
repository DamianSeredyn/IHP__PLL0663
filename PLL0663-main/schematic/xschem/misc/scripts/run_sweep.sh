#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"
source $PROJECT_DIR/configs/corner_data
SPICE=$PROJECT_DIR/schematics/misc/simulations/level_shifter_tb.spice
DATA_DIR=$PROJECT_DIR/schematics/misc/results/data
mkdir -p $DATA_DIR
rm -f $DATA_DIR/ls_results.txt
rm -f $RESULTS_DIR/ls_*.png
rm -f $RESULTS_DIR/ls_report.html

OUT=$DATA_DIR/ls_results.txt
echo "corner temp vp vph vout_max vout_avg" > $OUT

for CORNER in $corners; do
for TEMP in $t_min $t_nom $t_max; do
for VP in $vp_min $vp_nom $vp_max; do
for VPH in $vph_min $vph_nom $vph_max; do
    TAG="${CORNER}_T${TEMP}_Vp${VP}_Vph${VPH}"
    echo "=== Corner: $CORNER Temp: $TEMP Vp: $VP Vph: $VPH ==="

    sed "s/\.temp=.*/.temp=$TEMP/" $SPICE | \
    sed "s/\.param Vp=.*/.param Vp=$VP/" | \
    sed "s/\.param Vph=.*/.param Vph=$VPH/" | \
    sed "s/cornerMOSlv\.lib .*/cornerMOSlv.lib $CORNER/" | \
    sed "s/cornerMOShv\.lib .*/cornerMOShv.lib $CORNER/" \
    > /tmp/ls_run.spice

    RESULT=$(ngspice -b /tmp/ls_run.spice 2>/dev/null)
    VOUT_MAX=$(echo "$RESULT" | grep "vout_max" | awk '{print $3}')
    VOUT_AVG=$(echo "$RESULT" | grep "vout_avg" | awk '{print $3}')

    echo "$CORNER $TEMP $VP $VPH $VOUT_MAX $VOUT_AVG" >> $OUT
    echo "Done: $TAG vout_max=$VOUT_MAX vout_avg=$VOUT_AVG"
done
done
done
done

python3 $SCRIPT_DIR/plot_ls.py
