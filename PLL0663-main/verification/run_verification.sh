#!/bin/bash
# Reproducible top-level DRC + LVS for PLL0663 (IHP SG13CMOS5L).
#
# Runs, on the RELEASE GDS and the RELEASE netlist:
#   - top cell check (is PLL0663 really a top cell of the GDS / a .subckt of the netlist?)
#   - DRC : run_drc.py  (PDK default tables)
#   - LVS : run_lvs.py --run_mode flat
#   - LVS : run_lvs.py --run_mode deep
# and writes verification/verification_summary.md (input hashes, tool/PDK versions, results).
#
# Usage:
#   run_verification.sh [PDK_DIR] [RUN_TAG]
#
#   PDK_DIR : PDK variant directory that contains libs.tech/klayout/...
#             default: ${PDK_ROOT:-/foss/pdks}/${PDK:-ihp-sg13cmos5l}
#   RUN_TAG : suffix for run directories (default: today's date)
#
# Optional environment overrides:  GDS=...  NET=...  TOP=...
#
# Netlist paths that point into a PDK install (.../ihp-sg13g2, .../ihp-sg13cmos5l) are rewritten
# to PDK_DIR in a per-run *_netlist_fixed.spice; the release netlist/layout are never modified.
# Generated *.lvsdb marker databases are large - keep them out of git (.gitignore).
#
# Exit code = number of failed checks (0 = everything passed).
set -u

PDK_DIR="${1:-${PDK_ROOT:-/foss/pdks}/${PDK:-ihp-sg13cmos5l}}"
RUN_TAG="${2:-$(date +%Y%m%d)}"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE="$(cd "$HERE/.." && pwd)"                 # PLL0663-main
REPO="$(cd "$BASE/.." && pwd)"                 # repo root

TOP="${TOP:-PLL0663}"
GDS="${GDS:-$REPO/release/v.1.0.0/gds/${TOP}.gds}"
NET="${NET:-$REPO/release/v.1.0.0/netlist/chip_top.spice}"

DRC_SCRIPT="$PDK_DIR/libs.tech/klayout/tech/drc/run_drc.py"
LVS_SCRIPT="$PDK_DIR/libs.tech/klayout/tech/lvs/run_lvs.py"

OUT="$BASE/verification"
DRC_DIR="$OUT/drc/drc_run_${TOP}_${RUN_TAG}"
LVF_DIR="$OUT/lvs/lvs_run_${TOP}_flat_${RUN_TAG}"
LVD_DIR="$OUT/lvs/lvs_run_${TOP}_deep_${RUN_TAG}"
SUMMARY="$OUT/verification_summary.md"

FAILS=0
declare -A RESULT

die() { echo "ERROR: $*" >&2; exit 99; }

[ -f "$DRC_SCRIPT" ] || die "run_drc.py not found: $DRC_SCRIPT  (pass the PDK dir as 1st argument)"
[ -f "$LVS_SCRIPT" ] || die "run_lvs.py not found: $LVS_SCRIPT"
[ -f "$GDS" ]        || die "GDS not found: $GDS  (override with GDS=...)"
[ -f "$NET" ]        || die "netlist not found: $NET  (override with NET=...)"

mkdir -p "$DRC_DIR" "$LVF_DIR" "$LVD_DIR"

echo "PDK_DIR = $PDK_DIR"
echo "TOP     = $TOP"
echo "GDS     = $GDS"
echo "NET     = $NET"

# ---------------------------------------------------------------- top cell checks
echo "== top cell check =="
GDS_TOPS="$(python3 - "$GDS" <<'PY'
import sys, klayout.db as db
ly = db.Layout(); ly.read(sys.argv[1])
print(" ".join(c.name for c in ly.top_cells()))
PY
)"
echo "GDS top cells : $GDS_TOPS"
if [[ " $GDS_TOPS " == *" $TOP "* ]]; then RESULT[topcell_gds]=PASS
else RESULT[topcell_gds]="FAIL ($TOP is not a top cell; found: $GDS_TOPS)"; FAILS=$((FAILS+1)); fi

if grep -qiE "^\.subckt[[:space:]]+${TOP}([[:space:]]|$)" "$NET"; then RESULT[topcell_net]=PASS
else RESULT[topcell_net]="FAIL (no .subckt $TOP in $(basename "$NET"))"; FAILS=$((FAILS+1)); fi
echo "top cell GDS: ${RESULT[topcell_gds]} | netlist: ${RESULT[topcell_net]}"

# ---------------------------------------------------------------- DRC
echo "== DRC =="
python3 "$DRC_SCRIPT" --path "$GDS" --topcell "$TOP" --run_dir "$DRC_DIR" 2>&1 | tee "$DRC_DIR/run.out"
DRC_RC=${PIPESTATUS[0]}
DRC_VIOL="$(grep -hE "Violated rules are" "$DRC_DIR"/run.out "$DRC_DIR"/*.log 2>/dev/null | sort -u)"
DRC_DB="$(ls "$DRC_DIR"/*.lyrdb 2>/dev/null | wc -l)"
if [ "$DRC_RC" -ne 0 ] || [ "$DRC_DB" -eq 0 ]; then
    RESULT[drc]="FAIL (run_drc.py exit code $DRC_RC, $DRC_DB report databases)"; FAILS=$((FAILS+1))
elif [ -n "$DRC_VIOL" ]; then
    RESULT[drc]="FAIL ($DRC_VIOL)"; FAILS=$((FAILS+1))
else
    RESULT[drc]="PASS (no violated rules reported)"
fi

# ---------------------------------------------------------------- LVS
for MODE in flat deep; do
    if [ "$MODE" = flat ]; then RD="$LVF_DIR"; else RD="$LVD_DIR"; fi
    FIXED="$RD/${TOP}_netlist_fixed.spice"
    sed -E "s|[^[:space:]\"']*/ihp-sg13[a-z0-9]*|${PDK_DIR}|g" "$NET" > "$FIXED"
    echo "== LVS ($MODE) =="
    python3 "$LVS_SCRIPT" --layout "$GDS" --netlist "$FIXED" --topcell "$TOP" \
        --run_mode "$MODE" --run_dir "$RD" 2>&1 | tee "$RD/run.out"
    LVS_RC=${PIPESTATUS[0]}
    # the decision is taken from the KLayout comparison text, not from a wrapper
    if grep -qs "Congratulations! Netlists match." "$RD"/*.log "$RD"/run.out \
       && ! grep -qsE "Netlists don't match" "$RD"/*.log "$RD"/run.out; then
        RESULT[lvs_$MODE]="PASS (netlists match)"
    else
        RESULT[lvs_$MODE]="FAIL (exit code $LVS_RC; netlists do not match or no comparison result)"
        FAILS=$((FAILS+1))
    fi
done

# ---------------------------------------------------------------- summary
sha() { sha256sum "$1" | cut -d' ' -f1; }
{
  echo "# PLL0663 top-level verification summary"
  echo
  echo "- Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "- Repo revision: $(git -C "$REPO" rev-parse HEAD 2>/dev/null || echo n/a)$( [ -n "$(git -C "$REPO" status --porcelain 2>/dev/null)" ] && echo ' (+ uncommitted changes)')"
  echo "- Top cell: $TOP"
  echo "- GDS: \`${GDS#$REPO/}\`  SHA-256 \`$(sha "$GDS")\`"
  echo "- Netlist: \`${NET#$REPO/}\`  SHA-256 \`$(sha "$NET")\`"
  echo "- PDK: \`$PDK_DIR\`  revision: $(git -C "$PDK_DIR" rev-parse --short HEAD 2>/dev/null || echo "see directory name / PDK release")"
  echo "- KLayout: $(klayout -v 2>/dev/null | head -1 || echo n/a)"
  echo "- Python: $(python3 --version 2>&1)"
  echo "- DRC script: \`run_drc.py\` (PDK default options), LVS script: \`run_lvs.py\` (modes flat, deep)"
  echo
  echo "| Check | Result |"
  echo "|---|---|"
  echo "| top cell in GDS | ${RESULT[topcell_gds]} |"
  echo "| top cell in netlist | ${RESULT[topcell_net]} |"
  echo "| DRC | ${RESULT[drc]} |"
  echo "| LVS flat | ${RESULT[lvs_flat]} |"
  echo "| LVS deep | ${RESULT[lvs_deep]} |"
  echo
  echo "Run directories: \`${DRC_DIR#$REPO/}\`, \`${LVF_DIR#$REPO/}\`, \`${LVD_DIR#$REPO/}\`"
  echo "Waivers: none recorded - list reviewed DRC/LVS waivers here."
} > "$SUMMARY"

echo
echo "== summary ($SUMMARY) =="
sed -n '/^| Check/,/^| LVS deep/p' "$SUMMARY"
echo "== done, failed checks: $FAILS =="
exit "$FAILS"
