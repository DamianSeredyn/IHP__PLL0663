v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 3250 -2380 3250 -2340 {lab=0}
N 3120 -2590 3210 -2590 {lab=test_1}
N 3060 -2380 3250 -2380 {lab=0}
N 3250 -2430 3250 -2380 {lab=0}
N 3040 -2590 3060 -2590 {lab=0}
N 3040 -2590 3040 -2380 {lab=0}
N 3060 -2560 3060 -2380 {lab=0}
N 3250 -2590 3280 -2590 {lab=0}
N 3280 -2590 3280 -2380 {lab=0}
N 3060 -2670 3060 -2620 {lab=test_1}
N 3180 -2870 3210 -2870 {lab=vout}
N 3180 -2810 3250 -2810 {lab=vout}
N 3250 -2840 3250 -2810 {lab=vout}
N 3180 -2870 3180 -2810 {lab=vout}
N 3100 -2870 3180 -2870 {lab=vout}
N 3060 -2940 3060 -2900 {lab=vp}
N 3060 -2940 3250 -2940 {lab=vp}
N 3250 -2940 3250 -2900 {lab=vp}
N 3050 -2940 3060 -2940 {lab=vp}
N 3250 -2870 3260 -2870 {lab=vp}
N 3260 -2940 3260 -2870 {lab=vp}
N 3250 -2940 3260 -2940 {lab=vp}
N 3050 -2870 3060 -2870 {lab=vp}
N 3050 -2940 3050 -2870 {lab=vp}
N 2900 -2940 2900 -2920 {lab=vp}
N 2900 -2940 3050 -2940 {lab=vp}
N 3060 -2670 3120 -2670 {lab=test_1}
N 3060 -2770 3060 -2670 {lab=test_1}
N 3120 -2670 3120 -2590 {lab=test_1}
N 3100 -2590 3120 -2590 {lab=test_1}
N 3250 -2780 3250 -2620 {lab=vout}
N 3250 -2780 3290 -2780 {lab=vout}
N 3250 -2810 3250 -2780 {lab=vout}
N 2970 -2770 3060 -2770 {lab=test_1}
N 3060 -2840 3060 -2770 {lab=test_1}
N 3250 -2380 3280 -2380 {lab=0}
N 3040 -2380 3060 -2380 {lab=0}
N 3210 -2490 3250 -2490 {lab=#net1}
N 3210 -2560 3250 -2560 {lab=#net2}
N 3210 -2560 3210 -2550 {lab=#net2}
C {sg13g2_pr/sg13_lv_nmos.sym} 3080 -2590 0 1 {name=M1
l=1u
w=10u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 3080 -2870 0 1 {name=M3
l=10u
w=5u
ng=1
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 3230 -2590 0 0 {name=M2
l=1u
w=10u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 3230 -2870 0 0 {name=M4
l=10u
w=5u
ng=1
m=10
model=sg13_lv_pmos
spiceprefix=X
}
C {res.sym} 3250 -2460 0 0 {name=R3
value=100k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 3250 -2340 0 0 {name=l1 lab=0}
C {devices/code_shown.sym} 3420 -3300 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 3380 -3200 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp=27
.param l=0.15u
.param Vp=1.1
.control

op
save all
show all > show_all.txt
write ptat_v3.raw
set appendwrite
.endc
"}
C {vsource.sym} 2900 -2890 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 2900 -2860 0 0 {name=l16 lab=0}
C {lab_pin.sym} 2900 -2920 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_pin.sym} 3290 -2780 0 1 {name=p3 sig_type=std_logic lab=vout}
C {lab_pin.sym} 2970 -2770 0 0 {name=p1 sig_type=std_logic lab=test_1}
C {vsource.sym} 3210 -2520 0 0 {name=Vvp1
value=0 savecurrent=true}
