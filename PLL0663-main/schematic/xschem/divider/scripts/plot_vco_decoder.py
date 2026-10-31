#!/usr/bin/env python3
# ==============================================================================
# VCO DECODER — Functional Check and HTML Report
# ==============================================================================
# run_vco_decoder_tb.sh drives VCO_decoder_tb.sch once per PVT point. Because
# c0,c1,c2,f0-f5 are binary-weighted PULSE sources (periods 3.125n * 2^bit),
# a single 801ns transient sweeps through all 512 (coarse,fine) codes, each
# held for a 1.5625ns "tick":
#
#     code(t) = floor(t / 1.5625ns) mod 512     (bit0=f0 ... bit8=c2)
#     coarse  = code >> 6     (0..7,  from c0,c1,c2)
#     fine    = code & 0x3F   (0..63, from f0..f5)
#
# For each code we sample the decoder's select outputs late in the tick
# (after the ~10ps PULSE edges have settled) and compare the asserted
# VCO/mode against a golden table taken directly from vco_dec_v2_codes.ods.
#
# GOLDEN TABLE NOTE (v2 codes, from vco_dec_v2_codes.ods): the spreadsheet lists
# fine = 0..63 (binary 000000..111111) for every coarse code (8 columns).
# Cells marked "X" in the spreadsheet (all of fine=63, and coarse=111 from
# fine=39 / 100111 upward) are DON'T-CARE: they are not sampled, not compared
# and not counted as pass/fail - whatever the decoder outputs there is ignored.
# Every other (coarse,fine) pair maps to exactly one of: Vco0, Vco2-5, Vco2-11,
# Vco3-5, Vco3-11, Vco4-5, Vco4-11, Vco5-11.
#
# Bit order assumption: the binary strings in the spreadsheet are read as plain
# numbers, i.e. coarse = c2c1c0 (c2 = MSB) and fine = f5..f0 (f5 = MSB), the
# same convention as the previous version of this script.
#
# KNOWN SCHEMATIC CAVEAT: VCO_decoder_tb.sch currently has TWO ports labeled
# "VCO2_11_sel" (one of them almost certainly should be "VCO5_11_sel"). Until
# that's fixed, this script marks all Vco5-11 codes UNTESTABLE rather than
# silently reporting a false pass/fail.
# ==============================================================================

import os
import re
import sys
import numpy as np
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# ──────────────────────────────────────────────────────────────────────────────
# CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────

BASE_HALF = 1.5625e-9   # f0's PULSE half-period = one "tick" = one code's dwell time
N_CODES = 512
SETTLE_FRACTION = 0.7   # ignore the first 70% of each tick (PULSE edges + decoder delay)
VOH_FRACTION = 0.5      # fraction of vdd above which an output counts as HIGH

# Golden table, from vco_dec_v2_codes.ods, coarse-major, fine=0..63 (64 entries
# per coarse code, 2 chars each, index = fine*2). Entry codes:
#   V0=Vco0  25=Vco2-5 2B=Vco2-11  35=Vco3-5 3B=Vco3-11  45=Vco4-5 4B=Vco4-11
#   5B=Vco5-11   --=X in the spreadsheet = DON'T CARE (excluded from all checks)
GOLDEN_TABLE = {
    0: "5B5B5B5B4545454545454545454545453B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B--",
    1: "4B4B4B4B454545453B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B35353535353535353535353535353535353535353535353535353535353535--",
    2: "5B4545453B3B3B3B3535353535353535353535353535353535353535353535352B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B--",
    3: "453B3B3B3B3B3B3B35353535353535352B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B--",
    4: "3B353535353535352B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B25252525252525252525252525252525252525252525252525252525252525--",
    5: "353535352B2B2B2B252525252525252525252525252525252525252525252525V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0--",
    6: "352B2B2B2B2B2B2B2525252525252525V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0--",
    7: "2B2B2B2B25252525V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0--------------------------------------------------",
}
assert all(len(v) == 128 for v in GOLDEN_TABLE.values())

DONT_CARE = 'X'   # sentinel returned by golden_label() for X cells

CODE_TO_LABEL = {
    'V0': 'Vco0', '25': 'Vco2-5', '2B': 'Vco2-11', '35': 'Vco3-5',
    '3B': 'Vco3-11', '45': 'Vco4-5', '4B': 'Vco4-11', '5B': 'Vco5-11',
    '--': DONT_CARE,
}

LABEL_TO_SIGNAL = {
    'Vco0': 'VCO_sel',
    'Vco2-5': 'VCO2_5_sel', 'Vco2-11': 'VCO2_11_sel',
    'Vco3-5': 'VCO3_5_sel', 'Vco3-11': 'VCO3_11_sel',
    'Vco4-5': 'VCO4_5_sel', 'Vco4-11': 'VCO4_11_sel',
    'Vco5-11': 'VCO5_11_sel',
}
SELECT_SIGNALS = list(LABEL_TO_SIGNAL.values())
SIGNAL_TO_LABEL = {v: k for k, v in LABEL_TO_SIGNAL.items()}


def golden_label(coarse, fine):
    """Expected VCO label ('Vco2-5', ...) or DONT_CARE ('X') for a given code."""
    return CODE_TO_LABEL[GOLDEN_TABLE[coarse][fine * 2:fine * 2 + 2]]


# ──────────────────────────────────────────────────────────────────────────────

def load_dat(dat_path, siglist_path):
    """Load an ngspice wrdata file. Returns (time, {signal_name: voltage_array}) or (None, None)."""
    if not os.path.exists(dat_path) or not os.path.exists(siglist_path):
        return None, None
    with open(siglist_path) as f:
        sig_names = f.read().split()

    try:
        with open(dat_path) as f:
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
        # wrdata repeats time before every signal's value column: t v0 t v1 t v2 ...
        value_cols = [1 + 2 * i for i in range(len(sig_names))]
        value_cols = [c for c in value_cols if c < data.shape[1]]
        signals = {name: data[:, col] for name, col in zip(sig_names, value_cols)}
        return time, signals
    except Exception as e:
        print(f"  WARN: could not load {dat_path}: {e}", file=sys.stderr)
        return None, None


def analyze_pvt(time, signals, vdd):
    """
    For every one of the 512 codes, sample the select outputs near the end
    of that code's 1.5625ns tick and figure out which one (if any) is
    asserted. Returns a dict: (coarse,fine) -> result dict.
    """
    results = {}
    has_vco5 = 'VCO5_11_sel' in signals

    for code in range(N_CODES):
        t_lo = code * BASE_HALF
        t_hi = (code + 1) * BASE_HALF
        t_sample = t_lo + SETTLE_FRACTION * (t_hi - t_lo)
        mask = (time >= t_sample) & (time < t_hi)
        if not np.any(mask):
            # window too fine for the chosen TSTEP right at the very end of
            # the sim; fall back to nearest sample
            idx = np.argmin(np.abs(time - (t_lo + t_hi) / 2))
            mask = np.zeros_like(time, dtype=bool)
            mask[idx] = True

        coarse = code >> 6
        fine = code & 0x3F
        expected = golden_label(coarse, fine)

        if expected == DONT_CARE:
            # "X" in the spreadsheet: completely ignored - no sampling, no check
            results[(coarse, fine)] = dict(expected=expected, actual=None, status='dontcare')
            continue

        high_signals = []
        for sig in SELECT_SIGNALS:
            if sig not in signals:
                continue
            v = np.mean(signals[sig][mask])
            if v > VOH_FRACTION * vdd:
                high_signals.append(sig)

        untestable = (expected == 'Vco5-11' or any(
            SIGNAL_TO_LABEL.get(s) == 'Vco5-11' for s in high_signals
        )) and not has_vco5

        if untestable:
            status = 'untestable'
            actual = None
        elif len(high_signals) == 0:
            actual = None
            status = 'fail'   # nothing asserted, but a VCO was expected
        elif len(high_signals) == 1:
            actual = SIGNAL_TO_LABEL.get(high_signals[0], high_signals[0])
            status = 'pass' if actual == expected else 'fail'
        else:
            actual = '+'.join(SIGNAL_TO_LABEL.get(s, s) for s in high_signals)
            status = 'multi'  # more than one select asserted at once - always a bug

        results[(coarse, fine)] = dict(expected=expected, actual=actual, status=status)

    return results


# ──────────────────────────────────────────────────────────────────────────────
# HTML REPORT
# ──────────────────────────────────────────────────────────────────────────────

STATUS_STYLE = {
    'pass':       ('#1b7a1b', '#eaf7ea'),   # green text, light green bg
    'fail':       ('#b30000', '#fbe6e6'),   # red text, light red bg
    'multi':      ('#b30000', '#ffd9d9'),   # red, stronger — multiple drivers
    'untestable': ('#8a6d00', '#fff6d9'),   # amber
    'dontcare':   ('#888888', '#e4e4e4'),   # X in spreadsheet: ignored, neutral grey
}

CSS = """
body { font-family: 'Segoe UI', Arial, sans-serif; margin: 20px; background:#f5f5f5; color:#333; }
.header { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color:white; padding:20px; border-radius:8px; margin-bottom:20px; }
.header h1 { margin:0; font-size:1.6em; }
.header p { margin:4px 0; opacity:.9; }
.summary { display:flex; gap:16px; margin-bottom:20px; flex-wrap:wrap; }
.summary .card { background:white; border-radius:8px; padding:12px 18px; box-shadow:0 2px 4px rgba(0,0,0,.1); min-width:140px; }
.summary .card .n { font-size:1.6em; font-weight:bold; }
.pvt-block { background:white; border-radius:8px; padding:16px; margin-bottom:24px; box-shadow:0 2px 4px rgba(0,0,0,.1); }
.pvt-block h2 { margin-top:0; font-size:1.15em; }
table.vco { border-collapse:collapse; font-size:11px; }
table.vco th, table.vco td { border:1px solid #ccc; padding:3px 6px; text-align:center; white-space:nowrap; }
table.vco th { background:#333; color:white; }
table.vco td.rowhdr { background:#7a0032; color:white; font-weight:bold; }
caption { caption-side:top; text-align:left; font-weight:bold; margin-bottom:6px; }
.legend span { display:inline-block; padding:2px 8px; border-radius:4px; margin-right:8px; font-size:12px; }
.notes { background:white; border-radius:8px; padding:16px; box-shadow:0 2px 4px rgba(0,0,0,.1); }
.notes code { background:#eee; padding:1px 4px; border-radius:3px; }
"""

COARSE_HEADERS = [(f'{c:03b}', f'*{2**c}') for c in range(8)]


def cell_html(res):
    if res is None:
        return '<td>?</td>'
    expected, actual, status = res['expected'], res['actual'], res['status']
    color, bg = STATUS_STYLE[status]
    if status == 'dontcare':
        return f'<td style="color:{color};background:{bg}" title="X in spreadsheet - not checked">X</td>'
    text = actual if actual else 'NONE'
    title = f"expected={expected} actual={actual or 'none'}"
    return f'<td style="color:{color};background:{bg}" title="{title}">{text}</td>'


def render_pvt_table(tag, results):
    rows = ['<table class="vco">',
            f'<caption>{tag}</caption>',
            '<tr><th>fine \\ coarse</th>' +
            ''.join(f'<th>{b}<br>{m}</th>' for b, m in COARSE_HEADERS) + '</tr>']
    for fine in range(0, 64):
        cells = []
        for coarse in range(8):
            cells.append(cell_html(results.get((coarse, fine))))
        rows.append(f'<tr><td class="rowhdr">{fine:06b} ({fine})</td>' + ''.join(cells) + '</tr>')
    rows.append('</table>')
    return '\n'.join(rows)


def generate_html_report(results_by_pvt, output_path):
    total_pass = total_fail = total_multi = total_untestable = total_dc = 0
    for results in results_by_pvt.values():
        for r in results.values():
            if r['status'] == 'pass':
                total_pass += 1
            elif r['status'] == 'fail':
                total_fail += 1
            elif r['status'] == 'multi':
                total_multi += 1
            elif r['status'] == 'untestable':
                total_untestable += 1
            elif r['status'] == 'dontcare':
                total_dc += 1

    html = ['<!DOCTYPE html><html><head><meta charset="UTF-8">',
            '<title>VCO Decoder Functional Report</title>',
            f'<style>{CSS}</style></head><body>']

    html.append(f"""
    <div class="header">
      <h1>VCO Decoder — Functional Check Report</h1>
      <p>Generated {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
      <p>{len(results_by_pvt)} PVT point(s), 512 codes each (all fine/coarse combinations)</p>
    </div>
    <div class="summary">
      <div class="card"><div class="n" style="color:#1b7a1b">{total_pass}</div>PASS</div>
      <div class="card"><div class="n" style="color:#b30000">{total_fail}</div>FAIL</div>
      <div class="card"><div class="n" style="color:#b30000">{total_multi}</div>MULTI-DRIVE</div>
      <div class="card"><div class="n" style="color:#8a6d00">{total_untestable}</div>UNTESTABLE (Vco5-11)</div>
      <div class="card"><div class="n" style="color:#888888">{total_dc}</div>X / NOT CHECKED</div>
    </div>
    """)

    for tag, results in sorted(results_by_pvt.items()):
        n_pass = sum(1 for r in results.values() if r['status'] == 'pass')
        n_fail = sum(1 for r in results.values() if r['status'] == 'fail')
        n_multi = sum(1 for r in results.values() if r['status'] == 'multi')
        n_unt = sum(1 for r in results.values() if r['status'] == 'untestable')
        n_dc = sum(1 for r in results.values() if r['status'] == 'dontcare')
        html.append('<div class="pvt-block">')
        html.append(f'<h2>{tag} — {n_pass} pass / {n_fail} fail / {n_multi} multi-drive / {n_unt} untestable / {n_dc} X (not checked)</h2>')
        html.append(render_pvt_table(tag, results))
        html.append('</div>')

    html.append("""
    <div class="notes">
      <p><strong>How this report was built:</strong></p>
      <ul>
        <li>c0,c1,c2,f0-f5 are binary-weighted PULSE sources, so one 801ns transient
            sweeps <code>code(t) = floor(t / 1.5625ns) mod 512</code> through all
            512 (coarse,fine) combinations. Each output is sampled in the last
            30% of its 1.5625ns window, after PULSE edges and decoder
            propagation delay have settled.</li>
        <li><strong>Golden table</strong> comes directly from <code>vco_dec_v2_codes.ods</code>
            (not re-derived), row/column headers match the fine/coarse binary
            codes 1:1.</li>
        <li><strong>PASS</strong> (green): exactly the expected select line is
            asserted. <strong>FAIL</strong> (red): wrong select line asserted,
            or none asserted when one was expected. <strong>MULTI-DRIVE</strong>:
            more than one select line asserted simultaneously — always a bug.
            <strong>UNTESTABLE</strong> (amber): Vco5-11 codes, blocked by the
            duplicate <code>VCO2_11_sel</code> net name in
            <code>VCO_decoder_tb.sch</code> (see header comments in both
            scripts) — fix the schematic port label to
            <code>VCO5_11_sel</code> and re-run to get real coverage here.</li>
        <li><strong>X (grey)</strong>: cells marked "X" in the spreadsheet
            (all of fine=63, and coarse=111 from fine=39 upward) are
            don't-care. They are not sampled or compared and are excluded
            from the PASS/FAIL/MULTI-DRIVE counts.</li>
      </ul>
    </div>
    </body></html>
    """)

    with open(output_path, 'w') as f:
        f.write('\n'.join(html))


# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    script_dir = Path(__file__).resolve().parent
    decoder_dir = script_dir.parent
    data_dir = decoder_dir / 'results' / 'data'
    report_path = decoder_dir / 'results' / 'vcodec_report.html'

    if not data_dir.exists():
        print(f"Error: data directory not found: {data_dir}")
        sys.exit(1)

    dat_files = sorted(data_dir.glob('vcodec_*.dat'))
    if not dat_files:
        print(f"Error: no .dat files found in {data_dir}")
        sys.exit(1)

    results_by_pvt = {}

    for dat_path in dat_files:
        m = re.match(r'vcodec_(.*?)_T(.*?)_Vp([\d.]+)\.dat', dat_path.name)
        if not m:
            print(f"WARN: skipping {dat_path.name} (doesn't match pattern)")
            continue
        corner, temp, vp = m.groups()
        tag = f"{corner}_T{temp}_Vp{vp}"

        print(f"Analyzing {dat_path.name}...", end=' ', flush=True)
        siglist_path = str(dat_path) + '.siglist'
        time, signals = load_dat(str(dat_path), siglist_path)
        if time is None:
            print("SKIP (could not load)")
            continue

        results_by_pvt[tag] = analyze_pvt(time, signals, float(vp))
        n_fail = sum(1 for r in results_by_pvt[tag].values() if r['status'] in ('fail', 'multi'))
        print(f"OK ({n_fail} issues)")

    if not results_by_pvt:
        print("Error: no valid results to report")
        sys.exit(1)

    print(f"\nGenerating report: {report_path}")
    generate_html_report(results_by_pvt, str(report_path))
    print("Report generated.")
    print(f"  Open: {report_path}")


if __name__ == '__main__':
    main()
