v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 70 -0 70 {lab=in}
N -40 10 -40 70 {lab=in}
N -40 -50 -0 -50 {lab=in}
N -90 10 -40 10 {lab=in}
N -40 -50 -40 10 {lab=in}
N 40 10 40 40 {lab=out_stage1}
N 40 -20 40 10 {lab=out_stage1}
N 40 100 40 220 {lab=gnd}
N 210 10 210 40 {lab=out}
N 170 10 170 70 {lab=out_stage1}
N 170 -50 170 10 {lab=out_stage1}
N -140 -250 -110 -250 {lab=gnd}
N -140 -220 -110 -220 {lab=vp}
N 40 10 170 10 {lab=out_stage1}
N 210 10 430 10 {lab=out}
N 210 -20 210 10 {lab=out}
N 210 -160 210 -80 {lab=vp}
N 70 -160 210 -160 {lab=vp}
N 40 -160 40 -80 {lab=vp}
N 130 220 210 220 {lab=gnd}
N 210 100 210 220 {lab=gnd}
N 130 220 130 230 {lab=gnd}
N 70 220 130 220 {lab=gnd}
N 70 70 70 220 {lab=gnd}
N 40 220 70 220 {lab=gnd}
N 210 70 250 70 {lab=gnd}
N 250 70 250 220 {lab=gnd}
N 210 220 250 220 {lab=gnd}
N 40 -50 70 -50 {lab=vp}
N 70 -160 70 -50 {lab=vp}
N 40 -160 70 -160 {lab=vp}
N 230 -160 230 -50 {lab=vp}
N 210 -160 230 -160 {lab=vp}
N 210 -50 230 -50 {lab=vp}
N 30 70 70 70 {lab=gnd}
C {sg13g2_pr/sg13_lv_nmos.sym} 20 70 0 0 {name=M1
l=0.75u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -50 0 0 {name=M4
l=0.75u
w=0.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 70 0 0 {name=M2
l=0.75u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 190 -50 0 0 {name=M3
l=0.75u
w=0.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -110 -250 0 0 {name=p1 lab=gnd}
C {iopin.sym} -110 -220 0 0 {name=p2 lab=vp
}
C {ipin.sym} -90 10 0 0 {name=p5 lab=in
}
C {lab_wire.sym} 130 -160 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 130 230 0 0 {name=p12 sig_type=std_logic lab=gnd}
C {iopin.sym} 430 10 0 0 {name=p6 lab=out
}
C {lab_wire.sym} 130 10 0 0 {name=p8 sig_type=std_logic lab=out_stage1}
