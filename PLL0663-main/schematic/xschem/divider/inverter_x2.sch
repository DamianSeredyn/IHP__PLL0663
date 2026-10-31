v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 30 30 30 40 {lab=OUT}
N -40 70 -10 70 {lab=IN}
N -40 30 -40 70 {lab=IN}
N -40 -10 -10 -10 {lab=IN}
N 60 -50 60 -10 {lab=VP}
N 30 -50 60 -50 {lab=VP}
N 30 -50 30 -40 {lab=VP}
N 30 100 30 110 {lab=GND}
N 30 110 60 110 {lab=GND}
N 60 70 60 110 {lab=GND}
N -50 30 -40 30 {lab=IN}
N -40 -10 -40 30 {lab=IN}
N 30 30 80 30 {lab=OUT}
N 30 20 30 30 {lab=OUT}
N 30 -60 30 -50 {lab=VP}
N 30 110 30 120 {lab=GND}
N 30 -10 60 -10 {lab=VP}
N 30 70 60 70 {lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 10 70 0 0 {name=M1
l=0.13u
w=0.30u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 10 -10 0 0 {name=M2
l=0.13u
w=0.30u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} -50 30 0 0 {name=p2 lab=IN}
C {iopin.sym} 30 -60 3 0 {name=p3 lab=VP}
C {opin.sym} 80 30 0 0 {name=p4 lab=OUT}
C {iopin.sym} 30 120 1 0 {name=p1 lab=GND}
