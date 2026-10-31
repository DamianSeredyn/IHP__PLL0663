#!/usr/bin/env python3
# ==============================================================================
# PROGRAMMABLE DIVIDER (pdiv) — Chunked Analysis and HTML Report
# ==============================================================================
# Loads per-N .dat files (pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat),
# analyzes measurements from out_div (not out, which has narrow pulses),
# merges all N values (0-63) into a single PVT condition report,
# and generates an HTML report showing results for each N value.
#
# Key: out_div is the /2 version of the programmable divider output,
# giving ~50% duty cycle and better measurability.
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
DIV_REL_TOL   = 0.10    # Divider ratio tolerance (±10%)
LAST_FRACTION = 0.5     # Use last 50% of each chunk for analysis (let settle)
VSWING_MIN    = 0.40    # Minimum swing fraction of VDD to count as switching

# Signals saved by wrdata in run_sweep_pdiv.sh
# NOTE: Now measures from out_div instead of out
SIGNAL_ORDER = ['clk', 'out_div', 'div2', 'div4', 'div8', 'div16', 'div32', 'div64']

# Expected division ratios for fixed-tap outputs (not affected by N)
EXPECTED_RATIOS_FIXED = {
    'clk':    1,      # Reference
    'div2':   2,      # Fixed taps from counter
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
            if not stripped or stripped.startswith(('Title', 'Date', '#')):
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
        time = data[:, 0]
        signals = data[:, [1,3,5,7,9,11,13,15]]
        return time, signals
    except Exception as e:
        print(f"  WARN: could not load {dat_path}: {e}", file=sys.stderr)
        return None, None


def analyze_signal(time, voltage, vdd, ref_freq=None):
    """
    Compute frequency, duty cycle, ratio vs ref_freq, and swing.
    Returns dict with keys: frequency, duty_cycle, measured_ratio, swing, status.
    """
    result = dict(frequency=None, duty_cycle=None,
                  measured_ratio=None, swing=0.0, status='ok')

    v_min, v_max = np.min(voltage), np.max(voltage)
    swing = v_max - v_min
    result['swing'] = swing

    # Check if signal is switching
    if swing < VSWING_MIN * vdd:
        result['status'] = 'stuck'
        return result

    # Find zero crossings at 50% amplitude
    threshold = (v_max + v_min) / 2.0
    crossings = []
    for i in range(len(voltage) - 1):
        v1, v2 = voltage[i], voltage[i + 1]
        t1, t2 = time[i], time[i + 1]
        if v1 < threshold <= v2:  # Rising edge
            t_x = t1 + (t2 - t1) * (threshold - v1) / (v2 - v1)
            crossings.append(('rise', t_x))
        elif v1 >= threshold > v2:  # Falling edge
            t_x = t1 + (t2 - t1) * (threshold - v1) / (v2 - v1)
            crossings.append(('fall', t_x))

    if len(crossings) < 3:
        result['status'] = 'stuck'
        return result

    # Use last LAST_FRACTION of simulation window
    t_start = time[0] + LAST_FRACTION * (time[-1] - time[0])
    crossings = [(e, t) for e, t in crossings if t >= t_start]

    if len(crossings) < 2:
        result['status'] = 'stuck'
        return result

    # Compute frequency from rising edges
    rising = [t for e, t in crossings if e == 'rise']
    if len(rising) >= 2:
        periods = np.diff(rising)
        period = np.mean(periods)
        if period > 0:
            result['frequency'] = 1.0 / period

    # Compute duty cycle
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

    # Compute measured ratio vs reference frequency
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
        return False, f'bad_duty ({duty:.1f}%)'
    
    if expected_ratio is not None and analysis.get('measured_ratio') is not None:
        ratio_err = abs(analysis['measured_ratio'] - expected_ratio) / expected_ratio
        if ratio_err > DIV_REL_TOL:
            return False, f'bad_ratio ({analysis["measured_ratio"]:.2f})'
    
    return True, 'pass'


def generate_html_report(results_by_pvt, output_path):
    """Generate HTML report from results aggregated by PVT condition."""
    
    html = """<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Programmable Divider (pdiv) PVT Analysis Report</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
            color: #333;
        }
        .header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 1.8em;
        }
        .header p {
            margin: 5px 0;
            opacity: 0.9;
        }
        .summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .summary-table th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }
        .summary-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        .summary-table tr:hover {
            background-color: #f9f9f9;
        }
        .pvt-panel {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .pvt-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #1e3c72;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ddd;
        }
        .n-table {
            width: 100%;
            border-collapse: collapse;
            margin: 10px 0;
            background-color: #fafafa;
        }
        .n-table th {
            background-color: #e8e8e8;
            padding: 10px;
            text-align: left;
            font-weight: bold;
            border: 1px solid #ccc;
        }
        .n-table td {
            padding: 8px;
            border: 1px solid #ddd;
        }
        .n-table tr:hover {
            background-color: #f0f0f0;
        }
        .pass {
            background-color: #c8e6c9;
            color: #1b5e20;
            font-weight: bold;
        }
        .fail {
            background-color: #ffcdd2;
            color: #b71c1c;
            font-weight: bold;
        }
        .signal-stuck {
            background-color: #ffe0b2;
            color: #e65100;
            font-weight: bold;
        }
        .duty-ok {
            background-color: #c8e6c9;
        }
        .duty-warn {
            background-color: #fff9c4;
        }
        .duty-fail {
            background-color: #ffcdd2;
        }
        .notes {
            background-color: #e3f2fd;
            border-left: 4px solid #1976d2;
            padding: 15px;
            margin-top: 30px;
            border-radius: 4px;
        }
        .notes ul {
            margin: 10px 0;
            padding-left: 20px;
        }
        .notes li {
            margin: 8px 0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Programmable Divider (pdiv) — PVT Analysis Report</h1>
        <p><strong>Generated:</strong> """ + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + """</p>
        <p><strong>Simulation:</strong> 63 short runs per PVT (N=1..63, dynamic duration per N)</p>
        <p><strong>Measurement Output:</strong> out_div (divide-by-2 output, ~50% duty cycle)</p>
    </div>

    <h2>Summary</h2>
    <table class="summary-table">
        <tr>
            <th>PVT Condition</th>
            <th>f_clk (MHz)</th>
            <th>clk Duty (%)</th>
            <th>Tested N Values</th>
            <th>Passed</th>
            <th>Failed</th>
            <th>Overall Status</th>
        </tr>
"""
    
    for pvt_tag in sorted(results_by_pvt.keys()):
        pvt_data = results_by_pvt[pvt_tag]
        
        clk_data = pvt_data.get('clk', {})
        clk_freq = clk_data.get('frequency')
        clk_duty = clk_data.get('duty_cycle')
        
        freq_str = f"{clk_freq:.3f}" if clk_freq else "N/A"
        duty_str = f"{clk_duty:.1f}" if clk_duty else "N/A"
        
        n_passed = sum(1 for k, v in pvt_data.items() 
                       if k.startswith('out_div_N') and check_pass_fail(v, 2*(int(k.split('N')[1])+1))[0])
        n_failed = sum(1 for k, v in pvt_data.items() 
                       if k.startswith('out_div_N') and not check_pass_fail(v, 2*(int(k.split('N')[1])+1))[0])
        
        overall = "✓ PASS" if n_failed == 0 else f"✗ FAIL ({n_failed} issues)"
        status_class = 'pass' if n_failed == 0 else 'fail'
        
        n_values = sum(1 for k in pvt_data.keys() if k.startswith('out_div_N'))
        
        html += f"""        <tr>
            <td><strong>{pvt_tag}</strong></td>
            <td>{freq_str}</td>
            <td>{duty_str}</td>
            <td>{n_values}</td>
            <td>{n_passed}</td>
            <td>{n_failed}</td>
            <td class="{status_class}">{overall}</td>
        </tr>
"""
    
    html += """    </table>
"""
    
    # Detailed panels per PVT
    html += """    <h2>Detailed Results per Corner</h2>
"""
    
    for pvt_tag in sorted(results_by_pvt.keys()):
        pvt_data = results_by_pvt[pvt_tag]
        
        html += f"""    <div class="pvt-panel">
        <div class="pvt-title">{pvt_tag}</div>
        
        <p><strong>Reference Clock (clk):</strong></p>
        <table class="n-table">
            <tr>
                <th>Signal</th>
                <th>Frequency (MHz)</th>
                <th>Duty Cycle (%)</th>
                <th>Swing (V)</th>
                <th>Status</th>
            </tr>
"""
        
        clk_data = pvt_data.get('clk', {})
        clk_freq = clk_data.get('frequency')
        clk_duty = clk_data.get('duty_cycle')
        clk_swing = clk_data.get('swing', 0)
        clk_status = clk_data.get('status', 'unknown')
        
        freq_str = f"{clk_freq:.3f}" if clk_freq else "N/A"
        duty_str = f"{clk_duty:.1f}" if clk_duty else "N/A"
        
        html += f"""            <tr>
                <td><strong>clk</strong></td>
                <td>{freq_str}</td>
                <td>{duty_str}</td>
                <td>{clk_swing:.3f}</td>
                <td>Reference</td>
            </tr>
        </table>
        
        <p style="margin-top: 15px;"><strong>Programmable Divider Output (out_div) — All N Values (0-63):</strong></p>
        <table class="n-table">
            <tr>
                <th>N</th>
                <th>Expected Ratio</th>
                <th>f_out_div (MHz)</th>
                <th>Meas. Ratio</th>
                <th>Duty (%)</th>
                <th>Swing (V)</th>
                <th>Status</th>
            </tr>
"""
        
        # Iterate N=0..63 (includes bypass mode N=0)
        for n_val in range(0, 64):
            n_key = f'out_div_N{n_val:02d}'
            n_data = pvt_data.get(n_key, {})
            
            # Expected: out_div = clk / (2*(N+1))
            expected_ratio = 2 * (n_val + 1)
            
            freq = n_data.get('frequency')
            duty = n_data.get('duty_cycle')
            meas_ratio = n_data.get('measured_ratio')
            swing = n_data.get('swing', 0)
            status = n_data.get('status', 'unknown')
            
            freq_str = f"{freq:.3f}" if freq else "N/A"
            duty_str = f"{duty:.1f}" if duty else "N/A"
            ratio_str = f"{meas_ratio:.2f}" if meas_ratio else "N/A"
            
            # Determine row class
            if status == 'stuck':
                row_class = 'signal-stuck'
                status_text = '✗ Stuck'
            elif freq is None:
                row_class = 'fail'
                status_text = '✗ No signal'
            else:
                passed, reason = check_pass_fail(n_data, expected_ratio)
                row_class = 'pass' if passed else 'fail'
                status_text = '✓ PASS' if passed else f'✗ {reason}'
            
            # Duty cycle highlight
            duty_class = ''
            if duty is not None:
                duty_dev = abs(duty - 50.0)
                if duty_dev <= 5.0:
                    duty_class = 'duty-ok'
                elif duty_dev <= 10.0:
                    duty_class = 'duty-warn'
                else:
                    duty_class = 'duty-fail'
            
            html += f"""            <tr>
                <td><strong>{n_val}</strong></td>
                <td>{expected_ratio}</td>
                <td>{freq_str}</td>
                <td>{ratio_str}</td>
                <td class="{duty_class}">{duty_str}</td>
                <td>{swing:.3f}</td>
                <td class="{row_class}">{status_text}</td>
            </tr>
"""
        
        html += """        </table>
    </div>
"""
    
    # Notes section
    html += """    <div class="notes">
        <p><strong>Analysis Notes:</strong></p>
        <ul>
            <li><code>out_div</code> is the divide-by-2 output of the programmable divider, 
                providing ~50% duty cycle and better measurability compared to <code>out</code> 
                (which has narrow pulses).</li>
            <li><strong>Expected Ratio:</strong> out_div = f_clk / (2 × (N+1)), 
                where N is the programming value (0-63). For bypass mode (N=0): ratio = 2.</li>
            <li><strong>Pass Criteria:</strong> (1) Duty cycle within 50% ± 5%, 
                (2) Measured ratio within ±10% of expected.</li>
            <li><strong>Stuck:</strong> Signal swing &lt; 40% of VDD (not switching).</li>
            <li>Results use last 50% of each simulation window (after settling).</li>
            <li>Measurements from fixed-tap outputs (div2-div64) are shown for 
                circuit validation but are architecture-dependent.</li>
            <li><strong>Bypass Mode (N=0):</strong> All data bits are zero; output frequency = f_clk / 2.
                Validates the divider path with no counter logic engaged.</li>
            <li><strong>Optimization:</strong> Each simulation runs for exactly 10 periods of its slowest output, 
                reducing total runtime significantly. Includes 64 division codes per corner (0-63).</li>
        </ul>
    </div>

</body>
</html>
"""
    
    with open(output_path, 'w') as f:
        f.write(html)


# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    # Resolve paths from this file's own location, not the caller's cwd.
    # Layout: CHIP-PLL/schematics/divider/scripts/<this file>
    #   script_dir  -> .../divider/scripts
    #   divider_dir -> .../divider            (1 level up)
    script_dir = Path(__file__).resolve().parent
    divider_dir = script_dir.parent
    data_dir = divider_dir / 'results' / 'data'
    report_path = divider_dir / 'results' / 'pdiv_report.html'
    
    if not data_dir.exists():
        print(f"Error: data directory not found: {data_dir}")
        sys.exit(1)
    
    # Find all .dat files
    dat_files = sorted(data_dir.glob('pdiv_*.dat'))
    if not dat_files:
        print(f"Error: no .dat files found in {data_dir}")
        sys.exit(1)
    
    # Organize results by PVT condition
    results_by_pvt = defaultdict(dict)
    
    for dat_path in dat_files:
        # Parse filename: pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat
        match = re.match(r'pdiv_(.*?)_T(.*?)_Vp([\d.]+)_N(\d+)\.dat', dat_path.name)
        if not match:
            print(f"WARN: skipping {dat_path.name} (doesn't match pattern)")
            continue
        
        corner, temp, vp, n_str = match.groups()
        n_val = int(n_str)
        pvt_tag = f"{corner}_T{temp}_Vp{vp}"
        
        print(f"Analyzing {dat_path.name}...", end=' ', flush=True)
        
        time, signals = load_dat(str(dat_path))
        if time is None or signals is None:
            print("SKIP (could not load)")
            continue
        
        vdd = float(vp)
        
        # Analyze each signal
        # Signals in wrdata: clk, out_div, div2, div4, div8, div16, div32, div64
        expected_signals = ['clk', 'out_div', 'div2', 'div4', 'div8', 'div16', 'div32', 'div64']
        
        clk_freq = None
        
        for col_idx, signal_name in enumerate(expected_signals):
            if col_idx >= signals.shape[1]:
                break
            
            voltage = signals[:, col_idx]
            
            # Reference frequency from clock
            if signal_name == 'clk':
                analysis = analyze_signal(time, voltage, vdd, ref_freq=None)
                clk_freq = analysis['frequency']
                results_by_pvt[pvt_tag]['clk'] = analysis
            else:
                # For out_div, store with N suffix
                if signal_name == 'out_div':
                    analysis = analyze_signal(time, voltage, vdd, ref_freq=clk_freq)
                    results_by_pvt[pvt_tag][f'out_div_N{n_val:02d}'] = analysis
                else:
                    # Fixed taps (div2, etc.) — could aggregate but for now just store first N
                    # (they are same for all N values since they're fixed taps)
                    if signal_name not in results_by_pvt[pvt_tag]:
                        analysis = analyze_signal(time, voltage, vdd, ref_freq=clk_freq)
                        results_by_pvt[pvt_tag][signal_name] = analysis
        
        print("OK")
    
    if not results_by_pvt:
        print("Error: no valid results to report")
        sys.exit(1)
    
    # Generate report
    print(f"\nGenerating report: {report_path}")
    generate_html_report(results_by_pvt, str(report_path))
    print("✓ Report generated successfully!")
    print(f"  Open: {report_path}")

if __name__ == '__main__':
    main()
