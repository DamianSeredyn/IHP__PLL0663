# PLL0663 – Release v1.0.0

## Summary

PLL0663 is a phase-locked loop for the IHP SG13CMOS5L process.
It contains a phase-frequency detector (PFD), charge pump (CP), VCO, VCO decoder and divider.
The loop filter is placed outside of the chip.

| Parameter | Value |
|---|---|
| Output frequency range | 32 kHz – 150 MHz |
| Reference frequency | 32 kHz |
| Divider ratio | 2 – 9984 |
| Supply voltage | 1.2 V core / 3.3 V pads |
| Power consumption | up to 100 mW (fastest frequency) |
| Lock time | 1 ms |
| Silicon area | 1050 µm × 1050 µm (sealring), 1.1025 mm² |
| Top cell | `PLL0663` |

## Contents of this release

| Path | Description |
|---|---|
| `release/v.1.0.0/gds/PLL0663.gds` | Final layout, top cell `PLL0663` |
| `release/v.1.0.0/netlist/PLL0663.spice` | Netlist used for LVS |
| `release/v.1.0.0/doc/` | Datasheet and documentation |
| `doc/info.json` | Submission metadata |
| `fix_xschem_paths.py` | Adapts the symbol paths in the schematics to the local checkout |
| `PLL0663-main/schematic/` | Xschem schematics and symbols |
| `PLL0663-main/testbenches/` | AC / DC / transient testbenches |
| `PLL0663-main/layout/` | Layout sources and block-level results |
| `PLL0663-main/verification/` | DRC / LVS scripts and reports |

## Tools and PDK

| Item | Version |
|---|---|
| PDK | IHP-Open-PDK, `ihp-sg13cmos5l`, revision `a49358cc0b20635fcb53c0940505e3563763fc7a` |
| KLayout | 0.30.12 |
| Xschem | 3.4.8RC |
| Ngspice | 47 |

## Verification status

Reports for this release are in `PLL0663-main/verification/`; summary with input hashes in
`verification/verification_summary.md`. GDS SHA-256: `TODO`.

| Check | Result | Notes |
|---|---|---|
| DRC main table (mandatory rules) | PASS | 0 violations of mandatory rules; see "DRC waivers" below |
| DRC main table (recommended rules) | 41 findings, waived | Single rule `Pad.fR_TM1`, pad ring; see "DRC waivers" below |
| DRC density table | PASS | 0 violations in 5 density rules (`PLL0663_PLL0663_density.lyrdb`) |
| LVS | PASS  |  

## Simulation results

| Testbench | Corner / conditions | Result |
|---|---|---|
| `testbenches/tran/xschem/top/PLL_top_tb.sch` | `mos_tt`, 1.2 V, 24 °C | lock at 1 MHz, lock time 1 ms |

Plots and waveforms: `doc/top_results`.

### DRC waivers

The main-table DRC of the top cell `PLL0663` (PDK runset `ihp-sg13cmos5l.drc`) reports no violations
of the mandatory rules. It reports 41 violations of one *recommended* rule, all along the pad ring.
The pads are unmodified cells from the PDK I/O library `sg13cmos5l_io`
(`ihp-sg13cmos5l/libs.ref/sg13cmos5l_io` of IHP-Open-PDK, revision
`a49358cc0b20635fcb53c0940505e3563763fc7a`).
They were used as delivered and not edited, so the violations are inherent to the library cells
and are not fixed in this design.

| Rule | Count | Location | Reason for waiver |
|---|---|---|---|
| `Pad.fR_TM1` (min. recommended TM1 exit length 7.0 µm) | 41 | pad ring, all four sides (top 14, left 14, right 8, bottom 5) | Unmodified PDK I/O library pad cells; recommended (not mandatory) rule, library cells not edited |

The other pad rules (`Pad.m`, `Pad.i`, `Pad.fR_M1` ... `Pad.fR_M4`) report no violations.

Report: `PLL0663-main/verification/drc/drc_run_PLL0663/PLL0663_PLL0663_main.lyrdb`

## Reproducing the results

1. Check out revision `TODO` of this repository.
2. Point the schematics to this checkout (run once after every clone or move of the repository),
   from the repository root:
   ```bash
   python3 fix_xschem_paths.py             # rewrite symbol paths to the current location
   python3 fix_xschem_paths.py --dry-run   # preview only, nothing is written
   python3 fix_xschem_paths.py --backup    # keep *.bak copies of changed files
   python3 fix_xschem_paths.py --project /path/to/PLL0663-main   # if run from elsewhere
   ```
   The script looks for `PLL0663-main/` in the current directory, then next to itself. It rewrites every
   `C {...}` symbol reference in `schematic/` and `testbenches/` to the absolute path of the matching file
   in this checkout, whatever the old path was (another computer, `/foss/designs/CHIP-PLL/...`, an earlier
   run). Old repository roots in other lines (e.g. a `wrdata` output path) are updated too. PDK library
   symbols (`sg13g2_pr/`, `sg13cmos5l_pr/`, `devices/`) are left untouched. The script is idempotent and
   lists symbols it cannot find in the repository. Do not commit the rewritten files: they contain
   machine-specific paths.
3. Start Xschem (any directory) and open `PLL0663-main/testbenches/tran/xschem/top/PLL_top_tb.sch`
   (full loop); block-level testbenches are in `PLL0663-main/testbenches/`.

## Changes

### v1.0.0 – TODO: release date
- Initial release.
- Top cell renamed to `PLL0663`, GDS exported as `PLL0663.gds`.
- `fix_xschem_paths.py` added: schematic and testbench symbol paths are adapted to the checkout location.

## License

Apache-2.0, see `LICENSE` in the repository root.
