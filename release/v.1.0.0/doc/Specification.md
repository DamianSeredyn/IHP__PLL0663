# PLL0663 – Specification

## Purpose
Integer-N phase-locked loop with an external loop filter, for the IHP SG13CMOS5L process.

## Requirements
| Parameter | Requirement |
|---|---|
| Reference frequency | 32 kHz |
| Output frequency | 32 kHz – 150 MHz |
| Divider ratio N | 2 – 9984, f_out = N × f_ref / 2 |
| Core supply vp | 1.2 V (1.08 – 1.32 V) |
| 3.3 V supplies vph, vp_bandgap | 3.3 V (3.1 – 3.5 V) |
| Temperature | -25 – 125 °C |
| Process corners | tt, ss, ff, sf, fs |
| Power consumption | up to 100 mW at the highest output frequency |
| Lock time | about 1 ms |
| Area | 1050 µm × 1050 µm including sealring |

## Architecture
PFD, charge pump, external loop filter, several VCOs selected by a VCO decoder, programmable
divider, input register (SIPO, 12 bits: 10-bit divider code, 2-bit debug mux code),
debug output multiplexer, bandgap reference.

## Interfaces
Pins and input register: see the datasheet, sections 3 and 3.1.

## Out of scope
Loop filter design (done by the user)