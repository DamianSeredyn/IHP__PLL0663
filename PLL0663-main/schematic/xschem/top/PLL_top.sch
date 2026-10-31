v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -20 100 -20 {lab=clk_ref}
N 120 -80 120 -50 {lab=vp}
N 120 10 120 40 {lab=gd}
N 180 -20 280 -20 {lab=cref}
N 200 40 280 40 {lab=cvco}
N 200 40 200 180 {lab=cvco}
N 430 -80 430 -50 {lab=vp}
N 430 70 430 90 {lab=gd}
N 580 40 670 40 {lab=DOWN}
N 580 -20 670 -20 {lab=UP}
N 870 -110 870 -80 {lab=vp}
N 870 80 870 100 {lab=gd}
N 2950 0 2950 20 {lab=gd}
N 2510 20 2520 20 {lab=#net1}
N 2520 20 2520 40 {lab=#net1}
N 2200 40 2520 40 {lab=#net1}
N 2200 -20 2200 40 {lab=#net1}
N 2200 -20 2210 -20 {lab=#net1}
N 2510 -20 2530 -20 {lab=vp}
N 2510 0 2530 0 {lab=gd}
N 1020 90 1020 120 {lab=gd}
N 1040 90 1040 120 {lab=vp}
N 1180 180 2120 180 {lab=vco_out_buffered}
N 950 270 950 310 {lab=a0}
N 970 270 970 310 {lab=a1}
N 990 270 990 310 {lab=a2}
N 1040 270 1040 310 {lab=d0}
N 1060 270 1060 310 {lab=d1}
N 1080 270 1080 310 {lab=d2}
N 1100 270 1100 310 {lab=d3}
N 1120 270 1120 310 {lab=d4}
N 1140 270 1140 310 {lab=d5}
N 200 10 280 10 {lab=rst_lv}
N 1020 30 1060 30 {lab=rst_n}
N 880 160 910 160 {lab=rst_lv}
N 770 290 830 290 {lab=rst_n}
N 720 240 720 260 {lab=vp}
N 720 320 720 340 {lab=gd}
N 3240 -220 3240 -170 {lab=vph}
N 3240 -70 3240 -30 {lab=gd}
N 2920 -190 2920 -160 {lab=vp}
N 2970 -190 2970 -160 {lab=vph}
N 3030 -120 3140 -120 {lab=aft_LS}
N 3350 -120 3470 -120 {lab=out}
N 2510 -40 2600 -40 {lab=out_PLL_divided}
N 2670 -40 2730 -40 {lab=#net2}
N 2620 -90 2620 -70 {lab=vp}
N 2620 -10 2620 10 {lab=gd}
N 2800 -40 2860 -40 {lab=pre_LS}
N 2750 -90 2750 -70 {lab=vp}
N 2750 -10 2750 10 {lab=gd}
N 1020 -10 1160 -10 {lab=vout}
N 1160 -10 1160 50 {lab=vout}
N 670 30 670 40 {lab=DOWN}
N 670 30 720 30 {lab=DOWN}
N 670 -30 720 -30 {lab=UP}
N 670 -30 670 -20 {lab=UP}
N 200 180 910 180 {lab=cvco}
N 2120 -40 2210 -40 {lab=vco_out_buffered}
N 2120 -40 2120 180 {lab=vco_out_buffered}
N 1160 50 1390 50 {lab=vout}
N 1360 -130 1390 -130 {lab=a0}
N 1360 -110 1390 -110 {lab=a1}
N 1360 -90 1390 -90 {lab=a2}
N 1360 -70 1390 -70 {lab=d0}
N 1360 -50 1390 -50 {lab=d1}
N 1360 -30 1390 -30 {lab=d2}
N 1360 -10 1390 -10 {lab=d3}
N 1360 10 1390 10 {lab=d4}
N 1360 30 1390 30 {lab=d5}
N 1610 140 1660 140 {lab=gd}
N 1610 -250 1610 -220 {lab=vp}
N 1850 -40 2120 -40 {lab=vco_out_buffered}
N 490 230 490 260 {lab=vp}
N 490 320 490 350 {lab=gd}
N 410 290 470 290 {lab=rst}
N 550 290 700 290 {lab=rst_lv}
N 2390 260 2390 300 {lab=vp}
N 2330 340 2360 340 {lab=gd}
N 2330 340 2330 440 {lab=gd}
N 2330 440 2390 440 {lab=gd}
N 2390 340 2390 440 {lab=gd}
N 2390 440 2460 440 {lab=gd}
N 2460 340 2460 440 {lab=gd}
N 2420 340 2460 340 {lab=gd}
C {ipin.sym} 40 -20 0 0 {name=p1 lab=clk_ref}
C {lab_wire.sym} 120 -80 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 120 40 0 0 {name=p3 sig_type=std_logic lab=gd}
C {lab_wire.sym} 430 -80 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} 430 90 0 0 {name=p5 sig_type=std_logic lab=gd}
C {lab_wire.sym} 870 100 0 0 {name=p6 sig_type=std_logic lab=gd}
C {lab_wire.sym} 870 -110 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2950 20 0 0 {name=p13 sig_type=std_logic lab=gd}
C {lab_wire.sym} 640 -20 0 0 {name=p14 sig_type=std_logic lab=UP}
C {lab_wire.sym} 650 40 0 0 {name=p15 sig_type=std_logic lab=DOWN}
C {lab_wire.sym} 260 -20 0 0 {name=p18 sig_type=std_logic lab=cref}
C {lab_wire.sym} 260 40 0 0 {name=p19 sig_type=std_logic lab=cvco}
C {opin.sym} 3470 -120 0 0 {name=p20 lab=out}
C {ipin.sym} 100 -180 0 0 {name=p21 lab=gd}
C {ipin.sym} 100 -210 0 0 {name=p22 lab=vph}
C {ipin.sym} 100 -240 0 0 {name=p23 lab=vp}
C {lab_pin.sym} 2530 0 2 0 {name=p41 sig_type=std_logic lab=gd}
C {lab_pin.sym} 2530 -20 2 0 {name=p42 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1040 100 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1020 100 0 0 {name=p27 sig_type=std_logic lab=gd}
C {ipin.sym} 950 310 3 0 {name=p30 lab=a0}
C {ipin.sym} 970 310 3 0 {name=p31 lab=a1}
C {ipin.sym} 990 310 3 0 {name=p32 lab=a2}
C {ipin.sym} 1040 310 3 0 {name=p33 lab=d0}
C {ipin.sym} 1060 310 3 0 {name=p34 lab=d1}
C {ipin.sym} 1080 310 3 0 {name=p35 lab=d2}
C {ipin.sym} 1100 310 3 0 {name=p36 lab=d3}
C {ipin.sym} 1120 310 3 0 {name=p37 lab=d4}
C {ipin.sym} 1140 310 3 0 {name=p38 lab=d5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/buffer_hv.sym} 210 -20 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_cell_2.sym} 430 10 0 0 {name=xPFD}
C {ipin.sym} 410 290 0 0 {name=p39 lab=rst}
C {lab_wire.sym} 260 10 0 0 {name=p40 sig_type=std_logic lab=rst_lv}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 3240 -120 0 0 {name=xBUF}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/Divider_top.sym} 1030 180 0 0 {name=xDiv}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} 2360 -10 0 0 {name=xOutFlipFlop}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/level_shifter.sym} 3010 -100 0 0 {name=xLS}
C {lab_wire.sym} 880 160 0 0 {name=p44 sig_type=std_logic lab=rst_lv}
C {lab_wire.sym} 830 290 0 0 {name=p46 sig_type=std_logic lab=rst_n}
C {lab_wire.sym} 1060 30 0 0 {name=p43 sig_type=std_logic lab=rst_n}
C {lab_wire.sym} 720 240 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_wire.sym} 720 340 0 0 {name=p48 sig_type=std_logic lab=gd}
C {lab_pin.sym} 3240 -30 2 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_pin.sym} 2920 -190 2 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_pin.sym} 2970 -190 2 0 {name=p12 sig_type=std_logic lab=vph}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x2.sym} 2630 -40 0 0 {name=x1}
C {lab_wire.sym} 2620 -90 0 0 {name=p50 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2620 10 0 0 {name=p51 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4_top.sym} 2750 -40 0 0 {name=x3}
C {lab_wire.sym} 2750 -90 0 0 {name=p24 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2750 10 0 0 {name=p49 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1970 180 0 0 {name=p52 sig_type=std_logic lab=vco_out_buffered}
C {lab_wire.sym} 3240 -220 0 0 {name=p10 sig_type=std_logic lab=vph}
C {lab_wire.sym} 2580 -40 0 0 {name=p57 sig_type=std_logic lab=out_PLL_divided}
C {lab_wire.sym} 2840 -40 0 0 {name=p58 sig_type=std_logic lab=pre_LS}
C {lab_wire.sym} 3100 -120 0 0 {name=p59 sig_type=std_logic lab=aft_LS}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/charge_pump_cell.sym} 870 0 0 0 {name=xCP}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 720 290 0 0 {name=x9}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_top.sym} 1530 -40 0 0 {name=xVCO}
C {lab_wire.sym} 1660 140 0 0 {name=p25 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1610 -250 0 0 {name=p28 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 1360 -130 0 0 {name=p60 sig_type=std_logic lab=a0
}
C {lab_wire.sym} 1360 -110 0 0 {name=p61 sig_type=std_logic lab=a1
}
C {lab_wire.sym} 1360 -90 0 0 {name=p62 sig_type=std_logic lab=a2}
C {lab_wire.sym} 1360 -70 0 0 {name=p63 sig_type=std_logic lab=d0}
C {lab_wire.sym} 1360 -50 0 0 {name=p64 sig_type=std_logic lab=d1}
C {lab_wire.sym} 1360 -30 0 0 {name=p65 sig_type=std_logic lab=d2}
C {lab_wire.sym} 1360 -10 0 0 {name=p66 sig_type=std_logic lab=d3}
C {lab_wire.sym} 1360 10 0 0 {name=p67 sig_type=std_logic lab=d4}
C {lab_wire.sym} 1360 30 0 0 {name=p68 sig_type=std_logic lab=d5}
C {lab_wire.sym} 490 230 0 0 {name=p29 sig_type=std_logic lab=vp}
C {lab_wire.sym} 490 350 0 0 {name=p53 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/buffer_hv.sym} 580 290 0 0 {name=x4}
C {lab_wire.sym} 620 290 0 0 {name=p54 sig_type=std_logic lab=rst_lv}
C {opin.sym} 1160 -10 0 0 {name=p8 lab=vout}
C {opin.sym} 670 -30 3 0 {name=p16 lab=UP}
C {opin.sym} 670 40 1 0 {name=p17 lab=DOWN}
C {opin.sym} 200 180 2 0 {name=p45 lab=cvco}
C {opin.sym} 2040 180 1 0 {name=p55 lab=vco_out_buffered}
C {opin.sym} 2580 -40 1 0 {name=p56 lab=out_PLL_divided}
C {opin.sym} 220 -20 3 0 {name=p69 lab=cref}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 2390 320 1 0 {name=M1
l=5u
w=240u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 2330 440 0 0 {name=p70 sig_type=std_logic lab=gd}
C {lab_wire.sym} 2390 260 0 0 {name=p71 sig_type=std_logic lab=vp}
