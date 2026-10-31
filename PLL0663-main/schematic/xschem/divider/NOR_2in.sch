v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -10 -60 10 {lab=Out}
N 150 10 220 10 {lab=Out}
N -60 160 -60 180 {lab=gd}
N -60 160 -40 160 {lab=gd}
N -60 130 -40 130 {lab=gd}
N -60 -40 -40 -40 {lab=vp}
N -60 -180 -60 -170 {lab=vp}
N -60 -180 -40 -180 {lab=vp}
N -60 -190 -60 -180 {lab=vp}
N -40 -180 -40 -140 {lab=vp}
N -60 -140 -40 -140 {lab=vp}
N -250 -40 -230 -40 {lab=vp}
N -250 -20 -230 -20 {lab=gd}
N -250 10 -230 10 {lab=A}
N -250 30 -230 30 {lab=B}
N -120 130 -100 130 {lab=A}
N -120 -140 -100 -140 {lab=A}
N 90 130 110 130 {lab=B}
N -120 -40 -100 -40 {lab=B}
N -60 -110 -60 -70 {lab=#net1}
N -40 -140 -40 -40 {lab=vp}
N -40 130 -40 160 {lab=gd}
N 150 10 150 100 {lab=Out}
N -60 10 150 10 {lab=Out}
N 150 160 150 180 {lab=gd}
N 150 160 170 160 {lab=gd}
N 150 130 170 130 {lab=gd}
N 170 130 170 160 {lab=gd}
N -60 10 -60 100 {lab=Out}
C {sg13g2_pr/sg13_lv_nmos.sym} -80 130 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 220 10 0 0 {name=p1 lab=Out}
C {iopin.sym} -250 -20 2 0 {name=p2 lab=gd}
C {ipin.sym} -250 10 0 0 {name=p3 lab=A}
C {iopin.sym} -250 -40 2 0 {name=p5 lab=vp}
C {ipin.sym} -250 30 0 0 {name=p6 lab=B}
C {lab_pin.sym} -230 30 2 0 {name=p8 sig_type=std_logic lab=B}
C {lab_pin.sym} -230 10 2 0 {name=p9 sig_type=std_logic lab=A}
C {lab_pin.sym} -230 -20 2 0 {name=p10 sig_type=std_logic lab=gd}
C {lab_pin.sym} -230 -40 2 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_pin.sym} -120 130 0 0 {name=p12 sig_type=std_logic lab=A}
C {lab_pin.sym} -120 -140 0 0 {name=p13 sig_type=std_logic lab=A}
C {lab_pin.sym} 90 130 0 0 {name=p14 sig_type=std_logic lab=B}
C {lab_pin.sym} -120 -40 0 0 {name=p15 sig_type=std_logic lab=B}
C {lab_pin.sym} -60 180 2 0 {name=p18 sig_type=std_logic lab=gd}
C {lab_pin.sym} -60 -190 2 0 {name=p20 sig_type=std_logic lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -40 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -140 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 130 130 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 150 180 2 0 {name=p4 sig_type=std_logic lab=gd}
