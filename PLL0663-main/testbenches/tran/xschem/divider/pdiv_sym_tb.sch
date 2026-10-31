v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 250 -130 270 {lab=clk}
N 110 90 110 100 {lab=VP}
N -130 330 -130 350 {lab=0}
N 110 160 110 180 {lab=0}
N 140 320 160 320 {lab=clk}
N 460 460 610 460 {lab=div64}
N 460 440 610 440 {lab=div32}
N 460 340 490 340 {lab=VP}
N 460 320 530 320 {lab=0}
N 460 420 610 420 {lab=div16}
N 460 400 610 400 {lab=div8}
N 460 380 610 380 {lab=div4}
N 460 360 610 360 {lab=div2}
N 910 400 940 400 {lab=0}
N 910 380 970 380 {lab=VP}
N -130 760 -130 780 {lab=0}
N -10 760 -10 780 {lab=0}
N 110 760 110 780 {lab=0}
N 580 480 610 480 {lab=d0}
N 580 500 610 500 {lab=d1}
N 580 520 610 520 {lab=d2}
N -130 670 -130 700 {lab=d0}
N -10 670 -10 700 {lab=d1}
N 110 670 110 700 {lab=d2}
N 480 840 480 860 {lab=0}
N 540 840 540 860 {lab=0}
N 600 840 600 860 {lab=0}
N 660 840 660 860 {lab=0}
N 720 840 720 860 {lab=0}
N 780 840 780 860 {lab=0}
N 480 760 480 780 {lab=div64}
N 460 760 480 760 {lab=div64}
N 460 740 540 740 {lab=div32}
N 540 740 540 780 {lab=div32}
N 600 720 600 780 {lab=div16}
N 460 720 600 720 {lab=div16}
N 460 700 660 700 {lab=div8}
N 660 700 660 780 {lab=div8}
N 460 680 720 680 {lab=div4}
N 720 680 720 780 {lab=div4}
N 460 660 780 660 {lab=div2}
N 780 660 780 780 {lab=div2}
N 580 540 610 540 {lab=d3}
N 1130 290 1150 290 {lab=VP}
N 1130 290 1130 330 {lab=VP}
N 1130 390 1130 420 {lab=0}
N 1420 680 1450 680 {lab=#net1}
N 1750 740 1760 740 {lab=#net2}
N 1760 740 1760 770 {lab=#net2}
N 1440 770 1760 770 {lab=#net2}
N 1440 700 1440 770 {lab=#net2}
N 1440 700 1450 700 {lab=#net2}
N 1750 720 1780 720 {lab=0}
N 1750 700 1810 700 {lab=VP}
N 580 560 610 560 {lab=d4}
N 580 580 610 580 {lab=d5}
N -130 940 -130 960 {lab=0}
N -10 940 -10 960 {lab=0}
N 110 940 110 960 {lab=0}
N -130 850 -130 880 {lab=d3}
N -10 850 -10 880 {lab=d4}
N 110 850 110 880 {lab=d5}
N 1180 360 1630 360 {lab=out}
N 120 340 160 340 {lab=out}
N 120 420 120 440 {lab=0}
N 120 340 120 360 {lab=out}
N 910 360 1110 360 {lab=#net3}
N 1690 80 1710 80 {lab=VP}
N 1690 80 1690 120 {lab=VP}
N 1690 180 1690 210 {lab=0}
N 980 -40 1000 -40 {lab=VP}
N 980 -20 1000 -20 {lab=0}
N 1340 50 1360 50 {lab=VP}
N 1340 70 1360 70 {lab=0}
N 1480 20 1500 20 {lab=VP}
N 1480 20 1480 60 {lab=VP}
N 1480 120 1480 150 {lab=0}
N 1580 70 1650 70 {lab=#net4}
N 1650 70 1650 120 {lab=#net4}
N 980 0 980 50 {lab=d012}
N 980 50 1040 50 {lab=d012}
N 990 130 1010 130 {lab=VP}
N 990 150 1010 150 {lab=0}
N 990 170 1040 170 {lab=d345}
N 1040 70 1040 170 {lab=d345}
N 650 -40 680 -40 {lab=d0}
N 650 -20 680 -20 {lab=d1}
N 650 0 680 0 {lab=d2}
N 670 130 690 130 {lab=d3}
N 670 150 690 150 {lab=d4}
N 670 170 690 170 {lab=d5}
N 1630 130 1630 150 {lab=clk}
N 1690 290 1690 330 {lab=VP}
N 1690 390 1690 420 {lab=0}
N 1650 390 1650 430 {lab=#net4}
N 1580 430 1650 430 {lab=#net4}
N 1650 220 1650 330 {lab=bypass}
N 1340 90 1340 220 {lab=bypass}
N 1690 290 1710 290 {lab=VP}
N 1650 180 1650 220 {lab=bypass}
N 1750 680 1820 680 {lab=out_div}
N 1710 360 1760 360 {lab=#net1}
N 1710 150 1760 150 {lab=#net1}
N 1760 150 1760 360 {lab=#net1}
N 1760 360 1760 560 {lab=#net1}
N 1420 560 1760 560 {lab=#net1}
N 1420 560 1420 680 {lab=#net1}
N 1530 90 1580 90 {lab=#net4}
N 1580 90 1580 430 {lab=#net4}
N 1580 70 1580 90 {lab=#net4}
N 1340 90 1460 90 {lab=bypass}
N 1340 220 1650 220 {lab=bypass}
C {devices/code_shown.sym} -20 -10 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ff
"}
C {devices/code_shown.sym} 300 -70 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control
set maxdata = 1000
op
print all
save all

tran 50p 1u
write pdiv_tb.raw 
set appendwrite

.endc
"}
C {vsource.sym} 110 130 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -130 300 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {lab_wire.sym} -130 250 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 110 90 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -130 350 0 0 {name=l3 lab=0
}
C {lab_wire.sym} 140 320 0 0 {name=p3 sig_type=std_logic lab=clk
}
C {gnd.sym} 520 320 3 0 {name=l9 lab=0
}
C {lab_wire.sym} 490 340 2 0 {name=p5 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 480 360 2 0 {name=p6 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 480 380 2 0 {name=p7 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 480 400 2 0 {name=p9 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 480 420 2 0 {name=p10 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 480 440 2 0 {name=p11 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 480 460 2 0 {name=p12 sig_type=std_logic lab=div64
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/count_data_check.sym} 760 470 0 0 {name=x2}
C {gnd.sym} 940 400 3 0 {name=l2 lab=0
}
C {lab_wire.sym} 970 380 2 0 {name=p13 sig_type=std_logic lab=VP
}
C {gnd.sym} -130 780 0 0 {name=l5 lab=0
}
C {gnd.sym} -10 780 0 0 {name=l6 lab=0
}
C {gnd.sym} 110 780 0 0 {name=l7 lab=0
}
C {lab_wire.sym} 580 540 0 0 {name=p14 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 580 500 0 0 {name=p15 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 580 520 0 0 {name=p16 sig_type=std_logic lab=d2
}
C {lab_wire.sym} -130 850 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -130 670 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 110 670 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {capa.sym} 480 810 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 480 860 0 0 {name=l11 lab=0
}
C {capa.sym} 540 810 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 540 860 0 0 {name=l14 lab=0
}
C {capa.sym} 600 810 0 0 {name=C3
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 600 860 0 0 {name=l15 lab=0
}
C {capa.sym} 660 810 0 0 {name=C4
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 660 860 0 0 {name=l16 lab=0
}
C {capa.sym} 720 810 0 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 720 860 0 0 {name=l17 lab=0
}
C {capa.sym} 780 810 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 780 860 0 0 {name=l18 lab=0
}
C {lab_wire.sym} 780 660 2 0 {name=p18 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 720 680 2 0 {name=p19 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 660 700 2 0 {name=p23 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 600 720 2 0 {name=p24 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 540 740 2 0 {name=p25 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 480 760 2 0 {name=p27 sig_type=std_logic lab=div64
}
C {gnd.sym} 110 180 0 0 {name=l13 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 1130 360 0 0 {name=x8}
C {lab_wire.sym} 1150 290 2 0 {name=p33 sig_type=std_logic lab=VP
}
C {gnd.sym} 1130 420 0 0 {name=l22 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} 1600 710 0 0 {name=x19}
C {gnd.sym} 1780 720 3 0 {name=l33 lab=0
}
C {lab_wire.sym} 1810 700 2 0 {name=p45 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 580 480 0 0 {name=p17 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 580 580 0 0 {name=p47 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 580 560 0 0 {name=p48 sig_type=std_logic lab=d4
}
C {gnd.sym} -130 960 0 0 {name=l8 lab=0
}
C {gnd.sym} -10 960 0 0 {name=l10 lab=0
}
C {gnd.sym} 110 960 0 0 {name=l34 lab=0
}
C {lab_wire.sym} 110 850 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -10 670 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -10 850 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} -10 910 0 0 {name=V8 value=1.2 savecurrent=false}
C {vsource.sym} 110 910 0 0 {name=V9 value=1.2 savecurrent=false}
C {vsource.sym} -130 730 0 0 {name=V11 value=0 savecurrent=false}
C {vsource.sym} -10 730 0 0 {name=V10 value=0 savecurrent=false}
C {vsource.sym} 110 730 0 0 {name=V12 value=0 savecurrent=false}
C {lab_wire.sym} 140 340 2 0 {name=p28 sig_type=std_logic lab=out
}
C {lab_wire.sym} 1220 360 2 0 {name=p29 sig_type=std_logic lab=out
}
C {capa.sym} 120 390 0 0 {name=C7
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 120 440 0 0 {name=l1 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate_scaled.sym} 1650 170 0 0 {name=x3}
C {lab_wire.sym} 1710 80 2 0 {name=p1 sig_type=std_logic lab=VP
}
C {gnd.sym} 1690 210 0 0 {name=l4 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in.sym} 830 -20 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NOR_2in.sym} 1190 70 0 0 {name=x5}
C {lab_wire.sym} 1000 -40 2 0 {name=p4 sig_type=std_logic lab=VP
}
C {gnd.sym} 1000 -20 0 0 {name=l12 lab=0
}
C {lab_wire.sym} 1360 50 2 0 {name=p26 sig_type=std_logic lab=VP
}
C {gnd.sym} 1360 70 0 0 {name=l19 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 1480 90 0 0 {name=x6}
C {lab_wire.sym} 1500 20 2 0 {name=p30 sig_type=std_logic lab=VP
}
C {gnd.sym} 1480 150 0 0 {name=l20 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in.sym} 840 150 0 0 {name=x7}
C {lab_wire.sym} 1010 130 2 0 {name=p31 sig_type=std_logic lab=VP
}
C {gnd.sym} 1010 150 0 0 {name=l21 lab=0
}
C {lab_wire.sym} 670 130 0 0 {name=p32 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 650 -20 0 0 {name=p34 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 650 0 0 0 {name=p35 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 650 -40 0 0 {name=p36 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 670 170 0 0 {name=p37 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 670 150 0 0 {name=p38 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 1630 130 0 0 {name=p39 sig_type=std_logic lab=clk
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate_scaled.sym} 1650 380 0 0 {name=x9}
C {gnd.sym} 1690 420 0 0 {name=l23 lab=0
}
C {lab_wire.sym} 1820 680 0 0 {name=p42 sig_type=std_logic lab=out_div
}
C {vsource.sym} -130 910 0 0 {name=V7 value=1.2 savecurrent=false}
C {lab_wire.sym} 1710 290 2 0 {name=p41 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1340 130 2 0 {name=p40 sig_type=std_logic lab=bypass
}
C {lab_wire.sym} 980 30 2 0 {name=p43 sig_type=std_logic lab=d012}
C {lab_wire.sym} 1040 160 2 0 {name=p44 sig_type=std_logic lab=d345}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/div_with_reset.sym} 310 390 0 0 {name=x1}
