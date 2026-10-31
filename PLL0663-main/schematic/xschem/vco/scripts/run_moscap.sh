#!/bin/bash
# =============================================================================
# run_moscap.sh - krzywa C-V sg13_moscap_p (IHP sg13cmos5l) z analizy AC
# =============================================================================
# PDK: /foss/pdks/ihp-sg13cmos5l
# Pliki modeli sa wykrywane w <PDK>/libs.tech/ngspice/models:
#   MOD_FILE    - plik z '.subckt sg13_moscap_p'
#   CORNER_FILE - corner*.lib definiujacy parametry *_moscap_p_vfbo
#   LIB_SEC     - sekcja typowa (tt) w CORNER_FILE
# Nadpisanie: MODELS_DIR / MOD_FILE / CORNER_FILE / LIB_SEC (zmienne srodowiskowe).
# Zrodlo 'vg' MUSI istniec w netliscie (skrypt wymusza 'dc 0 ac 1').
# C = -Im(i(vg)) / (2*pi*f),  G = -Re(i(vg))
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PROJECT_DIR=""
_dir="$SCRIPT_DIR"
while [[ "$_dir" != "/" ]]; do
    if [[ -f "$_dir/configs/corner_data" ]]; then PROJECT_DIR="$_dir"; break; fi
    _dir="$(dirname "$_dir")"
done
if [[ -z "$PROJECT_DIR" ]]; then
    echo "Blad: nie znaleziono configs/corner_data powyzej $SCRIPT_DIR"; exit 1
fi
source "$PROJECT_DIR/configs/corner_data"

PDK_DIR="${MOSCAP_PDK_DIR:-/foss/pdks/ihp-sg13cmos5l}"
MODELS_DIR="${MODELS_DIR:-$PDK_DIR/libs.tech/ngspice/models}"

# Opcje:
#   -c typ|hot|cold   preset temperatury (t_nom / t_max / t_min); bez -c: wszystkie 3
#   -t <T...>         jawne temperatury
#   -f <Hz>           czestotliwosc AC (domyslnie 1meg)
#   -vg a b s         zakres Vg: min max krok (domyslnie -1.5 1.5 0.05)
#   -debug
FILTER_TEMPS=""; USE_DEBUG=0
FREQ="1meg"; VG_MIN="0.3"; VG_MAX="1.2"; VG_STEP="0.05"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -debug) USE_DEBUG=1; shift ;;
        -f)  FREQ="$2"; shift 2 ;;
        -vg) VG_MIN="$2"; VG_MAX="$3"; VG_STEP="$4"; shift 4 ;;
        -t) shift
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_TEMPS="$FILTER_TEMPS $1"; shift; done ;;
        -c) shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)  FILTER_TEMPS="$FILTER_TEMPS $t_nom" ;;
                    hot)  FILTER_TEMPS="$FILTER_TEMPS $t_max" ;;
                    cold) FILTER_TEMPS="$FILTER_TEMPS $t_min" ;;
                    *)    echo "Nieznany preset: $1 (typ|hot|cold)"; exit 1 ;;
                esac
                shift
            done ;;
        *) echo "Nieznana opcja: $1"; exit 1 ;;
    esac
done
if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi

# ---- Wykrywanie plikow modeli -------------------------------------------------
if [[ ! -d "$MODELS_DIR" ]]; then
    echo "Blad: brak katalogu modeli: $MODELS_DIR"
    echo "      Sprawdz: ls $PDK_DIR"; exit 1
fi

# Moscap w sg13cmos5l to symlinki do modeli z ihp-sg13g2 (te same pliki).
MOD_FILE="${MOD_FILE:-$MODELS_DIR/sg13g2_moscap_mod.lib}"
CORNER_FILE="${CORNER_FILE:-$MODELS_DIR/cornerMOSCAP.lib}"
LIB_SEC="${LIB_SEC:-moscap_tt}"

for f in "$MOD_FILE" "$CORNER_FILE"; do
    if [[ ! -e "$f" ]]; then
        echo "Blad: brak pliku modelu: $f (symlink do ihp-sg13g2 uszkodzony?)"; exit 1
    fi
done
if ! grep -qiE "^[[:space:]]*\.lib[[:space:]]+$LIB_SEC\b" "$CORNER_FILE"; then
    echo "Blad: sekcja $LIB_SEC nie istnieje w $CORNER_FILE"; exit 1
fi

SPICE=$PROJECT_DIR/schematics/simulations/moscap_tb.spice
RESULTS_DIR=$PROJECT_DIR/schematics/vco/results_moscap
DATA_DIR=$RESULTS_DIR/data

echo "Sciezki:"
echo "  PROJECT_DIR = $PROJECT_DIR"
echo "  SPICE       = $SPICE"
echo "  DATA_DIR    = $DATA_DIR"
echo "  MODELS_DIR  = $MODELS_DIR"
echo "  MOD_FILE    = $MOD_FILE"
echo "  CORNER_FILE = $CORNER_FILE  (sekcja: $LIB_SEC)"
echo "  subckt      = $(grep -iE '^[[:space:]]*\.subckt[[:space:]]+sg13_moscap_p\b' "$MOD_FILE" | head -1)"
echo "Temp: $FILTER_TEMPS | f=$FREQ | Vg: $VG_MIN..$VG_MAX krok $VG_STEP"
if [[ ! -f "$SPICE" ]]; then echo "  [BLAD] Brak netlisty: $SPICE"; exit 1; fi

dbg() { if [[ "$USE_DEBUG" -eq 1 ]]; then echo "[DEBUG] $*"; fi; }

mkdir -p "$DATA_DIR"
rm -f "$DATA_DIR"/moscap_*.cvdat "$DATA_DIR"/meta.txt
rm -f "$RESULTS_DIR"/moscap_*.png "$RESULTS_DIR"/moscap_report.html

TOTAL=0; for TEMP in $FILTER_TEMPS; do TOTAL=$((TOTAL+1)); done
CURRENT=0

for TEMP in $FILTER_TEMPS; do

    TAG="T${TEMP}"
    CVDAT=$DATA_DIR/moscap_${TAG}.cvdat
    dbg "TAG=$TAG CVDAT=$CVDAT"

    python3 - "$SPICE" "$TEMP" "$CVDAT" "$FREQ" "$VG_MIN" "$VG_MAX" "$VG_STEP" \
              "$DATA_DIR/meta.txt" "$USE_DEBUG" "$CORNER_FILE" "$LIB_SEC" "$MOD_FILE" <<'PYEOF'
import re, sys
(spice_path, temp, cvdat, freq, vmin, vmax, vstep, meta_path, use_debug,
 corner_file, lib_sec, mod_file) = sys.argv[1:]
use_debug = (use_debug == '1')
vmin, vmax, vstep = float(vmin), float(vmax), float(vstep)

with open(spice_path) as f:
    spice = f.read()

# 1) Usun bloki .control (takze urwane, bez .endc) i zblakane .endc
out_lines, in_ctl = [], False
for ln in spice.splitlines():
    s = ln.strip().lower()
    if re.match(r'\.control\b', s):
        in_ctl = True
        continue
    if in_ctl:
        if re.match(r'\.endc\b', s):
            in_ctl = False
            continue
        if re.match(r'\.end\b', s):
            in_ctl = False
            out_lines.append(ln)
        continue
    if re.match(r'\.endc\b', s):
        continue
    out_lines.append(ln)
spice = "\n".join(out_lines) + "\n"

# 2) Usun .save, .temp, .options TEMP; nadpisz .param temp
spice = re.sub(r'^[ \t]*\.save\b[^\n]*\n', '', spice, flags=re.IGNORECASE | re.MULTILINE)
spice = re.sub(r'^[ \t]*\.temp\b[^\n]*\n', '', spice, flags=re.IGNORECASE | re.MULTILINE)
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)

# 3) Usun stare .lib corner*.lib i .include z moscap, wstaw wlasne
#    (najpierw parametry corneru, potem model) zaraz pod tytulem netlisty.
spice = re.sub(r'^[ \t]*\.lib[ \t]+\S*corner\S*\.lib\b[^\n]*\n', '',
               spice, flags=re.IGNORECASE | re.MULTILINE)
spice = re.sub(r'^[ \t]*\.include[ \t]+\S*moscap\S*\.lib[^\n]*\n', '',
               spice, flags=re.IGNORECASE | re.MULTILINE)
libs = f".lib {corner_file} {lib_sec}\n.include {mod_file}\n"
first, _, rest = spice.partition("\n")
spice = first + "\n" + libs + rest

# 4) Wymus zrodlo vg: 'vg <n+> <n-> dc 0 ac 1'
m = re.search(r'^[ \t]*vg[ \t]+(\S+)[ \t]+(\S+)[^\n]*$', spice,
              re.IGNORECASE | re.MULTILINE)
if not m:
    sys.stderr.write("[BLAD] Brak zrodla 'vg' w netliscie (potrzebne do alter/i(vg)).\n")
    sys.exit(3)
spice = spice[:m.start()] + f"vg {m.group(1)} {m.group(2)} dc 0 ac 1" + spice[m.end():]

# 5) W, L, m komorki moscap (do Cox w plot_moscap.py)
suffix = {'f':1e-15,'p':1e-12,'n':1e-9,'u':1e-6,'m':1e-3,'k':1e3,'meg':1e6}
def val(s):
    mm = re.match(r'^([0-9.eE+-]+?)(meg|[fpnumk])?$', s.lower())
    return float(mm.group(1)) * suffix.get(mm.group(2) or '', 1.0) if mm else None
w = l = mult = None
for ln in spice.splitlines():
    if 'moscap' in ln.lower() and ln.strip().lower().startswith('x'):
        kv = dict(t.split('=', 1) for t in ln.split() if '=' in t)
        w, l, mult = val(kv.get('w', '')), val(kv.get('l', '')), val(kv.get('m', '1'))
        break
with open(meta_path, 'w') as f:
    f.write(f"{w} {l} {mult} {freq}\n")

spice = re.sub(r'(^[ \t]*\.end\b)', f'.options TEMP={temp}\n\\1', spice,
               count=1, flags=re.IGNORECASE | re.MULTILINE)

# 6) Rozwiniety sweep Vg (jedna seria komend na punkt)
n = int(round((vmax - vmin) / vstep)) + 1
cmds = [".control", "set noaskquit", "save i(vg)", f"shell rm -f {cvdat}"]
for k in range(n):
    vg = vmin + k * vstep
    cmds += [f"alter vg dc = {vg:.4f}",
             f"ac lin 1 {freq} {freq}",
             "let ire = real(i(vg))",
             "let iim = imag(i(vg))",
             f'echo "{vg:.4f} $&ire $&iim" >> {cvdat}']
cmds += ["exit", ".endc", ""]
ctl = "\n".join(cmds)

if re.search(r'^[ \t]*\.end\b', spice, re.IGNORECASE | re.MULTILINE):
    spice = re.sub(r'(^[ \t]*\.end\b)', lambda mo: ctl + "\n" + mo.group(1),
                   spice, count=1, flags=re.IGNORECASE | re.MULTILINE)
else:
    spice += ctl + "\n.end\n"

with open('/tmp/moscap_run.spice', 'w') as f:
    f.write(spice)

if use_debug:
    sys.stderr.write(f"[DEBUG-PY] W={w} L={l} m={mult} punktow Vg={n}\n")
    sys.stderr.write("[DEBUG-PY] netlista -> /tmp/moscap_run.spice\n")
PYEOF
    rc=$?
    if [[ $rc -ne 0 ]]; then echo "Blad generacji netlisty (kod $rc)"; exit 1; fi

    LOG=/tmp/moscap_${TAG}.log
    if [[ "$USE_DEBUG" -eq 1 ]]; then
        ngspice -b /tmp/moscap_run.spice 2>&1 | tee "$LOG"
    else
        ngspice -b /tmp/moscap_run.spice > "$LOG" 2>&1
    fi

    if [[ ! -s "$CVDAT" ]]; then
        echo "  [BLAD] Brak $CVDAT"
        grep -iE "error|warning|no such|not available|aborted|unknown|undefined" "$LOG" | tail -8 | sed 's/^/         /'
        echo "  [BLAD] (pelny log: $LOG)"
    fi

    CURRENT=$((CURRENT + 1))
    printf "%-30s done %3d%% of simulation finished\n" "$TAG" $((CURRENT*100/TOTAL))
done

echo "Generating plots and report..."
PLOT_ARGS=""
if [[ "$USE_DEBUG" -eq 1 ]]; then PLOT_ARGS="--debug"; fi
python3 "$SCRIPT_DIR/plot_moscap.py" $PLOT_ARGS
