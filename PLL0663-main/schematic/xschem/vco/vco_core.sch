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
N -210 -660 -210 -580 {lab=vp}
N 250 -470 290 -470 {lab=#net1}
N 570 -470 610 -470 {lab=#net2}
N 890 -470 930 -470 {lab=#net3}
N 1630 -350 1670 -350 {lab=pgt}
N 1630 -270 1670 -270 {lab=in}
N 1810 -420 1810 -370 {lab=vp}
N 1810 -250 1810 -200 {lab=gnd}
N 1630 -310 1670 -310 {lab=5th}
N 1950 -310 2020 -310 {lab=out}
N -410 240 -370 240 {lab=pgt}
N -410 320 -370 320 {lab=in}
N -230 170 -230 220 {lab=vp}
N -230 340 -230 390 {lab=gnd}
N -90 240 -50 240 {lab=pgt}
N -90 320 -50 320 {lab=in}
N 90 170 90 220 {lab=vp}
N 90 340 90 390 {lab=gnd}
N 230 240 270 240 {lab=pgt}
N 230 320 270 320 {lab=in}
N 410 170 410 220 {lab=vp}
N 410 340 410 390 {lab=gnd}
N 550 240 590 240 {lab=pgt}
N 550 320 590 320 {lab=in}
N 730 170 730 220 {lab=vp}
N 730 340 730 390 {lab=gnd}
N 870 240 910 240 {lab=pgt}
N 870 320 910 320 {lab=in}
N 1050 170 1050 220 {lab=vp}
N 1050 340 1050 390 {lab=gnd}
N -90 280 -50 280 {lab=#net4}
N 230 280 270 280 {lab=#net5}
N 550 280 590 280 {lab=#net6}
N 870 280 910 280 {lab=#net7}
N 1250 240 1290 240 {lab=pgt}
N 1250 320 1290 320 {lab=in}
N 1430 170 1430 220 {lab=vp}
N 1430 340 1430 390 {lab=gnd}
N 1190 280 1290 280 {lab=#net8}
N 1210 -470 1320 -470 {lab=4th}
N 1570 280 1690 280 {lab=#net9}
N 1320 -470 1320 -380 {lab=4th}
N 1320 -470 1440 -470 {lab=4th}
N 1350 -530 1400 -530 {lab=vp}
N 1350 -510 1400 -510 {lab=gnd}
N 1440 -500 1440 -470 {lab=4th}
N 1440 -560 1550 -560 {lab=5th}
N 1230 -350 1280 -350 {lab=en11}
N 1230 -330 1280 -330 {lab=gnd}
N -470 280 -370 280 {lab=11_1st}
N 1320 -320 1320 -240 {lab=11_1st}
N 1600 120 1650 120 {lab=en11}
N 1600 140 1650 140 {lab=gnd}
N 1690 -20 1690 90 {lab=5th}
N 1690 150 1690 280 {lab=#net9}
C {sg13g2_pr/sg13_lv_nmos.sym} -230 -360 0 0 {name=M1
l=\{Lcs\}
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -230 -580 0 0 {name=M2
l=\{Lcs\}
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -330 -360 0 0 {name=p1 lab=in}
C {iopin.sym} -450 -620 0 1 {name=p3 lab=vp
}
C {opin.sym} 2020 -310 0 0 {name=p4 lab=out}
C {lab_wire.sym} -50 -470 0 0 {name=p5 sig_type=std_logic lab=out
}
C {lab_wire.sym} -50 -510 0 0 {name=p10 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} -50 -430 0 0 {name=p11 sig_type=std_logic lab=in
}
C {lab_wire.sym} -210 -660 0 0 {name=p12 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 110 -580 0 0 {name=p13 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 110 -360 0 0 {name=p15 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 270 -510 0 0 {name=p7 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 270 -430 0 0 {name=p8 sig_type=std_logic lab=in
}
C {lab_wire.sym} 430 -580 0 0 {name=p9 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 430 -360 0 0 {name=p16 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 590 -510 0 0 {name=p18 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 590 -430 0 0 {name=p19 sig_type=std_logic lab=in
}
C {lab_wire.sym} 750 -580 0 0 {name=p20 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 750 -360 0 0 {name=p21 sig_type=std_logic lab=gnd
}
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
C {lab_wire.sym} 1650 -350 0 0 {name=p39 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1650 -270 0 0 {name=p40 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1810 -420 0 0 {name=p41 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1810 -200 0 0 {name=p42 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} -390 240 0 0 {name=p17 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} -390 320 0 0 {name=p22 sig_type=std_logic lab=in
}
C {lab_wire.sym} -230 170 0 0 {name=p27 sig_type=std_logic lab=vp
}
C {lab_wire.sym} -230 390 0 0 {name=p33 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} -70 240 0 0 {name=p38 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} -70 320 0 0 {name=p43 sig_type=std_logic lab=in
}
C {lab_wire.sym} 90 170 0 0 {name=p44 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 90 390 0 0 {name=p45 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 250 240 0 0 {name=p46 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 250 320 0 0 {name=p47 sig_type=std_logic lab=in
}
C {lab_wire.sym} 410 170 0 0 {name=p48 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 410 390 0 0 {name=p49 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 570 240 0 0 {name=p50 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 570 320 0 0 {name=p51 sig_type=std_logic lab=in
}
C {lab_wire.sym} 730 170 0 0 {name=p52 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 730 390 0 0 {name=p53 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 890 240 0 0 {name=p54 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 890 320 0 0 {name=p55 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1050 170 0 0 {name=p56 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1050 390 0 0 {name=p57 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 1270 240 0 0 {name=p58 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1270 320 0 0 {name=p59 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1430 170 0 0 {name=p60 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1430 390 0 0 {name=p61 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 1260 -470 0 0 {name=p6 sig_type=std_logic lab=4th
}
C {switch_ngspice.sym} 1440 -530 0 0 {name=S3 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {lab_wire.sym} 1390 -530 0 0 {name=p28 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1390 -510 0 0 {name=p29 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 1530 -560 0 0 {name=p30 sig_type=std_logic lab=5th
}
C {lab_wire.sym} 1280 -350 0 0 {name=p31 sig_type=std_logic lab=en11
}
C {lab_wire.sym} 1280 -330 0 0 {name=p34 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 1320 -350 0 0 {name=S1 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {lab_wire.sym} 1320 -240 0 0 {name=p35 sig_type=std_logic lab=11_1st
}
C {lab_wire.sym} 1660 -310 0 0 {name=p36 sig_type=std_logic lab=5th
}
C {lab_wire.sym} 1650 120 0 0 {name=p37 sig_type=std_logic lab=en11
}
C {lab_wire.sym} 1650 140 0 0 {name=p62 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 1690 120 0 0 {name=S2 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {lab_wire.sym} 1690 -20 0 0 {name=p63 sig_type=std_logic lab=5th
}
C {lab_wire.sym} -410 280 0 0 {name=p64 sig_type=std_logic lab=11_1st
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 110 -470 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 430 -470 0 0 {name=x6}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 750 -470 0 0 {name=x14}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1070 -470 0 0 {name=x15}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1810 -310 0 0 {name=x16}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1430 280 0 0 {name=x17}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1050 280 0 0 {name=x18}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 730 280 0 0 {name=x19}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 410 280 0 0 {name=x20}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 90 280 0 0 {name=x21}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} -230 280 0 0 {name=x22}
