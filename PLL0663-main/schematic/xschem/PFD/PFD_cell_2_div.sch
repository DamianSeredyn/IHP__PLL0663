v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -340 -290 -340 {lab=gnd}
N -320 -310 -290 -310 {lab=vp}
N 920 310 930 310 {lab=UP}
N -590 -30 -540 -30 {lab=gnd}
N 540 70 540 310 {lab=pre_up}
N 540 -170 540 -70 {lab=pre_down}
N 540 60 550 60 {lab=pre_up}
N 570 -140 570 -110 {lab=gnd}
N 180 -70 240 -70 {lab=vp}
N 180 -50 240 -50 {lab=gnd}
N 540 -50 540 60 {lab=pre_up}
N -770 -170 -770 -140 {lab=vp}
N -770 -80 -770 -60 {lab=gnd}
N -480 -90 -480 -60 {lab=vp}
N -480 0 -480 30 {lab=gnd}
N -720 -110 -670 -110 {lab=reset_n}
N -500 -90 -500 -60 {lab=reset_n}
N -500 0 -500 30 {lab=rst}
N 950 -90 1000 -90 {lab=gnd}
N 950 -100 950 -90 {lab=gnd}
N 1000 -130 1000 -90 {lab=gnd}
N 950 -130 1000 -130 {lab=gnd}
N 870 -130 910 -130 {lab=rst}
N 950 -170 950 -160 {lab=DOWN}
N 950 -170 980 -170 {lab=DOWN}
N 950 -90 950 -80 {lab=gnd}
N 920 440 970 440 {lab=gnd}
N 920 430 920 440 {lab=gnd}
N 970 400 970 440 {lab=gnd}
N 920 400 970 400 {lab=gnd}
N 840 400 880 400 {lab=rst}
N 920 440 920 450 {lab=gnd}
N 920 310 920 370 {lab=UP}
N -340 -30 -300 -30 {lab=flip_flop_reset}
N -280 -90 -280 -60 {lab=vp}
N -280 0 -280 30 {lab=gnd}
N -260 -90 -260 -60 {lab=rst}
N -260 0 -260 30 {lab=reset_n}
N -860 -110 -790 -110 {lab=rst}
N 570 -230 570 -200 {lab=vp}
N 540 -170 550 -170 {lab=pre_down}
N 690 -140 690 -110 {lab=gnd}
N 690 -230 690 -200 {lab=vp}
N 560 340 560 370 {lab=gnd}
N 560 250 560 280 {lab=vp}
N 660 340 660 370 {lab=gnd}
N 660 250 660 280 {lab=vp}
N 610 310 640 310 {lab=#net1}
N 620 -170 670 -170 {lab=#net2}
N 210 -170 540 -170 {lab=pre_down}
N -320 80 -280 80 {lab=cVco}
N 90 70 540 70 {lab=pre_up}
N 540 60 540 70 {lab=pre_up}
N 20 140 120 140 {lab=#net3}
N 210 -230 210 -170 {lab=pre_down}
N 20 -230 210 -230 {lab=pre_down}
N 20 -170 120 -170 {lab=#net4}
N -340 -210 -280 -210 {lab=vp}
N -290 -230 -280 -230 {lab=cRef}
N -340 -190 -340 -30 {lab=flip_flop_reset}
N -460 -30 -340 -30 {lab=flip_flop_reset}
N 20 80 90 80 {lab=pre_up}
N 90 70 90 80 {lab=pre_up}
N 740 -170 950 -170 {lab=DOWN}
N 710 310 920 310 {lab=UP}
N -390 30 -390 50 {lab=gnd}
N -220 -30 -40 -30 {lab=#net5}
N 20 -190 100 -190 {lab=gnd}
N 20 -210 100 -210 {lab=vp}
N -340 -190 -280 -190 {lab=flip_flop_reset}
N -340 120 -280 120 {lab=flip_flop_reset}
N -340 -30 -340 120 {lab=flip_flop_reset}
N -310 100 -280 100 {lab=vp}
N 20 100 90 100 {lab=vp}
N 20 120 90 120 {lab=gnd}
N 20 10 20 30 {lab=gnd}
N 20 -90 20 -70 {lab=vp}
N 60 -30 240 -30 {lab=post_nand}
C {iopin.sym} -290 -340 0 0 {name=p1 lab=gnd}
C {iopin.sym} -290 -310 0 0 {name=p2 lab=vp
}
C {ipin.sym} -290 -230 0 0 {name=p5 lab=cRef}
C {ipin.sym} -320 80 0 0 {name=p6 lab=cVco}
C {lab_wire.sym} 570 -110 0 0 {name=p16 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 570 -230 0 0 {name=p17 sig_type=std_logic lab=vp}
C {lab_wire.sym} 200 -70 0 0 {name=p20 sig_type=std_logic lab=vp}
C {lab_wire.sym} 200 -50 0 0 {name=p21 sig_type=std_logic lab=gnd}
C {ipin.sym} -860 -110 0 0 {name=p24 lab=rst}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} -770 -110 0 0 {name=x9}
C {lab_wire.sym} -480 -90 0 0 {name=p25 sig_type=std_logic lab=vp}
C {lab_wire.sym} -480 30 0 1 {name=p26 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -770 -60 0 0 {name=p27 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -770 -170 0 0 {name=p28 sig_type=std_logic lab=vp}
C {lab_wire.sym} -680 -110 0 0 {name=p29 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} 370 -170 0 1 {name=p32 sig_type=std_logic lab=pre_down}
C {lab_wire.sym} 350 70 0 0 {name=p33 sig_type=std_logic lab=pre_up}
C {lab_wire.sym} 230 -30 0 0 {name=p34 sig_type=std_logic lab=post_nand}
C {lab_wire.sym} -360 -30 0 0 {name=p35 sig_type=std_logic lab=flip_flop_reset}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 930 -130 0 0 {name=M4
l=0.15u
w=0.45u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 950 -80 0 0 {name=p52 sig_type=std_logic lab=gnd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 900 400 0 0 {name=M5
l=0.15u
w=0.45u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 920 450 0 0 {name=p53 sig_type=std_logic lab=gnd}
C {opin.sym} 930 310 0 0 {name=p55 lab=UP
}
C {opin.sym} 980 -170 0 0 {name=p3 lab=DOWN
}
C {lab_wire.sym} -280 -90 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} -280 30 0 0 {name=p22 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -500 -90 0 0 {name=p30 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} -500 30 0 1 {name=p31 sig_type=std_logic lab=rst}
C {lab_wire.sym} -260 -90 0 1 {name=p36 sig_type=std_logic lab=rst}
C {lab_wire.sym} -260 30 0 1 {name=p23 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} 890 -130 0 0 {name=p42 sig_type=std_logic lab=rst}
C {lab_wire.sym} 850 400 0 0 {name=p43 sig_type=std_logic lab=rst}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 690 -170 0 0 {name=x4}
C {lab_wire.sym} 690 -110 0 0 {name=p44 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 690 -230 0 0 {name=p45 sig_type=std_logic lab=vp}
C {lab_wire.sym} 560 370 0 0 {name=p18 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 560 250 0 0 {name=p19 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 660 310 0 0 {name=x6}
C {lab_wire.sym} 660 370 0 0 {name=p46 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 660 250 0 0 {name=p49 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 570 -170 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 560 310 0 0 {name=x5}
C {PFD_passgate.sym} -500 -30 0 1 {name=x1}
C {PFD_passgate.sym} -260 -30 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in.sym} 390 -50 0 1 {name=x7}
C {noconn.sym} 120 140 0 1 {name=l2}
C {noconn.sym} 120 -170 0 1 {name=l1}
C {lab_wire.sym} -340 -210 0 0 {name=p9 sig_type=std_logic lab=vp}
C {capa.sym} -390 0 0 0 {name=C5
m=1
value=2f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} -390 50 0 0 {name=p50 sig_type=std_logic lab=gnd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} -130 110 0 0 {name=x11}
C {lab_wire.sym} 100 -210 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 100 -190 0 0 {name=p8 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 90 120 0 0 {name=p11 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 90 100 0 0 {name=p12 sig_type=std_logic lab=vp}
C {lab_wire.sym} -310 100 0 0 {name=p37 sig_type=std_logic lab=vp}
C {lab_wire.sym} -590 -30 0 0 {name=p13 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 20 -90 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} 20 30 0 0 {name=p14 sig_type=std_logic lab=gnd}
C {PFD_buffor.sym} -90 -30 0 1 {name=x8}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} -130 -200 0 0 {name=x10}
