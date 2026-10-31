================================================================================
VCO SWEEP — USAGE GUIDE
================================================================================

This guide explains how to run the VCO testbench across process, voltage,
temperature, and input-voltage corners, and how to interpret the
frequency / duty-cycle / supply-current report.

The flow consists of two files:

  vco/scripts/run_sweep.sh           sweep driver (bash)
  vco/scripts/plot_vco.py            plot + report generator (python)

You run the .sh script. It patches the testbench for each (corner, temp,
VDD, Vin) combination, calls ngspice, then calls the .py script to extract
oscillation metrics from the steady-state portion of the waveform and
produce a per-combination PNG plus a single HTML report.


================================================================================
1. WHAT THE FLOW DOES
================================================================================

For every (corner, temperature, VDD, Vin) combination:

  1. Rewrite the testbench in place to set:
       - .param temp     to the swept temperature
       - .param vdd      to the swept supply voltage
       - .param vin      to the swept input voltage (VCO tune voltage)
       - .options TEMP   to the swept temperature
       - .control block  is stripped and replaced with a tran + wrdata block
  2. Run ngspice -b in batch mode.
  3. Save three signals to a .dat file:
       v(out_pb), v(out), i(V2)
     where V2 is assumed to be the supply source whose current represents
     the VCO's VDD draw. The current is sign-flipped at plot time so
     "current drawn from VDD" displays as a positive number.

After all sweeps finish, plot_vco.py:

  1. Loads each .dat file (6 columns: time/value pairs for the three signals).
  2. Analyses the LAST 30% of each waveform — by then the VCO has settled
     and is oscillating steadily.
  3. Extracts per-signal metrics:
       - Frequency (from rising-edge interval at the 50% level)
       - Duty cycle (from rising-to-falling vs full period)
       - Rise time and fall time at 10/90% (for v(out_pb) only by default)
     plus supply-current statistics:
       - Average i(V2)
       - Peak i(V2)
       - Average dissipated power = avg_current * VDD
  4. Generates a PNG per combination plus an HTML report with tabs and a
     summary table grouped by corner.


================================================================================
2. REQUIRED DIRECTORY LAYOUT
================================================================================

The scripts expect this structure relative to the project root:

  <PROJECT_DIR>/
    configs/
      corner_data                 (sourced by the sweep script)
    vco/
      scripts/
        run_sweep.sh
        plot_vco.py
      simulations/
        vco_dcin_tb_3BL.spice     (testbench — name is hardcoded in the .sh)
      results/                    (auto-created, holds .png and .html)
        data/                     (auto-created, holds .dat files)

PROJECT_DIR is resolved as two directories above the .sh file. So if the
.sh sits at /foss/designs/CHIP-PLL/vco/scripts/, PROJECT_DIR is
/foss/designs/CHIP-PLL/.

If the testbench filename is not vco_dcin_tb_3BL.spice, edit the SPICE
variable near line 78 of run_sweep.sh.


================================================================================
3. WHAT corner_data MUST PROVIDE
================================================================================

The sweep script sources $PROJECT_DIR/configs/corner_data. That file must
export these shell variables (space-separated lists or single numbers):

  corners     space-separated list of corner names, e.g.
              "mos_tt mos_ss mos_ff mos_sf mos_fs"
  t_min       minimum temperature (e.g. -40)
  t_nom       nominal temperature (e.g. 27)
  t_max       maximum temperature (e.g. 125)
  vp_min      minimum supply voltage (e.g. 1.08)
  vp_nom      nominal supply voltage (e.g. 1.2)
  vp_max      maximum supply voltage (e.g. 1.32)

If corner_data is missing or any variable is empty, the sweep will fail
or produce zero combinations.

Note: the Vin axis is NOT in corner_data — it's hardcoded to 0.4 V and
0.8 V inside run_sweep.sh (see Section 7).


================================================================================
4. NETLIST REQUIREMENTS
================================================================================

The testbench netlist (vco_dcin_tb_3BL.spice by default) must contain:

  4.1  PARAMETERS USED FOR SWEEPING

       .param temp=27          (or any default)
       .param vdd=1.2          (or any default)
       .param vin=0.4          (or any default)

       All three must exist as text lines matching
       "^\.param\s+(temp|vdd|vin)\s*=.*". The sweep script rewrites these
       per iteration. If a parameter is missing from the netlist, the sweep
       silently leaves that variable at the netlist default — meaning the
       sweep axis has no electrical effect.

       Recommended placement: at the TOP of the netlist, before any
       element that references {vdd}, {vin}, or {temp} via brace expansion.

  4.2  SUPPLY SOURCE

       V2 ... 0 {vdd}    (or equivalent — supply going from a positive node
                          to ground, named V2)

       The script saves i(V2) and treats it as the VDD current. The name
       MUST be V2 — that string is baked into the wrdata line. If your
       supply has a different name, edit the wrdata line in run_sweep.sh
       and also update load_dat in plot_vco.py.

  4.3  OUTPUT NODES

       Two oscillating nodes named "out" and "out_pb". These are saved
       via v(out) and v(out_pb). The plotting code expects:
         - v(out)    — primary VCO output (single waveform, frequency reported)
         - v(out_pb) — secondary/complementary output (frequency, duty,
                       rise/fall time reported)

       If your VCO uses different node names, you must edit both:
         - the wrdata line in run_sweep.sh
         - the column mapping in load_dat() in plot_vco.py

  4.4  TUNE VOLTAGE NODE

       The Vin parameter is rewritten by the sweep. How it reaches the VCO
       depends on your testbench (typically a voltage source somewhere
       references {vin}, e.g. Vctrl tune 0 {vin}). The sweep doesn't care
       about the source name — only that .param vin is used somewhere.


================================================================================
5. SIMULATION TIME AND METRIC EXTRACTION
================================================================================

The sweep runs:

  tran 200p 160u

That is 200 ps step, 160 µs stop time. This is long compared to typical
oscillation periods, by design — the VCO needs to start up and reach
steady-state before metrics are extracted.

plot_vco.py analyses only the LAST 30% of the waveform (last 48 µs out of
160 µs). If your VCO startup is slow or its frequency is very low, you may
need to increase the stop time (200p 160u → 200p 500u, for example) or
change last_fraction in analyze_signal().

If a signal is flat (peak-to-peak < 50 mV) or has fewer than two rising
edges in the analysis window, the script reports N/A for that signal's
metrics instead of crashing.


================================================================================
6. RUNNING THE SWEEP
================================================================================

From any working directory:

  cd <PROJECT_DIR>/vco/scripts
  ./run_sweep.sh [options]

  6.1  NO ARGUMENTS — FULL PVT SWEEP

       ./run_sweep.sh

       Sweeps every corner in corner_data x {t_min, t_nom, t_max} x
       {vp_min, vp_nom, vp_max} x {0.4, 0.8} (Vin).
       For 5 corners that's 5*3*3*2 = 90 runs.

       Each run is ~160 µs of simulated time. Expect this to take a while.

  6.2  -c PRESET — SHORTHAND COMBOS

       ./run_sweep.sh -c typ
       ./run_sweep.sh -c hot
       ./run_sweep.sh -c cold

       typ   = mos_tt at (t_nom, vp_nom)
       hot   = mos_ss at (t_max, vp_min)   worst-case slow
       cold  = mos_ff at (t_min, vp_max)   worst-case fast

       Each preset narrows the corner list AND the temp/vdd range. Vin is
       NOT narrowed by presets — both 0.4 V and 0.8 V are still simulated,
       so each preset produces 2 simulations (one per Vin value).

  6.3  -c WITH CORNER NAMES — SUBSET OF CORNERS, FULL TEMP/VDD

       ./run_sweep.sh -c tt
       ./run_sweep.sh -c tt ss
       ./run_sweep.sh -c mos_tt

       Filters corners by substring match. -c tt matches any corner whose
       name contains "tt". Each matching corner still sweeps the full
       3 x 3 x 2 grid (temp, vdd, vin).

  6.4  MIXING PRESETS AND CORNERS

       ./run_sweep.sh -c typ hot

       Combines: typ adds mos_tt with narrowed PVT, hot adds mos_ss with
       its own narrowed PVT. Note that presets DO narrow PVT, so combining
       with raw corners can give surprising results — prefer one or the
       other.


================================================================================
7. CHANGING THE Vin SWEEP VALUES
================================================================================

Vin is hardcoded in run_sweep.sh — it is NOT in corner_data and is NOT
narrowed by presets. To change the set of Vin values, edit two places in
run_sweep.sh:

  Place 1 (around line 112) — combination counter:
       for VIN in 0.4 0.8; do
           TOTAL=$((TOTAL + 1))
       done

  Place 2 (around line 121) — main loop:
       for VIN in 0.4 0.8; do
           ...
           TAG="${CORNER}_T${TEMP}_Vp${VP}_Vin${VIN}"
           ...
       done

Replace "0.4 0.8" with whatever values you want, e.g. "0.2 0.4 0.6 0.8 1.0".
Keep the two lines in sync.


================================================================================
8. WHAT YOU GET IN results/
================================================================================

After a successful run:

  vco/results/
    vco_report.html
    vco_<corner>_T<temp>_Vp<vdd>_Vin<vin>.png    (one per combination)
    data/
      vco_<corner>_T<temp>_Vp<vdd>_Vin<vin>.dat  (one per combination)

Open vco_report.html in a browser. Tabs across the top:

  Podsumowanie    summary table grouped by corner, with a Vin sub-header
                  inside each corner section. Columns: TEMP, VDD, Vin,
                  f_out, f_out_pb, t_r out_pb, t_f out_pb, DC out, DC out_pb,
                  I_avg VDD, I_max VDD. Duty-cycle cells are color-coded:
                    white  — within ±5% of 50%
                    orange — between ±5% and ±10% off
                    red    — more than ±10% off
  Per-combo tabs  click "mos_xx T<temp> <vdd>V Vin<vin>V" to see the
                  detailed PNG and a metric breakdown.

Each PNG contains six panels:

  1. Full v(out) waveform.
  2. Full v(out_pb) waveform.
  3. Full i(V2) trace with average and peak lines drawn.
  4. v(out) metrics: frequency, duty cycle.
  5. v(out_pb) metrics: frequency, rise time, fall time, duty cycle.
  6. Simulation conditions and supply summary (avg/max current, avg power).


================================================================================
9. TROUBLESHOOTING
================================================================================

  Symptom: "Brak plikow .dat w <DATA_DIR>"
           Sweep claimed 100% done but produced no data files.
  Cause:   ngspice failed silently (sweep redirects its output to /dev/null).
  Fix:     Re-run the LAST iteration manually to see the real error:
             ngspice -b /tmp/vco_run.spice
           Common errors:
             "Undefined parameter [vdd]"  -> move .param vdd= above any line
                                             that references {vdd} in the
                                             netlist.
             "Cannot find subckt ..."     -> netlist references a corner-
                                             specific subckt that isn't
                                             available; check that your
                                             cornerMOSlv.lib (or equivalent)
                                             provides every corner in
                                             corner_data.

  Symptom: All frequencies show as N/A.
  Cause:   The VCO isn't oscillating in the last 30% of the simulation,
           or the signal is too small (< 50 mV peak-to-peak).
  Fix:     Open one .dat file and plot it manually. Common causes:
             - VCO never started (bias issue, Vin out of range)
             - VCO startup time > 70% of sim time (increase tran stop time)
             - Wrong node names (signal saved is a flat node)

  Symptom: Frequencies look right but duty cycle is consistently far from 50%.
  Note:    This is data, not a bug. A skewed duty cycle on v(out_pb) usually
           points at imbalance in the output stage (mismatched p/n drive,
           load asymmetry). The HTML report flags cells > ±5% off in orange
           and > ±10% off in red exactly so this stands out.

  Symptom: Rise/fall times reported but seem wrong (e.g. extremely short
           or longer than the period).
  Note:    The 10/90% crossing detection bails if the measured dt is
           negative or > period/2, returning None. If you see values that
           still look suspicious, check that v(out_pb) is a clean digital-
           shaped waveform — sinusoidal outputs will produce meaningless
           rise/fall numbers.

  Symptom: Sweep is taking many hours.
  Note:    Each run is 160 µs simulated time. 90 runs at a few minutes
           each adds up. To speed iteration use -c typ for a single point,
           or trim the Vin loop to one value while debugging.

  Symptom: i(V2) sign is wrong / power dissipation is negative.
  Cause:   Your supply current convention differs. The plot script flips
           sign internally (assumes ngspice reports current INTO V2's "+"
           node, and inverts so VDD draw is positive). If your supply
           polarity is reversed, edit the sign in load_dat / analyze
           sections.


================================================================================
10. EXTENDING / MODIFYING
================================================================================

  10.1 CHANGE SIMULATION TIME OR STEP

       In run_sweep.sh, the line:
         tran 200p 160u
       Increase the second number to give the VCO more time to settle.
       Increase the step (200p) cautiously — too coarse and you'll alias
       fast oscillations.

  10.2 CHANGE THE STEADY-STATE ANALYSIS WINDOW

       In plot_vco.py, analyze_signal() takes a last_fraction parameter
       defaulting to 0.3 (last 30% of the waveform). Change to 0.2 if
       startup is fast, or 0.5 if you need more cycles for averaging.

  10.3 ADD MORE SIGNALS TO THE .dat FILE

       Two places must stay in sync:
         a) The wrdata line in run_sweep.sh.
         b) load_dat() in plot_vco.py — both the column count check
            (currently expects 6) and the dict it returns.
       The order must match.

  10.4 ADD MORE Vin VALUES

       See Section 7.

  10.5 ADD ANOTHER SWEEP AXIS (e.g. load capacitance)

       a) Add a .param to the netlist, e.g. .param cload=10f.
       b) Use it in the testbench (Cload out 0 {cload}).
       c) In run_sweep.sh:
            - add to the `skip` set in the parameter-printing block at
              the top (so it isn't listed as a "fixed" parameter)
            - add a new outer for-loop (and update TOTAL counter)
            - extend TAG to include the new axis (e.g. _Cl${CLOAD})
            - add a sed line in the python heredoc to rewrite the param
       d) In plot_vco.py:
            - extend parse_tag() to extract the new axis from filenames
            - sort and group summary rows by it if desired
            - add a column to the summary tables

  10.6 ADD METRICS

       analyze_signal() can be extended (or wrapped) to return more
       quantities. The plotting code (make_plot) and the summary tables
       reference metric dict keys explicitly — search for 'freq_out',
       'i_avg_v2', etc. to see all the places a new metric needs to be
       added.
