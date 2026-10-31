v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -90 -40 -90 60 {lab=A}
N 70 60 140 60 {lab=B}
N 140 -30 140 60 {lab=B}
N 70 -120 140 -120 {lab=B}
N 140 -30 190 -30 {lab=B}
N 140 -120 140 -30 {lab=B}
N -130 -40 -90 -40 {lab=A}
N -90 -120 -90 -40 {lab=A}
N 40 100 40 140 {lab=in_n}
N 40 -200 40 -160 {lab=in_p}
N 40 -120 40 -40 {lab=vp}
N -90 -120 10 -120 {lab=A}
N -90 60 10 60 {lab=A}
N -70 -40 40 -40 {lab=vp}
N -70 -70 -70 -40 {lab=vp}
N -80 -10 40 -10 {lab=gnd}
N -80 -10 -80 0 {lab=gnd}
N 40 -10 40 60 {lab=gnd}
C {sg13g2_pr/sg13_lv_pmos.sym} 40 -140 3 1 {name=M4
l=0.15u
w=0.3u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 40 80 1 1 {name=M5
l=0.15u
w=0.3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} 40 140 0 0 {name=p6 lab=in_n}
C {ipin.sym} 40 -200 0 0 {name=p8 lab=in_p}
C {iopin.sym} -70 -70 1 1 {name=p9 lab=vp
}
C {iopin.sym} -80 0 1 0 {name=p10 lab=gnd}
C {iopin.sym} 190 -30 0 0 {name=p11 lab=B
}
C {iopin.sym} -130 -40 0 1 {name=p12 lab=A
}
