#!/usr/bin/env python3
# ==============================================================================
# VCO DECODER (DC sweep) — Functional Check and HTML Report
# ==============================================================================
# Companion to run_vco_decoder_dc_sweep.sh. Unlike plot_vco_decoder.py (which
# had to reconstruct code(t) from a single PULSE-driven transient and sample
# each 1.5625ns window), here every code already has its own small .dat file
# with c0,c1,c2,f0-f5 hardwired as DC sources — so there's nothing to decode
# from time, and no settle-fraction/window guessing. We just read the last
# row of each file as the settled value.
#
# Golden table, label<->signal mapping and HTML report are unchanged from
# plot_vco_decoder.py (same GOLDEN_TABLE, same visual layout) so the two
# reports stay directly comparable.
# ==============================================================================

import os
import re
import sys
import numpy as np
from pathlib import Path
from datetime import datetime

# ──────────────────────────────────────────────────────────────────────────────
# CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────

N_CODES = 512
VOH_FRACTION = 0.5   # fraction of vdd above which an output counts as HIGH

# Golden table, from vco_dec.ods, coarse-major, fine=1..62 (fine=0/63 always
# illegal and are not stored). Each entry is a 2-char code:
#   V0=Vco0  25=Vco2-5 2B=Vco2-11  35=Vco3-5 3B=Vco3-11  45=Vco4-5 4B=Vco4-11
#   5B=Vco5-11   --=illegal (no VCO covers this code)
GOLDEN_TABLE = {
    0: "5B5B5B4B4B4B4B45454545454545453B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B",
    1: "5B5B45454545453B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B35353535353535353535353535353535353535353535353535353535353535",
    2: "5B45453B3B3B3B3535353535353535353535353535353535353535353535352B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B",
    3: "45453B3B3B3B3B35353535353535352B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B",
    4: "3B3B3B353535352B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B25252525252525252525252525252525252525252525252525252525252525",
    5: "3535352B2B2B2B252525252525252525252525252525252525252525252525V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0",
    6: "35352B2B2B2B2B2525252525252525V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0",
    7: "2B2B2B25252525V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0V0------------------------------------------------",
}

CODE_TO_LABEL = {
    'V0': 'Vco0', '25': 'Vco2-5', '2B': 'Vco2-11', '35': 'Vco3-5',
    '3B': 'Vco3-11', '45': 'Vco4-5', '4B': 'Vco4-11', '5B': 'Vco5-11',
    '--': None,
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

# fixed signal order written by run_vco_decoder_dc_sweep.sh's wrdata line
SIGNAL_ORDER = ['c0', 'c1', 'c2', 'f0', 'f1', 'f2', 'f3', 'f4', 'f5',
                 'VCO_sel', 'VCO2_5_sel', 'VCO2_11_sel',
                 'VCO3_5_sel', 'VCO3_11_sel', 'VCO4_5_sel', 'VCO4_11_sel', 'VCO5_11_sel']


def golden_label(coarse, fine):
    """Expected VCO label ('Vco2-5', ...) or None (illegal) for a given code."""
    if fine == 0 or fine == 63:
        return None
    return CODE_TO_LABEL[GOLDEN_TABLE[coarse][(fine - 1) * 2:(fine - 1) * 2 + 2]]


# ──────────────────────────────────────────────────────────────────────────────

def load_settled_values(dat_path):
    """
    Load one per-code .dat file (wrdata output for a short tran on DC-only
    sources) and return the LAST row's value for each signal in
    SIGNAL_ORDER. Returns None on any read failure.
    """
    if not os.path.exists(dat_path):
        return None
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
        if data.ndim == 1:
            data = data.reshape(1, -1)
        if data.size == 0:
            return None
        last_row = data[-1]
        # wrdata repeats time before every signal's value column: t v0 t v1 ...
        value_cols = [1 + 2 * i for i in range(len(SIGNAL_ORDER))]
        value_cols = [c for c in value_cols if c < len(last_row)]
        return {name: last_row[col] for name, col in zip(SIGNAL_ORDER, value_cols)}
    except Exception as e:
        print(f"  WARN: could not load {dat_path}: {e}", file=sys.stderr)
        return None


def analyze_pvt(data_dir, sim_name, tag, vdd):
    """
    For every one of the 512 codes, read its settled .dat file and figure out
    which select output (if any) is asserted. Returns dict:
    (coarse,fine) -> result dict.
    """
    results = {}

    for code in range(N_CODES):
        nnn = f"{code:03d}"
        dat_path = data_dir / f"{sim_name}_{tag}_code{nnn}.dat"
        values = load_settled_values(str(dat_path))

        coarse = code >> 6
        fine = code & 0x3F
        expected = golden_label(coarse, fine)

        if values is None:
            results[(coarse, fine)] = dict(expected=expected, actual=None, status='missing')
            continue

        high_signals = [sig for sig in SELECT_SIGNALS if values.get(sig, 0.0) > VOH_FRACTION * vdd]

        if len(high_signals) == 0:
            actual = None
            status = 'pass' if expected is None else 'fail'
        elif len(high_signals) == 1:
            actual = SIGNAL_TO_LABEL.get(high_signals[0], high_signals[0])
            status = 'pass' if actual == expected else 'fail'
        else:
            actual = '+'.join(SIGNAL_TO_LABEL.get(s, s) for s in high_signals)
            status = 'multi'

        results[(coarse, fine)] = dict(expected=expected, actual=actual, status=status)

    return results


# ──────────────────────────────────────────────────────────────────────────────
# HTML REPORT (same visual layout as plot_vco_decoder.py)
# ──────────────────────────────────────────────────────────────────────────────

STATUS_STYLE = {
    'pass':       ('#1b7a1b', '#eaf7ea'),
    'fail':       ('#b30000', '#fbe6e6'),
    'multi':      ('#b30000', '#ffd9d9'),
    'missing':    ('#8a6d00', '#fff6d9'),
    'illegal-ok': ('#555555', '#1a1a1a'),
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
.notes { background:white; border-radius:8px; padding:16px; box-shadow:0 2px 4px rgba(0,0,0,.1); }
.notes code { background:#eee; padding:1px 4px; border-radius:3px; }
"""

COARSE_HEADERS = [(f'{c:03b}', f'*{2**c}') for c in range(8)]


def cell_html(res):
    if res is None:
        return '<td>?</td>'
    expected, actual, status = res['expected'], res['actual'], res['status']
    if expected is None and actual is None and status == 'pass':
        color, bg = STATUS_STYLE['illegal-ok']
        text = '—'
    else:
        color, bg = STATUS_STYLE.get(status, STATUS_STYLE['fail'])
        text = actual if actual else ('NONE' if expected else '—')
    title = f"expected={expected or 'illegal'} actual={actual or 'none'} status={status}"
    return f'<td style="color:{color};background:{bg}" title="{title}">{text}</td>'


def render_pvt_table(tag, results):
    rows = ['<table class="vco">',
            f'<caption>{tag}</caption>',
            '<tr><th>fine \\ coarse</th>' +
            ''.join(f'<th>{b}<br>{m}</th>' for b, m in COARSE_HEADERS) + '</tr>']
    for fine in range(0, 64):
        cells = []
        for coarse in range(8):
            if fine == 0 or fine == 63:
                cells.append('<td style="color:#555;background:#1a1a1a">illegal</td>')
            else:
                cells.append(cell_html(results.get((coarse, fine))))
        rows.append(f'<tr><td class="rowhdr">{fine:06b} ({fine})</td>' + ''.join(cells) + '</tr>')
    rows.append('</table>')
    return '\n'.join(rows)


def generate_html_report(results_by_pvt, output_path):
    total_pass = total_fail = total_multi = total_missing = 0
    for results in results_by_pvt.values():
        for r in results.values():
            if r['status'] == 'pass':
                total_pass += 1
            elif r['status'] == 'fail':
                total_fail += 1
            elif r['status'] == 'multi':
                total_multi += 1
            elif r['status'] == 'missing':
                total_missing += 1

    html = ['<!DOCTYPE html><html><head><meta charset="UTF-8">',
            '<title>VCO Decoder Functional Report (DC sweep)</title>',
            f'<style>{CSS}</style></head><body>']

    html.append(f"""
    <div class="header">
      <h1>VCO Decoder — Functional Check Report (DC sweep, one sim per code)</h1>
      <p>Generated {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
      <p>{len(results_by_pvt)} PVT point(s), 512 codes each, one ngspice run per code</p>
    </div>
    <div class="summary">
      <div class="card"><div class="n" style="color:#1b7a1b">{total_pass}</div>PASS</div>
      <div class="card"><div class="n" style="color:#b30000">{total_fail}</div>FAIL</div>
      <div class="card"><div class="n" style="color:#b30000">{total_multi}</div>MULTI-DRIVE</div>
      <div class="card"><div class="n" style="color:#8a6d00">{total_missing}</div>MISSING (sim failed)</div>
    </div>
    """)

    for tag, results in sorted(results_by_pvt.items()):
        n_pass = sum(1 for r in results.values() if r['status'] == 'pass')
        n_fail = sum(1 for r in results.values() if r['status'] == 'fail')
        n_multi = sum(1 for r in results.values() if r['status'] == 'multi')
        n_miss = sum(1 for r in results.values() if r['status'] == 'missing')
        html.append('<div class="pvt-block">')
        html.append(f'<h2>{tag} — {n_pass} pass / {n_fail} fail / {n_multi} multi-drive / {n_miss} missing</h2>')
        html.append(render_pvt_table(tag, results))
        html.append('</div>')

    html.append("""
    <div class="notes">
      <p><strong>How this report was built:</strong></p>
      <ul>
        <li>Each of the 512 codes was simulated in its own ngspice run, with
            c0,c1,c2,f0-f5 hardwired as plain DC sources (no PULSE, no time
            windows) — see <code>run_vco_decoder_dc_sweep.sh</code>. The last
            row of each code's <code>.dat</code> file is taken as the
            settled value.</li>
        <li><strong>Golden table</strong> comes directly from <code>vco_dec.ods</code>.</li>
        <li><strong>PASS</strong> (green): exactly the expected select line is
            asserted, or the code is legitimately illegal and nothing is
            asserted. <strong>FAIL</strong> (red): wrong select line asserted,
            or none asserted when one was expected. <strong>MULTI-DRIVE</strong>:
            more than one select line asserted at once — always a bug.
            <strong>MISSING</strong> (amber): that code's ngspice run failed
            or produced no data — check <code>/tmp/vcodec_dc_&lt;tag&gt;_code&lt;NNN&gt;.log</code>.</li>
        <li>fine=0 and fine=63 are illegal for every coarse code; coarse=111
            additionally goes illegal from fine=39 upward.</li>
        <li>This report does NOT exercise code-to-code transitions/glitches —
            see <code>plot_vco_decoder.py</code> (the PULSE-based testbench)
            for that coverage.</li>
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
    report_path = decoder_dir / 'results' / 'vcodec_dc_report.html'
    sim_name = 'vcodec_dc'

    if not data_dir.exists():
        print(f"Error: data directory not found: {data_dir}")
        sys.exit(1)

    dat_files = sorted(data_dir.glob(f'{sim_name}_*_code*.dat'))
    if not dat_files:
        print(f"Error: no {sim_name}_*_code*.dat files found in {data_dir}")
        sys.exit(1)

    # discover PVT tags from filenames: vcodec_dc_<tag>_code<NNN>.dat
    tags = set()
    pat = re.compile(rf'{re.escape(sim_name)}_(.+)_code\d{{3}}\.dat')
    for p in dat_files:
        m = pat.match(p.name)
        if m:
            tags.add(m.group(1))

    results_by_pvt = {}
    for tag in sorted(tags):
        m = re.search(r'Vp([\d.]+)$', tag)
        vp = float(m.group(1)) if m else 1.2
        print(f"Analyzing {tag} (512 codes)...", end=' ', flush=True)
        results_by_pvt[tag] = analyze_pvt(data_dir, sim_name, tag, vp)
        n_fail = sum(1 for r in results_by_pvt[tag].values() if r['status'] in ('fail', 'multi'))
        n_miss = sum(1 for r in results_by_pvt[tag].values() if r['status'] == 'missing')
        print(f"OK ({n_fail} issues, {n_miss} missing)")

    if not results_by_pvt:
        print("Error: no valid results to report")
        sys.exit(1)

    print(f"\nGenerating report: {report_path}")
    generate_html_report(results_by_pvt, str(report_path))
    print("Report generated.")
    print(f"  Open: {report_path}")


if __name__ == '__main__':
    main()
