v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 -20 -130 80 {lab=A}
N 30 80 100 80 {lab=B}
N 100 -10 100 80 {lab=B}
N 30 -100 100 -100 {lab=B}
N 100 -10 150 -10 {lab=B}
N 100 -100 100 -10 {lab=B}
N -170 -20 -130 -20 {lab=A}
N -130 -100 -130 -20 {lab=A}
N -0 120 0 160 {lab=in_n}
N -0 -180 -0 -140 {lab=in_p}
N 0 -100 -0 -20 {lab=vp}
N -130 -100 -30 -100 {lab=A}
N -130 80 -30 80 {lab=A}
N -110 -20 -0 -20 {lab=vp}
N -110 -50 -110 -20 {lab=vp}
N -120 10 -0 10 {lab=gnd}
N -120 10 -120 20 {lab=gnd}
N 0 10 -0 80 {lab=gnd}
C {sg13g2_pr/sg13_lv_pmos.sym} 0 -120 3 1 {name=M4
l=0.15u
w=0.3u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 0 100 1 1 {name=M5
l=0.15u
w=0.3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} 0 160 0 0 {name=p4 lab=in_n}
C {ipin.sym} 0 -180 0 0 {name=p6 lab=in_p}
C {iopin.sym} -110 -50 1 1 {name=p7 lab=vp
}
C {iopin.sym} -120 20 1 0 {name=p8 lab=gnd}
C {iopin.sym} 150 -10 0 0 {name=p1 lab=B
}
C {iopin.sym} -170 -20 0 1 {name=p2 lab=A
}
