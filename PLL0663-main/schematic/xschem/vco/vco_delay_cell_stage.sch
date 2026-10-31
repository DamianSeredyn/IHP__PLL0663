v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1080 -440 1080 -310 {lab=up}
N 1040 -220 1040 -130 {lab=in}
N 1080 -220 1080 -160 {lab=out}
N 1000 -220 1040 -220 {lab=in}
N 1040 -310 1040 -220 {lab=in}
N 1080 -130 1080 -10 {lab=dn}
N 1080 -220 1150 -220 {lab=out}
N 1080 -280 1080 -220 {lab=out}
N 990 -470 1040 -470 {lab=pgt}
N 1000 20 1040 20 {lab=ngt}
N 1080 20 1080 100 {lab=gnd}
N 1080 -560 1080 -470 {lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 1060 -470 0 0 {name=M23
l=\{Lcs\}
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1060 -310 0 0 {name=M24
l=\{Ldrv\}
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1060 -130 0 0 {name=M25
l=\{Ldrv\}
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1060 20 0 0 {name=M26
l=\{Lcs\}
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 1080 -390 0 0 {name=p21 sig_type=std_logic lab=up
}
C {lab_wire.sym} 1080 -50 0 0 {name=p22 sig_type=std_logic lab=dn}
C {ipin.sym} 1000 -220 0 0 {name=p23 lab=in}
C {opin.sym} 1150 -220 0 0 {name=p24 lab=out}
C {iopin.sym} 1080 100 0 1 {name=p20 lab=gnd}
C {iopin.sym} 1080 -560 0 1 {name=p25 lab=vp
}
C {iopin.sym} 990 -470 0 1 {name=p26 lab=pgt
}
C {iopin.sym} 1000 20 0 1 {name=p27 lab=ngt}
