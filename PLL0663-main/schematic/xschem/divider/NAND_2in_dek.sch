v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 80 500 80 600 {lab=GND}
N 80 410 80 440 {lab=#net1}
N 80 340 80 350 {lab=y}
N 220 340 360 340 {lab=y}
N 80 320 80 340 {lab=y}
N 220 320 220 340 {lab=y}
N 80 340 220 340 {lab=y}
N 80 380 100 380 {lab=GND}
N 80 600 80 620 {lab=GND}
N 80 600 100 600 {lab=GND}
N 80 470 100 470 {lab=GND}
N 100 380 100 470 {lab=GND}
N 100 470 100 600 {lab=GND}
N 80 250 80 260 {lab=VP}
N 80 250 100 250 {lab=VP}
N 80 240 80 250 {lab=VP}
N 100 250 100 290 {lab=VP}
N 80 290 100 290 {lab=VP}
N 220 250 220 260 {lab=VP}
N 220 250 240 250 {lab=VP}
N 220 240 220 250 {lab=VP}
N 240 250 240 290 {lab=VP}
N 220 290 240 290 {lab=VP}
N -110 290 -90 290 {lab=VP}
N -110 310 -90 310 {lab=GND}
N -110 340 -90 340 {lab=a}
N -110 360 -90 360 {lab=b}
N 20 380 40 380 {lab=a}
N 160 290 180 290 {lab=a}
N 20 470 40 470 {lab=b}
N 20 290 40 290 {lab=b}
C {sg13g2_pr/sg13_lv_nmos.sym} 60 380 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 60 470 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {opin.sym} 360 340 0 0 {name=p1 lab=y}
C {iopin.sym} -110 310 2 0 {name=p2 lab=GND}
C {ipin.sym} -110 340 0 0 {name=p3 lab=a}
C {iopin.sym} -110 290 2 0 {name=p5 lab=VP}
C {ipin.sym} -110 360 0 0 {name=p6 lab=b}
C {lab_pin.sym} -90 360 2 0 {name=p8 sig_type=std_logic lab=b}
C {lab_pin.sym} -90 340 2 0 {name=p9 sig_type=std_logic lab=a}
C {lab_pin.sym} -90 310 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -90 290 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} 20 380 0 0 {name=p12 sig_type=std_logic lab=a}
C {lab_pin.sym} 160 290 0 0 {name=p13 sig_type=std_logic lab=a}
C {lab_pin.sym} 20 470 0 0 {name=p14 sig_type=std_logic lab=b}
C {lab_pin.sym} 20 290 0 0 {name=p15 sig_type=std_logic lab=b}
C {lab_pin.sym} 80 620 2 0 {name=p18 sig_type=std_logic lab=GND}
C {lab_pin.sym} 80 240 2 0 {name=p19 sig_type=std_logic lab=VP}
C {lab_pin.sym} 220 240 2 0 {name=p20 sig_type=std_logic lab=VP}
C {sg13g2_pr/sg13_lv_pmos.sym} 60 290 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 290 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
