#!/usr/bin/env python3
"""
fix_xschem_paths.py  -  rewrites symbol paths in xschem files (.sch / .sym)

Whatever the paths were before (other computer, /foss/designs/CHIP-PLL/...,
an earlier run of this script, a bare file name), after running this script
they point into the CURRENT location of the repo:

    C {/anything/old/charge_pump/vbias.sym} 530 -540 0 0 {name=x1}
 -> C {<repo>/schematic/xschem/charge_pump/vbias.sym} 530 -540 0 0 {name=x1}

How the repo location is chosen (first match wins):
    1. --project DIR
    2. the current working directory (pwd), if it contains 'schematic/' or 'PLL0663-main/schematic/'
    3. the directory of this script, same check

What gets rewritten:
    * every  C {...}  line (symbol references) - the file is looked up in the repo tree by name
    * symbols that do not exist in the repo but whose old path contains 'schematic/' or
      'testbenches/' are re-rooted to the new location (and reported as missing)
    * old repo roots found in other lines (e.g. 'wrdata /old/root/simulations/x.dat') and
      leftover '${PLL_ROOT}' strings

Not touched: PDK / library symbols (sg13g2_pr/, devices/, /foss/pdks/...), standard xschem symbols.

Usage:
    ./fix_xschem_paths.py                 # rewrite paths
    ./fix_xschem_paths.py --dry-run       # only show what would change
    ./fix_xschem_paths.py --backup        # create *.bak copies before changing
    ./fix_xschem_paths.py --project /other/path/to/PLL0663-main
    ./fix_xschem_paths.py --prefix '${PROJ}'   # write a variable instead of the absolute path

The script is idempotent - run it again after moving the repo.
"""
import argparse
import os
import sys
from collections import defaultdict

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_NAME = "PLL0663-main"
ANCHORS = ("schematic", "testbenches")

# Old repo roots known in advance (more are learned from the files themselves).
DEFAULT_OLD_ROOTS = [
    "/foss/designs/CHIP-PLL/PLL0663-main",
    "/foss/designs/CHIP-PLL",
]

# Libraries that xschem finds on its own via XSCHEM_LIBRARY_PATH - left untouched.
LIB_PREFIXES = ("sg13g2_pr/", "sg13cmos5l_pr/", "devices/")
LIB_FRAGMENTS = ("/pdks/", "/libs.tech/", "/share/xschem/")
STD_SYMBOLS = {
    "ipin.sym", "opin.sym", "iopin.sym", "gnd.sym", "vdd.sym", "lab_pin.sym",
    "lab_wire.sym", "res.sym", "capa.sym", "capa-2.sym", "ind.sym", "isource.sym",
    "vsource.sym", "vcvs.sym", "vccs.sym", "ccvs.sym", "cccs.sym", "noconn.sym",
    "launcher.sym", "simulator_commands_shown.sym", "simulator_commands.sym",
    "switch_ngspice.sym", "code.sym", "code_shown.sym", "title.sym", "diode.sym",
    "ammeter.sym", "spice_probe.sym", "bus_connect.sym", "input_pin.sym",
    "netlist.sym",
}
RW = dict(encoding="utf-8", errors="surrogateescape", newline="")


def detect_project(cli_value):
    if cli_value:
        return os.path.abspath(cli_value)
    for base in (os.getcwd(), SCRIPT_DIR):
        cand = os.path.join(base, PROJECT_NAME)
        if os.path.isdir(os.path.join(cand, "schematic")):
            return cand
        if os.path.isdir(os.path.join(base, "schematic")):
            return base
    sys.exit(f"Could not find 'schematic/' or '{PROJECT_NAME}/schematic' in the current "
             f"directory ({os.getcwd()}) or next to the script ({SCRIPT_DIR}). Use --project.")


def xschem_files(project_dir):
    for root, _dirs, files in os.walk(project_dir):
        for f in sorted(files):
            if f.endswith((".sch", ".sym")):
                yield os.path.join(root, f)


def build_index(project_dir):
    by_base = defaultdict(list)
    for full in xschem_files(project_dir):
        by_base[os.path.basename(full)].append(os.path.relpath(full, project_dir))
    return by_base


def tail_match(a_parts, b_parts):
    n = 0
    for x, y in zip(reversed(a_parts), reversed(b_parts)):
        if x != y:
            break
        n += 1
    return n


def norm(p):
    p = p.strip()
    while p.startswith("//"):
        p = p[1:]
    return p


def resolve(old_path, src_file, project_dir, index):
    """Returns (rel_path | None, status).
    status: ok / anchor / same_dir / ambiguous / missing / lib"""
    p = norm(old_path)
    if not p:
        return None, "lib"
    if p.startswith(LIB_PREFIXES) or any(s in p for s in LIB_FRAGMENTS):
        return None, "lib"
    base = os.path.basename(p)
    cands = index.get(base, [])
    src_dir = os.path.dirname(os.path.relpath(src_file, project_dir))
    p_parts = p.strip("/").split("/")

    if not cands:
        if base in STD_SYMBOLS:
            return None, "lib"
        # not in the repo: if the old path contains schematic/ or testbenches/, re-root it
        for i, part in enumerate(p_parts[:-1]):
            if part in ANCHORS:
                return "/".join(p_parts[i:]), "anchor"
        return None, "missing"

    # bare file name: if the file sits next to the source, xschem finds it itself
    if "/" not in p and os.path.join(src_dir, base) in cands:
        return None, "same_dir"

    def score(rel):
        parts = rel.split(os.sep)
        return (
            tail_match(p_parts, parts),                         # longer matching tail is better
            0 if "old" in "/".join(parts[:-1]).lower() else 1,  # avoid old_sch etc.
            1 if os.path.dirname(rel) == src_dir else 0,        # prefer the same directory
        )

    best = max(score(c) for c in cands)
    winners = [c for c in cands if score(c) == best]
    if len(winners) == 1:
        return winners[0], "ok"
    return None, "ambiguous"


def learn_roots(project_dir, index):
    """Collect old repo roots: for 'C {<root>/<rel>}' where rel is where the file lives now."""
    roots = set(DEFAULT_OLD_ROOTS)
    for path in xschem_files(project_dir):
        with open(path, "r", **RW) as fh:
            for line in fh.read().split("\n"):
                if not line.startswith("C {"):
                    continue
                end = line.find("}", 3)
                if end < 0:
                    continue
                old = norm(line[3:end])
                if not old.startswith("/"):
                    continue
                rel, status = resolve(old, path, project_dir, index)
                if rel and status in ("ok", "anchor"):
                    rel = rel.replace(os.sep, "/")
                    if old.endswith("/" + rel):
                        roots.add(old[:-(len(rel) + 1)])
    return sorted(roots, key=len, reverse=True)


def process_file(path, project_dir, index, prefix, roots, stats, dry, backup, verbose):
    with open(path, "r", **RW) as fh:
        original = fh.read()
    lines = original.split("\n")
    changed = False
    rel_src = os.path.relpath(path, project_dir)

    for i, line in enumerate(lines):
        orig_line = line

        # leftovers from a '--prefix ${PLL_ROOT}' run, anywhere in the line
        if "${PLL_ROOT}" in line and prefix != "${PLL_ROOT}":
            line = line.replace("${PLL_ROOT}", prefix)

        if line.startswith("C {"):
            end = line.find("}", 3)
            if end >= 0:
                old = line[3:end]
                rel, status = resolve(old, path, project_dir, index)
                if rel is None and status == "missing":
                    # file not in the repo: still move it from an old root to the new one
                    n_old = norm(old)
                    for root in roots:
                        if root != prefix and n_old.startswith(root + "/"):
                            new_path = prefix + n_old[len(root):]
                            stats["missing"].append((rel_src, f"{n_old}  (re-rooted to {new_path})"))
                            line = "C {" + new_path + line[end:]
                            break
                    else:
                        stats["missing"].append((rel_src, n_old))
                elif rel is None:
                    if status == "ambiguous":
                        stats[status].append((rel_src, norm(old)))
                else:
                    new = f"{prefix}/{rel.replace(os.sep, '/')}"
                    if status == "anchor":
                        stats["missing"].append((rel_src, f"{norm(old)}  (re-rooted to {new})"))
                    line = "C {" + new + line[end:]
        else:
            # old repo roots in other lines (e.g. spice commands: wrdata /old/root/...)
            for root in roots:
                if root != prefix and (root + "/") in line:
                    line = line.replace(root + "/", prefix + "/")

        if line != orig_line:
            lines[i] = line
            changed = True
            stats["replaced"] += 1
            if verbose:
                print(f"  {rel_src}:\n      {orig_line.strip()[:150]}\n   -> {line.strip()[:150]}")

    if changed:
        stats["files"] += 1
        if not dry:
            if backup:
                with open(path + ".bak", "w", **RW) as bf:
                    bf.write(original)
            with open(path, "w", **RW) as fh:
                fh.write("\n".join(lines))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--project", help="repo directory (default: auto-detect from pwd, then from the script's directory)")
    ap.add_argument("--prefix", help="text written at the start of each path instead of the absolute "
                                      "repo path (e.g. '${PROJ}'); default: absolute repo path")
    ap.add_argument("--dry-run", action="store_true", help="do not write anything, only show changes")
    ap.add_argument("--backup", action="store_true", help="save *.bak copies")
    ap.add_argument("-q", "--quiet", action="store_true", help="do not print every change")
    args = ap.parse_args()

    project_dir = detect_project(args.project)
    prefix = (args.prefix or project_dir).rstrip("/")
    index = build_index(project_dir)
    roots = learn_roots(project_dir, index)

    print(f"Project : {project_dir}")
    print(f"Prefix  : {prefix}")
    if args.dry_run:
        print("Mode    : DRY-RUN (nothing written)")

    stats = {"replaced": 0, "files": 0, "missing": [], "ambiguous": []}
    for path in xschem_files(project_dir):
        process_file(path, project_dir, index, prefix, roots, stats,
                     args.dry_run, args.backup, not args.quiet)

    print(f"\nRewrote {stats['replaced']} lines in {stats['files']} files.")
    if stats["ambiguous"]:
        print("\nAMBIGUOUS (skipped - pick manually):")
        for src, old in stats["ambiguous"]:
            print(f"  {src}: {old}")
    if stats["missing"]:
        print("\nTARGET FILE NOT FOUND in the repo (unchanged, or re-rooted as noted):")
        for src, old in sorted(set(stats["missing"])):
            print(f"  {src}: {old}")


if __name__ == "__main__":
    main()
