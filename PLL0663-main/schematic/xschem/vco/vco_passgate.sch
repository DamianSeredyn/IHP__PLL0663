v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 210 -150 210 -80 {lab=OI}
N 70 -150 70 -80 {lab=IO}
N 210 -150 230 -150 {lab=OI}
N 210 -220 210 -150 {lab=OI}
N 50 -150 70 -150 {lab=IO}
N 70 -220 70 -150 {lab=IO}
N 140 -40 140 -20 {lab=en}
N 140 -220 140 -200 {lab=VP}
N 140 -200 180 -200 {lab=VP}
N 140 -100 140 -80 {lab=GND}
N 100 -100 140 -100 {lab=GND}
N 70 -80 110 -80 {lab=IO}
N 170 -80 210 -80 {lab=OI}
N 170 -220 210 -220 {lab=OI}
N 70 -220 110 -220 {lab=IO}
N 140 -280 140 -260 {lab=en_}
N 130 -20 140 -20 {lab=en}
N 130 -280 140 -280 {lab=en_}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 -60 3 0 {name=M1
l=0.13u
w=2.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 140 -240 1 0 {name=M2
l=0.13u
w=2.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 230 -150 0 0 {name=p1 lab=OI}
C {iopin.sym} 50 -150 2 0 {name=p3 lab=IO}
C {iopin.sym} 180 -200 1 0 {name=p5 lab=VP}
C {iopin.sym} 100 -100 3 0 {name=p7 lab=GND}
C {ipin.sym} 130 -280 0 0 {name=p2 lab=en_}
C {ipin.sym} 130 -20 0 0 {name=p4 lab=en}
