v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -80 220 -80 250 {lab=#net1}
N -80 -30 -80 -20 {lab=y}
N 60 -30 190 -30 {lab=y}
N -80 -50 -80 -30 {lab=y}
N 190 -50 190 -30 {lab=y}
N 60 -50 60 -30 {lab=y}
N -80 -30 60 -30 {lab=y}
N -80 10 -60 10 {lab=GND}
N -80 320 -80 340 {lab=GND}
N -80 320 -60 320 {lab=GND}
N -80 310 -80 320 {lab=GND}
N -80 190 -60 190 {lab=GND}
N -60 280 -60 320 {lab=GND}
N -80 280 -60 280 {lab=GND}
N -60 190 -60 280 {lab=GND}
N -80 -120 -80 -110 {lab=VP}
N -80 -120 -60 -120 {lab=VP}
N -80 -130 -80 -120 {lab=VP}
N -60 -120 -60 -80 {lab=VP}
N -80 -80 -60 -80 {lab=VP}
N 60 -120 60 -110 {lab=VP}
N 60 -120 80 -120 {lab=VP}
N 60 -130 60 -120 {lab=VP}
N 80 -120 80 -80 {lab=VP}
N 60 -80 80 -80 {lab=VP}
N 190 -120 190 -110 {lab=VP}
N 190 -120 210 -120 {lab=VP}
N 190 -130 190 -120 {lab=VP}
N 210 -120 210 -80 {lab=VP}
N 190 -80 210 -80 {lab=VP}
N -270 -80 -250 -80 {lab=VP}
N -270 -60 -250 -60 {lab=GND}
N -270 -30 -250 -30 {lab=a}
N -270 -10 -250 -10 {lab=b}
N -270 10 -250 10 {lab=c}
N 190 -30 320 -30 {lab=y}
N -140 10 -120 10 {lab=a}
N 0 -80 20 -80 {lab=a}
N -140 190 -120 190 {lab=c}
N -140 -80 -120 -80 {lab=b}
N -150 280 -120 280 {lab=d}
N 130 -80 150 -80 {lab=c}
N 320 -50 320 -30 {lab=y}
N 320 -120 320 -110 {lab=VP}
N 320 -120 340 -120 {lab=VP}
N 320 -130 320 -120 {lab=VP}
N 340 -120 340 -80 {lab=VP}
N 320 -80 340 -80 {lab=VP}
N 320 -30 330 -30 {lab=y}
N 260 -80 280 -80 {lab=d}
N -80 30 -80 60 {lab=#net2}
N -140 90 -120 90 {lab=b}
N -80 120 -80 160 {lab=#net3}
N -60 90 -60 190 {lab=GND}
N -80 90 -60 90 {lab=GND}
N -60 10 -60 90 {lab=GND}
N -270 30 -250 30 {lab=c}
C {sg13g2_pr/sg13_lv_nmos.sym} -100 10 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -100 190 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -100 280 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 330 -30 0 0 {name=p1 lab=y}
C {iopin.sym} -270 -60 2 0 {name=p2 lab=GND}
C {ipin.sym} -270 -30 0 0 {name=p3 lab=a}
C {iopin.sym} -270 -80 2 0 {name=p5 lab=VP}
C {ipin.sym} -270 -10 0 0 {name=p6 lab=b}
C {ipin.sym} -270 10 0 0 {name=p7 lab=c}
C {lab_pin.sym} -250 -10 2 0 {name=p8 sig_type=std_logic lab=b}
C {lab_pin.sym} -250 -30 2 0 {name=p9 sig_type=std_logic lab=a}
C {lab_pin.sym} -250 -60 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -250 -80 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} -140 10 0 0 {name=p12 sig_type=std_logic lab=a}
C {lab_pin.sym} 0 -80 0 0 {name=p13 sig_type=std_logic lab=a}
C {lab_pin.sym} -140 190 0 0 {name=p14 sig_type=std_logic lab=c}
C {lab_pin.sym} -140 -80 0 0 {name=p15 sig_type=std_logic lab=b}
C {lab_pin.sym} -80 340 2 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_pin.sym} -80 -130 2 0 {name=p19 sig_type=std_logic lab=VP}
C {lab_pin.sym} 60 -130 2 0 {name=p20 sig_type=std_logic lab=VP}
C {lab_pin.sym} 190 -130 2 0 {name=p21 sig_type=std_logic lab=VP}
C {sg13g2_pr/sg13_lv_pmos.sym} 170 -80 0 0 {name=M7
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 40 -80 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -100 -80 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -250 10 2 0 {name=p4 sig_type=std_logic lab=c}
C {lab_pin.sym} -150 280 0 0 {name=p16 sig_type=std_logic lab=d}
C {lab_pin.sym} 130 -80 0 0 {name=p17 sig_type=std_logic lab=c}
C {lab_pin.sym} 320 -130 2 0 {name=p22 sig_type=std_logic lab=VP}
C {sg13g2_pr/sg13_lv_pmos.sym} 300 -80 0 0 {name=M6
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 260 -80 0 0 {name=p23 sig_type=std_logic lab=d}
C {sg13g2_pr/sg13_lv_nmos.sym} -100 90 0 0 {name=M8
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -140 90 0 0 {name=p24 sig_type=std_logic lab=b}
C {ipin.sym} -270 30 0 0 {name=p25 lab=d}
C {lab_pin.sym} -250 30 2 0 {name=p26 sig_type=std_logic lab=d}
