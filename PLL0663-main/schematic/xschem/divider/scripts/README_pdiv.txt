==============================================================================
PROGRAMMABLE DIVIDER (pdiv) — SWEEP AND REPORT
==============================================================================

Scripts for PVT simulation of the programmable frequency divider in ngspice
and for verifying correct frequency division and duty cycle across all
measurement outputs.


FILES
------------------------------------------------------------------------------
run_sweep_pdiv.sh       Sweep driver: corner x temperature x VDD. Patches the
                        testbench, runs `ngspice -b`, and finally calls the
                        report script.

plot_divider_pdiv.py    Loads the .dat files, computes frequency and duty
                        cycle of each signal, checks divisibility, and
                        generates an HTML report (tables only, no plots).


DIRECTORY LAYOUT
------------------------------------------------------------------------------
Assumes the same project structure as the other blocks:

  PROJECT_DIR/
  |-- configs/
  |   `-- corner_data          # t_min/t_nom/t_max, vp_min/vp_nom/vp_max, corners
  |-- divider/
  |   |-- scripts/
  |   |   |-- run_sweep_pdiv.sh       # <- this file
  |   |   `-- plot_divider_pdiv.py    # <- this file
  |   |-- simulations/
  |   |   `-- pdiv_sym_tb.spice       # testbench
  |   `-- results/
  |       |-- data/              # generated *.dat
  |       `-- pdiv_report.html   # generated report

run_sweep_pdiv.sh derives PROJECT_DIR as the directory two levels above the
script itself, so run it from divider/scripts/.


REQUIREMENTS
------------------------------------------------------------------------------
- ngspice on PATH
- python3 with numpy
- a configs/corner_data file providing: t_min t_nom t_max,
  vp_min vp_nom vp_max, corners (a list, e.g. "mos_tt mos_ss mos_ff ...")


RUNNING
------------------------------------------------------------------------------
  cd divider/scripts

  ./run_sweep_pdiv.sh                 # full sweep: all corners x all PVT points
  ./run_sweep_pdiv.sh -c typ          # mos_tt, t_nom, vp_nom
  ./run_sweep_pdiv.sh -c hot          # mos_ss, t_max, vp_min
  ./run_sweep_pdiv.sh -c cold         # mos_ff, t_min, vp_max
  ./run_sweep_pdiv.sh -c hot cold     # several presets at once
  ./run_sweep_pdiv.sh -c tt ss        # corners by name (substring match)

Presets narrow corner + temperature + VDD. Passing only a corner name (e.g.
"tt") narrows the corner only; temperature and VDD use their full ranges.


WHAT IS MEASURED
------------------------------------------------------------------------------
For each PVT combination the script records waveforms of:

  - clk       : reference clock input
  - out       : main programmable divider output
  - out_div   : /2 output (used for 50% duty cycle reset signal)
  - div2-div64: intermediate measurement points (if present in testbench)

Over the last 50% of the simulation (to let the circuit settle), 
plot_divider_pdiv.py computes:

  - clk           : frequency and duty cycle (reference clock)
  - out           : frequency, duty cycle, and measured divider ratio
  - out_div       : frequency, duty cycle (should be ~50%)
  - div2..div64   : frequency, duty cycle (if monitored)

Frequency and duty are averaged over all periods in the analysis window
(interpolated crossings of the 50% amplitude level).


PASS/FAIL CRITERION (green check / red X)
------------------------------------------------------------------------------
For the main output (out) and intermediate signals:

  1. the measured divider ratio (f_clk / f_out) must match expected
     (default: 10% relative tolerance)
  2. the duty cycle must be within 50% ± 5% (default values)

A signal passes if BOTH criteria are met. Otherwise it fails.
Stuck signals (no switching) are marked as failed.

Special notes:
  - clk is always reference (ratio 1:1)
  - out_div should have ~50% duty by design (is /2 of out)
  - Expected ratio for out_div is: measured_ratio(out) × 2


REPORT
------------------------------------------------------------------------------
results/pdiv_report.html contains:

  - Summary table: one row per PVT condition showing f_clk, clk duty,
    f_out, out duty, measured divider ratio, and overall status.

  - One panel per PVT condition: a table with rows for each signal showing
    frequency, duty cycle, measured vs. expected ratio, signal swing, and
    pass/fail status.

Duty cells are color-coded:
  - green: within target ± tolerance
  - yellow: slightly high/low (deviation > 5% but < 10%)
  - red: badly mismatched

Pass/fail status is highlighted and shows reason if failed.


TESTBENCH SIGNAL LIST
------------------------------------------------------------------------------
The signals measured must match the wrdata line in run_sweep_pdiv.sh and
the SIGNAL_ORDER list in plot_divider_pdiv.py:

  SIGNAL_ORDER = ['clk', 'out', 'out_div', 'div2', 'div4', 'div8', 'div16', 'div32', 'div64']

If your testbench has different signal names or if some signals don't exist,
you MUST:
  1. Modify the wrdata line in run_sweep_pdiv.sh
  2. Update SIGNAL_ORDER in plot_divider_pdiv.py
  3. Keep them in the same order

Example: if your testbench only has clk, out, out_div (no div2-div64):
  wrdata {dat_path} v(clk) v(out) v(out_div)
  SIGNAL_ORDER = ['clk', 'out', 'out_div']


TUNABLE PARAMETERS
------------------------------------------------------------------------------
In plot_divider_pdiv.py (constants near the top):

  - DUTY_TARGET, DUTY_TOL   : duty-cycle center and tolerance
                              (default 50% ± 5%)
  - DIV_REL_TOL             : divider-match tolerance (default 10%)
  - LAST_FRACTION           : fraction of the simulation fed to analysis
                              (default 0.5 = last 50%)
  - VSWING_MIN              : minimum swing (as fraction of VDD) to count as
                              real switching (default 0.40 = 40% of VDD;
                              rejects stuck nodes)

In run_sweep_pdiv.sh:

  - tran 50p 4u             : time step and stop time. For a programmable
                              divider that can divide by up to 64, you may
                              need to increase 4u if the circuit startup is slow.
  - the .lib cornerMOSlv.lib line : adjust if your corner names differ or if
                                    the library path is different.

NOTE: the order of signals in the wrdata line MUST MATCH SIGNAL_ORDER in
plot_divider_pdiv.py. If you change one, change the other.


PROGRAMMABLE DIVIDER SPECIFICS
------------------------------------------------------------------------------
The programmable divider has a counter (0 to 63) and a comparator that resets
it when count == data_in. The reset signal is divided by 2 to get out_div
(50% duty cycle output).

- out       : the main output at frequency = f_clk / (data_in + 1)
- out_div   : /2 version of out, so frequency = f_clk / (2 * (data_in + 1))
- div2-div64: optional monitoring points; expected frequencies depend on
              where they are tapped from the counter.

Currently, the scripts measure whatever is available in the testbench and
compute the actual ratios. If you want to program specific data_in values
during the sweep, you can extend the bash script to loop over different
programming values and generate separate reports for each.


TROUBLESHOOTING
------------------------------------------------------------------------------
Q: "No .dat files found"
A: Check that ngspice ran successfully. Look at /tmp/pdiv_run.spice for the
   last generated netlist and try running it manually:
     ngspice -b /tmp/pdiv_run.spice
   Check for simulation errors.

Q: "Signal stuck" or "No signal"
A: Check that the testbench netlists include the monitoring probe points
   (v(clk), v(out), v(out_div), etc.) and that they are correctly connected.
   Verify supply voltages and that the circuit is actually toggling.

Q: "Measured ratio does not match expected"
A: This can mean the divider is working correctly but at an unexpected ratio
   (e.g., data_in was set to a different value than you thought). Check the
   testbench for the data_in signal and verify its value during simulation.
   You can also extend the script to sweep different data_in values.

Q: "Duty cycle bad"
A: The /2 divider (for out_div) should give ~50%. If out has poor duty, check
   the counter logic and async/sync reset behavior. If out_div has poor duty,
   check that the /2 stage is symmetric.
