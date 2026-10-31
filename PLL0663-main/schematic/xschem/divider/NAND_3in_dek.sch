v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 50 40 50 70 {lab=#net1}
N 50 -50 50 -20 {lab=#net2}
N 50 -120 50 -110 {lab=y}
N 190 -120 320 -120 {lab=y}
N 50 -140 50 -120 {lab=y}
N 320 -140 320 -120 {lab=y}
N 190 -140 190 -120 {lab=y}
N 50 -120 190 -120 {lab=y}
N 50 -80 70 -80 {lab=GND}
N 50 140 50 160 {lab=GND}
N 50 140 70 140 {lab=GND}
N 50 130 50 140 {lab=GND}
N 50 10 70 10 {lab=GND}
N 70 -80 70 10 {lab=GND}
N 70 100 70 140 {lab=GND}
N 50 100 70 100 {lab=GND}
N 70 10 70 100 {lab=GND}
N 50 -210 50 -200 {lab=VP}
N 50 -210 70 -210 {lab=VP}
N 50 -220 50 -210 {lab=VP}
N 70 -210 70 -170 {lab=VP}
N 50 -170 70 -170 {lab=VP}
N 190 -210 190 -200 {lab=VP}
N 190 -210 210 -210 {lab=VP}
N 190 -220 190 -210 {lab=VP}
N 210 -210 210 -170 {lab=VP}
N 190 -170 210 -170 {lab=VP}
N 320 -210 320 -200 {lab=VP}
N 320 -210 340 -210 {lab=VP}
N 320 -220 320 -210 {lab=VP}
N 340 -210 340 -170 {lab=VP}
N 320 -170 340 -170 {lab=VP}
N -140 -170 -120 -170 {lab=VP}
N -140 -150 -120 -150 {lab=GND}
N -140 -120 -120 -120 {lab=a}
N -140 -100 -120 -100 {lab=b}
N -140 -80 -120 -80 {lab=c}
N 320 -120 330 -120 {lab=y}
N -10 -80 10 -80 {lab=a}
N 130 -170 150 -170 {lab=a}
N -10 10 10 10 {lab=b}
N -10 -170 10 -170 {lab=b}
N -20 100 10 100 {lab=c}
N 260 -170 280 -170 {lab=c}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 -80 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 10 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 100 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 330 -120 0 0 {name=p1 lab=y}
C {iopin.sym} -140 -150 2 0 {name=p2 lab=GND}
C {ipin.sym} -140 -120 0 0 {name=p3 lab=a}
C {iopin.sym} -140 -170 2 0 {name=p5 lab=VP}
C {ipin.sym} -140 -100 0 0 {name=p6 lab=b}
C {ipin.sym} -140 -80 0 0 {name=p7 lab=c}
C {lab_pin.sym} -120 -100 2 0 {name=p8 sig_type=std_logic lab=b}
C {lab_pin.sym} -120 -120 2 0 {name=p9 sig_type=std_logic lab=a}
C {lab_pin.sym} -120 -150 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -120 -170 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} -10 -80 0 0 {name=p12 sig_type=std_logic lab=a}
C {lab_pin.sym} 130 -170 0 0 {name=p13 sig_type=std_logic lab=a}
C {lab_pin.sym} -10 10 0 0 {name=p14 sig_type=std_logic lab=b}
C {lab_pin.sym} -10 -170 0 0 {name=p15 sig_type=std_logic lab=b}
C {lab_pin.sym} 50 160 2 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_pin.sym} 50 -220 2 0 {name=p19 sig_type=std_logic lab=VP}
C {lab_pin.sym} 190 -220 2 0 {name=p20 sig_type=std_logic lab=VP}
C {lab_pin.sym} 320 -220 2 0 {name=p21 sig_type=std_logic lab=VP}
C {sg13g2_pr/sg13_lv_pmos.sym} 300 -170 0 0 {name=M7
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 170 -170 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 30 -170 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -120 -80 2 0 {name=p4 sig_type=std_logic lab=c}
C {lab_pin.sym} -20 100 0 0 {name=p16 sig_type=std_logic lab=c}
C {lab_pin.sym} 260 -170 0 0 {name=p17 sig_type=std_logic lab=c}
