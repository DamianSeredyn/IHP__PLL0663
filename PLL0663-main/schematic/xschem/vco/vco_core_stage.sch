v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -60 -240 -60 {lab=in}
N -240 -230 -200 -230 {lab=pgt}
N -200 -230 -200 -90 {lab=pgt}
N -60 -170 -20 -170 {lab=out}
N -60 -210 -20 -210 {lab=pgt}
N -60 -130 -20 -130 {lab=in}
N 120 -280 120 -230 {lab=vp}
N 120 -110 120 -60 {lab=gnd}
N 260 -210 300 -210 {lab=pgt}
N 260 -130 300 -130 {lab=in}
N 440 -280 440 -230 {lab=vp}
N 440 -110 440 -60 {lab=gnd}
N 580 -210 620 -210 {lab=pgt}
N 580 -130 620 -130 {lab=in}
N 760 -280 760 -230 {lab=vp}
N 760 -110 760 -60 {lab=gnd}
N 900 -210 940 -210 {lab=pgt}
N 900 -130 940 -130 {lab=in}
N 1080 -280 1080 -230 {lab=vp}
N 1080 -110 1080 -60 {lab=gnd}
N 1220 -210 1260 -210 {lab=pgt}
N 1220 -130 1260 -130 {lab=in}
N 1400 -280 1400 -230 {lab=vp}
N 1400 -110 1400 -60 {lab=gnd}
N -440 -320 -400 -320 {lab=vp}
N -440 -280 -400 -280 {lab=gnd}
N -200 -60 -200 20 {lab=gnd}
N -240 -280 -240 -230 {lab=pgt}
N -200 -250 -200 -230 {lab=pgt}
N -200 -360 -200 -280 {lab=vp}
N 260 -170 300 -170 {lab=1-2}
N 580 -170 620 -170 {lab=2-3}
N 900 -170 940 -170 {lab=3-4}
N 1220 -170 1260 -170 {lab=4-5}
N 1540 -170 1610 -170 {lab=out}
C {sg13g2_pr/sg13_lv_nmos.sym} -220 -60 0 0 {name=M1
l=\{Lcs\}
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -220 -280 0 0 {name=M2
l=\{Lcs\}
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -320 -60 0 0 {name=p1 lab=in}
C {iopin.sym} -440 -320 0 1 {name=p3 lab=vp
}
C {opin.sym} 1610 -170 0 0 {name=p4 lab=out}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 120 -170 0 0 {name=x1}
C {lab_wire.sym} -40 -170 0 0 {name=p5 sig_type=std_logic lab=out
}
C {lab_wire.sym} -40 -210 0 0 {name=p10 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} -40 -130 0 0 {name=p11 sig_type=std_logic lab=in
}
C {lab_wire.sym} -200 -360 0 0 {name=p12 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 120 -280 0 0 {name=p13 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 120 -60 0 0 {name=p15 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 440 -170 0 0 {name=x2}
C {lab_wire.sym} 280 -170 0 0 {name=p6 sig_type=std_logic lab=1-2
}
C {lab_wire.sym} 280 -210 0 0 {name=p7 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 280 -130 0 0 {name=p8 sig_type=std_logic lab=in
}
C {lab_wire.sym} 440 -280 0 0 {name=p9 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 440 -60 0 0 {name=p16 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 760 -170 0 0 {name=x3}
C {lab_wire.sym} 600 -170 0 0 {name=p17 sig_type=std_logic lab=2-3
}
C {lab_wire.sym} 600 -210 0 0 {name=p18 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 600 -130 0 0 {name=p19 sig_type=std_logic lab=in
}
C {lab_wire.sym} 760 -280 0 0 {name=p20 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 760 -60 0 0 {name=p21 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1080 -170 0 0 {name=x4}
C {lab_wire.sym} 920 -170 0 0 {name=p22 sig_type=std_logic lab=3-4
}
C {lab_wire.sym} 920 -210 0 0 {name=p23 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 920 -130 0 0 {name=p24 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1080 -280 0 0 {name=p25 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1080 -60 0 0 {name=p26 sig_type=std_logic lab=gnd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1400 -170 0 0 {name=x5}
C {lab_wire.sym} 1240 -170 0 0 {name=p27 sig_type=std_logic lab=4-5
}
C {lab_wire.sym} 1240 -210 0 0 {name=p28 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1240 -130 0 0 {name=p29 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1400 -280 0 0 {name=p30 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1400 -60 0 0 {name=p31 sig_type=std_logic lab=gnd
}
C {iopin.sym} -440 -280 0 1 {name=p32 lab=gnd}
C {lab_wire.sym} -200 20 0 0 {name=p2 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} -200 -160 0 0 {name=p14 sig_type=std_logic lab=pgt
}
