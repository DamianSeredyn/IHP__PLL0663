#!/bin/bash
# ==============================================================================
# VCO DECODER — functional check across all 512 codes, swept over corner/temp/VDD
# ==============================================================================
# VCO_decoder_tb.sch drives c0,c1,c2 (coarse select) and f0-f5 (fine select)
# with PULSE sources whose periods are binary-weighted powers of two
# (f0=3.125n, f1=6.25n, f2=12.5n, f3=25n, f4=50n, f5=100n, c0=200n, c1=400n,
# c2=800n). Together these 9 sources behave exactly like a free-running
# 9-bit binary counter with a 1.5625ns "tick":
#
#     code(t) = floor(t / 1.5625ns) mod 512        (bit0=f0 ... bit8=c2)
#     coarse  = code >> 6      (c0,c1,c2 -> 0..7)
#     fine    = code & 0x3F    (f0..f5   -> 0..63)
#
# so a SINGLE 801ns transient already exercises all 512 (coarse,fine)
# combinations once each. What IS worth sweeping is corner/temp/VDD, since
# decoder propagation delay eating into the 1.5625ns dwell window is a real
# functional risk at slow/cold/low-VDD corners.
#
# KNOWN SCHEMATIC ISSUE:
# port p15 (net 130,520) on the VCO_decoder symbol instance is labeled
# "VCO2_11_sel", identical to port p4 (net 130,400). xschem ties both pins to
# the same node. Almost certainly meant to be "VCO5_11_sel". Until the .sch is
# fixed, VCO5-11 codes cannot be independently verified.
#
# NOTE: this script consumes an ALREADY NETLISTED .spice file — it does not
# invoke xschem itself. Netlist VCO_decoder_tb.sch to VCO_decoder_tb.spice
# (simulations/), or point at it with --spice <path>.
#
# POST-LAYOUT (-ext), same mechanism as run_vco.sh:
#   For every .subckt found in the testbench netlist, the script looks for
#   <cell>.pex.spice in the extraction directory (default
#   $ROOT_DIR/layout/extraction, override with --ext-dir <path>) and replaces
#   that cell in a COPY of the netlist (results/VCO_decoder_tb_ext.spice).
#   Cells without an extraction stay schematic. If a parent cell has an
#   extraction, its child cells are skipped (already inside the parent PEX).
#   Ports are mapped BY NAME (case-insensitive), not by position, through a
#   wrapper .subckt that keeps the schematic port list. See SHORTS and
#   EXT_ALIASES in the python block below for ports that exist only on one
#   side (e.g. substrate port from extraction -> gnd).
#
# SINGLE-CODE MODE (--code / --coarse+--fine):
#   Instead of the free-running 512-code counter, the nine PULSE sources on
#   c0,c1,c2,f0..f5 are replaced (in the simulated copy of the netlist) by DC
#   sources holding the requested code (bit0=f0 ... bit5=f5, bit6=c0 ... bit8=c2;
#   logic levels taken from each source's own PULSE v1/v2). A short transient
#   is run and the settled output levels are printed. The 512-code report is
#   NOT generated; results go to vcodecsel_code<N>_*.dat so the full-sweep
#   results are not overwritten.
#
#   --coarse / --fine take BINARY strings, MSB first (as written in the sheet):
#       --coarse c2c1c0        (exactly 3 digits)   e.g. 011
#       --fine   f5f4f3f2f1f0  (exactly 6 digits)   e.g. 000100
#   --code accepts decimal, 0x.. hex or 0b.. binary (9 bits, c2c1c0f5..f0).
#
# File naming: vcodec_<corner>_T<temp>_Vp<vp>.dat
# (NOTE: -ext results use the same names and overwrite schematic results.)
#
# Place in vco_decoder/scripts/ and run from there.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Expected hierarchy:
#   SCRIPT_DIR    -> .../CHIP-PLL/schematics/vco_decoder/scripts
#   DECODER_DIR   -> .../CHIP-PLL/schematics/vco_decoder        (1 level up)
#   ROOT_DIR      -> .../CHIP-PLL                                (3 levels up)
DECODER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT_DIR="$(cd "$DECODER_DIR/../.." && pwd)"

source $ROOT_DIR/configs/corner_data

usage() {
    cat <<EOF
Usage: $(basename "$0") [options]

  -c  <preset|corner ...>   presets: typ | hot | cold, or corner names (e.g. mos_tt)
  -t  <temp ...>            temperatures (values or t_min / t_nom / t_max)
  -v  <vdd ...>             supply voltages (values or vp_min / vp_nom / vp_max)
  --spice <path>            path to the netlisted VCO_decoder_tb.spice
  --code <n ...>            simulate only the given code(s), 0..511 (decimal, 0x.. or 0b..)
  --coarse <bbb> --fine <bbbbbb>
                            same, as binary strings (MSB first): coarse = c2c1c0,
                            fine = f5f4f3f2f1f0; code = coarse*64 + fine
  -ext                      post-layout: replace cells with <cell>.pex.spice
  --ext-dir <path>          extraction directory (default: \$ROOT_DIR/layout/extraction)
  -h, --help                this help

Examples:
  $(basename "$0") -c typ
  $(basename "$0") -c typ -ext
  $(basename "$0") -c typ --code 137
  $(basename "$0") -c typ --code 0b010001001
  $(basename "$0") -c typ -ext --coarse 011 --fine 010001
  $(basename "$0") -c mos_ss -t t_max -v vp_min -ext
EOF
}

# ── Argument parsing (-c/-t/-v convention as in run_sweep_pdiv_optimized.sh) ──
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
SPICE_OVERRIDE=""
USE_EXT=0
CODES=""
COARSE=""
FINE=""
EXTRACTION_DIR="$ROOT_DIR/layout/extraction"

resolve_var() {
    local name="$1"
    case "$name" in
        t_min)  echo "$t_min"  ;;
        t_nom)  echo "$t_nom"  ;;
        t_max)  echo "$t_max"  ;;
        vp_min) echo "$vp_min" ;;
        vp_nom) echo "$vp_nom" ;;
        vp_max) echo "$vp_max" ;;
        *)      echo "$name"   ;;
    esac
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -ext)
            USE_EXT=1
            shift
            ;;
        --code)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: --code requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do CODES="$CODES $1"; shift; done
            ;;
        --coarse)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: --coarse requires a value"; exit 1; }
            COARSE="$1"; shift
            ;;
        --fine)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: --fine requires a value"; exit 1; }
            FINE="$1"; shift
            ;;
        --ext-dir)
            shift
            [[ $# -eq 0 ]] && { echo "Error: --ext-dir requires a path"; exit 1; }
            EXTRACTION_DIR="$1"
            shift
            ;;
        -c)
            shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)  FILTER_CORNERS="$FILTER_CORNERS mos_tt"; FILTER_TEMPS="$FILTER_TEMPS $t_nom"; FILTER_VPS="$FILTER_VPS $vp_nom" ;;
                    hot)  FILTER_CORNERS="$FILTER_CORNERS mos_ff"; FILTER_TEMPS="$FILTER_TEMPS $t_min"; FILTER_VPS="$FILTER_VPS $vp_min" ;;
                    cold) FILTER_CORNERS="$FILTER_CORNERS mos_ff"; FILTER_TEMPS="$FILTER_TEMPS $t_nom"; FILTER_VPS="$FILTER_VPS $vp_max" ;;
                    *)    FILTER_CORNERS="$FILTER_CORNERS $1" ;;
                esac
                shift
            done
            ;;
        -t)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -t requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_TEMPS="$FILTER_TEMPS $(resolve_var "$1")"; shift; done
            ;;
        -v)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -v requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_VPS="$FILTER_VPS $(resolve_var "$1")"; shift; done
            ;;
        --spice)
            shift
            [[ $# -eq 0 ]] && { echo "Error: --spice requires a path"; exit 1; }
            SPICE_OVERRIDE="$1"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: unknown option '$1'"
            echo "Run with -h for usage."
            exit 1
            ;;
    esac
done

dedup() { echo "$1" | tr ' ' '\n' | grep -v '^$' | awk '!seen[$0]++' | tr '\n' ' '; }
FILTER_CORNERS=$(dedup "$FILTER_CORNERS")
FILTER_TEMPS=$(dedup "$FILTER_TEMPS")
FILTER_VPS=$(dedup "$FILTER_VPS")

# ── Selected code(s) ───────────────────────────────────────────────────────────
to_int() {   # decimal (leading zeros allowed), 0x hex or 0b binary -> integer, or empty if invalid
    if [[ "$1" =~ ^0[xX][0-9a-fA-F]+$ ]]; then echo $(( $1 ))
    elif [[ "$1" =~ ^0[bB][01]+$ ]]; then echo $(( 2#${1:2} ))
    elif [[ "$1" =~ ^[0-9]+$ ]]; then echo $(( 10#$1 ))
    fi
}
if [[ -n "$COARSE$FINE" ]]; then
    if [[ -z "$COARSE" || -z "$FINE" ]]; then
        echo "Error: --coarse and --fine must be given together"; exit 1
    fi
    # binary strings, MSB first: --coarse c2c1c0 (3 bits), --fine f5f4f3f2f1f0 (6 bits)
    C_BITS="${COARSE#0[bB]}"; F_BITS="${FINE#0[bB]}"
    if [[ ! "$C_BITS" =~ ^[01]{3}$ ]]; then
        echo "Error: --coarse must be exactly 3 binary digits (c2c1c0), e.g. 010"; exit 1
    fi
    if [[ ! "$F_BITS" =~ ^[01]{6}$ ]]; then
        echo "Error: --fine must be exactly 6 binary digits (f5f4f3f2f1f0), e.g. 000100"; exit 1
    fi
    CV=$(( 2#$C_BITS )); FV=$(( 2#$F_BITS ))
    CODES="$CODES $(( CV * 64 + FV ))"
fi
CODE_LIST="-1"      # -1 = normal full 512-code run
CODE_MODE=0
if [[ -n "$CODES" ]]; then
    CODE_LIST=""
    for c in $CODES; do
        n=$(to_int "$c")
        if [[ -z "$n" || "$n" -gt 511 ]]; then
            echo "Error: invalid code '$c' (must be 0..511)"; exit 1
        fi
        CODE_LIST="$CODE_LIST $n"
    done
    CODE_LIST=$(dedup "$CODE_LIST")
    CODE_MODE=1
fi

if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

if [[ -n "$FILTER_CORNERS" ]]; then
    filtered=""
    for C in $corners; do
        for F in $FILTER_CORNERS; do
            if [[ "$C" == *"$F"* ]]; then filtered="$filtered $C"; break; fi
        done
    done
    if [[ -z "$filtered" ]]; then
        echo "Error: no corner matches for: $FILTER_CORNERS"
        echo "Available corners: $corners"
        exit 1
    fi
    corners=$(dedup "$filtered")
fi

# ── Configuration ──────────────────────────────────────────────────────────────
SIM_NAME="vcodec"
NETLIST="${SPICE_OVERRIDE:-$DECODER_DIR/simulations/VCO_decoder_tb.spice}"
DATA_DIR=$DECODER_DIR/results/data
RESULTS_DIR=$DECODER_DIR/results

TSTEP="50p"
TSTOP="801n"     # 512 codes * 1.5625ns tick + margin
if [[ "$CODE_MODE" -eq 1 ]]; then
    SIM_NAME="vcodecsel"   # does not match the vcodec_* glob used by the report script
    TSTOP="20n"            # static code: short run, outputs are read at the end
fi

# ── Load an already-netlisted .spice file (no xschem call here) ───────────────
if [[ ! -f "$NETLIST" ]]; then
    echo "Error: netlist not found: $NETLIST"
    echo "Netlist VCO_decoder_tb.sch to VCO_decoder_tb.spice first (xschem batch"
    echo "mode or File > Netlist), or point at it with --spice <path>."
    exit 1
fi

# ── Sanity-check the known duplicate-net-name issue (on the SCHEMATIC netlist,
#    i.e. the top-level testbench connectivity, before any PEX substitution) ───
if grep -q 'VCO5_11_sel' "$NETLIST"; then
    HAS_VCO5_NET=1
else
    HAS_VCO5_NET=0
fi
if [[ "$HAS_VCO5_NET" -eq 0 ]]; then
    echo "WARNING: no 'VCO5_11_sel' net found in the netlist — the schematic's"
    echo "         second 'VCO2_11_sel'-labeled port (p15) is shorted onto the"
    echo "         real VCO2_11_sel net. Vco5-11 codes cannot be verified"
    echo "         independently until the .sch label is fixed. Continuing —"
    echo "         the report will mark those codes as UNTESTABLE."
fi

mkdir -p $DATA_DIR $RESULTS_DIR

# Netlist actually simulated. Schematic by default; with -ext replaced by the
# post-layout copy built below.
SIM_NETLIST="$NETLIST"

# ── Build post-layout netlist (-ext) ──────────────────────────────────────────
if [[ "$USE_EXT" -eq 1 ]]; then
    if [[ ! -d "$EXTRACTION_DIR" ]]; then
        echo "Error: extraction directory does not exist: $EXTRACTION_DIR"
        exit 1
    fi
    EXT_SPICE="$RESULTS_DIR/VCO_decoder_tb_ext.spice"
    echo "-ext mode: building post-layout netlist from $EXTRACTION_DIR"

    python3 - "$NETLIST" "$EXTRACTION_DIR" "$EXT_SPICE" <<'PYEOF'
import re
import sys
import os

in_path, ext_dir, out_path = sys.argv[1:4]

# ---- Configurable port rules (keys/values compared case-insensitively) -------
# Schematic port that does NOT exist in the extraction -> net to tie it to
# inside the wrapper (e.g. {'vdd_dec': 'vdd'}).
SHORTS = {}
# Port that exists ONLY in the extraction (typically substrate/bulk) -> net of
# the wrapper to connect it to (e.g. {'vsubs': 'gnd', 'sub': 'gnd'}).
EXT_ALIASES = {}
# Port that exists ONLY in the extraction and has no alias: True -> leave it
# unconnected (dangling node nc_<port> inside the wrapper) and warn, False ->
# skip the whole cell. Use True when the layout has more outputs than the
# schematic subckt (e.g. schematic out of date).
FLOAT_UNKNOWN = False
# ------------------------------------------------------------------------------
SHORTS = {k.lower(): v for k, v in SHORTS.items()}
EXT_ALIASES = {k.lower(): v for k, v in EXT_ALIASES.items()}

with open(in_path) as f:
    netlist = f.read()


def parse_subckts(text):
    subckts = {}
    # xschem wraps long lines with '+' continuation (e.g. a 19-pin .subckt
    # header or x-instance line). Join them first, otherwise the port list is
    # cut off after the first physical line.
    text = re.sub(r'[ \t]*\n[ \t]*\+', ' ', text)
    pattern = re.compile(
        r'^[ \t]*\.subckt[ \t]+(\S+)[ \t]+(.*?)\n(.*?)^[ \t]*\.ends\b',
        re.IGNORECASE | re.DOTALL | re.MULTILINE,
    )
    for m in pattern.finditer(text):
        name = m.group(1)
        ports = [t for t in m.group(2).split() if '=' not in t]
        body = m.group(3)
        child_tokens = set()
        for line in body.splitlines():
            s = line.strip()
            if s and s[0] in 'xX':
                toks = [t for t in s.split() if '=' not in t]
                if len(toks) >= 2:
                    child_tokens.add(toks[-1])
        subckts[name] = {'ports': ports, 'body': body, 'child_tokens': child_tokens}
    return subckts


def parse_ext_header(pex_path, cell):
    """Return (subckt_name, ports) of the top cell in a PEX file.
    Handles '+' continuation lines. If the file holds several .subckt
    (hierarchical extraction), picks the one named like the cell, otherwise
    the last one (Magic writes the top cell last)."""
    with open(pex_path) as f:
        lines = f.read().splitlines()
    found = []
    for i, line in enumerate(lines):
        m = re.match(r'^[ \t]*\.subckt[ \t]+(\S+)(.*)$', line, re.IGNORECASE)
        if not m:
            continue
        rest = m.group(2)
        j = i + 1
        while j < len(lines) and lines[j].lstrip().startswith('+'):
            rest += ' ' + lines[j].lstrip()[1:]
            j += 1
        found.append((m.group(1), [t for t in rest.split() if '=' not in t]))
    if not found:
        return None, None
    for name, ports in found:
        if name.lower() == cell.lower():
            return name, ports
    return found[-1]


def descendants(name, subckts):
    seen = set()
    stack = [name]
    while stack:
        cur = stack.pop()
        info = subckts.get(cur)
        if not info:
            continue
        for tok in info['child_tokens']:
            if tok in subckts and tok not in seen:
                seen.add(tok)
                stack.append(tok)
    seen.discard(name)
    return seen


subckts = parse_subckts(netlist)

available = {}
for name in subckts:
    pex = os.path.join(ext_dir, f'{name}.pex.spice')
    if os.path.isfile(pex):
        available[name] = pex

if not available:
    sys.stderr.write(
        f'[-ext] No extraction files in {ext_dir} for any cell '
        f'(subckts in netlist: {", ".join(sorted(subckts)) or "none"}).\n'
        f'       Expected <cell>.pex.spice. If the list of subckts is empty, the\n'
        f'       decoder is not defined as .subckt inside the testbench netlist.\n'
    )
    sys.exit(2)

excluded = set()
for name in available:
    excluded |= descendants(name, subckts) & set(available)
selected = {n: p for n, p in available.items() if n not in excluded}

out = netlist
adapters = []

for name, pex in selected.items():
    ext_name, ext_ports = parse_ext_header(pex, name)
    if ext_name is None:
        sys.stderr.write(f'[-ext] WARNING: no .subckt header in {pex}; skipping {name}.\n')
        continue
    with open(pex) as f:
        ext_body_full = f.read()

    sch_ports = subckts[name]['ports']
    sch_map = {p.lower(): p for p in sch_ports}        # lower -> schematic spelling
    ext_lower = {p.lower() for p in ext_ports}

    # Map each extraction port to a wrapper node, BY NAME (case-insensitive).
    nodes = []
    unknown_ext = []
    for p in ext_ports:
        pl = p.lower()
        if pl in sch_map:
            nodes.append(sch_map[pl])
        elif pl in EXT_ALIASES:
            nodes.append(EXT_ALIASES[pl])
        elif FLOAT_UNKNOWN:
            unknown_ext.append(p)
            nodes.append(f'nc_{p}')
        else:
            unknown_ext.append(p)
            nodes.append(None)
    if unknown_ext and FLOAT_UNKNOWN:
        sys.stderr.write(
            f'[-ext] WARNING: extraction of {name} has ports missing in the schematic '
            f'subckt: {unknown_ext}\n'
            f'        left UNCONNECTED (nc_<port>) - these outputs cannot be '
            f'observed in the testbench.\n'
        )
    elif unknown_ext:
        sys.stderr.write(
            f'[-ext] WARNING: extraction of {name} has ports unknown to the schematic: '
            f'{unknown_ext}\n'
            f'        schematic:  {sch_ports}\n'
            f'        extraction: {ext_ports}\n'
            f'        Add a rule to EXT_ALIASES in the script. Skipping this cell.\n'
        )
        continue

    # Schematic ports missing in the extraction need a short rule, otherwise
    # they would dangle.
    missing_in_ext = [p for p in sch_ports if p.lower() not in ext_lower]
    unshorted = [p for p in missing_in_ext if p.lower() not in SHORTS]
    if unshorted:
        sys.stderr.write(
            f'[-ext] WARNING: schematic ports of {name} missing in extraction and '
            f'without a short rule: {unshorted}\n'
            f'        schematic:  {sch_ports}\n'
            f'        extraction: {ext_ports}\n'
            f'        Add a rule to SHORTS in the script. Skipping this cell.\n'
        )
        continue
    if missing_in_ext:
        sys.stderr.write(
            f'[-ext] INFO {name}: ports {missing_in_ext} missing in extraction; '
            f'tying them per SHORTS {SHORTS}.\n'
        )

    # Remove the schematic definition of the cell from the netlist.
    block_re = re.compile(
        r'^[ \t]*\.subckt[ \t]+' + re.escape(name) + r'\b.*?^[ \t]*\.ends\b[^\n]*\n?',
        re.IGNORECASE | re.DOTALL | re.MULTILINE,
    )
    out = block_re.sub('', out, count=1)

    # Rename the extracted top subckt so the wrapper can take the original name.
    pex_name = f'{name}__pex'
    ext_renamed = re.sub(
        r'(^[ \t]*\.subckt[ \t]+)' + re.escape(ext_name) + r'\b',
        lambda m: m.group(1) + pex_name,
        ext_body_full,
        count=1,
        flags=re.IGNORECASE | re.MULTILINE,
    )

    # 0 V sources are exact shorts (a 0-ohm resistor makes ngspice complain).
    short_lines = ''
    for i, p in enumerate(missing_in_ext):
        short_lines += f'Vshort_{i} {p} {SHORTS[p.lower()]} 0\n'

    adapter = (
        f'* ---- PEX adapter for {name} ----\n'
        f'*   schematic ports (kept): {" ".join(sch_ports)}\n'
        f'*   extraction ports:       {" ".join(ext_ports)}\n'
        f'.subckt {name} {" ".join(sch_ports)}\n'
        f'xpex {" ".join(nodes)} {pex_name}\n'
        f'{short_lines}'
        f'.ends\n'
        f'{ext_renamed.rstrip()}\n'
    )
    adapters.append(adapter)

if not adapters:
    sys.stderr.write('[-ext] Nothing substituted; aborting.\n')
    sys.exit(2)

ext_section = (
    '\n* ==== BEGIN PEX substitutions (generated by -ext) ====\n'
    + '\n'.join(adapters)
    + '* ==== END PEX substitutions ====\n'
)
# lambda: the section may contain backslashes (escaped net names) which must
# not be interpreted as regex replacement escapes.
if re.search(r'^[ \t]*\.end\b', out, re.IGNORECASE | re.MULTILINE):
    out = re.sub(
        r'^[ \t]*\.end\b',
        lambda m: ext_section + m.group(0),
        out,
        count=1,
        flags=re.IGNORECASE | re.MULTILINE,
    )
else:
    out = out + ext_section

with open(out_path, 'w') as f:
    f.write(out)

sys.stderr.write('[-ext] Applied extraction:\n')
for name in sorted(selected):
    sys.stderr.write(f'         extracted:  {name}\n')
for name in sorted(excluded):
    sys.stderr.write(f'         skipped (inside extracted parent): {name}\n')
for name in sorted(set(subckts) - set(available)):
    sys.stderr.write(f'         schematic (no extraction): {name}\n')
PYEOF

    if [[ $? -ne 0 ]]; then
        echo "Error: building the post-layout netlist failed."
        exit 1
    fi
    SIM_NETLIST="$EXT_SPICE"
    echo "Post-layout netlist written: $EXT_SPICE"
fi

echo "=========================================================================="
echo "VCO DECODER FUNCTIONAL CHECK (all 512 codes per PVT point, single run each)"
echo "=========================================================================="
if [[ "$USE_EXT" -eq 1 ]]; then
    echo "Netlist     : $SIM_NETLIST (post-layout / PEX)"
else
    echo "Netlist     : $SIM_NETLIST (schematic)"
fi
echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
echo "Timestep    : $TSTEP   TSTOP: $TSTOP"
if [[ "$CODE_MODE" -eq 1 ]]; then
    echo "Codes       : $CODE_LIST  (single-code mode, DC inputs)"
fi
echo ""

TOTAL=0
for CODE in $CODE_LIST; do for CORNER in $corners; do for TEMP in $FILTER_TEMPS; do for VP in $FILTER_VPS; do TOTAL=$((TOTAL+1)); done; done; done; done
if [[ "$CODE_MODE" -eq 1 ]]; then
    echo "Total simulations: $TOTAL (one per code and PVT point)"
else
    echo "Total simulations: $TOTAL (1 run per PVT point covers all 512 codes)"
fi
echo "=========================================================================="
echo ""

rm -f $DATA_DIR/${SIM_NAME}_*.dat
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

CURRENT=0

for CODE in $CODE_LIST; do
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    if [[ "$CODE_MODE" -eq 1 ]]; then TAG="code${CODE}_${TAG}"; fi
    DAT=$DATA_DIR/${SIM_NAME}_${TAG}.dat

    python3 - "$SIM_NETLIST" "$CORNER" "$TEMP" "$VP" "$DAT" "$TSTEP" "$TSTOP" "$HAS_VCO5_NET" "$CODE" <<'PYEOF'
import re, sys

(netlist_path, corner, temp, vp, dat_path, tstep, tstop, has_vco5, code) = sys.argv[1:]
has_vco5 = (has_vco5 == "1")
code = int(code)

with open(netlist_path) as f:
    spice = f.read()

# 1. Remove existing .control block (the xschem-netlisted one from the .sch)
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Corner / temp / vdd
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice, flags=re.IGNORECASE)
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+', r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 3. Remove any pre-existing .options TEMP, then re-add
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 3b. Single-code mode: replace the PULSE sources on c0,c1,c2,f0..f5 by DC
#     sources holding the requested code (levels from each source's own
#     PULSE v1 (low) / v2 (high)). code = -1 -> leave the counter untouched.
if code >= 0:
    bitmap = {'f0': 0, 'f1': 1, 'f2': 2, 'f3': 3, 'f4': 4, 'f5': 5,
              'c0': 6, 'c1': 7, 'c2': 8}
    # join '+' continuation lines (xschem wraps long lines)
    spice = re.sub(r'[ \t]*\n[ \t]*\+', ' ', spice)
    found = set()
    src_re = re.compile(r'^([ \t]*[Vv]\S*)[ \t]+(\S+)[ \t]+(\S+)[ \t]+(.*\bpulse\b.*)$',
                        re.IGNORECASE | re.MULTILINE)

    def repl(m):
        node = m.group(2).lower()
        if node not in bitmap:
            return m.group(0)
        am = re.search(r'\bpulse\b[ \t]*\(?([^)\n]*)\)?', m.group(4), re.IGNORECASE)
        toks = re.findall(r'\{[^}]*\}|[^\s,]+', am.group(1)) if am else []
        if len(toks) < 2:
            return m.group(0)
        # PULSE(v1 v2 ...): the LOW level is the one that is numerically 0.
        # Do not assume v1=low: the testbench may use PULSE(vdd 0 ...).
        def is_zero(t):
            try:
                return float(t) == 0.0
            except ValueError:
                return False
        if is_zero(toks[1]) and not is_zero(toks[0]):
            low, high = toks[1], toks[0]
        else:
            low, high = toks[0], toks[1]
        if low == high:
            sys.stderr.write(f'ERROR: source driving {node} has PULSE levels low == high '
                             f'({low}); fix the .sch (expected PULSE({{vdd}} 0 ...)).\n')
            sys.exit(3)
        level = high if (code >> bitmap[node]) & 1 else low
        found.add(node)
        return f'{m.group(1)} {m.group(2)} {m.group(3)} DC {level}'

    spice = src_re.sub(repl, spice)
    missing = sorted(set(bitmap) - found)
    if missing:
        sys.stderr.write(f'ERROR: no PULSE source found driving: {missing}\n'
                         f'       (single-code mode needs a V source with a PULSE on each of '
                         f'c0,c1,c2,f0..f5)\n')
        sys.exit(3)

# 4. Rebuild the .control block: single transient, wrdata all decoder I/O.
#    Inputs (c0,c1,c2,f0..f5) are saved too so the analysis script can
#    cross-check the reconstructed code against the actual bit values
#    instead of only trusting the nominal PULSE timing.
sigs = ['c0', 'c1', 'c2', 'f0', 'f1', 'f2', 'f3', 'f4', 'f5',
        'VCO_sel', 'VCO2_5_sel', 'VCO2_11_sel',
        'VCO3_5_sel', 'VCO3_11_sel', 'VCO4_5_sel', 'VCO4_11_sel']
if has_vco5:
    sigs.append('VCO5_11_sel')

wrdata_sigs = ' '.join(f'v({s})' for s in sigs)

control_block = f"""
.control
save all
tran {tstep} {tstop}
wrdata {dat_path} {wrdata_sigs}
exit
.endc
"""

with open('/tmp/vcodec_run.spice', 'w') as f:
    f.write(spice + control_block)

# stash the signal order next to the .dat file so the python report
# generator doesn't have to guess it
with open(dat_path + '.siglist', 'w') as f:
    f.write(' '.join(sigs))
PYEOF

    if [[ $? -ne 0 ]]; then
        echo "Error: could not prepare the netlist for $TAG"
        exit 1
    fi

    ngspice -b /tmp/vcodec_run.spice >/tmp/vcodec_${TAG}.log 2>&1
    if [[ ! -s "$DAT" ]]; then
        echo "  [$TAG] FAILED — see /tmp/vcodec_${TAG}.log"
    else
        CURRENT=$((CURRENT+1))
        PCT=$(( CURRENT * 100 / TOTAL ))
        echo "  [$TAG] done — ${PCT}% total"
        if [[ "$CODE_MODE" -eq 1 ]]; then
            python3 - "$DAT" "$VP" "$CODE" <<'PYEOF'
import sys
dat, vp, code = sys.argv[1], float(sys.argv[2]), int(sys.argv[3])
sigs = open(dat + '.siglist').read().split()
rows = []
for line in open(dat):
    try:
        r = [float(x) for x in line.split()]
    except ValueError:
        continue
    if r:
        rows.append(r)
if not rows:
    print("    (no numeric data in .dat)")
    sys.exit(0)
tmax = rows[-1][0]
sel = [r for r in rows if r[0] >= 0.7 * tmax]       # settled part of the run
ncol = len(rows[0])
idx = (lambda i: 2 * i + 1) if ncol == 2 * len(sigs) else (lambda i: i + 1)
val = {s: sum(r[idx(i)] for r in sel) / len(sel) for i, s in enumerate(sigs)}

bitnames = ['f0', 'f1', 'f2', 'f3', 'f4', 'f5', 'c0', 'c1', 'c2']
applied = sum((1 << b) for b, n in enumerate(bitnames) if val[n] > vp / 2)
flag = 'OK' if applied == code else f'MISMATCH (inputs read back as {applied})'
print(f"    code {code} (coarse={code >> 6:03b}, fine={code & 63:06b}); inputs vs request: {flag}")

def lvl(v):
    if v > 0.8 * vp: return '1'
    if v < 0.2 * vp: return '0'
    return '?'
for s in sigs[9:]:
    print(f"      {s:<12} = {lvl(val[s])}   ({val[s]:.3f} V)")
PYEOF
        fi
    fi

done
done
done
done

echo ""
echo "=========================================================================="
if [[ "$CODE_MODE" -eq 1 ]]; then
    echo "Selected-code run finished (512-code report not generated)."
    echo "Data: $DATA_DIR/${SIM_NAME}_*.dat"
else
    echo "All simulations done. Generating report..."
    echo "=========================================================================="
    python3 $SCRIPT_DIR/plot_vco_decoder.py
fi
