v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 180 -870 180 -830 {lab=vp}
N 640 -870 900 -870 {lab=vp}
N 900 -870 900 -830 {lab=vp}
N 640 -870 640 -830 {lab=vp}
N 420 -870 640 -870 {lab=vp}
N 420 -870 420 -830 {lab=vp}
N 180 -870 420 -870 {lab=vp}
N 420 -800 430 -800 {lab=vp}
N 430 -830 430 -800 {lab=vp}
N 420 -830 430 -830 {lab=vp}
N 630 -800 640 -800 {lab=vp}
N 630 -830 630 -800 {lab=vp}
N 630 -830 640 -830 {lab=vp}
N 170 -800 180 -800 {lab=vp}
N 170 -830 170 -800 {lab=vp}
N 170 -830 180 -830 {lab=vp}
N 180 -770 180 -700 {lab=#net1}
N 180 -770 220 -770 {lab=#net1}
N 220 -800 220 -770 {lab=#net1}
N 220 -800 380 -800 {lab=#net1}
N 900 -830 910 -830 {lab=vp}
N 910 -830 910 -800 {lab=vp}
N 900 -800 910 -800 {lab=vp}
N 680 -800 860 -800 {lab=#net2}
N 900 -770 900 -540 {lab=#net2}
N 860 -800 860 -770 {lab=#net2}
N 860 -770 900 -770 {lab=#net2}
N 900 -510 910 -510 {lab=gd}
N 910 -510 910 -480 {lab=gd}
N 900 -480 910 -480 {lab=gd}
N 900 -410 900 -390 {lab=vp}
N 900 -330 900 -150 {lab=#net3}
N 900 -360 910 -360 {lab=vp}
N 910 -390 910 -360 {lab=vp}
N 900 -390 910 -390 {lab=vp}
N 900 -120 910 -120 {lab=gd}
N 910 -120 910 -90 {lab=gd}
N 900 -90 910 -90 {lab=gd}
N 680 -120 860 -120 {lab=#net3}
N 860 -150 860 -120 {lab=#net3}
N 860 -150 900 -150 {lab=#net3}
N 680 -240 740 -240 {lab=dn}
N 220 -120 380 -120 {lab=#net4}
N 180 -230 180 -150 {lab=#net4}
N 180 -310 180 -290 {lab=vp}
N 220 -150 220 -120 {lab=#net4}
N 180 -150 220 -150 {lab=#net4}
N 330 -300 380 -300 {lab=dn}
N 420 -120 430 -120 {lab=gd}
N 430 -120 430 -90 {lab=gd}
N 420 -90 430 -90 {lab=gd}
N 630 -120 640 -120 {lab=gd}
N 630 -120 630 -90 {lab=gd}
N 630 -90 640 -90 {lab=gd}
N 420 -300 430 -300 {lab=gd}
N 630 -240 640 -240 {lab=gd}
N 640 -360 860 -360 {lab=vout}
N 420 -360 420 -330 {lab=vout}
N 640 -360 640 -270 {lab=vout}
N 420 -360 640 -360 {lab=vout}
N 640 -550 640 -510 {lab=vout}
N 420 -550 420 -510 {lab=vout}
N 420 -510 640 -510 {lab=vout}
N 640 -510 860 -510 {lab=vout}
N 340 -430 420 -430 {lab=vout}
N 640 -770 640 -610 {lab=#net5}
N 420 -580 430 -580 {lab=vp}
N 630 -580 640 -580 {lab=vp}
N 330 -580 380 -580 {lab=upb}
N 680 -580 730 -580 {lab=upb}
N 640 -210 640 -150 {lab=#net6}
N 170 -90 180 -90 {lab=gd}
N 170 -120 170 -90 {lab=gd}
N 170 -120 180 -120 {lab=gd}
N 420 -510 420 -430 {lab=vout}
N 420 -430 420 -360 {lab=vout}
N 420 -270 420 -150 {lab=#net7}
N 420 -770 420 -610 {lab=#net8}
N 180 -90 180 -60 {lab=gd}
N 640 -60 900 -60 {lab=gd}
N 900 -90 900 -60 {lab=gd}
N 420 -90 420 -60 {lab=gd}
N 180 -60 420 -60 {lab=gd}
N 640 -90 640 -60 {lab=gd}
N 420 -60 640 -60 {lab=gd}
N 900 -480 900 -460 {lab=gd}
N 180 -640 180 -610 {lab=gd}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -800 0 1 {name=M3
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -800 0 0 {name=M1
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 660 -800 0 1 {name=M2
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 880 -800 0 0 {name=M4
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 660 -580 0 1 {name=M5
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -580 0 0 {name=M6
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 880 -510 0 0 {name=M18
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 880 -360 0 0 {name=M7
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 880 -120 0 0 {name=M8
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -300 0 0 {name=M9
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -120 0 0 {name=M10
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 660 -240 0 1 {name=M11
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 660 -120 0 1 {name=M12
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -120 0 1 {name=M14
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 180 -670 0 0 {name=Ichar value=50e-06}
C {lab_pin.sym} 900 -410 0 0 {name=p1 sig_type=std_logic lab=vp}
C {isource.sym} 180 -260 0 0 {name=Idisch value=50e-06}
C {lab_pin.sym} 180 -310 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_pin.sym} 430 -580 0 0 {name=p6 sig_type=std_logic lab=vp}
C {lab_pin.sym} 630 -580 0 0 {name=p7 sig_type=std_logic lab=vp}
C {iopin.sym} 420 -870 0 1 {name=p10 lab=vp
}
C {ipin.sym} 330 -580 0 0 {name=p11 lab=upb}
C {opin.sym} 340 -430 0 1 {name=p12 lab=vout
}
C {ipin.sym} 330 -300 0 0 {name=p4 lab=dn}
C {iopin.sym} 640 -60 0 0 {name=p5 lab=gd}
C {lab_pin.sym} 430 -300 0 1 {name=p8 sig_type=std_logic lab=gd}
C {lab_pin.sym} 630 -240 0 0 {name=p13 sig_type=std_logic lab=gd}
C {lab_pin.sym} 900 -460 0 0 {name=p14 sig_type=std_logic lab=gd}
C {lab_pin.sym} 180 -610 0 0 {name=p15 sig_type=std_logic lab=gd}
C {lab_pin.sym} 730 -580 0 1 {name=p2 sig_type=std_logic lab=upb}
C {lab_pin.sym} 740 -240 0 1 {name=p9 sig_type=std_logic lab=dn}
