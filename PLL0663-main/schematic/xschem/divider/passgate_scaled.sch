v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -120 120 -50 {lab=OI}
N -20 -120 -20 -50 {lab=IO}
N 120 -120 140 -120 {lab=OI}
N 120 -190 120 -120 {lab=OI}
N -40 -120 -20 -120 {lab=IO}
N -20 -190 -20 -120 {lab=IO}
N 50 -10 50 10 {lab=en}
N 50 -190 50 -170 {lab=VP}
N 50 -170 90 -170 {lab=VP}
N 50 -70 50 -50 {lab=GND}
N 10 -70 50 -70 {lab=GND}
N -20 -50 20 -50 {lab=IO}
N 80 -50 120 -50 {lab=OI}
N 80 -190 120 -190 {lab=OI}
N -20 -190 20 -190 {lab=IO}
N 50 -250 50 -230 {lab=en_}
N 40 10 50 10 {lab=en}
N 40 -250 50 -250 {lab=en_}
C {sg13g2_pr/sg13_lv_nmos.sym} 50 -30 3 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 50 -210 1 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 140 -120 0 0 {name=p1 lab=OI}
C {iopin.sym} -40 -120 2 0 {name=p3 lab=IO}
C {iopin.sym} 90 -170 1 0 {name=p5 lab=VP}
C {iopin.sym} 10 -70 3 0 {name=p7 lab=GND}
C {ipin.sym} 40 -250 0 0 {name=p2 lab=en_}
C {ipin.sym} 40 10 0 0 {name=p4 lab=en}
