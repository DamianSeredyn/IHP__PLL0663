v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -540 -360 -520 -360 {lab=gd}
N -540 -340 -520 -340 {lab=VP}
N -540 -290 -520 -290 {lab=c1}
N -540 -270 -520 -270 {lab=c2}
N -540 -240 -520 -240 {lab=f0}
N -540 -220 -520 -220 {lab=f1}
N -540 -310 -520 -310 {lab=c0}
N -540 60 -520 60 {lab=VCO2_11_sel}
N -540 80 -520 80 {lab=VCO2_5_sel}
N -540 100 -520 100 {lab=VCO3_11_sel}
N -540 120 -520 120 {lab=VCO3_5_sel}
N -540 160 -520 160 {lab=VCO4_5_sel}
N -540 140 -520 140 {lab=VCO4_11_sel}
N -540 -200 -520 -200 {lab=f2}
N -540 -180 -520 -180 {lab=f3}
N -540 -160 -520 -160 {lab=f4}
N -540 -140 -520 -140 {lab=f5}
N 50 -190 70 -190 {lab=gd}
N 50 -170 70 -170 {lab=VP}
N 720 -190 740 -190 {lab=gd}
N 720 -170 740 -170 {lab=VP}
N -270 -170 -250 -170 {lab=c1}
N -270 -150 -250 -150 {lab=c2}
N -270 -130 -250 -130 {lab=f0}
N -270 -110 -250 -110 {lab=f1}
N -270 -190 -250 -190 {lab=c0}
N -270 -90 -250 -90 {lab=f2}
N -270 -70 -250 -70 {lab=f3}
N -270 -50 -250 -50 {lab=f4}
N -270 -30 -250 -30 {lab=f5}
N -540 -100 -520 -100 {lab=VCO_in}
N -540 -80 -520 -80 {lab=VCO2_in}
N -540 -60 -520 -60 {lab=VCO3_in}
N -540 -40 -520 -40 {lab=VCO4_in}
N -540 -20 -520 -20 {lab=VCO5_in}
N -540 220 -520 220 {lab=out}
N 720 -150 740 -150 {lab=out}
N 400 -190 420 -190 {lab=VCO_in}
N 400 -170 420 -170 {lab=VCO2_in}
N 400 -150 420 -150 {lab=VCO3_in}
N 400 -130 420 -130 {lab=VCO4_in}
N 400 -110 420 -110 {lab=VCO5_in}
N 50 -130 70 -130 {lab=VCO2_11_sel}
N 50 -110 70 -110 {lab=VCO2_5_sel}
N 50 -150 70 -150 {lab=VCO_sel}
N 50 -90 70 -90 {lab=VCO3_11_sel}
N 50 -70 70 -70 {lab=VCO3_5_sel}
N 50 -30 70 -30 {lab=VCO4_5_sel}
N 50 -50 70 -50 {lab=VCO4_11_sel}
N 400 -10 420 -10 {lab=VCO5_sel}
N 50 120 70 120 {lab=gd}
N 50 100 70 100 {lab=VP}
N 120 170 120 180 {lab=gd}
N 120 100 120 110 {lab=VP}
N 170 140 180 140 {lab=VCO2_sel}
N -270 100 -250 100 {lab=VCO2_11_sel}
N -270 120 -250 120 {lab=VCO2_5_sel}
N 50 240 70 240 {lab=gd}
N 50 220 70 220 {lab=VP}
N 120 290 120 300 {lab=gd}
N 120 220 120 230 {lab=VP}
N 170 260 180 260 {lab=VCO3_sel}
N 50 360 70 360 {lab=gd}
N 50 340 70 340 {lab=VP}
N 120 410 120 420 {lab=gd}
N 120 340 120 350 {lab=VP}
N 170 380 180 380 {lab=VCO4_sel}
N -270 220 -250 220 {lab=VCO3_11_sel}
N -270 240 -250 240 {lab=VCO3_5_sel}
N -270 340 -250 340 {lab=VCO4_11_sel}
N -270 360 -250 360 {lab=VCO4_5_sel}
N 400 -90 420 -90 {lab=VCO_sel}
N 400 -70 420 -70 {lab=VCO2_sel}
N 400 -50 420 -50 {lab=VCO3_sel}
N 400 -30 420 -30 {lab=VCO4_sel}
N 50 140 100 140 {lab=#net1}
N 50 260 100 260 {lab=#net2}
N 50 380 100 380 {lab=#net3}
N -540 300 -520 300 {lab=VCO_sel}
N -540 320 -520 320 {lab=VCO2_sel}
N -540 340 -520 340 {lab=VCO3_sel}
N -540 360 -520 360 {lab=VCO4_sel}
N 50 -10 70 -10 {lab=VCO5_sel}
N -540 380 -520 380 {lab=VCO5_sel}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/VCO_MUX.sym} 570 -100 0 0 {name=x2}
C {iopin.sym} -540 -360 2 0 {name=p46 lab=gd}
C {lab_wire.sym} -520 -360 2 0 {name=p53 sig_type=std_logic lab=gd}
C {iopin.sym} -540 -340 2 0 {name=p54 lab=VP}
C {ipin.sym} -540 -290 0 0 {name=p2 lab=c1}
C {lab_wire.sym} -520 -290 2 0 {name=p56 sig_type=std_logic lab=c1}
C {ipin.sym} -540 -270 0 0 {name=p57 lab=c2}
C {lab_wire.sym} -520 -270 2 0 {name=p58 sig_type=std_logic lab=c2}
C {ipin.sym} -540 -240 0 0 {name=p59 lab=f0}
C {lab_wire.sym} -520 -240 2 0 {name=p60 sig_type=std_logic lab=f0}
C {ipin.sym} -540 -220 0 0 {name=p61 lab=f1}
C {lab_wire.sym} -520 -220 2 0 {name=p63 sig_type=std_logic lab=f1}
C {ipin.sym} -540 -310 0 0 {name=p20 lab=c0}
C {lab_wire.sym} -520 -310 2 0 {name=p21 sig_type=std_logic lab=c0}
C {lab_wire.sym} -520 -340 2 0 {name=p1 sig_type=std_logic lab=VP}
C {opin.sym} -540 60 0 1 {name=p6 lab=VCO2_11_sel}
C {lab_wire.sym} -520 60 2 0 {name=p7 sig_type=std_logic lab=VCO2_11_sel}
C {opin.sym} -540 80 0 1 {name=p8 lab=VCO2_5_sel}
C {lab_wire.sym} -520 80 2 0 {name=p9 sig_type=std_logic lab=VCO2_5_sel}
C {opin.sym} -540 100 0 1 {name=p10 lab=VCO3_11_sel}
C {lab_wire.sym} -520 100 2 0 {name=p11 sig_type=std_logic lab=VCO3_11_sel}
C {opin.sym} -540 120 0 1 {name=p12 lab=VCO3_5_sel}
C {lab_wire.sym} -520 120 2 0 {name=p13 sig_type=std_logic lab=VCO3_5_sel}
C {opin.sym} -540 140 0 1 {name=p3 lab=VCO4_11_sel}
C {lab_wire.sym} -520 140 2 0 {name=p4 sig_type=std_logic lab=VCO4_11_sel}
C {opin.sym} -540 160 0 1 {name=p5 lab=VCO4_5_sel}
C {lab_wire.sym} -520 160 2 0 {name=p16 sig_type=std_logic lab=VCO4_5_sel}
C {ipin.sym} -540 -200 0 0 {name=p19 lab=f2}
C {lab_wire.sym} -520 -200 2 0 {name=p22 sig_type=std_logic lab=f2}
C {ipin.sym} -540 -180 0 0 {name=p23 lab=f3}
C {lab_wire.sym} -520 -180 2 0 {name=p24 sig_type=std_logic lab=f3}
C {ipin.sym} -540 -160 0 0 {name=p25 lab=f4}
C {lab_wire.sym} -520 -160 2 0 {name=p26 sig_type=std_logic lab=f4}
C {ipin.sym} -540 -140 0 0 {name=p27 lab=f5}
C {lab_wire.sym} -520 -140 2 0 {name=p28 sig_type=std_logic lab=f5}
C {lab_wire.sym} 70 -190 2 0 {name=p29 sig_type=std_logic lab=gd}
C {lab_wire.sym} 70 -170 2 0 {name=p30 sig_type=std_logic lab=VP}
C {lab_wire.sym} 740 -190 2 0 {name=p31 sig_type=std_logic lab=gd}
C {lab_wire.sym} 740 -170 2 0 {name=p32 sig_type=std_logic lab=VP}
C {lab_wire.sym} -270 -170 0 0 {name=p33 sig_type=std_logic lab=c1}
C {lab_wire.sym} -270 -150 0 0 {name=p34 sig_type=std_logic lab=c2}
C {lab_wire.sym} -270 -130 0 0 {name=p35 sig_type=std_logic lab=f0}
C {lab_wire.sym} -270 -110 0 0 {name=p36 sig_type=std_logic lab=f1}
C {lab_wire.sym} -270 -190 0 0 {name=p37 sig_type=std_logic lab=c0}
C {lab_wire.sym} -270 -90 0 0 {name=p38 sig_type=std_logic lab=f2}
C {lab_wire.sym} -270 -70 0 0 {name=p39 sig_type=std_logic lab=f3}
C {lab_wire.sym} -270 -50 0 0 {name=p40 sig_type=std_logic lab=f4}
C {lab_wire.sym} -270 -30 0 0 {name=p41 sig_type=std_logic lab=f5}
C {ipin.sym} -540 -100 0 0 {name=p42 lab=VCO_in}
C {lab_wire.sym} -520 -100 2 0 {name=p43 sig_type=std_logic lab=VCO_in}
C {ipin.sym} -540 -80 0 0 {name=p44 lab=VCO2_in}
C {lab_wire.sym} -520 -80 2 0 {name=p45 sig_type=std_logic lab=VCO2_in}
C {ipin.sym} -540 -60 0 0 {name=p47 lab=VCO3_in}
C {lab_wire.sym} -520 -60 2 0 {name=p48 sig_type=std_logic lab=VCO3_in}
C {ipin.sym} -540 -40 0 0 {name=p49 lab=VCO4_in}
C {lab_wire.sym} -520 -40 2 0 {name=p50 sig_type=std_logic lab=VCO4_in}
C {ipin.sym} -540 -20 0 0 {name=p51 lab=VCO5_in}
C {lab_wire.sym} -520 -20 2 0 {name=p52 sig_type=std_logic lab=VCO5_in}
C {opin.sym} -540 220 0 1 {name=p55 lab=out}
C {lab_wire.sym} -520 220 2 0 {name=p62 sig_type=std_logic lab=out}
C {lab_wire.sym} 740 -150 2 0 {name=p64 sig_type=std_logic lab=out}
C {lab_wire.sym} 400 -190 2 1 {name=p65 sig_type=std_logic lab=VCO_in}
C {lab_wire.sym} 400 -170 2 1 {name=p66 sig_type=std_logic lab=VCO2_in}
C {lab_wire.sym} 400 -150 2 1 {name=p67 sig_type=std_logic lab=VCO3_in}
C {lab_wire.sym} 400 -130 2 1 {name=p68 sig_type=std_logic lab=VCO4_in}
C {lab_wire.sym} 400 -110 2 1 {name=p69 sig_type=std_logic lab=VCO5_in}
C {lab_wire.sym} 70 -130 2 0 {name=p70 sig_type=std_logic lab=VCO2_11_sel}
C {lab_wire.sym} 70 -110 2 0 {name=p71 sig_type=std_logic lab=VCO2_5_sel}
C {lab_wire.sym} 70 -150 2 0 {name=p72 sig_type=std_logic lab=VCO_sel}
C {lab_wire.sym} 70 -90 2 0 {name=p73 sig_type=std_logic lab=VCO3_11_sel}
C {lab_wire.sym} 70 -70 2 0 {name=p74 sig_type=std_logic lab=VCO3_5_sel}
C {lab_wire.sym} 70 -50 2 0 {name=p75 sig_type=std_logic lab=VCO4_11_sel}
C {lab_wire.sym} 70 -30 2 0 {name=p76 sig_type=std_logic lab=VCO4_5_sel}
C {lab_wire.sym} 70 -10 2 0 {name=p77 sig_type=std_logic lab=VCO5_sel}
C {lab_wire.sym} 400 -10 2 1 {name=p78 sig_type=std_logic lab=VCO5_sel}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NOR_2in.sym} -100 120 0 0 {name=x4}
C {lab_wire.sym} 70 100 2 0 {name=p79 sig_type=std_logic lab=VP}
C {lab_wire.sym} 70 120 2 0 {name=p80 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 120 140 0 0 {name=x5}
C {lab_wire.sym} 120 100 0 1 {name=p81 sig_type=std_logic lab=VP}
C {lab_wire.sym} 120 180 2 0 {name=p82 sig_type=std_logic lab=gd}
C {lab_wire.sym} 70 220 2 0 {name=p83 sig_type=std_logic lab=VP}
C {lab_wire.sym} 70 240 2 0 {name=p84 sig_type=std_logic lab=gd}
C {lab_wire.sym} 120 220 0 1 {name=p85 sig_type=std_logic lab=VP}
C {lab_wire.sym} 120 300 2 0 {name=p86 sig_type=std_logic lab=gd}
C {lab_wire.sym} 70 340 2 0 {name=p87 sig_type=std_logic lab=VP}
C {lab_wire.sym} 70 360 2 0 {name=p88 sig_type=std_logic lab=gd}
C {lab_wire.sym} 120 340 0 1 {name=p89 sig_type=std_logic lab=VP}
C {lab_wire.sym} 120 420 2 0 {name=p90 sig_type=std_logic lab=gd}
C {lab_wire.sym} 400 -90 2 1 {name=p91 sig_type=std_logic lab=VCO_sel}
C {lab_wire.sym} 400 -70 2 1 {name=p92 sig_type=std_logic lab=VCO2_sel}
C {lab_wire.sym} 400 -50 2 1 {name=p93 sig_type=std_logic lab=VCO3_sel}
C {lab_wire.sym} 400 -30 2 1 {name=p94 sig_type=std_logic lab=VCO4_sel}
C {lab_wire.sym} 180 140 0 1 {name=p96 sig_type=std_logic lab=VCO2_sel}
C {lab_wire.sym} 180 260 0 1 {name=p97 sig_type=std_logic lab=VCO3_sel}
C {lab_wire.sym} 180 380 0 1 {name=p98 sig_type=std_logic lab=VCO4_sel}
C {lab_wire.sym} -270 100 2 1 {name=p95 sig_type=std_logic lab=VCO2_11_sel}
C {lab_wire.sym} -270 120 2 1 {name=p99 sig_type=std_logic lab=VCO2_5_sel}
C {lab_wire.sym} -270 220 2 1 {name=p100 sig_type=std_logic lab=VCO3_11_sel}
C {lab_wire.sym} -270 240 2 1 {name=p101 sig_type=std_logic lab=VCO3_5_sel}
C {lab_wire.sym} -270 340 2 1 {name=p102 sig_type=std_logic lab=VCO4_11_sel}
C {lab_wire.sym} -270 360 2 1 {name=p103 sig_type=std_logic lab=VCO4_5_sel}
C {opin.sym} -540 300 0 1 {name=p14 lab=VCO_sel}
C {lab_wire.sym} -520 300 2 0 {name=p15 sig_type=std_logic lab=VCO_sel}
C {opin.sym} -540 320 0 1 {name=p17 lab=VCO2_sel}
C {lab_wire.sym} -520 320 2 0 {name=p18 sig_type=std_logic lab=VCO2_sel}
C {opin.sym} -540 340 0 1 {name=p104 lab=VCO3_sel}
C {lab_wire.sym} -520 340 2 0 {name=p105 sig_type=std_logic lab=VCO3_sel}
C {opin.sym} -540 360 0 1 {name=p106 lab=VCO4_sel}
C {lab_wire.sym} -520 360 2 0 {name=p107 sig_type=std_logic lab=VCO4_sel}
C {opin.sym} -540 380 0 1 {name=p109 lab=VCO5_sel}
C {lab_wire.sym} -520 380 2 0 {name=p108 sig_type=std_logic lab=VCO5_sel}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NOR_2in.sym} -100 240 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NOR_2in.sym} -100 360 0 0 {name=x6}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 120 260 0 0 {name=x7}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 120 380 0 0 {name=x8}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/VCO_decoder_cells.sym} -100 -100 0 0 {name=x9}
