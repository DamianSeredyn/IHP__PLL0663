# PLL0663 top-level verification summary


- Top cell: PLL0663
- GDS: `release/v.1.0.0/gds/PLL0663.gds`  SHA-256 `af1cd7230d668bee49ade49bfee07f34f5b07c11fe78f38a533892ef4f775d38`
- PDK: IHP-Open-PDK `/foss/pdks/ihp-sg13cmos5l`, revision `a49358cc0b20635fcb53c0940505e3563763fc7a`
- KLayout: KLayout 0.30.12
- Python: Python 3.12.3
- DRC script: `run_drc.py` (PDK default options), LVS script: `run_lvs.py`

## Verification status

| Check | Result | Notes |
|---|---|---|
| Top cell in GDS | PASS | Single root cell `PLL0663` |
| Top cell in netlist | PASS | `.subckt PLL0663` present in `chip_top.spice` |
| DRC main table (mandatory rules) | PASS | 0 violations of mandatory rules |
| DRC main table (recommended rules) | 41 findings, waived | Single rule `Pad.fR_TM1`, pad ring; see "DRC waivers" below |
| DRC density table | PASS | 0 violations in 5 density rules (`PLL0663_PLL0663_density.lyrdb`) |
| LVS | PASS | Netlists match |

Run directories:
`PLL0663-main/verification/drc`,
`PLL0663-main/verification/lvs`

## DRC waivers

- `Pad.fR_TM1` (41 findings, recommended rule): reported on pad cells from the PDK I/O library
  `sg13cmos5l_io`, which are used unmodified. Reviewed and waived.

No waivers for LVS.