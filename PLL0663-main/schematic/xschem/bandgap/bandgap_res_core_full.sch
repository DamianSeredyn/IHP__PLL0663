v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 370 -160 {}
N 200 -30 200 0 {lab=gd}
N 140 -60 160 -60 {lab=gd}
N 140 -60 140 0 {lab=gd}
N 140 0 200 0 {lab=gd}
N 360 -30 360 0 {lab=gd}
N 300 -60 320 -60 {lab=gd}
N 300 -60 300 0 {lab=gd}
N 300 0 360 0 {lab=gd}
N 360 -130 360 -90 {lab=#net1}
N 360 -220 360 -190 {lab=#net2}
N 360 -220 520 -220 {lab=#net2}
N 520 -220 520 -190 {lab=#net2}
N 520 -130 520 0 {lab=gd}
N 360 0 520 0 {lab=gd}
N 200 0 300 0 {lab=gd}
N 40 -220 40 -190 {lab=#net3}
N 40 -130 40 0 {lab=gd}
N 40 0 140 0 {lab=gd}
N 0 0 40 0 {lab=gd}
N 200 -220 200 -90 {lab=#net3}
N 40 -220 200 -220 {lab=#net3}
N 280 -620 320 -620 {lab=start_up}
N 280 -620 280 -560 {lab=start_up}
N 240 -620 280 -620 {lab=start_up}
N 280 -560 350 -560 {lab=start_up}
N 350 -570 350 -560 {lab=start_up}
N 350 -570 370 -570 {lab=start_up}
N 370 -570 370 -560 {lab=start_up}
N 370 -560 650 -560 {lab=start_up}
N 200 -690 200 -650 {lab=vp}
N 200 -690 360 -690 {lab=vp}
N 360 -690 360 -650 {lab=vp}
N 130 -620 200 -620 {lab=vp}
N 360 -620 430 -620 {lab=vp}
N 0 -690 200 -690 {lab=vp}
N 640 -270 640 -240 {lab=ibias}
N 610 -240 640 -240 {lab=ibias}
N 650 -570 650 -560 {lab=start_up}
N 650 -570 670 -570 {lab=start_up}
N 670 -570 670 -560 {lab=start_up}
N 670 -560 790 -560 {lab=start_up}
N 660 -690 860 -690 {lab=vp}
N 860 -620 930 -620 {lab=vp}
N 790 -620 820 -620 {lab=start_up}
N 760 -340 790 -340 {lab=start_up}
N 660 -270 660 -0 {lab=gd}
N 520 0 660 0 {lab=gd}
N 860 -240 860 -190 {lab=vref}
N 660 0 860 0 {lab=gd}
N 860 -130 860 -0 {lab=gd}
N 360 -690 660 -690 {lab=vp}
N 790 -560 790 -340 {lab=start_up}
N 660 -690 660 -410 {lab=vp}
N 360 -370 360 -220 {lab=#net2}
N 200 -310 200 -220 {lab=#net3}
N 860 -240 920 -240 {lab=vref}
N 860 -590 860 -240 {lab=vref}
N 370 -310 580 -310 {lab=#net3}
N 370 -320 370 -310 {lab=#net3}
N 350 -320 370 -320 {lab=#net3}
N 350 -320 350 -310 {lab=#net3}
N 200 -310 350 -310 {lab=#net3}
N 360 -370 580 -370 {lab=#net2}
N 860 -690 860 -650 {lab=vp}
N 40 230 40 260 {lab=gd}
N 40 40 40 70 {lab=gd}
N 360 -590 360 -370 {lab=#net2}
N 200 -590 200 -310 {lab=#net3}
N 210 -560 280 -560 {lab=start_up}
N 210 -570 210 -560 {lab=start_up}
N 190 -570 210 -570 {lab=start_up}
N 190 -570 190 -560 {lab=start_up}
N 0 -560 190 -560 {lab=start_up}
N 40 130 40 170 {lab=#net4}
N 200 40 200 70 {lab=gd}
N 200 130 200 160 {lab=gd}
N 790 -620 790 -560 {lab=start_up}
C {sg13cmos5l_pr/pnpMPA.sym} 180 -60 0 0 {name=Q1
model=pnpMPA
spiceprefix=X
w=2.0e-6
l=2.0e-6
m=1
}
C {sg13cmos5l_pr/pnpMPA.sym} 340 -60 0 0 {name=Q2
model=pnpMPA
spiceprefix=X
w=2.0e-6
l=2.0e-6
m=8
}
C {ipin.sym} 0 0 0 0 {name=p4 lab=gd}
C {ipin.sym} 0 -690 0 0 {name=p5 lab=vp}
C {lab_wire.sym} 150 -620 0 0 {name=p6 sig_type=std_logic lab=vp}
C {lab_wire.sym} 410 -620 0 1 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 910 -620 0 1 {name=p10 sig_type=std_logic lab=vp}
C {ipin.sym} 610 -240 0 0 {name=p11 lab=ibias}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 340 -620 0 0 {name=M2
l=0.9u
w=3.6u
ng=1
m=10
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 220 -620 0 1 {name=M1
l=0.9u
w=3.6u
ng=1
m=10
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 840 -620 0 0 {name=M3
l=0.9u
w=3.6u
ng=1
m=10
model=sg13_hv_pmos
spiceprefix=X
}
C {opin.sym} 920 -240 0 0 {name=p2 lab=vref}
C {sg13cmos5l_pr/rppd.sym} 520 -160 0 0 {name=R2
w=2e-6
l=100e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {sg13cmos5l_pr/rppd.sym} 40 -160 0 0 {name=R3
w=2e-6
l=100e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {sg13cmos5l_pr/rppd.sym} 860 -160 0 0 {name=R4
w=2e-6
l=100e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {sg13cmos5l_pr/rppd.sym} 360 -160 0 0 {name=R1
w=5.8e-6
l=42e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/opamp_folded.sym} 580 -370 0 0 {name=x1}
C {sg13cmos5l_pr/rppd.sym} 40 100 0 0 {name=R5
w=2e-6
l=37.5e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {lab_wire.sym} 40 50 3 1 {name=p3 sig_type=std_logic lab=gd}
C {lab_wire.sym} 40 240 3 0 {name=p12 sig_type=std_logic lab=gd
}
C {ipin.sym} 0 -560 0 0 {name=p14 lab=start_up}
C {sg13cmos5l_pr/rppd.sym} 40 200 0 0 {name=R6
w=2e-6
l=12.5e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {sg13cmos5l_pr/rppd.sym} 200 100 0 0 {name=R7
w=2e-6
l=12.5e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {lab_wire.sym} 200 50 3 1 {name=p1 sig_type=std_logic lab=gd}
C {lab_wire.sym} 200 140 3 0 {name=p8 sig_type=std_logic lab=gd
}
