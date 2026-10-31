v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -250 -140 -210 -140 {lab=vp}
N -250 -100 -210 -100 {lab=gnd}
N 340 -30 340 60 {lab=2th}
N 380 -190 380 -120 {lab=vp}
N 380 60 380 120 {lab=gnd}
N 260 -30 260 30 {lab=2th}
N 260 -190 260 -120 {lab=vp}
N 260 60 260 120 {lab=gnd}
N 260 -190 380 -190 {lab=vp}
N 260 120 380 120 {lab=gnd}
N 260 -30 340 -30 {lab=2th}
N 260 -90 260 -30 {lab=2th}
N 340 -120 340 -30 {lab=2th}
N 220 -30 220 60 {lab=1th}
N 380 -30 380 30 {lab=3th}
N 460 -30 460 60 {lab=3th}
N 500 -190 500 -120 {lab=vp}
N 500 60 500 120 {lab=gnd}
N 380 -190 500 -190 {lab=vp}
N 380 120 500 120 {lab=gnd}
N 380 -30 460 -30 {lab=3th}
N 460 -120 460 -30 {lab=3th}
N 500 -30 500 30 {lab=4th}
N 380 -90 380 -30 {lab=3th}
N 580 -30 580 60 {lab=4th}
N 620 -190 620 -120 {lab=vp}
N 620 60 620 120 {lab=gnd}
N 500 -190 620 -190 {lab=vp}
N 500 120 620 120 {lab=gnd}
N 500 -30 580 -30 {lab=4th}
N 580 -120 580 -30 {lab=4th}
N 620 -30 620 30 {lab=5th}
N 500 -90 500 -30 {lab=4th}
N 620 -30 700 -30 {lab=5th}
N 620 -90 620 -30 {lab=5th}
N 740 -190 740 -120 {lab=vp}
N 740 60 740 120 {lab=gnd}
N 620 -190 740 -190 {lab=vp}
N 620 120 740 120 {lab=gnd}
N 740 -30 740 30 {lab=out}
N 700 -30 700 60 {lab=5th}
N 700 -120 700 -30 {lab=5th}
N 740 -30 880 -30 {lab=out}
N 740 -90 740 -30 {lab=out}
N 20 -190 20 -140 {lab=vp}
N 20 -30 20 50 {lab=1th}
N -20 -140 -20 80 {lab=in}
N 20 -30 220 -30 {lab=1th}
N 20 -110 20 -30 {lab=1th}
N 220 -120 220 -30 {lab=1th}
N 20 120 260 120 {lab=gnd}
N 20 80 20 120 {lab=gnd}
N 20 -190 260 -190 {lab=vp}
C {ipin.sym} -20 -30 0 0 {name=p23 lab=in}
C {opin.sym} 880 -30 0 0 {name=p24 lab=out}
C {iopin.sym} -250 -140 0 1 {name=p3 lab=vp
}
C {iopin.sym} -250 -100 0 1 {name=p32 lab=gnd}
C {lab_wire.sym} 300 -190 0 0 {name=p9 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 260 120 0 0 {name=p16 sig_type=std_logic lab=gnd
}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -120 0 0 {name=M9
l=0.13u
w=2.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 60 0 0 {name=M10
l=0.13u
w=2.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 240 -120 0 0 {name=M11
l=0.13u
w=2.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 240 60 0 0 {name=M12
l=0.13u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 480 -120 0 0 {name=M1
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 480 60 0 0 {name=M2
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 600 -120 0 0 {name=M3
l=0.13u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 600 60 0 0 {name=M4
l=0.13u
w=10u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 720 -120 0 0 {name=M5
l=0.13u
w=10u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 720 60 0 0 {name=M6
l=0.13u
w=10u
ng=1
m=2
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 0 80 0 0 {name=M7
l=0.13u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 0 -140 0 0 {name=M8
l=0.13u
w=1.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 130 -30 0 0 {name=p1 sig_type=std_logic lab=1th
}
C {lab_wire.sym} 310 -30 0 0 {name=p2 sig_type=std_logic lab=2th
}
C {lab_wire.sym} 440 -30 0 0 {name=p4 sig_type=std_logic lab=3th
}
C {lab_wire.sym} 540 -30 0 0 {name=p5 sig_type=std_logic lab=4th
}
C {lab_wire.sym} 670 -30 0 0 {name=p6 sig_type=std_logic lab=5th
}
