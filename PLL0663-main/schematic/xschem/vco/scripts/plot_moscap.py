import sys
import os
import glob
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results_moscap/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results_moscap')
os.makedirs(RESULTS_DIR, exist_ok=True)

USE_DEBUG = '--debug' in sys.argv[1:]

def dbg(*a):
    if USE_DEBUG:
        sys.stderr.write('[DEBUG] ' + ' '.join(str(x) for x in a) + '\n')

# ── meta: W, L, m, f ──────────────────────────────────────────────────────────
def load_meta():
    try:
        with open(os.path.join(DATA_DIR, 'meta.txt')) as f:
            w, l, m, fr = f.read().split()
        num = lambda s: None if s == 'None' else float(s)
        fr_s = fr.lower().replace('meg', 'e6').replace('k', 'e3')
        return num(w), num(l), num(m), float(fr_s)
    except Exception as e:
        print(f"  [WARN] meta.txt: {e}")
        return None, None, 1.0, 1e6

W, L, M, FREQ = load_meta()
dbg(f'W={W} L={L} m={M} f={FREQ}')

# ── .cvdat: vg  re(i(vg))  im(i(vg));  C = -Im(i)/(2*pi*f), G = -Re(i) ───────
def load_cv(path):
    try:
        d = np.atleast_2d(np.loadtxt(path))
        if d.shape[1] < 3:
            print(f"  [WARN] {path}: oczekiwano 3 kolumn, jest {d.shape}")
            return None
        d = d[np.argsort(d[:, 0])]
        return {'vg': d[:, 0],
                'c': -d[:, 2] / (2.0 * np.pi * FREQ),   # F
                'g': -d[:, 1]}                          # S
    except Exception as e:
        print(f"  [WARN] Nie mozna odczytac {path}: {e}")
        return None

def cv_metrics(d):
    vg, c = d['vg'], d['c']
    i_max, i_min = int(np.argmax(c)), int(np.argmin(c))
    dcdv = np.gradient(c, vg)
    i_sl = int(np.argmax(np.abs(dcdv)))
    area = (W * L * (M or 1.0)) if (W and L) else None
    return {
        'c_max': float(c[i_max]), 'v_cmax': float(vg[i_max]),
        'c_min': float(c[i_min]), 'v_cmin': float(vg[i_min]),
        'ratio': float(c[i_max] / c[i_min]) if c[i_min] > 0 else None,
        'slope_max': float(dcdv[i_sl]), 'v_slope': float(vg[i_sl]),   # F/V
        'cox': float(c[i_max] / area) if area else None,              # F/m^2
    }

def fmt(v, scale=1.0, dec=3, unit=''):
    if v is None or not np.isfinite(v):
        return 'N/A'
    return f'{v*scale:.{dec}f} {unit}'.strip()

def tkey(t):
    try:
        return float(t)
    except ValueError:
        return 0.0

files = sorted(glob.glob(os.path.join(DATA_DIR, 'moscap_*.cvdat')))
if not files:
    print("Brak plikow .cvdat w", DATA_DIR)
    sys.exit(1)

results = []   # (tag, temp, d, metrics)
for idx, fp in enumerate(files, 1):
    tag = os.path.basename(fp).replace('moscap_', '').replace('.cvdat', '')
    temp = tag[1:] if tag.startswith('T') else tag
    d = load_cv(fp)
    m = cv_metrics(d) if d is not None else {}
    if d is not None:
        dbg(f'{tag}: {len(d["vg"])} pkt, Cmax={m["c_max"]:.3e} F, Cmin={m["c_min"]:.3e} F')
    print(f"\r{idx*100//len(files)}% of report done", end='', flush=True)
    results.append((tag, temp, d, m))
print()
results.sort(key=lambda r: tkey(r[1]))

def plot_single(tag, d, out_path):
    fig, (axc, axg) = plt.subplots(1, 2, figsize=(12, 5))
    fig.suptitle(f'MOSCAP C-V - {tag}', fontweight='bold')
    axc.plot(d['vg'], d['c']*1e15, 'o-', ms=3, color='royalblue')
    axc.set_xlabel('Vg [V]'); axc.set_ylabel('C [fF]')
    axc.set_title(f'C(Vg) @ {FREQ/1e6:g} MHz'); axc.grid(True, alpha=0.3)
    axg.plot(d['vg'], d['g']*1e6, 's-', ms=3, color='crimson')
    axg.set_xlabel('Vg [V]'); axg.set_ylabel('G [uS]')
    axg.set_title('Re(Y) (straty)'); axg.grid(True, alpha=0.3)
    plt.tight_layout(); plt.savefig(out_path, dpi=150); plt.close()

def plot_overlay(out_path):
    fig, ax = plt.subplots(figsize=(9, 6))
    for tag, temp, d, m in results:
        if d is not None:
            ax.plot(d['vg'], d['c']*1e15, label=f'{temp} C')
    ax.set_xlabel('Vg [V]'); ax.set_ylabel('C [fF]')
    ax.set_title('MOSCAP C-V - temperatury')
    ax.grid(True, alpha=0.3); ax.legend(fontsize=8)
    plt.tight_layout(); plt.savefig(out_path, dpi=150); plt.close()

for tag, temp, d, m in results:
    if d is None:
        continue
    try:
        plot_single(tag, d, os.path.join(RESULTS_DIR, f'moscap_{tag}.png'))
    except Exception as e:
        sys.stderr.write(f"  [WARN] Blad wykresu {tag}: {e}\n")
        plt.close('all')
try:
    plot_overlay(os.path.join(RESULTS_DIR, 'moscap_overlay.png'))
except Exception as e:
    sys.stderr.write(f"  [WARN] Blad overlay: {e}\n")
    plt.close('all')

# ── terminal ──────────────────────────────────────────────────────────────────
print(f"\nMOSCAP C-V (f = {FREQ/1e6:g} MHz, W={fmt(W,1e6,2)}u L={fmt(L,1e6,2)}u m={fmt(M,1,0)}):")
print("  {:<8} {:>10} {:>8} {:>10} {:>8} {:>9} {:>12} {:>12}".format(
    'T[C]', 'Cmax[fF]', '@Vg', 'Cmin[fF]', '@Vg', 'Cmax/min', 'dC/dV[fF/V]', 'Cox[fF/um2]'))
print("  " + "-" * 92)
for tag, temp, d, m in results:
    if not m:
        print(f"  {temp:<8} brak danych"); continue
    print("  {:<8} {:>10} {:>8} {:>10} {:>8} {:>9} {:>12} {:>12}".format(
        temp,
        fmt(m['c_max'], 1e15, 3), f"{m['v_cmax']:+.2f}",
        fmt(m['c_min'], 1e15, 3), f"{m['v_cmin']:+.2f}",
        fmt(m['ratio'], 1, 2),
        fmt(m['slope_max'], 1e15, 3),
        fmt(m['cox'], 1e3, 3)))      # F/m^2 -> fF/um^2 : *1e3
print("\n  C = -Im(i(vg))/(2*pi*f) przy ac 1; Cox = Cmax/(W*L*m).")
print("  Cox ma sens tylko tam, gdzie C jest nasycone (akumulacja / silna inwersja).\n")

# ── HTML ──────────────────────────────────────────────────────────────────────
rows, imgs = '', ''
for tag, temp, d, m in results:
    if not m:
        continue
    rows += f'''<tr><td>{temp} C</td>
        <td><b>{fmt(m['c_max'],1e15,3)}</b></td><td>{m['v_cmax']:+.2f}</td>
        <td>{fmt(m['c_min'],1e15,3)}</td><td>{m['v_cmin']:+.2f}</td>
        <td>{fmt(m['ratio'],1,2)}</td><td>{fmt(m['slope_max'],1e15,3)}</td>
        <td>{fmt(m['cox'],1e3,3)}</td></tr>'''
    imgs += f'<div class="card"><h3>T={temp}C</h3><img src="moscap_{tag}.png" style="max-width:100%"></div>'

html = f'''<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>MOSCAP C-V Report</title>
<style>
 body {{ font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }}
 h2 {{ color: #333; border-bottom: 2px solid #27ae60; padding-bottom: 6px; }}
 .panel {{ background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; }}
 .card {{ margin-bottom: 20px; border: 1px solid #ddd; border-radius: 6px; padding: 12px; }}
 table {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
 th {{ background: #27ae60; color: white; padding: 8px; }}
 td {{ padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
</style></head><body>
<h1>MOSCAP C-V Report</h1>
<div class="panel"><h2>Podsumowanie (f = {FREQ/1e6:g} MHz)</h2>
 <table><thead><tr><th>TEMP</th><th>C<sub>max</sub> [fF]</th><th>@Vg [V]</th>
 <th>C<sub>min</sub> [fF]</th><th>@Vg [V]</th><th>C<sub>max</sub>/C<sub>min</sub></th>
 <th>max dC/dV [fF/V]</th><th>C<sub>ox</sub> [fF/&micro;m&sup2;]</th></tr></thead>
 <tbody>{rows}</tbody></table></div>
<div class="panel"><h2>Wszystkie krzywe</h2><img src="moscap_overlay.png" style="max-width:100%"></div>
<div class="panel"><h2>Szczegoly</h2>{imgs}</div>
</body></html>'''

html_path = os.path.join(RESULTS_DIR, 'moscap_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
