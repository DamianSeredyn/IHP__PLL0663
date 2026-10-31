v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 210 -500 210 -490 {lab=vp}
N 410 -510 550 -510 {lab=vp}
N 550 -410 550 -400 {lab=vp}
N 410 -500 410 -490 {lab=vp}
N 210 -510 410 -510 {lab=vp}
N 270 -460 370 -460 {lab=net1}
N 210 -410 210 -300 {lab=net1}
N 410 -370 410 -300 {lab=net2}
N 460 -370 510 -370 {lab=net2}
N 410 -430 410 -370 {lab=net2}
N 550 -250 550 -140 {lab=vout}
N 390 -110 510 -110 {lab=#net4}
N 390 -130 390 -110 {lab=#net4}
N 270 -130 390 -130 {lab=#net4}
N 270 -130 270 -110 {lab=#net4}
N 210 -110 270 -110 {lab=#net4}
N 310 -80 310 -60 {lab=0}
N 550 -70 550 -60 {lab=0}
N 320 -60 550 -60 {lab=0}
N 210 -240 210 -220 {lab=net3}
N 390 -220 410 -220 {lab=net3}
N 410 -240 410 -220 {lab=net3}
N 310 -220 310 -140 {lab=net3}
N 220 -220 310 -220 {lab=net3}
N 450 -270 470 -270 {lab=vin_plus}
N 470 -270 470 -190 {lab=vin_plus}
N 150 -190 470 -190 {lab=vin_plus}
N 200 -460 210 -460 {lab=vp}
N 200 -500 200 -460 {lab=vp}
N 200 -500 210 -500 {lab=vp}
N 210 -510 210 -500 {lab=vp}
N 410 -460 420 -460 {lab=vp}
N 420 -500 420 -460 {lab=vp}
N 410 -500 420 -500 {lab=vp}
N 410 -510 410 -500 {lab=vp}
N 550 -370 560 -370 {lab=vp}
N 560 -410 560 -370 {lab=vp}
N 550 -410 560 -410 {lab=vp}
N 550 -510 550 -410 {lab=vp}
N 390 -270 410 -270 {lab=net3}
N 390 -270 390 -220 {lab=net3}
N 310 -220 390 -220 {lab=net3}
N 210 -270 220 -270 {lab=net3}
N 220 -270 220 -220 {lab=net3}
N 210 -220 220 -220 {lab=net3}
N 210 -410 270 -410 {lab=net1}
N 210 -430 210 -410 {lab=net1}
N 270 -460 270 -410 {lab=net1}
N 250 -460 270 -460 {lab=net1}
N 210 -50 310 -50 {lab=0}
N 310 -60 310 -50 {lab=0}
N 310 -110 320 -110 {lab=0}
N 320 -110 320 -60 {lab=0}
N 310 -60 320 -60 {lab=0}
N 550 -110 560 -110 {lab=0}
N 560 -110 560 -70 {lab=0}
N 550 -70 560 -70 {lab=0}
N 550 -80 550 -70 {lab=0}
N 520 -320 550 -320 {lab=vout}
N 550 -340 550 -320 {lab=vout}
N 460 -370 460 -320 {lab=net2}
N 410 -370 460 -370 {lab=net2}
N 550 -250 670 -250 {lab=vout}
N 550 -290 550 -250 {lab=vout}
N 110 -270 170 -270 {lab=vout}
N 550 -290 660 -290 {lab=vout}
N 550 -320 550 -290 {lab=vout}
N 110 -270 130 -600 {lab=vout}
N 130 -600 660 -570 {lab=vout}
N 660 -570 660 -290 {lab=vout}
C {devices/code_shown.sym} 740 -580 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 750 -430 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param wp=3u
.param wn=2.5u
.param l=0.15u
.control
dc V1 0 1.2 0.01
plot v(vin_plus) v(vout)
write amp_tb.raw
set appendwrite
plot Vtest1 Vtest2
show all
.endc
"}
C {vsource.sym} 70 -520 0 0 {name=VP
value=1.2 savecurrent=false}
C {gnd.sym} 70 -490 0 0 {name=l16 lab=0}
C {lab_pin.sym} 70 -550 0 0 {name=p10 sig_type=std_logic lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 390 -460 0 0 {name=M4
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 -270 0 0 {name=M1
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 230 -460 0 1 {name=M3
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 430 -270 0 1 {name=M2
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 290 -110 0 0 {name=M5
l=0.15u
w=6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 530 -370 0 0 {name=M6
l=0.15u
w=1.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 530 -110 0 0 {name=M7
l=0.15u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {vsource.sym} 210 -80 0 0 {name=Vbias
value=0.5 savecurrent=false}
C {capa.sym} 490 -320 1 0 {name=C1
m=1
value=100f
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 310 -510 0 0 {name=p4 sig_type=std_logic lab=vp}
C {gnd.sym} 370 -60 0 0 {name=l1 lab=0}
C {lab_pin.sym} 270 -190 0 0 {name=p3 sig_type=std_logic lab=vin_plus}
C {capa.sym} 670 -220 0 0 {name=C2
m=1
value=1p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 670 -250 0 1 {name=p5 sig_type=std_logic lab=vout}
C {gnd.sym} 670 -190 0 0 {name=l2 lab=0}
C {lab_pin.sym} 210 -370 0 0 {name=p2 sig_type=std_logic lab=net1}
C {lab_pin.sym} 410 -390 0 0 {name=p6 sig_type=std_logic lab=net2}
C {lab_pin.sym} 310 -160 0 0 {name=p7 sig_type=std_logic lab=net3}
C {gnd.sym} 150 -130 0 0 {name=l4 lab=0}
C {devices/vsource.sym} 150 -160 0 0 {name=V1 value=1}
