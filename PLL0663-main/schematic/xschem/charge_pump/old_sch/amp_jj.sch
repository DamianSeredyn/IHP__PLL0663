v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 210 -560 210 -550 {lab=vp}
N 410 -570 550 -570 {lab=vp}
N 550 -470 550 -460 {lab=vp}
N 410 -560 410 -550 {lab=vp}
N 210 -570 410 -570 {lab=vp}
N 270 -520 370 -520 {lab=net1}
N 210 -470 210 -360 {lab=net1}
N 410 -430 410 -360 {lab=net2}
N 460 -430 510 -430 {lab=net2}
N 410 -490 410 -430 {lab=net2}
N 550 -310 550 -200 {lab=vout}
N 390 -170 510 -170 {lab=#net4}
N 390 -190 390 -170 {lab=#net4}
N 270 -190 390 -190 {lab=#net4}
N 270 -190 270 -170 {lab=#net4}
N 210 -170 270 -170 {lab=#net4}
N 310 -140 310 -120 {lab=gd}
N 550 -130 550 -120 {lab=gd}
N 320 -120 550 -120 {lab=gd}
N 210 -300 210 -280 {lab=net3}
N 390 -280 410 -280 {lab=net3}
N 410 -300 410 -280 {lab=net3}
N 310 -280 310 -200 {lab=net3}
N 220 -280 310 -280 {lab=net3}
N 450 -330 470 -330 {lab=vin_plus}
N 470 -330 470 -250 {lab=vin_plus}
N 200 -520 210 -520 {lab=vp}
N 200 -560 200 -520 {lab=vp}
N 200 -560 210 -560 {lab=vp}
N 210 -570 210 -560 {lab=vp}
N 410 -520 420 -520 {lab=vp}
N 420 -560 420 -520 {lab=vp}
N 410 -560 420 -560 {lab=vp}
N 410 -570 410 -560 {lab=vp}
N 550 -430 560 -430 {lab=vp}
N 560 -470 560 -430 {lab=vp}
N 550 -470 560 -470 {lab=vp}
N 550 -570 550 -470 {lab=vp}
N 390 -330 410 -330 {lab=net3}
N 390 -330 390 -280 {lab=net3}
N 310 -280 390 -280 {lab=net3}
N 210 -330 220 -330 {lab=net3}
N 220 -330 220 -280 {lab=net3}
N 210 -280 220 -280 {lab=net3}
N 210 -470 270 -470 {lab=net1}
N 210 -490 210 -470 {lab=net1}
N 270 -520 270 -470 {lab=net1}
N 250 -520 270 -520 {lab=net1}
N 210 -110 310 -110 {lab=gd}
N 310 -120 310 -110 {lab=gd}
N 310 -170 320 -170 {lab=gd}
N 320 -170 320 -120 {lab=gd}
N 310 -120 320 -120 {lab=gd}
N 550 -170 560 -170 {lab=gd}
N 560 -170 560 -130 {lab=gd}
N 550 -130 560 -130 {lab=gd}
N 550 -140 550 -130 {lab=gd}
N 520 -380 550 -380 {lab=vout}
N 550 -400 550 -380 {lab=vout}
N 460 -430 460 -380 {lab=net2}
N 410 -430 460 -430 {lab=net2}
N 550 -310 570 -310 {lab=vout}
N 550 -350 550 -310 {lab=vout}
N 550 -350 660 -350 {lab=vout}
N 550 -380 550 -350 {lab=vout}
N 120 -330 170 -330 {lab=vin_min}
N 230 -250 470 -250 {lab=vin_plus}
C {sg13g2_pr/sg13_lv_pmos.sym} 390 -520 0 0 {name=M8
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 -330 0 0 {name=M9
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 230 -520 0 1 {name=M10
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 430 -330 0 1 {name=M11
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 290 -170 0 0 {name=M12
l=0.5u
w=6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 530 -430 0 0 {name=M13
l=0.5u
w=1.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 530 -170 0 0 {name=M14
l=0.5u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {vsource.sym} 210 -140 0 0 {name=Vbias1
value=0.5 savecurrent=false}
C {capa.sym} 490 -380 1 0 {name=C2
m=1
value=100f
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 570 -310 0 1 {name=p5 sig_type=std_logic lab=vout}
C {lab_pin.sym} 210 -430 0 0 {name=p7 sig_type=std_logic lab=net1}
C {lab_pin.sym} 410 -450 0 0 {name=p8 sig_type=std_logic lab=net2}
C {lab_pin.sym} 310 -220 0 0 {name=p9 sig_type=std_logic lab=net3}
C {iopin.sym} 330 -570 0 0 {name=p6 lab=vp}
C {ipin.sym} 660 -350 0 1 {name=p11 lab=vout}
C {iopin.sym} 420 -120 0 0 {name=p12 lab=gd}
C {ipin.sym} 120 -330 0 0 {name=p13 lab=vin_min}
C {ipin.sym} 230 -250 0 0 {name=p14 lab=vin_plus}
