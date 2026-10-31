v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -190 240 -170 240 {lab=clk}
N 130 380 280 380 {lab=r_div64}
N 130 360 280 360 {lab=r_div32}
N 130 260 160 260 {lab=VP}
N 130 240 200 240 {lab=gd}
N 130 340 280 340 {lab=r_div16}
N 130 320 280 320 {lab=r_div8}
N 130 300 280 300 {lab=r_div4}
N 130 280 280 280 {lab=r_div2}
N 580 320 610 320 {lab=gd}
N 580 300 640 300 {lab=VP}
N 250 400 280 400 {lab=d0}
N 250 420 280 420 {lab=d1}
N 250 440 280 440 {lab=d2}
N 250 460 280 460 {lab=d3}
N 800 210 820 210 {lab=VP}
N 800 210 800 250 {lab=VP}
N 800 310 800 340 {lab=gd}
N 1090 600 1120 600 {lab=#net1}
N 1420 660 1430 660 {lab=#net2}
N 1430 660 1430 690 {lab=#net2}
N 1110 690 1430 690 {lab=#net2}
N 1110 620 1110 690 {lab=#net2}
N 1110 620 1120 620 {lab=#net2}
N 1420 640 1450 640 {lab=gd}
N 1420 620 1480 620 {lab=VP}
N 250 480 280 480 {lab=d4}
N 250 500 280 500 {lab=d5}
N 850 280 1300 280 {lab=out}
N 580 280 780 280 {lab=out_pre_buff}
N 1360 0 1380 0 {lab=VP}
N 1360 0 1360 40 {lab=VP}
N 1360 100 1360 130 {lab=gd}
N 650 -120 670 -120 {lab=VP}
N 650 -100 670 -100 {lab=gd}
N 1010 -30 1030 -30 {lab=VP}
N 1010 -10 1030 -10 {lab=gd}
N 1150 -60 1170 -60 {lab=VP}
N 1150 -60 1150 -20 {lab=VP}
N 1150 40 1150 70 {lab=gd}
N 1250 -10 1320 -10 {lab=#net3}
N 1320 -10 1320 40 {lab=#net3}
N 650 -80 650 -30 {lab=d012}
N 650 -30 710 -30 {lab=d012}
N 660 50 680 50 {lab=VP}
N 660 70 680 70 {lab=gd}
N 660 90 710 90 {lab=d345}
N 710 -10 710 90 {lab=d345}
N 320 -120 350 -120 {lab=d0}
N 320 -100 350 -100 {lab=d1}
N 320 -80 350 -80 {lab=d2}
N 340 50 360 50 {lab=d3}
N 340 70 360 70 {lab=d4}
N 340 90 360 90 {lab=d5}
N 1300 50 1300 70 {lab=clk}
N 1360 210 1360 250 {lab=VP}
N 1360 310 1360 340 {lab=gd}
N 1320 310 1320 350 {lab=#net3}
N 1250 350 1320 350 {lab=#net3}
N 1320 140 1320 250 {lab=bypass}
N 1010 10 1010 140 {lab=bypass}
N 1360 210 1380 210 {lab=VP}
N 1320 100 1320 140 {lab=bypass}
N 1420 600 1490 600 {lab=out_div}
N 1380 280 1430 280 {lab=#net1}
N 1380 70 1430 70 {lab=#net1}
N 1430 70 1430 280 {lab=#net1}
N 1430 280 1430 480 {lab=#net1}
N 1090 480 1430 480 {lab=#net1}
N 1090 480 1090 600 {lab=#net1}
N 1200 10 1250 10 {lab=#net3}
N 1250 10 1250 350 {lab=#net3}
N 1250 -10 1250 10 {lab=#net3}
N 1010 10 1130 10 {lab=bypass}
N 1010 140 1320 140 {lab=bypass}
N -10 -90 10 -90 {lab=gd}
N -10 -70 10 -70 {lab=VP}
N -10 -50 10 -50 {lab=clk}
N -10 0 10 0 {lab=d0}
N -10 20 10 20 {lab=d1}
N -10 40 10 40 {lab=d2}
N -10 60 10 60 {lab=d3}
N -10 80 10 80 {lab=d4}
N -10 100 10 100 {lab=d5}
N -10 130 10 130 {lab=out_div}
N 1020 570 1040 570 {lab=VP}
N 1020 570 1020 610 {lab=VP}
N 1020 670 1020 700 {lab=gd}
N 1070 640 1120 640 {lab=#net4}
N -10 -20 10 -20 {lab=reset}
N 970 640 1000 640 {lab=reset}
N -220 260 -170 260 {lab=out}
C {lab_wire.sym} -190 240 0 0 {name=p3 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 160 260 2 0 {name=p5 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 150 280 2 0 {name=p6 sig_type=std_logic lab=r_div2
}
C {lab_wire.sym} 150 300 2 0 {name=p7 sig_type=std_logic lab=r_div4
}
C {lab_wire.sym} 150 320 2 0 {name=p9 sig_type=std_logic lab=r_div8
}
C {lab_wire.sym} 150 340 2 0 {name=p10 sig_type=std_logic lab=r_div16
}
C {lab_wire.sym} 150 360 2 0 {name=p11 sig_type=std_logic lab=r_div32
}
C {lab_wire.sym} 150 380 2 0 {name=p12 sig_type=std_logic lab=r_div64
}
C {lab_wire.sym} 640 300 2 0 {name=p13 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 250 460 0 0 {name=p14 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 250 420 0 0 {name=p15 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 250 440 0 0 {name=p16 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 820 210 2 0 {name=p33 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1480 620 2 0 {name=p45 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 250 400 0 0 {name=p17 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 250 500 0 0 {name=p47 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 250 480 0 0 {name=p48 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 890 280 2 0 {name=p29 sig_type=std_logic lab=out
}
C {lab_wire.sym} 1380 0 2 0 {name=p1 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 670 -120 2 0 {name=p4 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1030 -30 2 0 {name=p26 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1170 -60 2 0 {name=p30 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 680 50 2 0 {name=p31 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 340 50 0 0 {name=p32 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 320 -100 0 0 {name=p34 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 320 -80 0 0 {name=p35 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 320 -120 0 0 {name=p36 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 340 90 0 0 {name=p37 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 340 70 0 0 {name=p38 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 1300 50 0 0 {name=p39 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 1490 600 0 0 {name=p42 sig_type=std_logic lab=out_div
}
C {lab_wire.sym} 1380 210 2 0 {name=p41 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1010 50 2 0 {name=p40 sig_type=std_logic lab=bypass
}
C {lab_wire.sym} 650 -50 2 0 {name=p43 sig_type=std_logic lab=d012}
C {lab_wire.sym} 710 80 2 0 {name=p44 sig_type=std_logic lab=d345}
C {iopin.sym} -10 -90 2 0 {name=p46 lab=gd}
C {ipin.sym} -10 -50 0 0 {name=p52 lab=clk}
C {lab_wire.sym} 10 -90 2 0 {name=p53 sig_type=std_logic lab=gd}
C {iopin.sym} -10 -70 2 0 {name=p54 lab=VP}
C {lab_wire.sym} 10 -70 2 0 {name=p55 sig_type=std_logic lab=VP}
C {lab_wire.sym} 10 -50 2 0 {name=p62 sig_type=std_logic lab=clk}
C {lab_wire.sym} 670 -100 2 0 {name=p8 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1030 -10 2 0 {name=p71 sig_type=std_logic lab=gd}
C {lab_wire.sym} 680 70 2 0 {name=p72 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1150 70 2 0 {name=p73 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1360 130 2 0 {name=p74 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1360 340 2 0 {name=p75 sig_type=std_logic lab=gd}
C {lab_wire.sym} 800 340 2 0 {name=p76 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1450 640 2 0 {name=p77 sig_type=std_logic lab=gd}
C {lab_wire.sym} 610 320 2 0 {name=p78 sig_type=std_logic lab=gd}
C {lab_wire.sym} 200 240 2 0 {name=p79 sig_type=std_logic lab=gd}
C {ipin.sym} -10 0 0 0 {name=p2 lab=d0}
C {lab_wire.sym} 10 0 2 0 {name=p56 sig_type=std_logic lab=d0}
C {ipin.sym} -10 20 0 0 {name=p57 lab=d1}
C {lab_wire.sym} 10 20 2 0 {name=p58 sig_type=std_logic lab=d1}
C {ipin.sym} -10 40 0 0 {name=p59 lab=d2}
C {lab_wire.sym} 10 40 2 0 {name=p60 sig_type=std_logic lab=d2}
C {ipin.sym} -10 60 0 0 {name=p61 lab=d3}
C {lab_wire.sym} 10 60 2 0 {name=p63 sig_type=std_logic lab=d3}
C {ipin.sym} -10 80 0 0 {name=p64 lab=d4}
C {lab_wire.sym} 10 80 2 0 {name=p65 sig_type=std_logic lab=d4}
C {ipin.sym} -10 100 0 0 {name=p66 lab=d5}
C {lab_wire.sym} 10 100 2 0 {name=p67 sig_type=std_logic lab=d5}
C {opin.sym} -10 130 0 1 {name=p68 lab=out_div}
C {lab_pin.sym} 10 130 2 0 {name=p69 sig_type=std_logic lab=out_div}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in.sym} 500 -100 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in.sym} 510 70 0 0 {name=x7}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NOR_2in.sym} 860 -10 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/div_with_reset.sym} -20 310 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/count_data_check.sym} 430 390 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} 1270 630 0 0 {name=x11}
C {lab_wire.sym} 1040 570 2 0 {name=p18 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1020 700 2 0 {name=p19 sig_type=std_logic lab=gd}
C {ipin.sym} -10 -20 0 0 {name=p20 lab=reset}
C {lab_wire.sym} 10 -20 2 0 {name=p21 sig_type=std_logic lab=reset}
C {lab_wire.sym} 970 640 0 0 {name=p22 sig_type=std_logic lab=reset}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x8.sym} 810 280 0 0 {name=x13}
C {lab_wire.sym} -220 260 2 0 {name=p23 sig_type=std_logic lab=out
}
C {lab_wire.sym} 700 280 2 0 {name=p24 sig_type=std_logic lab=out_pre_buff
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate.sym} 1320 90 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate.sym} 1320 300 0 0 {name=x8}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 1150 10 0 0 {name=x6}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 1020 640 0 0 {name=x9}
