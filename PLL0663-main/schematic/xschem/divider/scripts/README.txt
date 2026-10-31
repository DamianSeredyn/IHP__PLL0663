================================================================================
INPUT REGISTER SWEEP — USAGE GUIDE
================================================================================

This guide explains how to run the input register testbench across process,
voltage, and temperature corners, and how to verify that the 13-stage shift
register correctly captures a serial bit pattern.

The flow consists of three files:

  divider/scripts/run_sweep_input_register.sh   sweep driver (bash)
  divider/scripts/plot_input_register.py        plot + report generator (python)
  divider/simulations/input_register_no_sym_tb.spice   testbench netlist

You run the .sh script. It patches the netlist for each PVT combination, calls
ngspice, then calls the .py script to decode V3, compare against measured
flip-flop states, and produce a per-combination PNG plus a single HTML report.


================================================================================
1. WHAT THE FLOW DOES
================================================================================

For every (corner, temperature, VDD) combination:

  1. Rewrite the testbench in place to set:
       - .param temp     to the swept temperature
       - .param vdd      to the swept supply voltage
       - .lib            to the swept corner name
       - .options TEMP   to the swept temperature
       - .control block  is stripped and replaced with a tran + wrdata block
  2. Run ngspice -b in batch mode.
  3. Save 16 signals to a .dat file:
       v(d), v(clk_buf), v(data_en), v(d0)..v(d12)

After all sweeps finish, plot_input_register.py:

  1. Parses the V3 PWL from the netlist and decodes it into the expected bit
     sequence (every 10 ns = 1 bit, threshold = vdd/2).
  2. Finds the falling edge of V4 (data_en). The sampling window is placed
     8 ns after data_en falls and is 10 ns wide.
  3. For each .dat file, averages v(d0)..v(d12) over the sampling window,
     thresholds at vdd/2 to get measured bits.
  4. Compares each measured bit to the expected one. Mapping is:
       first bit shifted in  ->  d12
       last bit shifted in   ->  d0
  5. Generates a PNG per combination plus an HTML report with tabs.


================================================================================
2. REQUIRED DIRECTORY LAYOUT
================================================================================

The scripts expect this structure relative to the project root:

  <PROJECT_DIR>/
    configs/
      corner_data                 (sourced by the sweep script)
    divider/
      scripts/
        run_sweep_input_register.sh
        plot_input_register.py
      simulations/
        input_register_no_sym_tb.spice
      results/                    (auto-created, holds .png and .html)
        data/                     (auto-created, holds .dat files)

PROJECT_DIR is resolved as two directories above the .sh file. So if the .sh
sits at /foss/designs/CHIP-PLL/divider/scripts/, PROJECT_DIR is
/foss/designs/CHIP-PLL/.


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


================================================================================
4. NETLIST REQUIREMENTS
================================================================================

The testbench netlist (input_register_no_sym_tb.spice) must contain:

  4.1  PARAMETERS USED FOR SWEEPING

       .param temp=27          (or any default value)
       .param vdd=1.2          (or any default value)

       Both must exist as text lines that match
       "^\.param\s+(temp|vdd)\s*=.*". The sweep script rewrites these lines
       per iteration. If they are missing, the sweep silently leaves them
       at their netlist defaults.

       Recommended placement: at the TOP of the netlist, before any
       element that references {vdd} or {temp}. ngspice resolves brace
       expansions during parse, so a forward reference will error out
       with "Undefined parameter [vdd]".

  4.2  CORNER LINE

       .lib cornerMOSlv.lib mos_tt

       The sweep script rewrites the second argument (the corner name)
       on every iteration. The .lib filename stays the same.

  4.3  SUPPLY AND SIGNALS

       V1 VP 0 {vdd}

       Using {vdd} ties the supply to the swept value. If you hardcode
       a number here (V1 VP 0 1.2) the VDD sweep has no electrical effect.

       Optional but recommended: also use {vdd} as the high level in V3
       and V4 PWL strings, so input swings track the supply.

  4.4  V3 — SERIAL DATA INPUT

       V3 d 0 PWL( 0 0 142.5n 0 142.51n {vdd} 162.5n {vdd} ... )

       Encoding rule (must hold for the decoder to work):
         - Each bit lasts exactly BIT_PERIOD_NS = 10 ns.
         - High level represents 1, low level represents 0.
         - The first rising edge marks the start of bit 0.
         - Edges should be sharp (e.g. 10 ps between low and high points)
           so the sampling at mid-bit is unambiguous.

  4.5  V4 — DATA_EN ENABLE

       V4 data_en 0 PWL( 0 {vdd} 272.6n {vdd} 272.61n 0)

       The decoder uses the falling edge of V4 to know when serial data
       has finished. Bits decoded = number of 10 ns slots between V3's
       first rising edge and V4's falling edge. This is what makes a
       sequence ending in zeros decode correctly.

       If V4 is missing or has no falling edge, the script falls back
       to a static 280-290 ns sampling window and strips trailing zeros
       from the decoded sequence (legacy behaviour, generally wrong if
       your data legitimately ends in zeros).


================================================================================
5. HOW TO ADJUST THE BIT SEQUENCE
================================================================================

To test a different 13-bit pattern, edit V3 in the netlist. No script
changes are needed — the expected sequence is parsed from V3 on every run.

Step by step:

  1. Decide on the bit pattern, e.g. 1010 0110 1100 1.
  2. Decide when bit 0 starts. The default is 142.51 ns. Any time is fine
     as long as V4 falls at first_rising_edge + 13 * 10 ns + a small margin.
  3. Build the PWL alternating low / high segments:
       - Each 10 ns window holds one bit.
       - Transitions use a 10 ps ramp (the "0.01n" offsets).
       - Consecutive identical bits are one long segment, not two.
     For 1010 0110 1100 1 starting at 142.5 ns:
       142.5n 0       (idle low)
       142.51n {vdd}  142.51..152.5  bit0=1
       152.5n {vdd}   152.51n 0      bit1=0 (10ns low)
       162.5n 0       162.51n {vdd}  bit2=1
       172.5n {vdd}   172.51n 0      bit3=0
       ...etc...
  4. Move V4's falling edge so it lands AFTER the last bit window ends
     plus ~100 ps. For 13 bits starting at 142.51 ns, last window ends at
     272.51 ns, so V4 falling at 272.6 ns is correct.
  5. Run the sweep. The terminal output will print the decoded sequence:
       "Sekwencja V3 (bit0 = pierwszy wsuniety): 1010 0110 1100 1"
     This is what the comparison uses. If this line is wrong, your PWL
     is wrong — fix the PWL, not the script.


================================================================================
6. RUNNING THE SWEEP
================================================================================

From any working directory:

  cd <PROJECT_DIR>/divider/scripts
  ./run_sweep_input_register.sh [options]

  6.1  NO ARGUMENTS — FULL PVT SWEEP

       ./run_sweep_input_register.sh

       Sweeps every corner in corner_data x {t_min, t_nom, t_max} x
       {vp_min, vp_nom, vp_max}. For 5 corners that's 5*3*3 = 45 runs.

  6.2  -c PRESET — SHORTHAND COMBOS

       ./run_sweep_input_register.sh -c typ
       ./run_sweep_input_register.sh -c hot
       ./run_sweep_input_register.sh -c cold

       typ   = mos_tt at (t_nom, vp_nom)
       hot   = mos_ss at (t_max, vp_min)   worst-case slow
       cold  = mos_ff at (t_min, vp_max)   worst-case fast

       Each preset narrows BOTH the corner list AND the temp/vdd range,
       producing a single simulation per preset.

  6.3  -c WITH CORNER NAMES — SUBSET OF CORNERS, FULL TEMP/VDD

       ./run_sweep_input_register.sh -c tt
       ./run_sweep_input_register.sh -c tt ss
       ./run_sweep_input_register.sh -c mos_tt

       Filters corners by substring match. -c tt matches any corner whose
       name contains "tt". Each matching corner still sweeps the full
       3x3 temperature x voltage grid.

  6.4  MIXING PRESETS AND CORNERS

       ./run_sweep_input_register.sh -c typ hot

       Combines: typ adds mos_tt with narrowed PVT, hot adds mos_ss with
       its own narrowed PVT. Note that presets DO narrow PVT, so combining
       with raw corners can give surprising results — prefer one or the
       other.


================================================================================
7. WHAT YOU GET IN results/
================================================================================

After a successful run:

  divider/results/
    input_register_report.html
    input_register_<corner>_T<temp>_Vp<vdd>.png    (one per combination)
    data/
      input_register_<corner>_T<temp>_Vp<vdd>.dat  (one per combination)

Open input_register_report.html in a browser. Tabs across the top:

  Podsumowanie    summary table with one row per combination, showing:
                  TEMP, VDD, "bity zgodne" (matched bits), status (PASS/FAIL),
                  expected sequence, measured sequence.
  Per-combo tabs  click any "mos_xx T<temp> <vdd>V" to see the detailed PNG
                  and a bit-by-bit table.

Each PNG contains six panels:

  1. Input signals: v(d), v(clk_buf), v(data_en) over the full 300 ns sim.
  2. Stacked d0..d12 outputs with the sampling window shaded.
  3. Per-bit comparison table (bit index, target flip-flop, expected, measured,
     v_avg, PASS/FAIL).
  4. Sequence summary (expected vs measured bits, pass count, overall verdict).
  5. Conditions (corner, temperature, VDD, bit period, sampling window,
     threshold, mapping).
  6. Empty (reserved for future metrics).


================================================================================
8. TROUBLESHOOTING
================================================================================

  Symptom: "Brak plikow .dat w <DATA_DIR>"
           Sweep claimed 100% done but produced no data files.
  Cause:   ngspice failed silently (sweep redirects its output to /dev/null).
  Fix:     Re-run the LAST iteration manually to see the real error:
             ngspice -b /tmp/input_register_run.spice
           Common errors:
             "Undefined parameter [vdd]"  -> move .param vdd= above V1 in the
                                             netlist.
             "Cannot find subckt ..."     -> .lib rewrite produced a bad
                                             corner name; check that
                                             corner_data lists corners with
                                             the full prefix expected by
                                             cornerMOSlv.lib.

  Symptom: "V4/data_en nie znalezione — fallback do statycznego okna."
  Cause:   V4 line missing or its PWL can't be parsed.
  Fix:     Check that V4 exists in the netlist and that any {vdd} references
           in its PWL match a defined .param.

  Symptom: Decoded sequence is shorter than expected (e.g. 12 bits instead
           of 13) when your pattern ends in 0.
  Cause:   V4 falling edge is too early — it lands inside the last bit
           window, so that bit is excluded.
  Fix:     Move V4's falling edge to at least 100 ps after the last bit
           window ends. For 13 bits starting at 142.51 ns, V4 should fall
           no earlier than 272.6 ns.

  Symptom: All flip-flops show 0 V or all show VDD regardless of expected
           pattern.
  Cause:   Likely a netlist issue (V1 not parametrized, clk_in malformed,
           reset still asserted). The sweep itself is fine — open one .dat
           file in a viewer and verify the waveforms manually.

  Symptom: Bit 0 maps to d0 in your expectations, but report says bit 0
           maps to d12.
  Note:    This is correct shift-register behaviour. The first bit shifted
           in propagates through all stages and ends up at the FAR end (d12).
           The last bit shifted in stays at the input side (d0).


================================================================================
9. EXTENDING / MODIFYING
================================================================================

  9.1  CHANGE SAMPLING WINDOW PLACEMENT

       Edit the top of plot_input_register.py:
         SAMPLE_MARGIN_NS = 8.0    gap between data_en fall and window start
         SAMPLE_WIDTH_NS  = 10.0   window width
       The window is computed as [fall + MARGIN, fall + MARGIN + WIDTH].

  9.2  CHANGE BIT PERIOD

       If you change clk_in's period, update BIT_PERIOD_NS in
       plot_input_register.py to match. The decoder uses this to slice
       V3 into bit windows.

  9.3  CHANGE THE FALLBACK WINDOW (when V4 is missing)

       SAMPLE_FALLBACK_START_NS and SAMPLE_FALLBACK_END_NS in the .py.

  9.4  ADD MORE SIGNALS TO THE .dat FILE

       Two places must stay in sync:
         a) The wrdata line in run_sweep_input_register.sh.
         b) The SIGNALS list at the top of plot_input_register.py.
       The order must match. The script will refuse to load a .dat whose
       column count doesn't match SIGNALS.

  9.5  CHANGE SIMULATION TIME

       In run_sweep_input_register.sh, the line:
         tran 50p 300n
       Increase 300n if you extend V3/V4 timing.
