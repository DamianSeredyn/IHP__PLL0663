v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 180 -850 180 -810 {lab=vp}
N 420 -850 420 -810 {lab=vp}
N 180 -850 420 -850 {lab=vp}
N 420 -780 430 -780 {lab=vp}
N 430 -810 430 -780 {lab=vp}
N 420 -810 430 -810 {lab=vp}
N 170 -780 180 -780 {lab=vp}
N 170 -810 170 -780 {lab=vp}
N 170 -810 180 -810 {lab=vp}
N 180 -720 180 -680 {lab=#net1}
N 240 -780 380 -780 {lab=#net1}
N 220 -100 380 -100 {lab=#net2}
N 180 -210 180 -130 {lab=#net2}
N 180 -290 180 -270 {lab=vp}
N 220 -130 220 -100 {lab=#net2}
N 180 -130 220 -130 {lab=#net2}
N 330 -280 380 -280 {lab=dn}
N 420 -100 430 -100 {lab=0}
N 430 -100 430 -70 {lab=0}
N 420 -70 430 -70 {lab=0}
N 420 -280 430 -280 {lab=0}
N 420 -420 420 -310 {lab=vout}
N 420 -560 430 -560 {lab=vp}
N 330 -560 380 -560 {lab=upb}
N 170 -70 180 -70 {lab=0}
N 170 -100 170 -70 {lab=0}
N 170 -100 180 -100 {lab=0}
N 420 -420 520 -420 {lab=vout}
N 420 -530 420 -420 {lab=vout}
N 240 -780 240 -720 {lab=#net1}
N 220 -780 240 -780 {lab=#net1}
N 180 -720 240 -720 {lab=#net1}
N 180 -750 180 -720 {lab=#net1}
N 420 -750 420 -590 {lab=#net3}
N 420 -250 420 -130 {lab=#net4}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -780 0 1 {name=M3
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -780 0 0 {name=M1
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -560 0 0 {name=M6
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -280 0 0 {name=M9
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -100 0 0 {name=M10
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -100 0 1 {name=M14
l=0.13u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 180 -650 0 0 {name=Ichar value=50e-06}
C {gnd.sym} 180 -620 0 0 {name=l11 lab=0}
C {gnd.sym} 420 -70 0 0 {name=l4 lab=0}
C {gnd.sym} 180 -70 0 0 {name=l5 lab=0}
C {isource.sym} 180 -240 0 0 {name=Idisch value=50e-06}
C {lab_pin.sym} 180 -290 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_pin.sym} 330 -280 0 0 {name=p4 sig_type=std_logic lab=dn}
C {gnd.sym} 430 -280 0 0 {name=l6 lab=0}
C {lab_pin.sym} 520 -420 0 1 {name=p5 sig_type=std_logic lab=vout}
C {lab_pin.sym} 430 -560 0 0 {name=p6 sig_type=std_logic lab=vp}
C {lab_pin.sym} 330 -560 0 0 {name=p8 sig_type=std_logic lab=upb}
C {lab_pin.sym} 310 -850 0 0 {name=p1 sig_type=std_logic lab=vp}
C {vsource.sym} 120 -990 0 0 {name=vvp
value=1.2 savecurrent=false}
C {gnd.sym} 120 -960 0 0 {name=l16 lab=0}
C {lab_pin.sym} 120 -1020 0 0 {name=p10 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 650 -790 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 650 -660 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.control
tran 0.01 25n
plot v(vout)
show all
.end
"}
C {capa.sym} 660 -360 0 0 {name=C1
m=1
value=10p
ic=0.6
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 660 -330 0 0 {name=l14 lab=0}
C {lab_pin.sym} 660 -390 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 270 -990 0 0 {name=vupb1
value="PULSE(1.2 0 0 10p 10p 2n 6.67n)" savecurrent=false}
C {gnd.sym} 270 -960 0 0 {name=l1 lab=0}
C {vsource.sym} 630 -990 0 0 {name=vdn1
value=0 savecurrent=false}
C {gnd.sym} 630 -960 0 0 {name=l2 lab=0}
C {lab_pin.sym} 270 -1020 0 1 {name=p2 sig_type=std_logic lab=upb}
C {lab_pin.sym} 630 -1020 0 1 {name=p7 sig_type=std_logic lab=dn}
