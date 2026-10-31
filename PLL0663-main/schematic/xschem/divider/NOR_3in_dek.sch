v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -10 -60 10 {lab=y}
N 190 10 220 10 {lab=y}
N -60 160 -60 180 {lab=GND}
N -60 160 -40 160 {lab=GND}
N -60 130 -40 130 {lab=GND}
N -60 -40 -40 -40 {lab=VP}
N -60 -250 -60 -240 {lab=VP}
N -60 -250 -40 -250 {lab=VP}
N -60 -260 -60 -250 {lab=VP}
N -60 -210 -40 -210 {lab=VP}
N -250 -40 -230 -40 {lab=VP}
N -250 -20 -230 -20 {lab=GND}
N -250 10 -230 10 {lab=a}
N -250 30 -230 30 {lab=b}
N -120 130 -100 130 {lab=a}
N -120 -210 -100 -210 {lab=a}
N 0 130 20 130 {lab=b}
N -120 -40 -100 -40 {lab=b}
N -40 -120 -40 -40 {lab=VP}
N -40 130 -40 160 {lab=GND}
N 60 10 190 10 {lab=y}
N 60 160 60 180 {lab=GND}
N 60 160 80 160 {lab=GND}
N 60 130 80 130 {lab=GND}
N 80 130 80 160 {lab=GND}
N -60 10 -60 100 {lab=y}
N 130 130 150 130 {lab=c}
N 190 160 190 180 {lab=GND}
N 190 160 210 160 {lab=GND}
N 190 130 210 130 {lab=GND}
N 210 130 210 160 {lab=GND}
N 190 10 190 100 {lab=y}
N 60 10 60 100 {lab=y}
N -60 10 60 10 {lab=y}
N -60 -120 -40 -120 {lab=VP}
N -120 -120 -100 -120 {lab=a}
N -60 -180 -60 -150 {lab=#net1}
N -60 -90 -60 -70 {lab=#net2}
N -40 -210 -40 -120 {lab=VP}
N -40 -250 -40 -210 {lab=VP}
N -250 50 -230 50 {lab=c}
C {sg13g2_pr/sg13_lv_nmos.sym} -80 130 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 220 10 0 0 {name=p1 lab=y}
C {iopin.sym} -250 -20 2 0 {name=p2 lab=GND}
C {ipin.sym} -250 10 0 0 {name=p3 lab=a}
C {iopin.sym} -250 -40 2 0 {name=p5 lab=VP}
C {ipin.sym} -250 30 0 0 {name=p6 lab=b}
C {lab_pin.sym} -230 30 2 0 {name=p8 sig_type=std_logic lab=b}
C {lab_pin.sym} -230 10 2 0 {name=p9 sig_type=std_logic lab=a}
C {lab_pin.sym} -230 -20 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -230 -40 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} -120 130 0 0 {name=p12 sig_type=std_logic lab=a}
C {lab_pin.sym} -120 -210 0 0 {name=p13 sig_type=std_logic lab=a}
C {lab_pin.sym} 0 130 0 0 {name=p14 sig_type=std_logic lab=b}
C {lab_pin.sym} -120 -40 0 0 {name=p15 sig_type=std_logic lab=b}
C {lab_pin.sym} -60 180 2 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_pin.sym} -60 -260 2 0 {name=p20 sig_type=std_logic lab=VP}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -40 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -210 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 40 130 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 60 180 2 0 {name=p4 sig_type=std_logic lab=GND}
C {lab_pin.sym} 130 130 0 0 {name=p7 sig_type=std_logic lab=c}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 130 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 190 180 2 0 {name=p16 sig_type=std_logic lab=GND}
C {lab_pin.sym} -120 -120 0 0 {name=p17 sig_type=std_logic lab=c}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -120 0 0 {name=M6
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -250 50 0 0 {name=p19 lab=c}
C {lab_pin.sym} -230 50 2 0 {name=p21 sig_type=std_logic lab=c}
