v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 3090 -2490 3090 -2450 {lab=0}
N 2960 -2700 3050 -2700 {lab=test_1}
N 2900 -2490 3090 -2490 {lab=0}
N 3090 -2540 3090 -2490 {lab=0}
N 2880 -2700 2900 -2700 {lab=0}
N 2880 -2700 2880 -2490 {lab=0}
N 2900 -2670 2900 -2490 {lab=0}
N 3090 -2700 3120 -2700 {lab=0}
N 3120 -2700 3120 -2490 {lab=0}
N 2900 -2780 2900 -2730 {lab=test_1}
N 3020 -2980 3050 -2980 {lab=vout}
N 3020 -2920 3090 -2920 {lab=vout}
N 3090 -2950 3090 -2920 {lab=vout}
N 3020 -2980 3020 -2920 {lab=vout}
N 2940 -2980 3020 -2980 {lab=vout}
N 2900 -3050 2900 -3010 {lab=vp}
N 2900 -3050 3090 -3050 {lab=vp}
N 3090 -3050 3090 -3010 {lab=vp}
N 2890 -3050 2900 -3050 {lab=vp}
N 3090 -2980 3100 -2980 {lab=vp}
N 3100 -3050 3100 -2980 {lab=vp}
N 3090 -3050 3100 -3050 {lab=vp}
N 2890 -2980 2900 -2980 {lab=vp}
N 2890 -3050 2890 -2980 {lab=vp}
N 2740 -3050 2740 -3030 {lab=vp}
N 2740 -3050 2890 -3050 {lab=vp}
N 2900 -2780 2960 -2780 {lab=test_1}
N 2900 -2880 2900 -2780 {lab=test_1}
N 2960 -2780 2960 -2700 {lab=test_1}
N 2940 -2700 2960 -2700 {lab=test_1}
N 3090 -2890 3090 -2730 {lab=vout}
N 3090 -2890 3130 -2890 {lab=vout}
N 3090 -2920 3090 -2890 {lab=vout}
N 2810 -2880 2900 -2880 {lab=test_1}
N 2900 -2950 2900 -2880 {lab=test_1}
N 3090 -2490 3120 -2490 {lab=0}
N 2880 -2490 2900 -2490 {lab=0}
N 3050 -2600 3090 -2600 {lab=#net1}
N 3050 -2670 3050 -2600 {lab=#net1}
N 3050 -2670 3090 -2670 {lab=#net1}
C {sg13g2_pr/sg13_lv_nmos.sym} 2920 -2700 0 1 {name=M1
l=1u
w=8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2920 -2980 0 1 {name=M3
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 3070 -2700 0 0 {name=M2
l=1u
w=8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 3070 -2980 0 0 {name=M4
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {res.sym} 3090 -2570 0 0 {name=R3
value=5k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 3090 -2450 0 0 {name=l1 lab=0}
C {devices/code_shown.sym} 3260 -3410 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 3270 -3260 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp=27
.param l=0.15u
.param Vp=1.2
.control

op
save all
show all > show_all.txt
write ptat.raw
set appendwrite
.endc
"}
C {vsource.sym} 2740 -3000 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 2740 -2970 0 0 {name=l16 lab=0}
C {lab_pin.sym} 2740 -3030 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_pin.sym} 3130 -2890 0 1 {name=p3 sig_type=std_logic lab=vout}
C {lab_pin.sym} 2810 -2880 0 0 {name=p1 sig_type=std_logic lab=test_1}
