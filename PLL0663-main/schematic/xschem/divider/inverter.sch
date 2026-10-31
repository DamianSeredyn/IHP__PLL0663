v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -30 -10 -20 {lab=OUT}
N -80 10 -50 10 {lab=IN}
N -80 -30 -80 10 {lab=IN}
N -80 -70 -50 -70 {lab=IN}
N 20 -110 20 -70 {lab=VP}
N -10 -110 20 -110 {lab=VP}
N -10 -110 -10 -100 {lab=VP}
N -10 40 -10 50 {lab=GND}
N -10 50 20 50 {lab=GND}
N 20 10 20 50 {lab=GND}
N -90 -30 -80 -30 {lab=IN}
N -80 -70 -80 -30 {lab=IN}
N -10 -30 40 -30 {lab=OUT}
N -10 -40 -10 -30 {lab=OUT}
N -10 -120 -10 -110 {lab=VP}
N -10 50 -10 60 {lab=GND}
N -10 -70 20 -70 {lab=VP}
N -10 10 20 10 {lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} -30 10 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -30 -70 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -90 -30 0 0 {name=p2 lab=IN}
C {iopin.sym} -10 -120 3 0 {name=p3 lab=VP}
C {opin.sym} 40 -30 0 0 {name=p4 lab=OUT}
C {iopin.sym} -10 60 1 0 {name=p1 lab=GND}
