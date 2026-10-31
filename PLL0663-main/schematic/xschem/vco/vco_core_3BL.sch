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
N 270 -170 300 -170 {lab=1-2}
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
N 260 -170 270 -170 {lab=1-2}
N 590 -170 620 -170 {lab=2-3}
N 910 -170 940 -170 {lab=3-4}
N 1230 -170 1260 -170 {lab=4-5}
N 1560 -170 1610 -170 {lab=out}
N -40 -30 10 -30 {lab=plus}
N -40 30 10 30 {lab=gnd}
N 180 20 230 20 {lab=plus}
N 180 40 230 40 {lab=gnd}
N 270 -170 270 -10 {lab=1-2}
N 270 50 270 70 {lab=#net1}
N 270 130 270 180 {lab=gnd}
N 500 20 550 20 {lab=plus}
N 500 40 550 40 {lab=gnd}
N 590 -170 590 -10 {lab=1-2}
N 590 50 590 70 {lab=#net1}
N 590 130 590 180 {lab=gnd}
N 580 -170 590 -170 {lab=2-3}
N 820 20 870 20 {lab=plus}
N 820 40 870 40 {lab=gnd}
N 910 -170 910 -10 {lab=1-2}
N 910 50 910 70 {lab=#net1}
N 910 130 910 180 {lab=gnd}
N 900 -170 910 -170 {lab=3-4}
N 1140 20 1190 20 {lab=plus}
N 1140 40 1190 40 {lab=gnd}
N 1230 -170 1230 -10 {lab=1-2}
N 1230 50 1230 70 {lab=#net1}
N 1230 130 1230 180 {lab=gnd}
N 1220 -170 1230 -170 {lab=4-5}
N 1470 20 1520 20 {lab=plus}
N 1470 40 1520 40 {lab=gnd}
N 1560 -170 1560 -10 {lab=1-2}
N 1560 50 1560 70 {lab=#net1}
N 1560 130 1560 180 {lab=gnd}
N 1540 -170 1560 -170 {lab=out}
C {sg13g2_pr/sg13_lv_nmos.sym} -220 -60 0 0 {name="M1"
l="\{Lcs\}"
w="0.4u"
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
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_3BL.sym} 120 -170 0 0 {name=x1}
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
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_3BL.sym} 440 -170 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_3BL.sym} 760 -170 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_3BL.sym} 1080 -170 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell_3BL.sym} 1400 -170 0 0 {name=x5}
C {capa.sym} 270 100 0 0 {name=C3
m=1
value=\{cap1\}
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 270 180 0 0 {name=p33 sig_type=std_logic lab=gnd
}
C {vsource.sym} -40 0 0 0 {name=V1 value=\{enable_cap\} savecurrent=false}
C {lab_wire.sym} 10 -30 0 0 {name=p38 sig_type=std_logic lab=plus
}
C {lab_wire.sym} 10 30 0 0 {name=p39 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 230 20 0 0 {name=p40 sig_type=std_logic lab=plus
}
C {lab_wire.sym} 230 40 0 0 {name=p41 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 270 20 0 0 {name=S1 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {capa.sym} 590 100 0 0 {name=C1
m=1
value=\{cap1\}
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 590 180 0 0 {name=p34 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 550 20 0 0 {name=p35 sig_type=std_logic lab=plus
}
C {lab_wire.sym} 550 40 0 0 {name=p36 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 590 20 0 0 {name=S2 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {capa.sym} 910 100 0 0 {name=C2
m=1
value=\{cap1\}
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 910 180 0 0 {name=p37 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 870 20 0 0 {name=p42 sig_type=std_logic lab=plus
}
C {lab_wire.sym} 870 40 0 0 {name=p43 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 910 20 0 0 {name=S3 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {capa.sym} 1230 100 0 0 {name=C4
m=1
value=\{cap1\}
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 1230 180 0 0 {name=p44 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 1190 20 0 0 {name=p45 sig_type=std_logic lab=plus
}
C {lab_wire.sym} 1190 40 0 0 {name=p46 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 1230 20 0 0 {name=S4 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {capa.sym} 1560 100 0 0 {name=C5
m=1
value=\{cap1\}
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 1560 180 0 0 {name=p47 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 1520 20 0 0 {name=p48 sig_type=std_logic lab=plus
}
C {lab_wire.sym} 1520 40 0 0 {name=p49 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 1560 20 0 0 {name=S5 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
