v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -580 -300 -560 -300 {lab=gd}
N -580 -280 -560 -280 {lab=vp}
N -580 -260 -560 -260 {lab=in}
N -580 -220 -560 -220 {lab=div2}
N -580 -200 -560 -200 {lab=div4}
N -580 -180 -560 -180 {lab=div8}
N -580 -160 -560 -160 {lab=div16}
N -580 -140 -560 -140 {lab=div32}
N -580 -120 -560 -120 {lab=div64}
N -580 -100 -560 -100 {lab=div128}
N -370 50 -360 50 {lab=#net1}
N -360 50 -360 70 {lab=#net1}
N -680 70 -360 70 {lab=#net1}
N -680 10 -680 70 {lab=#net1}
N -680 10 -670 10 {lab=#net1}
N -370 10 -350 10 {lab=vp}
N -370 30 -350 30 {lab=gd}
N -690 -10 -670 -10 {lab=in}
N 0 50 10 50 {lab=#net2}
N 10 50 10 70 {lab=#net2}
N -310 70 10 70 {lab=#net2}
N -310 10 -310 70 {lab=#net2}
N -310 10 -300 10 {lab=#net2}
N 0 10 20 10 {lab=vp}
N 0 30 20 30 {lab=gd}
N -340 -10 -300 -10 {lab=div2}
N 370 50 380 50 {lab=#net3}
N 380 50 380 70 {lab=#net3}
N 60 70 380 70 {lab=#net3}
N 60 10 60 70 {lab=#net3}
N 60 10 70 10 {lab=#net3}
N 370 10 390 10 {lab=vp}
N 370 30 390 30 {lab=gd}
N 30 -10 70 -10 {lab=div4}
N 30 -20 30 -10 {lab=div4}
N 0 -10 30 -10 {lab=div4}
N -340 -20 -340 -10 {lab=div2}
N -370 -10 -340 -10 {lab=div2}
N 740 50 750 50 {lab=#net4}
N 750 50 750 70 {lab=#net4}
N 430 70 750 70 {lab=#net4}
N 430 10 430 70 {lab=#net4}
N 430 10 440 10 {lab=#net4}
N 740 10 760 10 {lab=vp}
N 740 30 760 30 {lab=gd}
N 400 -10 440 -10 {lab=div8}
N 400 -20 400 -10 {lab=div8}
N 370 -10 400 -10 {lab=div8}
N 740 -10 760 -10 {lab=div16}
N 760 -20 760 -10 {lab=div16}
N -370 220 -360 220 {lab=#net5}
N -360 220 -360 240 {lab=#net5}
N -680 240 -360 240 {lab=#net5}
N -680 180 -680 240 {lab=#net5}
N -680 180 -670 180 {lab=#net5}
N -370 180 -350 180 {lab=vp}
N -370 200 -350 200 {lab=gd}
N -710 160 -670 160 {lab=div16}
N 0 220 10 220 {lab=#net6}
N 10 220 10 240 {lab=#net6}
N -310 240 10 240 {lab=#net6}
N -310 180 -310 240 {lab=#net6}
N -310 180 -300 180 {lab=#net6}
N 0 180 20 180 {lab=vp}
N 0 200 20 200 {lab=gd}
N -340 160 -300 160 {lab=div32}
N -340 150 -340 160 {lab=div32}
N -370 160 -340 160 {lab=div32}
N 370 220 380 220 {lab=#net7}
N 380 220 380 240 {lab=#net7}
N 60 240 380 240 {lab=#net7}
N 60 180 60 240 {lab=#net7}
N 60 180 70 180 {lab=#net7}
N 370 180 390 180 {lab=vp}
N 370 200 390 200 {lab=gd}
N 30 160 70 160 {lab=div64}
N 30 150 30 160 {lab=div64}
N 0 160 30 160 {lab=div64}
N 370 160 390 160 {lab=div128}
N 390 150 390 160 {lab=div128}
N -710 150 -710 160 {lab=div16}
C {iopin.sym} -580 -300 2 0 {name=p1 lab=gd}
C {ipin.sym} -580 -260 0 0 {name=p2 lab=in}
C {lab_pin.sym} -560 -300 2 0 {name=p4 sig_type=std_logic lab=gd}
C {iopin.sym} -580 -280 2 0 {name=p5 lab=vp}
C {lab_pin.sym} -560 -280 2 0 {name=p6 sig_type=std_logic lab=vp}
C {opin.sym} -580 -220 2 0 {name=p7 lab=div2}
C {opin.sym} -580 -200 2 0 {name=p8 lab=div4}
C {opin.sym} -580 -180 2 0 {name=p9 lab=div8}
C {opin.sym} -580 -160 2 0 {name=p10 lab=div16}
C {opin.sym} -580 -140 2 0 {name=p11 lab=div32}
C {opin.sym} -580 -120 2 0 {name=p12 lab=div64}
C {opin.sym} -580 -100 2 0 {name=p13 lab=div128}
C {lab_pin.sym} -560 -260 2 0 {name=p14 sig_type=std_logic lab=in}
C {lab_pin.sym} -560 -220 2 0 {name=p16 sig_type=std_logic lab=div2}
C {lab_pin.sym} -560 -200 2 0 {name=p17 sig_type=std_logic lab=div4}
C {lab_pin.sym} -560 -180 2 0 {name=p18 sig_type=std_logic lab=div8}
C {lab_pin.sym} -560 -160 2 0 {name=p19 sig_type=std_logic lab=div16}
C {lab_pin.sym} -560 -140 2 0 {name=p20 sig_type=std_logic lab=div32}
C {lab_pin.sym} -560 -120 2 0 {name=p21 sig_type=std_logic lab=div64}
C {lab_pin.sym} -560 -100 2 0 {name=p22 sig_type=std_logic lab=div128}
C {lab_pin.sym} -350 30 2 0 {name=p23 sig_type=std_logic lab=gd}
C {lab_pin.sym} -350 10 2 0 {name=p24 sig_type=std_logic lab=vp}
C {lab_pin.sym} -690 -10 0 0 {name=p25 sig_type=std_logic lab=in}
C {lab_pin.sym} 20 30 2 0 {name=p27 sig_type=std_logic lab=gd}
C {lab_pin.sym} 20 10 2 0 {name=p28 sig_type=std_logic lab=vp}
C {lab_pin.sym} 390 30 2 0 {name=p30 sig_type=std_logic lab=gd}
C {lab_pin.sym} 390 10 2 0 {name=p31 sig_type=std_logic lab=vp}
C {lab_pin.sym} -340 -20 1 0 {name=p29 sig_type=std_logic lab=div2}
C {lab_pin.sym} 760 30 2 0 {name=p32 sig_type=std_logic lab=gd}
C {lab_pin.sym} 760 10 2 0 {name=p33 sig_type=std_logic lab=vp}
C {lab_pin.sym} 30 -20 1 0 {name=p34 sig_type=std_logic lab=div4}
C {lab_pin.sym} 400 -20 1 0 {name=p35 sig_type=std_logic lab=div8}
C {lab_pin.sym} -350 200 2 0 {name=p36 sig_type=std_logic lab=gd}
C {lab_pin.sym} -350 180 2 0 {name=p37 sig_type=std_logic lab=vp}
C {lab_pin.sym} 20 200 2 0 {name=p38 sig_type=std_logic lab=gd}
C {lab_pin.sym} 20 180 2 0 {name=p39 sig_type=std_logic lab=vp}
C {lab_pin.sym} 390 200 2 0 {name=p41 sig_type=std_logic lab=gd}
C {lab_pin.sym} 390 180 2 0 {name=p42 sig_type=std_logic lab=vp}
C {lab_pin.sym} 760 -20 1 0 {name=p3 sig_type=std_logic lab=div16}
C {lab_pin.sym} -710 150 1 0 {name=p15 sig_type=std_logic lab=div16}
C {lab_pin.sym} -340 150 1 0 {name=p26 sig_type=std_logic lab=div32}
C {lab_pin.sym} 30 150 1 0 {name=p40 sig_type=std_logic lab=div64}
C {lab_pin.sym} 390 150 1 0 {name=p43 sig_type=std_logic lab=div128}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} -520 190 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} -150 190 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} 220 190 0 0 {name=x7}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} -520 20 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} -150 20 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} 220 20 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} 590 20 0 0 {name=x6}
