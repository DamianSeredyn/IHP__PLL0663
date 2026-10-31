v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 280 -500 280 -480 {lab=#net1}
N 360 -480 500 -480 {lab=#net1}
N 500 -500 500 -480 {lab=#net1}
N 360 -480 360 -440 {lab=#net1}
N 280 -480 360 -480 {lab=#net1}
N 290 -410 320 -410 {lab=#net2}
N 150 -460 150 -440 {lab=#net2}
N 220 -460 220 -410 {lab=#net2}
N 190 -410 220 -410 {lab=#net2}
N 150 -460 220 -460 {lab=#net2}
N 150 -560 150 -460 {lab=#net2}
N 150 -360 150 -340 {lab=gd}
N 360 -340 640 -340 {lab=gd}
N 640 -360 640 -340 {lab=gd}
N 360 -360 360 -340 {lab=gd}
N 150 -340 360 -340 {lab=gd}
N 640 -530 640 -440 {lab=vampout}
N 540 -530 560 -530 {lab=vin2}
N 220 -530 240 -530 {lab=vin1}
N 280 -620 280 -560 {lab=#net3}
N 340 -680 460 -680 {lab=#net3}
N 280 -620 340 -620 {lab=#net3}
N 280 -650 280 -620 {lab=#net3}
N 340 -680 340 -620 {lab=#net3}
N 320 -680 340 -680 {lab=#net3}
N 640 -650 640 -610 {lab=vampout}
N 590 -610 640 -610 {lab=vampout}
N 150 -750 150 -620 {lab=vp}
N 500 -750 640 -750 {lab=vp}
N 640 -720 640 -710 {lab=vp}
N 500 -720 500 -710 {lab=vp}
N 280 -750 500 -750 {lab=vp}
N 280 -720 280 -710 {lab=vp}
N 150 -750 280 -750 {lab=vp}
N 290 -460 290 -410 {lab=#net2}
N 220 -410 290 -410 {lab=#net2}
N 290 -460 560 -460 {lab=#net2}
N 560 -460 560 -410 {lab=#net2}
N 560 -410 600 -410 {lab=#net2}
N 640 -530 670 -530 {lab=vampout}
N 640 -610 640 -530 {lab=vampout}
N 270 -680 280 -680 {lab=vp}
N 270 -720 270 -680 {lab=vp}
N 270 -720 280 -720 {lab=vp}
N 280 -750 280 -720 {lab=vp}
N 500 -680 510 -680 {lab=vp}
N 510 -720 510 -680 {lab=vp}
N 500 -720 510 -720 {lab=vp}
N 500 -750 500 -720 {lab=vp}
N 640 -680 650 -680 {lab=vp}
N 650 -720 650 -680 {lab=vp}
N 640 -720 650 -720 {lab=vp}
N 640 -750 640 -720 {lab=vp}
N 280 -530 290 -530 {lab=gd}
N 490 -530 500 -530 {lab=gd}
N 360 -410 370 -410 {lab=gd}
N 370 -410 370 -360 {lab=gd}
N 360 -360 370 -360 {lab=gd}
N 360 -380 360 -360 {lab=gd}
N 140 -410 150 -410 {lab=gd}
N 140 -410 140 -360 {lab=gd}
N 140 -360 150 -360 {lab=gd}
N 150 -380 150 -360 {lab=gd}
N 640 -410 650 -410 {lab=gd}
N 650 -410 650 -360 {lab=gd}
N 640 -360 650 -360 {lab=gd}
N 640 -380 640 -360 {lab=gd}
N 590 -680 600 -680 {lab=vampout}
N 590 -680 590 -610 {lab=vampout}
N 500 -610 500 -560 {lab=vampout}
N 500 -610 590 -610 {lab=vampout}
N 500 -650 500 -610 {lab=vampout}
C {sg13g2_pr/sg13_lv_pmos.sym} 480 -680 0 0 {name=M3
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 520 -530 0 1 {name=M10
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 300 -680 0 1 {name=M1
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 260 -530 0 0 {name=M2
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 340 -410 0 0 {name=M4
l=1u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 -410 0 1 {name=M5
l=1u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 620 -680 0 0 {name=M6
l=0.13u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 620 -410 0 0 {name=M7
l=0.13u
w=10u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 150 -590 0 0 {name=I0 value=10e-06}
C {ipin.sym} 220 -530 0 0 {name=p11 lab=vin1}
C {ipin.sym} 560 -530 0 1 {name=p1 lab=vin2}
C {ipin.sym} 670 -530 0 1 {name=p2 lab=vampout}
C {iopin.sym} 390 -750 0 1 {name=p10 lab=vp
}
C {iopin.sym} 360 -340 0 1 {name=p3 lab=gd
}
C {lab_pin.sym} 290 -530 0 1 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 490 -530 0 0 {name=p5 sig_type=std_logic lab=gd}
