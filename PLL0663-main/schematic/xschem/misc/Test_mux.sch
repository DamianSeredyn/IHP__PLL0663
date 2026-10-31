v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 400 -180 400 -150 {lab=VP}
N 670 -190 670 -160 {lab=VP}
N 230 -50 260 -50 {lab=VP}
N 230 -70 260 -70 {lab=ground}
N 670 -60 670 -30 {lab=ground}
N 430 10 430 40 {lab=ground}
N 450 -180 450 -150 {lab=VPHIGH}
N -90 -70 -70 -70 {lab=t0}
N -90 -50 -70 -50 {lab=t1}
N -90 -30 -70 -30 {lab=t2}
N -250 -70 -230 -70 {lab=ground}
N -250 -50 -230 -50 {lab=VP}
N -250 -30 -230 -30 {lab=debug_out}
N -250 -10 -230 -10 {lab=in1}
N -250 10 -230 10 {lab=in2}
N -250 30 -230 30 {lab=in3}
N -250 50 -230 50 {lab=in4}
N -250 90 -230 90 {lab=in6}
N -250 110 -230 110 {lab=in7}
N -250 130 -230 130 {lab=in8}
N -250 70 -230 70 {lab=in5}
N -90 -10 -70 -10 {lab=in1}
N -90 10 -70 10 {lab=in2}
N -90 30 -70 30 {lab=in3}
N -90 50 -70 50 {lab=in4}
N -90 90 -70 90 {lab=in6}
N -90 110 -70 110 {lab=in7}
N -90 130 -70 130 {lab=in8}
N -90 70 -70 70 {lab=in5}
N 250 -30 250 10 {lab=MUX_out}
N 230 -30 250 -30 {lab=MUX_out}
N -260 -210 -240 -210 {lab=t0}
N -260 -190 -240 -190 {lab=t1}
N -260 -170 -240 -170 {lab=t2}
N -250 -90 -230 -90 {lab=VPHIGH}
N 510 -110 570 -110 {lab=#net1}
N 250 -30 340 -30 {lab=MUX_out}
N 780 -110 850 -110 {lab=debug_out}
C {lab_pin.sym} 400 -180 1 0 {name=p128 sig_type=std_logic lab=VP}
C {lab_pin.sym} 670 -190 1 0 {name=p1 sig_type=std_logic lab=VP}
C {lab_pin.sym} 260 -50 2 0 {name=p2 sig_type=std_logic lab=VP}
C {lab_pin.sym} 260 -70 2 0 {name=p3 sig_type=std_logic lab=ground}
C {lab_pin.sym} 670 -30 3 0 {name=p4 sig_type=std_logic lab=ground}
C {lab_pin.sym} 430 40 3 0 {name=p5 sig_type=std_logic lab=ground}
C {lab_pin.sym} 450 -180 1 0 {name=p6 sig_type=std_logic lab=VPHIGH}
C {lab_wire.sym} -90 -70 0 0 {name=p52 sig_type=std_logic lab=t0
}
C {lab_wire.sym} -90 -50 0 0 {name=p53 sig_type=std_logic lab=t1
}
C {lab_wire.sym} -90 -30 0 0 {name=p54 sig_type=std_logic lab=t2
}
C {iopin.sym} -250 -70 2 0 {name=p7 lab=ground}
C {iopin.sym} -250 -50 2 0 {name=p9 lab=VP}
C {opin.sym} -250 -30 2 0 {name=p11 lab=debug_out}
C {lab_pin.sym} -230 -30 2 0 {name=p12 sig_type=std_logic lab=debug_out}
C {ipin.sym} -250 -10 2 1 {name=p13 lab=in1}
C {lab_pin.sym} -230 -10 2 0 {name=p14 sig_type=std_logic lab=in1}
C {ipin.sym} -250 10 2 1 {name=p15 lab=in2}
C {lab_pin.sym} -230 10 2 0 {name=p16 sig_type=std_logic lab=in2}
C {ipin.sym} -250 30 2 1 {name=p17 lab=in3}
C {lab_pin.sym} -230 30 2 0 {name=p18 sig_type=std_logic lab=in3}
C {ipin.sym} -250 50 2 1 {name=p19 lab=in4}
C {lab_pin.sym} -230 50 2 0 {name=p20 sig_type=std_logic lab=in4}
C {ipin.sym} -250 70 2 1 {name=p21 lab=in5}
C {lab_pin.sym} -230 70 2 0 {name=p22 sig_type=std_logic lab=in5}
C {ipin.sym} -250 90 2 1 {name=p23 lab=in6}
C {lab_pin.sym} -230 90 2 0 {name=p24 sig_type=std_logic lab=in6}
C {ipin.sym} -250 110 2 1 {name=p25 lab=in7}
C {lab_pin.sym} -230 110 2 0 {name=p26 sig_type=std_logic lab=in7}
C {ipin.sym} -250 130 2 1 {name=p27 lab=in8}
C {lab_pin.sym} -230 130 2 0 {name=p28 sig_type=std_logic lab=in8}
C {lab_pin.sym} -230 -70 2 0 {name=p8 sig_type=std_logic lab=ground}
C {lab_pin.sym} -230 -50 2 0 {name=p10 sig_type=std_logic lab=VP}
C {lab_pin.sym} -90 -10 2 1 {name=p29 sig_type=std_logic lab=in1}
C {lab_pin.sym} -90 10 2 1 {name=p30 sig_type=std_logic lab=in2}
C {lab_pin.sym} -90 30 2 1 {name=p31 sig_type=std_logic lab=in3}
C {lab_pin.sym} -90 50 2 1 {name=p32 sig_type=std_logic lab=in4}
C {lab_pin.sym} -90 70 2 1 {name=p33 sig_type=std_logic lab=in5}
C {lab_pin.sym} -90 90 2 1 {name=p34 sig_type=std_logic lab=in6}
C {lab_pin.sym} -90 110 2 1 {name=p35 sig_type=std_logic lab=in7}
C {lab_pin.sym} -90 130 2 1 {name=p36 sig_type=std_logic lab=in8}
C {lab_pin.sym} 850 -110 2 0 {name=p37 sig_type=std_logic lab=debug_out}
C {lab_pin.sym} 250 10 2 0 {name=p38 sig_type=std_logic lab=MUX_out}
C {lab_wire.sym} -240 -210 2 0 {name=p42 sig_type=std_logic lab=t0
}
C {lab_wire.sym} -240 -190 2 0 {name=p43 sig_type=std_logic lab=t1
}
C {lab_wire.sym} -240 -170 2 0 {name=p44 sig_type=std_logic lab=t2
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf_lp.sym} 670 -230 0 0 {name=x2}
C {lab_pin.sym} -230 -90 2 0 {name=p46 sig_type=std_logic lab=VPHIGH}
C {iopin.sym} -250 -90 2 0 {name=p47 lab=VPHIGH}
C {ipin.sym} -260 -170 2 1 {name=p40 lab=t2}
C {ipin.sym} -260 -190 2 1 {name=p41 lab=t1}
C {ipin.sym} -260 -210 2 1 {name=p45 lab=t0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/mux8to1.sym} 80 30 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/debug_level_shifter.sym} 490 -90 0 0 {name=x3}
