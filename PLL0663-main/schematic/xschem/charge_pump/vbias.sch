v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -360 120 -340 {lab=#net1}
N 120 -260 120 -250 {lab=vbias}
N 120 -150 120 -130 {lab=#net2}
N 60 -100 80 -100 {lab=#net2}
N 60 -150 60 -100 {lab=#net2}
N 60 -150 120 -150 {lab=#net2}
N 120 -190 120 -150 {lab=#net2}
N 60 -220 80 -220 {lab=#net1}
N 60 -360 60 -220 {lab=#net1}
N 60 -360 120 -360 {lab=#net1}
N 120 -380 120 -360 {lab=#net1}
N 120 -260 260 -260 {lab=vbias}
N 120 -280 120 -260 {lab=vbias}
N 120 -220 170 -220 {lab=gd}
N 120 -100 170 -100 {lab=gd}
N 160 -410 180 -410 {lab=iref}
N 120 -460 120 -440 {lab=vp}
N 110 -410 120 -410 {lab=vp}
N 110 -460 110 -410 {lab=vp}
N 110 -460 120 -460 {lab=vp}
N 120 -490 120 -460 {lab=vp}
N 490 -370 530 -370 {lab=vp}
N 490 -350 540 -350 {lab=iref}
N 490 -330 540 -330 {lab=gd}
N 120 -70 120 -40 {lab=gd}
N 270 -140 310 -140 {lab=gd}
N 270 -140 270 -80 {lab=gd}
N 270 -80 330 -80 {lab=gd}
N 330 -110 330 -80 {lab=gd}
N 310 -110 330 -110 {lab=gd}
N 530 -140 570 -140 {lab=vp}
N 570 -140 570 -80 {lab=vp}
N 520 -80 570 -80 {lab=vp}
N 520 -110 520 -80 {lab=vp}
N 520 -110 530 -110 {lab=vp}
C {lab_pin.sym} 120 -490 0 1 {name=p5 sig_type=std_logic lab=vp}
C {lab_pin.sym} 180 -410 0 1 {name=p13 sig_type=std_logic lab=iref}
C {opin.sym} 260 -260 0 0 {name=p14 lab=vbias}
C {iopin.sym} 540 -330 0 0 {name=p21 lab=gd}
C {iopin.sym} 530 -370 0 0 {name=p22 lab=vp}
C {lab_pin.sym} 540 -350 0 1 {name=p1 sig_type=std_logic lab=iref}
C {lab_pin.sym} 120 -40 0 1 {name=p2 sig_type=std_logic lab=gd}
C {lab_pin.sym} 170 -100 0 1 {name=p3 sig_type=std_logic lab=gd}
C {lab_pin.sym} 170 -220 0 1 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 330 -80 0 1 {name=p6 sig_type=std_logic lab=gd}
C {lab_pin.sym} 570 -80 0 1 {name=p7 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 140 -410 0 1 {name=M5
l=0.6u
w=1.2u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 100 -220 0 0 {name=M6
l=0.6u
w=3.6u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 100 -100 0 0 {name=M2
l=0.6u
w=1.2u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 290 -110 0 0 {name=M3
l=0.6u
w=1.86u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 550 -110 0 1 {name=M7
l=0.6u
w=1.375u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} 120 -310 0 0 {name=R1
w=1e-6
l=1.7e-6
model=rppd
body=gd
spiceprefix=X
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/curr_source.sym} 340 -350 0 0 {name=x1}
