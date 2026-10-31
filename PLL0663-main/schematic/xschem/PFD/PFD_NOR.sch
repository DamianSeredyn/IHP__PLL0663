v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 80 -90 80 -60 {lab=#net1}
N 80 0 80 30 {lab=Out}
N -10 30 80 30 {lab=Out}
N -10 30 -10 50 {lab=Out}
N 140 30 240 30 {lab=Out}
N -10 80 20 80 {lab=gd}
N -10 110 -10 190 {lab=gd}
N 140 80 180 80 {lab=gd}
N 140 110 140 190 {lab=gd}
N 80 -30 110 -30 {lab=vp}
N 110 -120 110 -30 {lab=vp}
N 80 -120 110 -120 {lab=vp}
N -10 -120 40 -120 {lab=B}
N -10 -30 40 -30 {lab=A}
N 70 80 100 80 {lab=B}
N -70 80 -50 80 {lab=A}
N 140 30 140 50 {lab=Out}
N 80 30 140 30 {lab=Out}
N 80 -210 80 -150 {lab=vp}
N 80 -210 110 -210 {lab=vp}
N 80 -220 80 -210 {lab=vp}
N 120 190 140 190 {lab=gd}
N 180 80 180 120 {lab=gd}
N 120 120 180 120 {lab=gd}
N 20 80 20 120 {lab=gd}
N 120 120 120 190 {lab=gd}
N 20 120 120 120 {lab=gd}
N 110 -210 110 -120 {lab=vp}
N -10 190 120 190 {lab=gd}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 60 -30 0 0 {name=M1
l=0.15u
w=0.3u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 60 -120 0 0 {name=M4
l=0.15u
w=0.3u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} 80 -220 0 0 {name=p1 lab=vp}
C {ipin.sym} -10 190 0 0 {name=p2 lab=gd}
C {ipin.sym} -70 -30 0 0 {name=p3 lab=B}
C {ipin.sym} -70 -60 0 0 {name=p4 lab=A}
C {opin.sym} 240 30 0 0 {name=p5 lab=Out}
C {lab_wire.sym} -10 -30 0 0 {name=p6 sig_type=std_logic lab=A}
C {lab_wire.sym} -10 -120 0 0 {name=p7 sig_type=std_logic lab=B}
C {lab_wire.sym} -70 80 0 0 {name=p8 sig_type=std_logic lab=A}
C {lab_wire.sym} 70 80 0 0 {name=p9 sig_type=std_logic lab=B}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -30 80 0 0 {name=M2
l=0.15u
w=0.3u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 120 80 0 0 {name=M3
l=0.15u
w=0.3u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
