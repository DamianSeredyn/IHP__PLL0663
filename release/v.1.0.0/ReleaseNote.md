# PLL0663 – Release v1.0.0


## Summary

PLL0663 is a phase-locked loop for the IHP SG13CMOS5L process.
It contains a phase-frequency detector (PFD), charge pump (CP), VCO, VCO decoder and divider.


| Output frequency range | 32kHz – 150MHz |
| Reference frequency | 32kHz |
| Divider ratio | <2 / 9984> |
| Supply voltage | 1.2V / PIN 3.3V |
| Power consumption | up to 100mW for fastest frequency |
| Lock time | 1ms |
| Silicon area | 1050 µm × 1050 µm (sealring), 1.1025 mm² |
| Top cell | `PLL0663` |

## Contents of this release


| `release/v.1.0.0/gds/PLL0663.gds` | Final layout, top cell `PLL0663` |
| `release/v.1.0.0/netlist/PLL0663.spice` | Netlist used for LVS |
| `release/v.1.0.0/doc/` | Datasheet and documentation |
| `doc/info.json` | Submission metadata |
| `PLL0663-main/schematic/` | Xschem schematics and symbols |
| `PLL0663-main/testbenches/` | AC / DC / transient testbenches |
| `PLL0663-main/layout/` | Layout sources and block-level results |
| `PLL0663-main/verification/` | DRC / LVS scripts and reports |

## Tools and PDK


| PDK | IHP-Open-PDK, `ihp-sg13cmos5l`, revision `<git commit or tag>` |
| KLayout | `<version>` |
| Xschem | `<version>` |
| Ngspice | `<version>` |

## Verification status

Reports for this release are in `PLL0663-main/verification/`; summary with input hashes in
`verification/verification_summary.md`. GDS SHA-256: `<sha256 of PLL0663.gds>`.


| DRC (top level) | <PASS> | <waivers, if any, with reasons> |
| LVS flat | <PASS / FAIL> | |
| LVS deep | <PASS / FAIL> | |
| Simulation | <testbenches run, corners> | |

## Reproducing the results

1. Check out revision `<commit>` of this repository.
2. Start Xschem from `PLL0663-main/` (the local `xschemrc` adds the project to the library path), or
   `xschem --rcfile PLL0663-main/xschemrc`.
3. Run `PLL0663-main/verification/run_verification.sh <PDK_DIR>` for DRC and LVS.
4. Simulation: testbench `testbenches/tran/xschem/top/PLL_top_tb.sch` (full loop),
   other testbenches per block in `testbenches/`.


## Changes

### v1.0.0 – <date>
- Initial release.
- <Top cell renamed to `PLL0663`, GDS exported as `PLL0663.gds`.>
- <Symbol paths in schematics and testbenches made relative; `xschemrc` added.>

## License

Apache-2.0, see `LICENSE` in the repository root.
