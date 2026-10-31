v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 10 0 10 10 {lab=OUT}
N -60 40 -30 40 {lab=IN}
N -60 0 -60 40 {lab=IN}
N -60 -40 -30 -40 {lab=IN}
N 40 -80 40 -40 {lab=VP}
N 10 -80 40 -80 {lab=VP}
N 10 -80 10 -70 {lab=VP}
N 10 70 10 80 {lab=GND}
N 10 80 40 80 {lab=GND}
N 40 40 40 80 {lab=GND}
N -70 0 -60 0 {lab=IN}
N -60 -40 -60 0 {lab=IN}
N 10 0 60 0 {lab=OUT}
N 10 -10 10 0 {lab=OUT}
N 10 -90 10 -80 {lab=VP}
N 10 80 10 90 {lab=GND}
N 10 -40 40 -40 {lab=VP}
N 10 40 40 40 {lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} -10 40 0 0 {name=M1
l=0.13u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -10 -40 0 0 {name=M2
l=0.13u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -70 0 0 0 {name=p2 lab=IN}
C {iopin.sym} 10 -90 3 0 {name=p3 lab=VP}
C {opin.sym} 60 0 0 0 {name=p4 lab=OUT}
C {iopin.sym} 10 90 1 0 {name=p1 lab=GND}
