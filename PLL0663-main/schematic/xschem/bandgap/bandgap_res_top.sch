v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 140 80 220 80 {lab=gd}
N 220 -90 220 80 {lab=gd}
N 220 -300 220 -250 {lab=vp}
N 180 -90 180 -60 {lab=d8}
N 120 -90 120 -60 {lab=d1}
N 140 60 140 80 {lab=gd}
N 0 80 140 80 {lab=gd}
N 0 -300 220 -300 {lab=vp}
N 300 -170 340 -170 {lab=vref}
N 300 -130 340 -130 {lab=vbias}
C {ipin.sym} 0 -300 0 0 {name=p1 lab=vp}
C {ipin.sym} 0 80 0 0 {name=p2 lab=gd}
C {opin.sym} 340 -170 0 0 {name=p3 lab=vref
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/bandgap_res_diodes.sym} 120 -60 0 0 {name=x1}
C {lab_wire.sym} 180 -70 0 0 {name=p4 sig_type=std_logic lab=d8}
C {lab_wire.sym} 120 -70 0 0 {name=p5 sig_type=std_logic lab=d1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/bandgap_res_core_wrapper.sym} 100 -170 0 0 {name=x2}
C {opin.sym} 340 -130 0 0 {name=p6 lab=vbias
}
