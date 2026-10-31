#!/usr/bin/env python3
# ==============================================================================
# PROGRAMMABLE DIVIDER (pdiv) — Chunked Analysis and HTML Report
# ==============================================================================
# Loads per-N .dat files (pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat),
# merges measurements for each PVT condition, and generates a single-page
# HTML report with one detailed panel per PVT point showing all 64 N values.
# ==============================================================================

import os
import sys
import re
import numpy as np
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# ──────────────────────────────────────────────────────────────────────────────
# CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────

DUTY_TARGET   = 50.0    # Target duty cycle (%)
DUTY_TOL      = 5.0     # Tolerance around target (%)
DIV_REL_TOL   = 0.10    # Divider ratio tolerance (10%)
LAST_FRACTION = 0.5     # Use last N% of each chunk for analysis
VSWING_MIN    = 0.40    # Minimum swing fraction of VDD to count as switching

# Signals saved by wrdata — must match run_sweep_pdiv.sh
SIGNAL_ORDER = ['clk', 'out', 'out_div', 'div2', 'div4', 'div8', 'div16', 'div32', 'div64']

# Expected division ratios for the intermediate tap outputs.
# These are fixed by circuit topology (ripple counter taps), not by N.
EXPECTED_RATIOS_FIXED = {
    'clk':    1,
    'div2':   2,
    'div4':   4,
    'div8':   8,
    'div16':  16,
    'div32':  32,
    'div64':  64,
}

# ──────────────────────────────────────────────────────────────────────────────

def load_dat(dat_path):
    """Load ngspice wrdata .dat file. Returns (time_array, signals_2d) or (None, None)."""
    if not os.path.exists(dat_path):
        return None, None
    try:
        with open(dat_path, 'r') as f:
            lines = f.readlines()
        data_start = 0
        for i, line in enumerate(lines):
            stripped = line.strip()
            if not stripped:
                continue
            if stripped.startswith(('Title', 'Date', '#')):
                continue
            try:
                float(stripped.split()[0])
                data_start = i
                break
            except (ValueError, IndexError):
                continue
        data = np.loadtxt(dat_path, skiprows=data_start)
        if data.ndim < 2 or data.size == 0:
            return None, None
        return data[:, 0], data[:, 1:]
    except Exception as e:
        print(f"  WARN: could not load {dat_path}: {e}", file=sys.stderr)
        return None, None


def analyze_signal(time, voltage, vdd, ref_freq=None):
    """
    Compute frequency, duty cycle, ratio vs ref_freq, and swing for one signal.
    Returns dict with keys: frequency, duty_cycle, measured_ratio, swing, status.
    """
    result = dict(frequency=None, duty_cycle=None,
                  measured_ratio=None, swing=0.0, status='ok')

    v_min, v_max = np.min(voltage), np.max(voltage)
    swing = v_max - v_min
    result['swing'] = swing

    if swing < VSWING_MIN * vdd:
        result['status'] = 'stuck'
        return result

    threshold = (v_max + v_min) / 2.0
    crossings = []
    for i in range(len(voltage) - 1):
        v1, v2 = voltage[i], voltage[i + 1]
        t1, t2 = time[i], time[i + 1]
        if v1 < threshold <= v2:
            t_x = t1 + (t2 - t1) * (threshold - v1) / (v2 - v1)
            crossings.append(('rise', t_x))
        elif v1 >= threshold > v2:
            t_x = t1 + (t2 - t1) * (threshold - v1) / (v2 - v1)
            crossings.append(('fall', t_x))

    if len(crossings) < 3:
        result['status'] = 'stuck'
        return result

    t_start = time[0] + LAST_FRACTION * (time[-1] - time[0])
    crossings = [(e, t) for e, t in crossings if t >= t_start]

    if len(crossings) < 2:
        result['status'] = 'stuck'
        return result

    rising = [t for e, t in crossings if e == 'rise']
    if len(rising) >= 2:
        periods = np.diff(rising)
        period = np.mean(periods)
        result['frequency'] = 1.0 / period if period > 0 else None

    if len(crossings) >= 4:
        duties, i = [], 0
        while i + 2 < len(crossings):
            e1, t1 = crossings[i]
            e2, t2 = crossings[i + 1]
            e3, t3 = crossings[i + 2]
            if e1 == 'rise' and e2 == 'fall' and e3 == 'rise':
                period = t3 - t1
                if period > 0:
                    duties.append(100.0 * (t2 - t1) / period)
                i += 2
            else:
                i += 1
        if duties:
            result['duty_cycle'] = float(np.mean(duties))

    if ref_freq and result['frequency'] and result['frequency'] > 0:
        result['measured_ratio'] = ref_freq / result['frequency']

    return result


def check_pass_fail(analysis, expected_ratio=None):
    """Returns (passed: bool, reason: str)."""
    if analysis['status'] == 'stuck':
        return False, 'stuck'
    if analysis.get('frequency') is None:
        return False, 'no_signal'
    duty = analysis.get('duty_cycle')
    if duty is not None and abs(duty - DUTY_TARGET) > DUTY_TOL:
        return False, 'bad_duty'
    if expected_ratio is not None and analysis.get('measured_ratio') is not None:
        if abs(analysis['measured_ratio'] - expected_ratio) / expected_ratio > DIV_REL_TOL:
            return False, 'bad_ratio'
    return True, 'pass'


def duty_class(duty):
    if duty is None:
        return ''
    dev = abs(duty - DUTY_TARGET)
    if dev <= DUTY_TOL:
        return 'duty-ok'
    if dev <= DUTY_TOL + 5:
        return 'duty-warn'
    return 'duty-fail'


# ──────────────────────────────────────────────────────────────────────────────
# HTML GENERATION
# ──────────────────────────────────────────────────────────────────────────────

CSS = """
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; font-size: 13px;
       background: #f5f5f5; color: #222; }
.header { background: #333; color: #fff; padding: 16px 20px; margin-bottom: 18px; }
.header h1 { font-size: 1.4em; font-weight: bold; }
.header .ts { font-size: 0.85em; opacity: .75; margin-top: 4px; }
.wrap { padding: 0 20px 30px; }
h2 { font-size: 1.1em; margin: 18px 0 8px; color: #333; border-bottom: 2px solid #4CAF50;
     padding-bottom: 4px; }

/* Summary table */
.summary-table { width: 100%; border-collapse: collapse; background: #fff;
                 margin-bottom: 24px; box-shadow: 0 1px 3px rgba(0,0,0,.1); }
.summary-table th { background: #4CAF50; color: #fff; padding: 9px 10px;
                    text-align: left; font-size: 0.9em; }
.summary-table td { padding: 7px 10px; border-bottom: 1px solid #e0e0e0; }
.summary-table tr:hover td { background: #f0f7f0; }

/* PVT accordion panels */
.pvt-panel { background: #fff; border: 1px solid #ddd; border-radius: 4px;
             margin-bottom: 14px; box-shadow: 0 1px 3px rgba(0,0,0,.07); }
.pvt-title { font-size: 1em; font-weight: bold; color: #fff;
             background: #388E3C; padding: 9px 14px; border-radius: 4px 4px 0 0;
             cursor: pointer; user-select: none; display: flex;
             justify-content: space-between; align-items: center; }
.pvt-title .arrow { transition: transform .2s; }
.pvt-title.collapsed .arrow { transform: rotate(-90deg); }
.pvt-body { overflow-x: auto; }
.pvt-body.hidden { display: none; }

/* Per-N detail table */
.data-table { width: 100%; border-collapse: collapse; font-size: 0.88em; }
.data-table th { background: #e8e8e8; padding: 7px 8px; text-align: left;
                 border: 1px solid #bbb; white-space: nowrap; }
.data-table td { padding: 5px 8px; border: 1px solid #ddd; white-space: nowrap; }
.data-table tr:nth-child(even) td { background: #f9f9f9; }
.data-table tr:hover td { background: #e8f5e9; }

/* Column groups */
.col-n   { background: #f3f3f3 !important; font-weight: bold; width: 48px; }
.col-bits{ background: #f3f3f3 !important; font-family: monospace; }

/* Status cells */
.pass { background: #c8e6c9 !important; font-weight: bold; color: #1b5e20; }
.fail { background: #ffcdd2 !important; font-weight: bold; color: #b71c1c; }
.warn { background: #fff9c4 !important; color: #795548; }
.duty-ok   { background: #e8f5e9; }
.duty-warn { background: #fff9c4; }
.duty-fail { background: #ffebee; }

/* Summary badge in panel header */
.badge { font-size: 0.78em; font-weight: normal; padding: 2px 8px;
         border-radius: 10px; margin-left: 8px; }
.badge-pass { background: #a5d6a7; color: #1b5e20; }
.badge-fail { background: #ef9a9a; color: #b71c1c; }

/* Sticky column headers when table is wide */
.data-table thead th { position: sticky; top: 0; z-index: 1; }

.note { font-size: 0.82em; color: #666; margin-top: 16px; }
"""

JS = """
function toggle(id) {
    var body  = document.getElementById('body-'  + id);
    var title = document.getElementById('title-' + id);
    body.classList.toggle('hidden');
    title.classList.toggle('collapsed');
}
"""

def fmt(val, decimals=3):
    if val is None:
        return '<span style="color:#999">N/A</span>'
    return f"{val:.{decimals}f}"

def fmt_mhz(hz):
    if hz is None:
        return '<span style="color:#999">N/A</span>'
    return f"{hz / 1e6:.3f}"

def generate_html(pvt_results, output_path):
    """
    pvt_results: dict keyed by (corner, temp, vp) →
                   dict keyed by N (int 0..63) →
                     dict keyed by signal_name → analysis_dict
    """
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    lines = [f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Programmable Divider — PVT Report</title>
<style>{CSS}</style>
</head>
<body>
<div class="header">
  <h1>Programmable Divider (pdiv) — PVT Analysis Report</h1>
  <div class="ts">Generated: {ts} &nbsp;|&nbsp; Simulation split into per-N chunks (≤4 µs each)</div>
</div>
<div class="wrap">
"""]

    # ── Summary table ──────────────────────────────────────────────────────────
    lines.append('<h2>Summary by Corner</h2>')
    lines.append("""<table class="summary-table">
<thead><tr>
  <th>Corner / T / VDD</th>
  <th>f_clk (MHz)</th>
  <th>CLK Duty (%)</th>
  <th>N values simulated</th>
  <th>Passed</th>
  <th>Failed</th>
  <th>Overall</th>
</tr></thead><tbody>""")

    for (corner, temp, vp) in sorted(pvt_results):
        n_data = pvt_results[(corner, temp, vp)]
        tag = f"{corner}_T{temp}_Vp{vp}"

        # Clock reference from N=1 (N=0 means pass-through, clk always valid)
        clk_a = None
        for n in sorted(n_data):
            a = n_data[n].get('clk', {})
            if a.get('frequency'):
                clk_a = a
                break

        clk_freq = clk_a.get('frequency') if clk_a else None
        clk_duty = clk_a.get('duty_cycle') if clk_a else None

        n_total   = len(n_data)
        n_passed  = 0
        n_failed  = 0
        for n, sig_dict in n_data.items():
            out_a = sig_dict.get('out', {})
            # Expected ratio for 'out' at this N: N+1 (divider counts 0..N then resets)
            exp = n + 1
            ok, _ = check_pass_fail(out_a, expected_ratio=exp)
            if ok:
                n_passed += 1
            else:
                n_failed += 1

        overall_class = 'pass' if n_failed == 0 else 'fail'
        overall_text  = '✓ PASS' if n_failed == 0 else f'✗ FAIL ({n_failed}/{n_total})'

        lines.append(f"""<tr>
  <td><a href="#{tag}" style="color:#1a6b1a">{tag}</a></td>
  <td>{fmt_mhz(clk_freq)}</td>
  <td>{fmt(clk_duty, 1)}</td>
  <td>{n_total}</td>
  <td>{n_passed}</td>
  <td>{n_failed}</td>
  <td class="{overall_class}">{overall_text}</td>
</tr>""")

    lines.append('</tbody></table>')

    # ── Per-PVT detail panels ──────────────────────────────────────────────────
    lines.append('<h2>Detailed Results by Corner</h2>')

    for panel_idx, (corner, temp, vp) in enumerate(sorted(pvt_results)):
        n_data = pvt_results[(corner, temp, vp)]
        tag = f"{corner}_T{temp}_Vp{vp}"

        # Count pass/fail for badge
        n_pass = 0; n_fail = 0
        for n, sd in n_data.items():
            ok, _ = check_pass_fail(sd.get('out', {}), expected_ratio=n + 1)
            if ok: n_pass += 1
            else:  n_fail += 1

        badge_cls  = 'badge-pass' if n_fail == 0 else 'badge-fail'
        badge_text = f'✓ {n_pass}/{n_pass+n_fail}' if n_fail == 0 \
                     else f'✗ {n_fail} failed'

        lines.append(f"""
<div class="pvt-panel" id="{tag}">
  <div class="pvt-title" id="title-{panel_idx}" onclick="toggle({panel_idx})">
    <span>{tag}<span class="badge {badge_cls}">{badge_text}</span></span>
    <span class="arrow">▾</span>
  </div>
  <div class="pvt-body" id="body-{panel_idx}">
    <table class="data-table">
    <thead><tr>
      <th class="col-n">N</th>
      <th class="col-bits">d5–d0</th>
      <th>Expected ratio</th>
      <th>f_out (MHz)</th>
      <th>out Duty (%)</th>
      <th>Meas. ratio (out)</th>
      <th>f_out_div (MHz)</th>
      <th>out_div Duty (%)</th>
      <th>f_div2</th><th>f_div4</th><th>f_div8</th>
      <th>f_div16</th><th>f_div32</th><th>f_div64</th>
      <th>out swing (V)</th>
      <th>Status (out)</th>
    </tr></thead>
    <tbody>""")

        # Get reference clock frequency from any valid N
        ref_clk = None
        for n in sorted(n_data):
            f = n_data[n].get('clk', {}).get('frequency')
            if f:
                ref_clk = f
                break

        for n in sorted(n_data):
            sig = n_data[n]
            bits = f"{(n>>5)&1}{(n>>4)&1}{(n>>3)&1}{(n>>2)&1}{(n>>1)&1}{n&1}"
            exp_ratio = n + 1   # divider counts 0..N then resets → period = (N+1) clk cycles

            out_a     = sig.get('out',     {})
            out_div_a = sig.get('out_div', {})

            passed, reason = check_pass_fail(out_a, expected_ratio=exp_ratio)
            row_stat_cls  = 'pass' if passed else 'fail'
            row_stat_text = '✓ Pass' if passed else f'✗ {reason}'

            # Intermediate tap frequencies
            def tap_freq_cell(sname):
                f = sig.get(sname, {}).get('frequency')
                return fmt_mhz(f)

            lines.append(f"""<tr>
  <td class="col-n">{n}</td>
  <td class="col-bits">{bits}</td>
  <td>{exp_ratio}</td>
  <td>{fmt_mhz(out_a.get('frequency'))}</td>
  <td class="{duty_class(out_a.get('duty_cycle'))}">{fmt(out_a.get('duty_cycle'),1)}</td>
  <td>{fmt(out_a.get('measured_ratio'),3)}</td>
  <td>{fmt_mhz(out_div_a.get('frequency'))}</td>
  <td class="{duty_class(out_div_a.get('duty_cycle'))}">{fmt(out_div_a.get('duty_cycle'),1)}</td>
  <td>{tap_freq_cell('div2')}</td>
  <td>{tap_freq_cell('div4')}</td>
  <td>{tap_freq_cell('div8')}</td>
  <td>{tap_freq_cell('div16')}</td>
  <td>{tap_freq_cell('div32')}</td>
  <td>{tap_freq_cell('div64')}</td>
  <td>{fmt(out_a.get('swing'),3)}</td>
  <td class="{row_stat_cls}">{row_stat_text}</td>
</tr>""")

        lines.append('</tbody></table></div></div>')

    # ── Footer ─────────────────────────────────────────────────────────────────
    lines.append(f"""
<p class="note">
  <b>Pass criteria:</b>
  (1) Duty cycle within {DUTY_TARGET:.0f}% ± {DUTY_TOL:.0f}% &nbsp;
  (2) Measured ratio within {int(DIV_REL_TOL*100)}% of expected (N+1) &nbsp;
  (3) Signal swing ≥ {int(VSWING_MIN*100)}% of VDD<br>
  <b>Expected ratio:</b> N+1 — the counter resets after counting N+1 input cycles.<br>
  <b>Signals:</b>
  out = main programmable output;
  out_div = /2 of out (should be ~50% duty);
  div2–div64 = ripple counter tap frequencies (topology-fixed, shown for monitoring).
</p>
</div>
<script>{JS}</script>
</body></html>""")

    with open(output_path, 'w') as f:
        f.write('\n'.join(lines))


# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    project_dir = Path.cwd().parent.parent
    data_dir    = project_dir / 'divider' / 'results' / 'data'
    spice_path  = project_dir / 'divider' / 'simulations' / 'pdiv_sym_tb.spice'
    report_path = project_dir / 'divider' / 'results' / 'pdiv_report.html'

    if not data_dir.exists():
        print(f"Error: data directory not found: {data_dir}")
        sys.exit(1)

    # Discover .dat files — new naming: pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat
    dat_files = sorted(data_dir.glob('pdiv_*_N[0-9][0-9].dat'))

    # Also accept old-style files without _N suffix (single-run legacy)
    legacy_files = [f for f in sorted(data_dir.glob('pdiv_*.dat'))
                    if not re.search(r'_N\d{2}\.dat$', f.name)]
    if not dat_files and not legacy_files:
        print(f"Error: no .dat files found in {data_dir}")
        sys.exit(1)

    # Parse VDD from netlist (fallback)
    vdd_default = 1.2
    try:
        with open(spice_path) as f:
            for line in f:
                m = re.match(r'\.param\s+vdd\s*=\s*([\d.]+)', line, re.I)
                if m:
                    vdd_default = float(m.group(1))
                    break
    except Exception:
        pass

    # pvt_results[(corner, temp, vp)][N][signal_name] = analysis_dict
    pvt_results = defaultdict(lambda: defaultdict(dict))

    def process_file(dat_path, corner, temp, vp, n):
        print(f"  Analyzing N={n:2d}  {dat_path.name} ...", end=' ', flush=True)
        time, signals = load_dat(str(dat_path))
        if time is None or signals is None:
            print("SKIP")
            return

        vdd = float(vp) if vp else vdd_default
        clk_freq = None
        sig_results = {}

        for col_idx, sig_name in enumerate(SIGNAL_ORDER):
            if col_idx >= signals.shape[1]:
                break
            voltage = signals[:, col_idx]
            ref = clk_freq if sig_name != 'clk' else None
            a = analyze_signal(time, voltage, vdd, ref_freq=ref)
            if sig_name == 'clk' and a.get('frequency'):
                clk_freq = a['frequency']
            sig_results[sig_name] = a

        pvt_results[(corner, temp, vp)][n] = sig_results
        print("OK")

    # ── Process chunked N files ────────────────────────────────────────────────
    if dat_files:
        # Group by PVT condition
        pvt_groups = defaultdict(list)
        for f in dat_files:
            m = re.match(r'pdiv_(.*?)_T(.*?)_Vp(.*?)_N(\d{2})\.dat', f.name)
            if m:
                corner, temp, vp, nn = m.groups()
                pvt_groups[(corner, temp, vp)].append((int(nn), f))

        for (corner, temp, vp), n_files in sorted(pvt_groups.items()):
            print(f"\nPVT: {corner} T={temp} Vp={vp}  ({len(n_files)} N chunks)")
            for n, dat_path in sorted(n_files):
                process_file(dat_path, corner, temp, vp, n)

    # ── Process legacy single-run files (no _N suffix) ─────────────────────────
    for dat_path in legacy_files:
        m = re.match(r'pdiv_(.*?)_T(.*?)_Vp(.*?)\.dat', dat_path.name)
        if not m:
            continue
        corner, temp, vp = m.groups()
        print(f"\nLegacy file: {dat_path.name}")
        # Treat as N=0 placeholder so it still renders
        process_file(dat_path, corner, temp, vp, n=0)

    if not pvt_results:
        print("Error: no valid results to report")
        sys.exit(1)

    print(f"\nGenerating report → {report_path}")
    generate_html(pvt_results, str(report_path))
    print("Done!")


if __name__ == '__main__':
    main()
