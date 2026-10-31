v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -330 120 -300 {lab=#net1}
N 240 -150 260 -150 {lab=#net1}
N 240 -200 240 -150 {lab=#net1}
N 190 -150 240 -150 {lab=#net1}
N 240 -200 400 -200 {lab=#net1}
N 400 -200 400 -150 {lab=#net1}
N 400 -150 420 -150 {lab=#net1}
N 300 -240 300 -180 {lab=#net2}
N 300 -100 300 -80 {lab=gd}
N 300 -80 460 -80 {lab=gd}
N 460 -110 460 -80 {lab=gd}
N 120 -80 300 -80 {lab=gd}
N 120 -90 120 -80 {lab=gd}
N 120 -240 120 -180 {lab=#net3}
N 190 -330 190 -150 {lab=#net1}
N 160 -150 190 -150 {lab=#net1}
N 120 -330 190 -330 {lab=#net1}
N 120 -400 120 -330 {lab=#net1}
N 240 -270 260 -270 {lab=dn}
N 240 -320 240 -270 {lab=dn}
N 160 -270 240 -270 {lab=dn}
N 240 -320 400 -320 {lab=dn}
N 400 -320 400 -270 {lab=dn}
N 400 -270 420 -270 {lab=dn}
N 460 -240 460 -180 {lab=#net4}
N 460 -330 460 -300 {lab=vout}
N 460 -510 460 -430 {lab=#net5}
N 360 -540 420 -540 {lab=#net6}
N 300 -510 300 -430 {lab=#net7}
N 300 -340 300 -300 {lab=#net6}
N 340 -400 420 -400 {lab=up}
N 300 -340 360 -340 {lab=#net6}
N 300 -370 300 -340 {lab=#net6}
N 360 -540 360 -340 {lab=#net6}
N 340 -540 360 -540 {lab=#net6}
N 120 -600 120 -460 {lab=vp}
N 120 -600 300 -600 {lab=vp}
N 300 -580 300 -570 {lab=vp}
N 300 -600 460 -600 {lab=vp}
N 460 -580 460 -570 {lab=vp}
N 460 -330 550 -330 {lab=vout}
N 460 -370 460 -330 {lab=vout}
N 100 -150 120 -150 {lab=gd}
N 100 -150 100 -90 {lab=gd}
N 100 -90 120 -90 {lab=gd}
N 120 -120 120 -90 {lab=gd}
N 300 -150 310 -150 {lab=gd}
N 310 -150 310 -100 {lab=gd}
N 300 -100 310 -100 {lab=gd}
N 300 -120 300 -100 {lab=gd}
N 460 -150 470 -150 {lab=gd}
N 470 -150 470 -110 {lab=gd}
N 460 -110 470 -110 {lab=gd}
N 460 -120 460 -110 {lab=gd}
N 110 -270 120 -270 {lab=gd}
N 300 -270 310 -270 {lab=gd}
N 460 -270 470 -270 {lab=gd}
N 290 -400 300 -400 {lab=vp}
N 460 -400 470 -400 {lab=vp}
N 280 -540 300 -540 {lab=vp}
N 280 -580 280 -540 {lab=vp}
N 280 -580 300 -580 {lab=vp}
N 300 -600 300 -580 {lab=vp}
N 460 -540 470 -540 {lab=vp}
N 470 -580 470 -540 {lab=vp}
N 460 -580 470 -580 {lab=vp}
N 460 -600 460 -580 {lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 320 -540 0 1 {name=M3
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 280 -270 0 0 {name=M9
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 440 -540 0 0 {name=M1
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 320 -400 0 1 {name=M2
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 440 -400 0 0 {name=M4
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 440 -270 0 0 {name=M5
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 280 -150 0 0 {name=M6
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 440 -150 0 0 {name=M7
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 -150 0 1 {name=M8
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 -270 0 1 {name=M10
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 120 -430 0 0 {name=I0 value=50e-06}
C {ipin.sym} 370 -400 0 1 {name=p1 lab=up}
C {ipin.sym} 270 -320 0 0 {name=p2 lab=dn}
C {opin.sym} 550 -330 0 0 {name=p3 lab=vout}
C {iopin.sym} 220 -600 0 0 {name=p4 lab=vp}
C {iopin.sym} 230 -80 0 0 {name=p5 lab=gd}
C {lab_pin.sym} 110 -270 0 0 {name=p7 sig_type=std_logic lab=gd}
C {lab_pin.sym} 310 -270 0 1 {name=p8 sig_type=std_logic lab=gd}
C {lab_pin.sym} 470 -270 0 1 {name=p9 sig_type=std_logic lab=gd}
C {lab_pin.sym} 470 -400 0 1 {name=p10 sig_type=std_logic lab=vp}
C {lab_pin.sym} 290 -400 0 0 {name=p11 sig_type=std_logic lab=vp}
