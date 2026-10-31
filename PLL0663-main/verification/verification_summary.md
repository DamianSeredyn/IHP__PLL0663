# PLL0663 top-level verification summary

- Date: 2026-10-31T21:09:31Z
- Repo revision: 72a58ee063b1ac9f319d70b7eae5c26ab398e5b1 (+ uncommitted changes)
- Top cell: PLL0663
- GDS: `release/v.1.0.0/gds/PLL0663.gds`  SHA-256 `549c7e33e155ae3c54f49dbcebcc3fc7e480878f95a24e0a125fe5ba72dcf7b3`
- Netlist: `release/v.1.0.0/netlist/chip_top.spice`  SHA-256 `bbccab7e8789f635cf5677e4539963704343766ad9e204cb5b9bd4bbcb708366`
- PDK: `/foss/pdks/ihp-sg13cmos5l`  revision: see directory name / PDK release
- KLayout: KLayout 0.30.12
- Python: Python 3.12.3
- DRC script: `run_drc.py` (PDK default options), LVS script: `run_lvs.py` (modes flat, deep)

| Check | Result |
|---|---|
| top cell in GDS | FAIL (PLL0663 is not a top cell; found: TOP sg13cmos5l_Filler4000) |
| top cell in netlist | FAIL (no .subckt PLL0663 in chip_top.spice) |
| DRC | FAIL (run_drc.py exit code 1, 0 report databases) |
| LVS flat | FAIL (exit code 1; netlists do not match or no comparison result) |
| LVS deep | FAIL (exit code 1; netlists do not match or no comparison result) |

Run directories: `PLL0663-main/verification/drc/drc_run_PLL0663_20261031`, `PLL0663-main/verification/lvs/lvs_run_PLL0663_flat_20261031`, `PLL0663-main/verification/lvs/lvs_run_PLL0663_deep_20261031`
Waivers: none recorded - list reviewed DRC/LVS waivers here.
