v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 2420 -2360 2490 -2360 {lab=#net1}
N 2350 -2290 2350 -2240 {lab=#net1}
N 2350 -2290 2420 -2290 {lab=#net1}
N 2350 -2330 2350 -2290 {lab=#net1}
N 2420 -2360 2420 -2290 {lab=#net1}
N 2390 -2360 2420 -2360 {lab=#net1}
N 2350 -2430 2350 -2390 {lab=vp}
N 2530 -2430 2530 -2390 {lab=vp}
N 2170 -2430 2170 -2400 {lab=vp}
N 2340 -2430 2350 -2430 {lab=vp}
N 2340 -2360 2350 -2360 {lab=vp}
N 2340 -2430 2340 -2360 {lab=vp}
N 2170 -2430 2340 -2430 {lab=vp}
N 2530 -2360 2540 -2360 {lab=vp}
N 2540 -2430 2540 -2360 {lab=vp}
N 2530 -2430 2540 -2430 {lab=vp}
N 2350 -2430 2530 -2430 {lab=vp}
N 2350 -1980 2350 -1960 {lab=0}
N 2350 -2140 2350 -2060 {lab=#net2}
N 2350 -2140 2490 -2140 {lab=#net2}
N 2350 -2180 2350 -2140 {lab=#net2}
N 2340 -2210 2350 -2210 {lab=0}
N 2340 -2210 2340 -1980 {lab=0}
N 2340 -1980 2350 -1980 {lab=0}
N 2350 -2000 2350 -1980 {lab=0}
N 2530 -2110 2530 -1980 {lab=0}
N 2350 -1980 2530 -1980 {lab=0}
N 2530 -2140 2540 -2140 {lab=0}
N 2540 -2140 2540 -1980 {lab=0}
N 2530 -1980 2540 -1980 {lab=0}
N 2530 -2210 2530 -2170 {lab=vbias}
N 2390 -2210 2530 -2210 {lab=vbias}
N 2530 -2220 2530 -2210 {lab=vbias}
N 2530 -2220 2580 -2220 {lab=vbias}
N 2530 -2330 2530 -2220 {lab=vbias}
C {sg13g2_pr/sg13_lv_nmos.sym} 2370 -2210 0 1 {name=M1
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2370 -2360 0 1 {name=M2
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 2510 -2360 0 0 {name=M3
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 2510 -2140 0 0 {name=M4
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 2350 -2030 0 0 {name=R2
value=500
footprint=1206
device=resistor
m=1}
C {gnd.sym} 2350 -1960 0 0 {name=l14 lab=0}
C {vsource.sym} 2170 -2370 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 2170 -2340 0 0 {name=l16 lab=0}
C {lab_pin.sym} 2170 -2400 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_pin.sym} 2580 -2220 0 1 {name=p1 sig_type=std_logic lab=vbias}
C {devices/code_shown.sym} 2740 -2840 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ff
"}
C {devices/code_shown.sym} 2750 -2690 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.param Vp=1.2
.control

op
save all
show all > show_all.txt
write vbias_v2.raw
.endc
"}
