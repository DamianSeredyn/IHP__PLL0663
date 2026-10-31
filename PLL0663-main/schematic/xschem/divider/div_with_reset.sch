v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -330 -380 -310 -380 {lab=gd}
N -330 -360 -310 -360 {lab=vp}
N -330 -340 -310 -340 {lab=in}
N -330 -280 -310 -280 {lab=r_div2}
N -330 -260 -310 -260 {lab=r_div4}
N -330 -240 -310 -240 {lab=r_div8}
N -330 -220 -310 -220 {lab=r_div16}
N -330 -200 -310 -200 {lab=r_div32}
N -330 -180 -310 -180 {lab=r_div64}
N -120 -10 -110 -10 {lab=r_div2}
N -110 -10 -110 10 {lab=r_div2}
N -430 10 -110 10 {lab=r_div2}
N -430 -50 -430 10 {lab=r_div2}
N -430 -50 -420 -50 {lab=r_div2}
N -120 -50 -100 -50 {lab=vp}
N -120 -30 -100 -30 {lab=gd}
N -440 -70 -420 -70 {lab=in}
N 250 -10 260 -10 {lab=r_div4}
N 260 -10 260 10 {lab=r_div4}
N -60 10 260 10 {lab=r_div4}
N -60 -50 -60 10 {lab=r_div4}
N -60 -50 -50 -50 {lab=r_div4}
N 250 -50 270 -50 {lab=vp}
N 250 -30 270 -30 {lab=gd}
N 620 -10 630 -10 {lab=r_div8}
N 630 -10 630 10 {lab=r_div8}
N 310 10 630 10 {lab=r_div8}
N 310 -50 310 10 {lab=r_div8}
N 310 -50 320 -50 {lab=r_div8}
N 620 -50 640 -50 {lab=vp}
N 620 -30 640 -30 {lab=gd}
N 250 -70 320 -70 {lab=#net1}
N -120 -70 -50 -70 {lab=#net2}
N 990 -10 1000 -10 {lab=r_div16}
N 1000 -10 1000 10 {lab=r_div16}
N 680 10 1000 10 {lab=r_div16}
N 680 -50 680 10 {lab=r_div16}
N 680 -50 690 -50 {lab=r_div16}
N 990 -50 1010 -50 {lab=vp}
N 990 -30 1010 -30 {lab=gd}
N 620 -70 690 -70 {lab=#net3}
N 990 -70 1060 -70 {lab=#net4}
N -120 190 -110 190 {lab=r_div32}
N -110 190 -110 210 {lab=r_div32}
N -430 210 -110 210 {lab=r_div32}
N -430 150 -430 210 {lab=r_div32}
N -430 150 -420 150 {lab=r_div32}
N -120 150 -100 150 {lab=vp}
N -120 170 -100 170 {lab=gd}
N -460 130 -420 130 {lab=#net4}
N 250 190 260 190 {lab=r_div64}
N 260 190 260 210 {lab=r_div64}
N -60 210 260 210 {lab=r_div64}
N -60 150 -60 210 {lab=r_div64}
N -60 150 -50 150 {lab=r_div64}
N 250 150 270 150 {lab=vp}
N 250 170 270 170 {lab=gd}
N -120 130 -50 130 {lab=#net5}
N -420 170 -420 180 {lab=reset}
N -50 170 -50 180 {lab=reset}
N -50 -30 -50 -20 {lab=reset}
N -420 -30 -420 -20 {lab=reset}
N 320 -30 320 -20 {lab=reset}
N 690 -30 690 -20 {lab=reset}
N -330 -320 -310 -320 {lab=reset}
N 1060 -70 1060 50 {lab=#net4}
N -460 50 1060 50 {lab=#net4}
N -460 50 -460 130 {lab=#net4}
N 250 130 270 130 {lab=#net6}
C {iopin.sym} -330 -380 2 0 {name=p2 lab=gd}
C {ipin.sym} -330 -340 0 0 {name=p4 lab=in}
C {lab_pin.sym} -310 -380 2 0 {name=p6 sig_type=std_logic lab=gd}
C {iopin.sym} -330 -360 2 0 {name=p7 lab=vp}
C {lab_pin.sym} -310 -360 2 0 {name=p8 sig_type=std_logic lab=vp}
C {opin.sym} -330 -280 2 0 {name=p9 lab=r_div2}
C {opin.sym} -330 -260 2 0 {name=p10 lab=r_div4}
C {opin.sym} -330 -240 2 0 {name=p11 lab=r_div8}
C {opin.sym} -330 -220 2 0 {name=p12 lab=r_div16}
C {opin.sym} -330 -200 2 0 {name=p13 lab=r_div32}
C {opin.sym} -330 -180 2 0 {name=p14 lab=r_div64}
C {lab_pin.sym} -310 -340 2 0 {name=p16 sig_type=std_logic lab=in}
C {lab_pin.sym} -310 -280 2 0 {name=p17 sig_type=std_logic lab=r_div2}
C {lab_pin.sym} -310 -260 2 0 {name=p18 sig_type=std_logic lab=r_div4}
C {lab_pin.sym} -310 -240 2 0 {name=p19 sig_type=std_logic lab=r_div8}
C {lab_pin.sym} -310 -220 2 0 {name=p20 sig_type=std_logic lab=r_div16}
C {lab_pin.sym} -310 -200 2 0 {name=p21 sig_type=std_logic lab=r_div32}
C {lab_pin.sym} -310 -180 2 0 {name=p22 sig_type=std_logic lab=r_div64}
C {lab_pin.sym} -100 -30 2 0 {name=p24 sig_type=std_logic lab=gd}
C {lab_pin.sym} -100 -50 2 0 {name=p25 sig_type=std_logic lab=vp}
C {lab_pin.sym} -440 -70 0 0 {name=p26 sig_type=std_logic lab=in}
C {lab_pin.sym} 270 -30 2 0 {name=p27 sig_type=std_logic lab=gd}
C {lab_pin.sym} 270 -50 2 0 {name=p28 sig_type=std_logic lab=vp}
C {lab_pin.sym} 640 -30 2 0 {name=p30 sig_type=std_logic lab=gd}
C {lab_pin.sym} 640 -50 2 0 {name=p31 sig_type=std_logic lab=vp}
C {lab_pin.sym} -150 10 2 0 {name=p29 sig_type=std_logic lab=r_div2}
C {lab_pin.sym} 1010 -30 2 0 {name=p32 sig_type=std_logic lab=gd}
C {lab_pin.sym} 1010 -50 2 0 {name=p33 sig_type=std_logic lab=vp}
C {lab_pin.sym} 250 10 2 0 {name=p34 sig_type=std_logic lab=r_div4}
C {lab_pin.sym} 620 10 2 0 {name=p35 sig_type=std_logic lab=r_div8}
C {lab_pin.sym} -100 170 2 0 {name=p36 sig_type=std_logic lab=gd}
C {lab_pin.sym} -100 150 2 0 {name=p37 sig_type=std_logic lab=vp}
C {lab_pin.sym} 270 170 2 0 {name=p38 sig_type=std_logic lab=gd}
C {lab_pin.sym} 270 150 2 0 {name=p39 sig_type=std_logic lab=vp}
C {lab_pin.sym} 1000 10 2 0 {name=p40 sig_type=std_logic lab=r_div16}
C {lab_pin.sym} -130 210 2 0 {name=p44 sig_type=std_logic lab=r_div32}
C {lab_pin.sym} 250 210 2 0 {name=p45 sig_type=std_logic lab=r_div64}
C {ipin.sym} -330 -320 0 0 {name=p49 lab=reset}
C {lab_wire.sym} -310 -320 2 0 {name=p50 sig_type=std_logic lab=reset
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} 100 -40 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} -270 -40 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} 100 160 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} -270 160 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} 840 -40 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop_reset.sym} 470 -40 0 0 {name=x6}
C {lab_wire.sym} -420 -20 3 0 {name=p1 sig_type=std_logic lab=reset
}
C {lab_wire.sym} -50 -20 3 0 {name=p3 sig_type=std_logic lab=reset
}
C {lab_wire.sym} 320 -20 3 0 {name=p5 sig_type=std_logic lab=reset
}
C {lab_wire.sym} 690 -20 3 0 {name=p15 sig_type=std_logic lab=reset
}
C {lab_wire.sym} -50 180 3 0 {name=p23 sig_type=std_logic lab=reset
}
C {lab_wire.sym} -420 180 3 0 {name=p41 sig_type=std_logic lab=reset
}
C {noconn.sym} 270 130 2 0 {name=l1}
