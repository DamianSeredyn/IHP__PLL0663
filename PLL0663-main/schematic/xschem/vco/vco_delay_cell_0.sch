v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 590 -220 590 -130 {lab=in}
N 630 -220 630 -160 {lab=out}
N 550 -220 590 -220 {lab=in}
N 590 -310 590 -220 {lab=in}
N 630 -220 700 -220 {lab=out}
N 630 -280 630 -220 {lab=out}
N 540 -470 590 -470 {lab=pgt}
N 550 20 590 20 {lab=ngt}
N 630 70 630 100 {lab=gnd}
N 630 -560 630 -470 {lab=vp}
N 630 -100 630 -10 {lab=dn}
N 630 70 740 70 {lab=gnd}
N 630 20 630 70 {lab=gnd}
N 740 -130 740 70 {lab=gnd}
N 630 -130 740 -130 {lab=gnd}
N 630 -310 740 -310 {lab=vp}
N 740 -470 740 -310 {lab=vp}
N 630 -470 740 -470 {lab=vp}
N 630 -440 630 -340 {lab=up}
C {sg13g2_pr/sg13_lv_pmos.sym} 610 -470 0 0 {name=M23
l=0.14*4u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 610 -310 0 0 {name=M1
l=0.14*2u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 610 -130 0 0 {name=M2
l=0.14*2u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 610 20 0 0 {name=M26
l=0.14*4u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 630 -390 0 0 {name=p21 sig_type=std_logic lab=up
}
C {lab_wire.sym} 630 -50 0 0 {name=p22 sig_type=std_logic lab=dn}
C {ipin.sym} 550 -220 0 0 {name=p1 lab=in}
C {opin.sym} 700 -220 0 0 {name=p2 lab=out}
C {iopin.sym} 630 100 0 1 {name=p3 lab=gnd}
C {iopin.sym} 630 -560 0 1 {name=p4 lab=vp
}
C {iopin.sym} 540 -470 0 1 {name=p26 lab=pgt
}
C {iopin.sym} 550 20 0 1 {name=p27 lab=ngt}
