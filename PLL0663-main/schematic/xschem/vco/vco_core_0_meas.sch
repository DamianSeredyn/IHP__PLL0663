v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -330 -360 -250 -360 {lab=in}
N -250 -530 -210 -530 {lab=pgt}
N -210 -530 -210 -390 {lab=pgt}
N -70 -470 -30 -470 {lab=out}
N -70 -510 -30 -510 {lab=pgt}
N -70 -430 -30 -430 {lab=in}
N 110 -580 110 -530 {lab=vp}
N 110 -410 110 -360 {lab=gnd}
N 250 -510 290 -510 {lab=pgt}
N 250 -430 290 -430 {lab=in}
N 430 -580 430 -530 {lab=vp}
N 430 -410 430 -360 {lab=gnd}
N 570 -510 610 -510 {lab=pgt}
N 570 -430 610 -430 {lab=in}
N 750 -580 750 -530 {lab=vp}
N 750 -410 750 -360 {lab=gnd}
N 890 -510 930 -510 {lab=pgt}
N 890 -430 930 -430 {lab=in}
N 1070 -580 1070 -530 {lab=vp}
N 1070 -410 1070 -360 {lab=gnd}
N -450 -620 -410 -620 {lab=vp}
N -450 -580 -410 -580 {lab=gnd}
N -210 -360 -210 -280 {lab=gnd}
N -250 -580 -250 -530 {lab=pgt}
N -210 -550 -210 -530 {lab=pgt}
N -210 -660 -210 -580 {lab=v2i_vp}
N 250 -470 290 -470 {lab=#net1}
N 570 -470 610 -470 {lab=#net2}
N 890 -470 930 -470 {lab=#net3}
N 1210 -510 1250 -510 {lab=pgt}
N 1210 -430 1250 -430 {lab=in}
N 1390 -580 1390 -530 {lab=vp}
N 1390 -410 1390 -360 {lab=gnd}
N 1210 -470 1250 -470 {lab=5th}
N 1530 -470 1600 -470 {lab=out}
N -450 -540 -410 -540 {lab=v2i_vp}
C {sg13g2_pr/sg13_lv_nmos.sym} -230 -360 0 0 {name=M1
l=0.16*4u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -230 -580 0 0 {name=M2
l=0.16*4u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -330 -360 0 0 {name=p1 lab=in}
C {iopin.sym} -450 -620 0 1 {name=p3 lab=vp
}
C {opin.sym} 1600 -470 0 0 {name=p4 lab=out}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_0_meas.sym} 110 -470 0 0 {name=x1}
C {lab_wire.sym} -50 -470 0 0 {name=p5 sig_type=std_logic lab=out
}
C {lab_wire.sym} -50 -510 0 0 {name=p10 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} -50 -430 0 0 {name=p11 sig_type=std_logic lab=in
}
C {lab_wire.sym} -210 -660 0 0 {name=p12 sig_type=std_logic lab=v2i_vp
}
C {lab_wire.sym} 110 -580 0 0 {name=p13 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 110 -360 0 0 {name=p15 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_0_meas.sym} 430 -470 0 0 {name=x2}
C {lab_wire.sym} 270 -510 0 0 {name=p7 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 270 -430 0 0 {name=p8 sig_type=std_logic lab=in
}
C {lab_wire.sym} 430 -580 0 0 {name=p9 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 430 -360 0 0 {name=p16 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_0_meas.sym} 750 -470 0 0 {name=x3}
C {lab_wire.sym} 590 -510 0 0 {name=p18 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 590 -430 0 0 {name=p19 sig_type=std_logic lab=in
}
C {lab_wire.sym} 750 -580 0 0 {name=p20 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 750 -360 0 0 {name=p21 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_0_meas.sym} 1070 -470 0 0 {name=x4}
C {lab_wire.sym} 910 -510 0 0 {name=p23 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 910 -430 0 0 {name=p24 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1070 -580 0 0 {name=p25 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1070 -360 0 0 {name=p26 sig_type=std_logic lab=gnd
}
C {iopin.sym} -450 -580 0 1 {name=p32 lab=gnd}
C {lab_wire.sym} -210 -280 0 0 {name=p2 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} -210 -460 0 0 {name=p14 sig_type=std_logic lab=pgt
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_0_meas.sym} 1390 -470 0 0 {name=x7}
C {lab_wire.sym} 1230 -510 0 0 {name=p39 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1230 -430 0 0 {name=p40 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1390 -580 0 0 {name=p41 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1390 -360 0 0 {name=p42 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 1240 -470 0 0 {name=p36 sig_type=std_logic lab=5th
}
C {iopin.sym} -450 -540 0 1 {name=p6 lab=v2i_vp
}
