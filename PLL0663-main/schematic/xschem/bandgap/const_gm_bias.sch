v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 10 10 10 310 {}
L 4 10 310 240 310 {}
L 4 240 10 240 310 {}
L 4 10 10 240 10 {}
T {Dummy} 20 20 0 0 0.4 0.4 {}
N 80 -280 80 -260 {lab=vp}
N 80 -20 180 -20 {lab=gd}
N 180 -40 180 -20 {lab=gd}
N 80 -140 80 -20 {lab=gd}
N 180 -140 180 -100 {lab=vr}
N 240 -220 280 -220 {lab=ibias}
N -0 -280 80 -280 {lab=vp}
N -0 -20 80 -20 {lab=gd}
N 80 150 80 190 {lab=#net1}
N 80 250 80 280 {lab=gd}
N 80 60 80 90 {lab=gd}
N 240 -200 280 -200 {lab=pbias}
N 240 -180 280 -180 {lab=nbias}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/const_gm_bias_core.sym} 40 -200 0 0 {name=xgm_core}
C {sg13cmos5l_pr/rppd.sym} 180 -70 0 0 {name=Rbias
w=1.2e-6
l=11.7e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {lab_wire.sym} 180 -120 3 0 {name=p1 sig_type=std_logic lab=vr}
C {opin.sym} 280 -220 0 0 {name=p2 lab=ibias}
C {ipin.sym} 0 -280 0 0 {name=p3 lab=vp}
C {ipin.sym} 0 -20 0 0 {name=p4 lab=gd}
C {sg13cmos5l_pr/rppd.sym} 80 120 0 0 {name=R2
w=1.2e-6
l=3.9e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {sg13cmos5l_pr/rppd.sym} 80 220 0 0 {name=R3
w=1.2e-6
l=1.3e-6
model=rppd
body=gd
spiceprefix=X
b=0
m=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {lab_wire.sym} 80 60 0 0 {name=p5 sig_type=std_logic lab=gd}
C {lab_wire.sym} 80 280 2 0 {name=p6 sig_type=std_logic lab=gd}
C {opin.sym} 280 -200 0 0 {name=p7 lab=pbias}
C {opin.sym} 280 -180 0 0 {name=p8 lab=nbias}
