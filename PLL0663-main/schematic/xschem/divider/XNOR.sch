v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 130 70 130 170 {lab=GND}
N 130 -20 130 10 {lab=#net1}
N 130 -230 130 -200 {lab=#net2}
N 300 -230 300 -200 {lab=#net3}
N 130 -50 150 -50 {lab=GND}
N 130 170 130 190 {lab=GND}
N 130 170 150 170 {lab=GND}
N 130 40 150 40 {lab=GND}
N 150 -50 150 40 {lab=GND}
N 150 40 150 170 {lab=GND}
N 130 -300 130 -290 {lab=VP}
N 130 -300 150 -300 {lab=VP}
N 130 -310 130 -300 {lab=VP}
N 130 -260 150 -260 {lab=VP}
N 300 -300 300 -290 {lab=VP}
N 300 -300 320 -300 {lab=VP}
N 300 -310 300 -300 {lab=VP}
N 300 -260 320 -260 {lab=VP}
N -60 -140 -40 -140 {lab=VP}
N -60 -120 -40 -120 {lab=GND}
N -60 -90 -40 -90 {lab=a}
N -60 -70 -40 -70 {lab=b}
N 70 -50 90 -50 {lab=a}
N 240 -260 260 -260 {lab=_a}
N 70 40 90 40 {lab=_b}
N 70 -260 90 -260 {lab=a}
N 300 70 300 170 {lab=GND}
N 300 -20 300 10 {lab=#net4}
N 300 -50 320 -50 {lab=GND}
N 300 170 300 190 {lab=GND}
N 300 170 320 170 {lab=GND}
N 300 40 320 40 {lab=GND}
N 320 -50 320 40 {lab=GND}
N 320 40 320 170 {lab=GND}
N 240 -50 260 -50 {lab=_a}
N 240 40 260 40 {lab=b}
N 300 -110 300 -80 {lab=y}
N 130 -170 150 -170 {lab=VP}
N 300 -170 320 -170 {lab=VP}
N 240 -170 260 -170 {lab=_b}
N 70 -170 90 -170 {lab=b}
N 150 -260 150 -170 {lab=VP}
N 150 -300 150 -260 {lab=VP}
N 320 -260 320 -170 {lab=VP}
N 320 -300 320 -260 {lab=VP}
N 130 -110 130 -80 {lab=y}
N 210 -110 300 -110 {lab=y}
N 130 -140 130 -110 {lab=y}
N 300 -140 300 -110 {lab=y}
N 210 -110 210 -90 {lab=y}
N 130 -110 210 -110 {lab=y}
N -170 80 -170 100 {lab=GND}
N -170 0 -170 20 {lab=VP}
N -210 50 -190 50 {lab=a}
N -120 50 -100 50 {lab=_a}
N -170 200 -170 220 {lab=GND}
N -170 120 -170 140 {lab=VP}
N -210 170 -190 170 {lab=b}
N -120 170 -100 170 {lab=_b}
C {sg13g2_pr/sg13_lv_nmos.sym} 110 -50 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 110 40 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 210 -90 0 0 {name=p1 lab=y}
C {iopin.sym} -60 -120 2 0 {name=p2 lab=GND}
C {ipin.sym} -60 -90 0 0 {name=p3 lab=a}
C {iopin.sym} -60 -140 2 0 {name=p5 lab=VP}
C {ipin.sym} -60 -70 0 0 {name=p6 lab=b}
C {lab_pin.sym} -40 -70 2 0 {name=p8 sig_type=std_logic lab=b}
C {lab_pin.sym} -40 -90 2 0 {name=p9 sig_type=std_logic lab=a}
C {lab_pin.sym} -40 -120 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -40 -140 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} 130 190 2 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_pin.sym} 130 -310 2 0 {name=p19 sig_type=std_logic lab=VP}
C {lab_pin.sym} 300 -310 2 0 {name=p20 sig_type=std_logic lab=VP}
C {sg13g2_pr/sg13_lv_pmos.sym} 110 -260 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 280 -260 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 280 -50 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 280 40 0 0 {name=M6
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 300 190 2 0 {name=p16 sig_type=std_logic lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} 110 -170 0 0 {name=M7
l=0.13u
w=0.15u
ng=1
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 280 -170 0 0 {name=M8
l=0.13u
w=0.15u
ng=1
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -170 100 2 0 {name=p4 sig_type=std_logic lab=GND}
C {lab_pin.sym} -170 0 2 0 {name=p7 sig_type=std_logic lab=VP}
C {lab_pin.sym} -170 220 2 0 {name=p12 sig_type=std_logic lab=GND}
C {lab_pin.sym} -170 120 2 0 {name=p13 sig_type=std_logic lab=VP}
C {lab_pin.sym} -210 50 0 0 {name=p14 sig_type=std_logic lab=a}
C {lab_pin.sym} -210 170 0 0 {name=p15 sig_type=std_logic lab=b}
C {lab_pin.sym} -100 170 2 0 {name=p17 sig_type=std_logic lab=_b}
C {lab_pin.sym} -100 50 2 0 {name=p21 sig_type=std_logic lab=_a}
C {lab_pin.sym} 70 -260 0 0 {name=p22 sig_type=std_logic lab=a}
C {lab_pin.sym} 70 -50 0 0 {name=p23 sig_type=std_logic lab=a}
C {lab_pin.sym} 240 -50 0 0 {name=p24 sig_type=std_logic lab=_a}
C {lab_pin.sym} 70 40 0 0 {name=p25 sig_type=std_logic lab=_b}
C {lab_pin.sym} 70 -170 0 0 {name=p26 sig_type=std_logic lab=b}
C {lab_pin.sym} 240 40 0 0 {name=p27 sig_type=std_logic lab=b}
C {lab_pin.sym} 240 -170 0 0 {name=p28 sig_type=std_logic lab=_b}
C {lab_pin.sym} 240 -260 0 0 {name=p29 sig_type=std_logic lab=_a}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} -170 50 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} -170 170 0 0 {name=x2}
