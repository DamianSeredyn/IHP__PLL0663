v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 -480 160 -440 {lab=vp}
N 320 -480 320 -440 {lab=vp}
N 160 -480 320 -480 {lab=vp}
N 320 -320 320 -300 {lab=net2}
N 220 -410 280 -410 {lab=iref}
N 260 -270 280 -270 {lab=net2}
N 160 -360 220 -360 {lab=iref}
N 160 -380 160 -360 {lab=iref}
N 220 -410 220 -360 {lab=iref}
N 200 -410 220 -410 {lab=iref}
N 160 -80 320 -80 {lab=gd}
N 260 -320 260 -270 {lab=net2}
N 200 -270 260 -270 {lab=net2}
N 260 -320 320 -320 {lab=net2}
N 320 -380 320 -320 {lab=net2}
N 150 -410 160 -410 {lab=vp}
N 320 -410 380 -410 {lab=vp}
N 320 -270 380 -270 {lab=gd}
N 110 -270 160 -270 {lab=gd}
N 160 -240 160 -220 {lab=net1}
N 160 -160 160 -80 {lab=gd}
N 160 -330 160 -300 {lab=iref}
N -70 -480 -70 -430 {lab=vp}
N 20 -480 160 -480 {lab=vp}
N -30 -400 -20 -400 {lab=vp}
N -20 -480 -20 -400 {lab=vp}
N -70 -480 -20 -480 {lab=vp}
N 20 -340 20 -330 {lab=iref}
N 20 -330 160 -330 {lab=iref}
N 160 -360 160 -330 {lab=iref}
N 20 -480 20 -400 {lab=vp}
N -20 -480 20 -480 {lab=vp}
N -70 -250 -70 -220 {lab=#net3}
N -20 -370 -20 -340 {lab=#net3}
N -70 -340 -20 -340 {lab=#net3}
N -70 -370 -70 -340 {lab=#net3}
N -30 -190 -10 -190 {lab=#net3}
N -10 -250 -10 -190 {lab=#net3}
N -70 -250 -10 -250 {lab=#net3}
N -70 -340 -70 -250 {lab=#net3}
N -70 -160 -70 -80 {lab=gd}
N -70 -80 160 -80 {lab=gd}
N -130 -400 -70 -400 {lab=gd}
N -140 -190 -70 -190 {lab=gd}
N 20 -370 90 -370 {lab=gd}
N 320 -240 320 -80 {lab=gd}
N 0 -40 40 -40 {lab=gd}
N 40 -40 40 20 {lab=gd}
N -10 20 40 20 {lab=gd}
N -10 -10 -10 20 {lab=gd}
N -10 -10 -0 -10 {lab=gd}
C {lab_pin.sym} 150 -410 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_pin.sym} 380 -410 0 1 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 380 -270 0 1 {name=p9 sig_type=std_logic lab=gd}
C {lab_pin.sym} 110 -270 0 0 {name=p10 sig_type=std_logic lab=gd}
C {iopin.sym} 180 -480 0 0 {name=p28 lab=vp}
C {iopin.sym} 180 -80 0 0 {name=p29 lab=gd}
C {opin.sym} 220 -360 0 0 {name=p1 lab=iref}
C {lab_pin.sym} 160 -230 0 1 {name=p2 sig_type=std_logic lab=net1}
C {lab_pin.sym} 320 -350 0 1 {name=p3 sig_type=std_logic lab=net2}
C {lab_pin.sym} 90 -370 0 0 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} -130 -400 0 1 {name=p5 sig_type=std_logic lab=gd}
C {lab_pin.sym} -140 -190 0 1 {name=p6 sig_type=std_logic lab=gd}
C {lab_pin.sym} 40 20 0 1 {name=p11 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -50 -190 0 1 {name=M9
l=0.6u
w=1u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 180 -410 0 1 {name=M4
l=0.6u
w=1.4u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 300 -410 0 0 {name=M5
l=0.6u
w=1.2u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 180 -270 0 1 {name=M10
l=0.6u
w=1.2u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 300 -270 0 0 {name=M1
l=0.6u
w=1.4u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -50 -400 0 1 {name=M3
l=0.6u
w=1u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 0 -370 0 0 {name=M6
l=0.6u
w=1u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 20 -10 0 1 {name=M2
l=0.6u
w=0.4u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} 160 -190 0 0 {name=R2
w=1e-6
l=1.7e-6
model=rppd
body=gd
spiceprefix=X
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
