v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 200 -20 230 {lab=0}
N -500 230 -20 230 {lab=0}
N -20 100 -20 140 {lab=net4}
N -160 170 -60 170 {lab=net1}
N -20 170 -10 170 {lab=0}
N -60 160 -60 170 {lab=net1}
N -20 70 -10 70 {lab=0}
N -400 70 -60 70 {lab=biasn}
N -500 200 -500 230 {lab=0}
N -640 200 -640 230 {lab=0}
N -640 230 -500 230 {lab=0}
N -460 -130 -410 -130 {lab=vbiasp}
N -600 170 -570 170 {lab=net1}
N -510 -130 -500 -130 {lab=0}
N -650 20 -640 20 {lab=#net3}
N -650 170 -640 170 {lab=0}
N -570 170 -540 170 {lab=net1}
N -540 160 -540 170 {lab=net1}
N -540 160 -420 160 {lab=net1}
N -420 160 -420 170 {lab=net1}
N -500 170 -490 170 {lab=0}
N -540 60 -540 70 {lab=biasn}
N -400 60 -400 70 {lab=biasn}
N -500 70 -490 70 {lab=0}
N -600 70 -540 70 {lab=biasn}
N -500 100 -500 140 {lab=net7}
N -540 60 -400 60 {lab=biasn}
N -570 -60 -570 170 {lab=net1}
N -640 -60 -570 -60 {lab=net1}
N -650 -10 -640 -10 {lab=0}
N -600 -10 -600 70 {lab=biasn}
N -640 -60 -640 -40 {lab=net1}
N -640 -400 -640 -230 {lab=vp}
N -640 -170 -640 -60 {lab=net1}
N -640 110 -640 140 {lab=net2}
N -640 20 -640 50 {lab=#net3}
N -500 20 -500 40 {lab=VE}
N -20 -110 -20 -50 {lab=VF}
N -20 10 -20 40 {lab=net13}
N -500 -520 -500 -470 {lab=vp}
N -510 -310 -500 -310 {lab=vp}
N -510 -240 -500 -240 {lab=vp}
N -510 -440 -500 -440 {lab=vp}
N -460 -340 -60 -340 {lab=#net6}
N -500 -410 -500 -340 {lab=net8}
N -460 -340 -460 -310 {lab=#net6}
N -500 -280 -500 -270 {lab=VG}
N -90 -440 -60 -440 {lab=net15}
N -500 -200 -500 -160 {lab=net15}
N -20 -520 -20 -470 {lab=vp}
N -20 -440 -10 -440 {lab=vp}
N -20 -280 -10 -280 {lab=vp}
N -60 -340 -60 -280 {lab=#net6}
N -20 -410 -20 -390 {lab=net5}
N -20 -330 -20 -310 {lab=#net9}
N -500 -100 -500 -40 {lab=net10}
N -390 -440 -390 -200 {lab=net15}
N -460 -440 -390 -440 {lab=net15}
N -500 -200 -390 -200 {lab=net15}
N -500 -210 -500 -200 {lab=net15}
N -20 -250 -20 -240 {lab=VH}
N -20 -240 100 -240 {lab=VH}
N 100 -240 100 -230 {lab=VH}
N 100 -130 100 -110 {lab=vout}
N 100 -50 100 -30 {lab=VF}
N 30 -30 100 -30 {lab=VF}
N 30 -110 30 -30 {lab=VF}
N -20 -110 30 -110 {lab=VF}
N -20 -120 -20 -110 {lab=VF}
N 140 -80 160 -80 {lab=vp}
N 140 -200 160 -200 {lab=0}
N 180 -130 260 -130 {lab=vout}
N 100 -170 100 -130 {lab=vout}
N 80 -80 100 -80 {lab=0}
N 80 -200 100 -200 {lab=vp}
N 220 -440 240 -440 {lab=vp}
N 220 -280 240 -280 {lab=vp}
N 220 20 240 20 {lab=0}
N 220 170 240 170 {lab=0}
N 220 -520 220 -470 {lab=vp}
N -20 -520 220 -520 {lab=vp}
N 330 -130 330 -110 {lab=vout}
N 180 -280 180 -130 {lab=vout}
N 100 -130 180 -130 {lab=vout}
N 180 -130 180 20 {lab=vout}
N 220 -30 220 -10 {lab=vp}
N 80 170 180 170 {lab=net1}
N 80 120 80 170 {lab=net1}
N -160 120 80 120 {lab=net1}
N -160 120 -160 170 {lab=net1}
N -420 170 -160 170 {lab=net1}
N 50 -440 180 -440 {lab=net15}
N 50 -490 50 -440 {lab=net15}
N -90 -490 50 -490 {lab=net15}
N -90 -490 -90 -440 {lab=net15}
N -390 -440 -90 -440 {lab=net15}
N -460 -240 -430 -240 {lab=vbiasn}
N 220 130 220 140 {lab=#net11}
N 220 50 220 70 {lab=vbiasn}
N 220 -320 220 -310 {lab=#net12}
N 220 -410 220 -380 {lab=vbiasp}
C {sg13g2_pr/sg13_lv_nmos.sym} -40 70 0 0 {name=M15
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -40 170 0 0 {name=M16
l=0.6u
w=1.7u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -20 110 0 1 {name=p54 sig_type=std_logic lab=net4}
C {lab_pin.sym} -330 70 0 1 {name=p5 sig_type=std_logic lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} -480 -130 0 1 {name=M1
l=0.8u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -520 70 0 0 {name=M6
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -520 170 0 0 {name=M8
l=0.6u
w=1.72u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -620 -10 0 1 {name=M9
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -620 170 0 1 {name=M10
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -500 130 0 1 {name=p17 sig_type=std_logic lab=net7}
C {vsource.sym} -250 100 0 0 {name=Vbiasn
value=0.6 savecurrent=false}
C {lab_pin.sym} -640 120 0 1 {name=p7 sig_type=std_logic lab=net2}
C {lab_pin.sym} -500 -70 0 1 {name=p16 sig_type=std_logic lab=net10}
C {lab_wire.sym} -640 -350 0 0 {name=p2 sig_type=std_logic lab=vp}
C {vsource.sym} -830 -250 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} -830 -220 0 0 {name=l16 lab=0}
C {lab_pin.sym} -830 -280 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -1080 -120 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -1030 -30 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=25

.control

op
save all
write source_follow.raw
set appendwrite
show all
.endc
"}
C {gnd.sym} -510 -130 0 0 {name=l1 lab=0}
C {gnd.sym} -250 130 0 0 {name=l4 lab=0}
C {gnd.sym} -10 70 0 0 {name=l5 lab=0}
C {gnd.sym} -10 170 0 0 {name=l6 lab=0}
C {gnd.sym} -490 170 0 0 {name=l7 lab=0}
C {gnd.sym} -650 170 0 0 {name=l8 lab=0}
C {gnd.sym} -490 70 0 0 {name=l2 lab=0}
C {gnd.sym} -650 -10 0 0 {name=l9 lab=0}
C {isource.sym} -640 -200 0 0 {name=Iiref
value=0.5u savecurrent=false}
C {gnd.sym} -350 230 0 0 {name=l10 lab=0}
C {lab_pin.sym} -640 -110 0 1 {name=p3 sig_type=std_logic lab=net1}
C {vsource.sym} -640 80 0 0 {name=Vprad
value=0 savecurrent=false}
C {vsource.sym} -500 -10 0 0 {name=Vprad1
value=0 savecurrent=false}
C {vsource.sym} -20 -20 0 0 {name=Vprad2
value=0 savecurrent=false}
C {sg13g2_pr/sg13_lv_pmos.sym} -480 -310 0 1 {name=M5
l=0.6u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -480 -240 0 1 {name=M3
l=0.6u
w=0.8u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -510 -240 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_pin.sym} -510 -310 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_pin.sym} -510 -440 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_pin.sym} -500 -380 0 1 {name=p14 sig_type=std_logic lab=net8}
C {vsource.sym} -200 -310 0 0 {name=Vbiasn2
value=0.4 savecurrent=false}
C {gnd.sym} -200 -280 0 0 {name=l11 lab=0}
C {lab_wire.sym} -500 -500 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} -20 30 0 0 {name=p6 sig_type=std_logic lab=net13}
C {sg13g2_pr/sg13_lv_pmos.sym} -40 -280 0 0 {name=M7
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -10 -440 2 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_pin.sym} -10 -280 2 0 {name=p36 sig_type=std_logic lab=vp}
C {lab_pin.sym} -20 -400 0 1 {name=p57 sig_type=std_logic lab=net5}
C {sg13g2_pr/sg13_lv_pmos.sym} -40 -440 0 0 {name=M11
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} -20 -520 0 0 {name=p8 sig_type=std_logic lab=vp}
C {vsource.sym} -20 -360 0 0 {name=Vprad3
value=0 savecurrent=false}
C {lab_pin.sym} -500 -180 0 1 {name=p9 sig_type=std_logic lab=net15}
C {sg13g2_pr/sg13_lv_pmos.sym} -480 -440 0 1 {name=M2
l=0.6u
w=2.83u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -440 0 0 {name=M4
l=0.6u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -280 0 0 {name=M12
l=0.6u
w=5u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 20 0 0 {name=M13
l=0.6u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 170 0 0 {name=M14
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 120 -200 0 1 {name=M17
l=0.6u
w=1.6u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 120 -80 0 1 {name=M18
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 260 -130 0 0 {name=p11 sig_type=std_logic lab=vout}
C {lab_wire.sym} 80 -200 0 0 {name=p12 sig_type=std_logic lab=vp}
C {gnd.sym} 80 -80 0 0 {name=l13 lab=0}
C {gnd.sym} 220 200 0 0 {name=l19 lab=0}
C {gnd.sym} 220 -250 0 0 {name=l21 lab=0}
C {gnd.sym} 240 20 0 0 {name=l25 lab=0}
C {gnd.sym} 240 170 0 0 {name=l26 lab=0}
C {lab_pin.sym} 240 -440 2 0 {name=p18 sig_type=std_logic lab=vp}
C {lab_pin.sym} 240 -280 2 0 {name=p19 sig_type=std_logic lab=vp}
C {capa.sym} 330 -80 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 330 -130 0 0 {name=p1 sig_type=std_logic lab=vout}
C {gnd.sym} 330 -50 0 0 {name=l24 lab=0}
C {vsource.sym} 210 -100 0 0 {name=Vout
value=0.4 savecurrent=false}
C {gnd.sym} 210 -70 0 0 {name=l27 lab=0}
C {gnd.sym} 160 -200 0 0 {name=l12 lab=0}
C {lab_pin.sym} 160 -80 2 0 {name=p20 sig_type=std_logic lab=vp}
C {lab_pin.sym} 220 -30 2 0 {name=p21 sig_type=std_logic lab=vp}
C {lab_pin.sym} 220 -400 2 0 {name=p22 sig_type=std_logic lab=vbiasp}
C {lab_pin.sym} 220 60 2 0 {name=p23 sig_type=std_logic lab=vbiasn}
C {lab_pin.sym} -430 -240 2 0 {name=p24 sig_type=std_logic lab=vbiasn}
C {lab_pin.sym} -410 -130 2 0 {name=p25 sig_type=std_logic lab=vbiasp}
C {lab_pin.sym} -500 30 2 0 {name=p27 sig_type=std_logic lab=VE}
C {lab_pin.sym} -500 -270 2 0 {name=p15 sig_type=std_logic lab=VG}
C {lab_pin.sym} 0 -240 2 0 {name=p28 sig_type=std_logic lab=VH}
C {lab_pin.sym} 0 -110 2 0 {name=p29 sig_type=std_logic lab=VF}
C {vsource.sym} 220 -350 0 0 {name=Vprad4
value=0 savecurrent=false}
C {vsource.sym} 220 100 0 0 {name=Vprad5
value=0 savecurrent=false}
