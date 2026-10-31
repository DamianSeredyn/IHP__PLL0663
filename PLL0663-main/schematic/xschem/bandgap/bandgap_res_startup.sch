v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 -70 160 -0 {lab=gd}
N 0 -0 160 -0 {lab=gd}
N 380 -340 460 -340 {lab=vp}
N 380 -410 380 -370 {lab=vp}
N 380 -310 380 -220 {lab=su_gm}
N 380 -220 410 -220 {lab=su_gm}
N 560 -340 640 -340 {lab=vp}
N 560 -410 560 -370 {lab=vp}
N 560 -310 560 -220 {lab=su_bg}
N 560 -220 590 -220 {lab=su_bg}
N 320 -280 370 -280 {lab=vcap}
N 370 -290 370 -280 {lab=vcap}
N 370 -290 390 -290 {lab=vcap}
N 390 -290 390 -280 {lab=vcap}
N 390 -280 500 -280 {lab=vcap}
N 500 -340 500 -280 {lab=vcap}
N 500 -340 520 -340 {lab=vcap}
N 320 -340 340 -340 {lab=vcap}
N 320 -340 320 -280 {lab=vcap}
N 380 -410 560 -410 {lab=vp}
N 160 -410 160 -370 {lab=vp}
N 0 -410 160 -410 {lab=vp}
N 160 -280 160 -130 {lab=vcap}
N 160 -310 160 -280 {lab=vcap}
N 160 -410 380 -410 {lab=vp}
N 160 -280 320 -280 {lab=vcap}
C {sg13cmos5l_pr/cap_mfringe.sym} 160 -100 2 1 {name=C2
model=cap_mfringe
w=10.0u
l=7.3u
mmin=1
mmax=3
spiceprefix=X
}
C {ipin.sym} 0 -410 0 0 {name=p1 lab=vp}
C {ipin.sym} 0 0 0 0 {name=p2 lab=gd}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 360 -340 0 0 {name=M3
l=2u
w=0.6u
ng=1
m=3
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 440 -340 0 1 {name=p4 sig_type=std_logic lab=vp}
C {opin.sym} 410 -220 0 0 {name=p6 lab=su_gm}
C {lab_wire.sym} 290 -280 0 0 {name=p8 sig_type=std_logic lab=vcap}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 540 -340 0 0 {name=M4
l=2u
w=0.6u
ng=1
m=3
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 620 -340 0 1 {name=p9 sig_type=std_logic lab=vp}
C {opin.sym} 590 -220 0 0 {name=p10 lab=su_bg}
C {sg13cmos5l_pr/rhigh.sym} 160 -340 0 0 {name=R1
w=0.5e-6
l=6.72e-6
model=rhigh
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 1.6e-4 / @w + 1360.0 * ( (@b + 1)* @l + ( 1.081*( @w - 0.04e-6 ) + 0.18e-6 )*@b ) / ( @w - 0.04e-6 ) ) / @m  )"
}
