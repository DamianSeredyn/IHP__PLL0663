v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 230 -520 230 -510 {lab=vp}
N 430 -530 570 -530 {lab=vp}
N 570 -430 570 -420 {lab=vp}
N 430 -520 430 -510 {lab=vp}
N 230 -530 430 -530 {lab=vp}
N 290 -480 390 -480 {lab=net1}
N 230 -430 230 -320 {lab=net1}
N 430 -390 430 -320 {lab=net2}
N 480 -390 530 -390 {lab=net2}
N 430 -450 430 -390 {lab=net2}
N 570 -270 570 -160 {lab=vout}
N 410 -130 530 -130 {lab=#net4}
N 410 -150 410 -130 {lab=#net4}
N 290 -150 410 -150 {lab=#net4}
N 290 -150 290 -130 {lab=#net4}
N 230 -130 290 -130 {lab=#net4}
N 330 -100 330 -80 {lab=0}
N 570 -90 570 -80 {lab=0}
N 340 -80 570 -80 {lab=0}
N 230 -260 230 -240 {lab=net3}
N 410 -240 430 -240 {lab=net3}
N 430 -260 430 -240 {lab=net3}
N 330 -240 330 -160 {lab=net3}
N 240 -240 330 -240 {lab=net3}
N 470 -290 490 -290 {lab=#net5}
N 490 -290 490 -210 {lab=#net5}
N 220 -480 230 -480 {lab=vp}
N 220 -520 220 -480 {lab=vp}
N 220 -520 230 -520 {lab=vp}
N 230 -530 230 -520 {lab=vp}
N 430 -480 440 -480 {lab=vp}
N 440 -520 440 -480 {lab=vp}
N 430 -520 440 -520 {lab=vp}
N 430 -530 430 -520 {lab=vp}
N 570 -390 580 -390 {lab=vp}
N 580 -430 580 -390 {lab=vp}
N 570 -430 580 -430 {lab=vp}
N 570 -530 570 -430 {lab=vp}
N 410 -290 430 -290 {lab=net3}
N 410 -290 410 -240 {lab=net3}
N 330 -240 410 -240 {lab=net3}
N 230 -290 240 -290 {lab=net3}
N 240 -290 240 -240 {lab=net3}
N 230 -240 240 -240 {lab=net3}
N 230 -430 290 -430 {lab=net1}
N 230 -450 230 -430 {lab=net1}
N 290 -480 290 -430 {lab=net1}
N 270 -480 290 -480 {lab=net1}
N 230 -70 330 -70 {lab=0}
N 330 -80 330 -70 {lab=0}
N 330 -130 340 -130 {lab=0}
N 340 -130 340 -80 {lab=0}
N 330 -80 340 -80 {lab=0}
N 570 -130 580 -130 {lab=0}
N 580 -130 580 -90 {lab=0}
N 570 -90 580 -90 {lab=0}
N 570 -100 570 -90 {lab=0}
N 540 -340 570 -340 {lab=vout}
N 570 -360 570 -340 {lab=vout}
N 480 -390 480 -340 {lab=net2}
N 430 -390 480 -390 {lab=net2}
N 570 -270 590 -270 {lab=vout}
N 570 -310 570 -270 {lab=vout}
N 570 -310 680 -310 {lab=vout}
N 570 -340 570 -310 {lab=vout}
N 140 -290 190 -290 {lab=#net6}
N 140 -170 140 -160 {lab=#net5}
N 140 -290 140 -240 {lab=#net6}
N 140 -170 250 -170 {lab=#net5}
N 140 -180 140 -170 {lab=#net5}
N 250 -210 250 -170 {lab=#net5}
N 250 -210 490 -210 {lab=#net5}
N 140 -100 140 -80 {lab=0}
C {devices/code_shown.sym} 760 -600 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 770 -450 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param wp=3u
.param wn=2.5u
.param l=0.15u
.control
ac dec 100 1 1Meg
plot v(vout)
write amp_tb.raw
set appendwrite
plot Vtest1 Vtest2
show all
.endc
"}
C {vsource.sym} 90 -540 0 0 {name=VP
value=1.2 savecurrent=false}
C {gnd.sym} 90 -510 0 0 {name=l16 lab=0}
C {lab_pin.sym} 90 -570 0 0 {name=p10 sig_type=std_logic lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 410 -480 0 0 {name=M4
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 210 -290 0 0 {name=M1
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 250 -480 0 1 {name=M3
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 450 -290 0 1 {name=M2
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 -130 0 0 {name=M5
l=0.5u
w=6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 550 -390 0 0 {name=M6
l=0.5u
w=1.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 550 -130 0 0 {name=M7
l=0.5u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {vsource.sym} 230 -100 0 0 {name=Vbias
value=0.5 savecurrent=false}
C {capa.sym} 510 -340 1 0 {name=C1
m=1
value=100f
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 330 -530 0 0 {name=p4 sig_type=std_logic lab=vp}
C {gnd.sym} 390 -80 0 0 {name=l1 lab=0}
C {lab_pin.sym} 590 -270 0 1 {name=p1 sig_type=std_logic lab=vout}
C {capa.sym} 690 -240 0 0 {name=C2
m=1
value=1p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 690 -270 0 1 {name=p5 sig_type=std_logic lab=vout}
C {gnd.sym} 690 -210 0 0 {name=l2 lab=0}
C {lab_pin.sym} 230 -390 0 0 {name=p2 sig_type=std_logic lab=net1}
C {lab_pin.sym} 430 -410 0 0 {name=p6 sig_type=std_logic lab=net2}
C {lab_pin.sym} 330 -180 0 0 {name=p7 sig_type=std_logic lab=net3}
C {gnd.sym} 140 -80 0 0 {name=l4 lab=0}
C {devices/vsource.sym} 140 -130 0 0 {name=V1 value="dc 0.65 ac 0"}
C {devices/vsource.sym} 140 -210 2 0 {name=V2 value="dc 0 ac 1"}
