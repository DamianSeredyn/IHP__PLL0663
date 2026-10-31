v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 0 0 10 {lab=OUT}
N -70 40 -40 40 {lab=IN}
N -70 0 -70 40 {lab=IN}
N -70 -40 -40 -40 {lab=IN}
N -0 150 0 170 {lab=GND}
N 30 40 30 150 {lab=GND}
N -80 0 -70 0 {lab=IN}
N -70 -40 -70 0 {lab=IN}
N 0 0 50 0 {lab=OUT}
N 0 -10 0 0 {lab=OUT}
N 0 -40 30 -40 {lab=VP}
N 0 40 30 40 {lab=GND}
N -0 150 30 150 {lab=GND}
N 0 70 -0 150 {lab=GND}
N 0 -130 0 -70 {lab=VP}
N 30 -130 30 -40 {lab=VP}
N 0 -130 30 -130 {lab=VP}
N -0 -160 0 -130 {lab=VP}
C {sg13g2_pr/sg13_lv_nmos.sym} -20 40 0 0 {name=M1
l=0.13u
w=0.60u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -20 -40 0 0 {name=M2
l=0.13u
w=0.60u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -80 0 0 0 {name=p2 lab=IN}
C {iopin.sym} 0 -160 3 0 {name=p3 lab=VP}
C {opin.sym} 50 0 0 0 {name=p4 lab=OUT}
C {iopin.sym} 0 170 1 0 {name=p1 lab=GND}
