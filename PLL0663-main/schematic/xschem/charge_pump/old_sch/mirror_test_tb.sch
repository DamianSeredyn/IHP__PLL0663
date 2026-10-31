v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -420 0 -420 30 {lab=0}
N -900 30 -420 30 {lab=0}
N -420 -100 -420 -60 {lab=net4}
N -560 -30 -460 -30 {lab=net1}
N -420 -30 -410 -30 {lab=0}
N -460 -40 -460 -30 {lab=net1}
N -420 -130 -410 -130 {lab=0}
N -800 -130 -460 -130 {lab=biasn}
N -900 0 -900 30 {lab=0}
N -1040 0 -1040 30 {lab=0}
N -1040 30 -900 30 {lab=0}
N -860 -330 -810 -330 {lab=biasn}
N -1000 -30 -970 -30 {lab=net1}
N -910 -330 -900 -330 {lab=0}
N -1050 -180 -1040 -180 {lab=#net3}
N -1050 -30 -1040 -30 {lab=0}
N -970 -30 -940 -30 {lab=net1}
N -940 -40 -940 -30 {lab=net1}
N -940 -40 -820 -40 {lab=net1}
N -820 -40 -820 -30 {lab=net1}
N -900 -30 -890 -30 {lab=0}
N -940 -140 -940 -130 {lab=biasn}
N -800 -140 -800 -130 {lab=biasn}
N -900 -130 -890 -130 {lab=0}
N -1000 -130 -940 -130 {lab=biasn}
N -900 -100 -900 -60 {lab=net7}
N -940 -140 -800 -140 {lab=biasn}
N -970 -260 -970 -30 {lab=net1}
N -1040 -260 -970 -260 {lab=net1}
N -1050 -210 -1040 -210 {lab=0}
N -1000 -210 -1000 -130 {lab=biasn}
N -1040 -260 -1040 -240 {lab=net1}
N -1040 -600 -1040 -430 {lab=vp}
N -1040 -370 -1040 -260 {lab=net1}
N -1040 -90 -1040 -60 {lab=net2}
N -1040 -180 -1040 -150 {lab=#net3}
N -900 -180 -900 -160 {lab=VE}
N -420 -310 -420 -250 {lab=VF}
N -420 -190 -420 -160 {lab=net13}
N -900 -720 -900 -670 {lab=vp}
N -910 -510 -900 -510 {lab=vp}
N -910 -440 -900 -440 {lab=vp}
N -910 -640 -900 -640 {lab=vp}
N -830 -540 -460 -540 {lab=biasn}
N -900 -610 -900 -540 {lab=net8}
N -860 -540 -860 -510 {lab=biasn}
N -900 -480 -900 -470 {lab=VG}
N -900 -400 -900 -360 {lab=net15}
N -420 -720 -420 -670 {lab=vp}
N -420 -640 -410 -640 {lab=vp}
N -420 -480 -410 -480 {lab=vp}
N -460 -540 -460 -480 {lab=biasn}
N -420 -610 -420 -590 {lab=net5}
N -420 -530 -420 -510 {lab=#net6}
N -900 -300 -900 -240 {lab=net10}
N -790 -640 -790 -400 {lab=net15}
N -860 -640 -790 -640 {lab=net15}
N -900 -400 -790 -400 {lab=net15}
N -900 -410 -900 -400 {lab=net15}
N -420 -450 -420 -440 {lab=VH}
N -420 -440 -300 -440 {lab=VH}
N -300 -440 -300 -430 {lab=VH}
N -300 -330 -300 -310 {lab=vout}
N -300 -250 -300 -230 {lab=VF}
N -370 -230 -300 -230 {lab=VF}
N -370 -310 -370 -230 {lab=VF}
N -420 -310 -370 -310 {lab=VF}
N -420 -320 -420 -310 {lab=VF}
N -260 -280 -240 -280 {lab=dn}
N -260 -400 -240 -400 {lab=up}
N -300 -370 -300 -330 {lab=vout}
N -320 -280 -300 -280 {lab=0}
N -320 -400 -300 -400 {lab=vp}
N -420 -720 -180 -720 {lab=vp}
N -300 -330 -220 -330 {lab=vout}
N -320 -30 -220 -30 {lab=net1}
N -320 -80 -320 -30 {lab=net1}
N -560 -80 -320 -80 {lab=net1}
N -560 -80 -560 -30 {lab=net1}
N -820 -30 -560 -30 {lab=net1}
N -790 -640 -460 -640 {lab=net15}
N -860 -440 -830 -440 {lab=biasn}
N -80 -340 -80 -320 {lab=vout}
N -830 -540 -830 -440 {lab=biasn}
N -860 -540 -830 -540 {lab=biasn}
N -540 -430 -520 -430 {lab=0}
N -540 -450 -520 -450 {lab=vp}
N -540 -410 -530 -410 {lab=biasn}
N -530 -410 -530 -390 {lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} -440 -130 0 0 {name=M15
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -440 -30 0 0 {name=M16
l=0.6u
w=1.7u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -420 -90 0 1 {name=p54 sig_type=std_logic lab=net4}
C {lab_pin.sym} -640 -540 0 1 {name=p5 sig_type=std_logic lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} -880 -330 0 1 {name=M1
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -920 -130 0 0 {name=M6
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -920 -30 0 0 {name=M8
l=0.6u
w=1.72u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -1020 -210 0 1 {name=M9
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -1020 -30 0 1 {name=M10
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} -900 -70 0 1 {name=p17 sig_type=std_logic lab=net7}
C {lab_pin.sym} -1040 -80 0 1 {name=p7 sig_type=std_logic lab=net2}
C {lab_pin.sym} -900 -270 0 1 {name=p16 sig_type=std_logic lab=net10}
C {lab_wire.sym} -1040 -550 0 0 {name=p2 sig_type=std_logic lab=vp}
C {vsource.sym} -1230 -450 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} -1230 -420 0 0 {name=l16 lab=0}
C {lab_pin.sym} -1230 -480 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -1480 -320 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -1430 -230 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 25

.control

tran 1n 100u
save all
plot v(vout)
write mirror_test.raw
set appendwrite
show all
.endc
"}
C {gnd.sym} -910 -330 0 0 {name=l1 lab=0}
C {gnd.sym} -410 -130 0 0 {name=l5 lab=0}
C {gnd.sym} -410 -30 0 0 {name=l6 lab=0}
C {gnd.sym} -890 -30 0 0 {name=l7 lab=0}
C {gnd.sym} -1050 -30 0 0 {name=l8 lab=0}
C {gnd.sym} -890 -130 0 0 {name=l2 lab=0}
C {gnd.sym} -1050 -210 0 0 {name=l9 lab=0}
C {isource.sym} -1040 -400 0 0 {name=Iiref
value=0.5u savecurrent=false}
C {gnd.sym} -750 30 0 0 {name=l10 lab=0}
C {lab_pin.sym} -1040 -310 0 1 {name=p3 sig_type=std_logic lab=net1}
C {vsource.sym} -1040 -120 0 0 {name=Vprad
value=0 savecurrent=false}
C {vsource.sym} -900 -210 0 0 {name=Vprad1
value=0 savecurrent=false}
C {vsource.sym} -420 -220 0 0 {name=Vprad2
value=0 savecurrent=false}
C {sg13g2_pr/sg13_lv_pmos.sym} -880 -510 0 1 {name=q
l=0.6u
w=2.84u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -880 -440 0 1 {name=M3
l=0.6u
w=2.8u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -910 -440 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_pin.sym} -910 -510 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_pin.sym} -910 -640 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_pin.sym} -900 -580 0 1 {name=p14 sig_type=std_logic lab=net8}
C {lab_wire.sym} -900 -700 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} -420 -170 0 0 {name=p6 sig_type=std_logic lab=net13}
C {sg13g2_pr/sg13_lv_pmos.sym} -440 -480 0 0 {name=M7
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -410 -640 2 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_pin.sym} -410 -480 2 0 {name=p36 sig_type=std_logic lab=vp}
C {lab_pin.sym} -420 -600 0 1 {name=p57 sig_type=std_logic lab=net5}
C {sg13g2_pr/sg13_lv_pmos.sym} -440 -640 0 0 {name=M11
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} -420 -720 0 0 {name=p8 sig_type=std_logic lab=vp}
C {vsource.sym} -420 -560 0 0 {name=Vprad3
value=0 savecurrent=false}
C {lab_pin.sym} -900 -380 0 1 {name=p9 sig_type=std_logic lab=net15}
C {sg13g2_pr/sg13_lv_pmos.sym} -880 -640 0 1 {name=M2
l=0.6u
w=2.84u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -280 -400 0 1 {name=M17
l=0.6u
w=1.6u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -280 -280 0 1 {name=M18
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} -320 -400 0 0 {name=p12 sig_type=std_logic lab=vp}
C {gnd.sym} -320 -280 0 0 {name=l13 lab=0}
C {lab_pin.sym} -900 -170 2 0 {name=p27 sig_type=std_logic lab=VE}
C {lab_pin.sym} -900 -470 2 0 {name=p15 sig_type=std_logic lab=VG}
C {lab_pin.sym} -400 -440 2 0 {name=p28 sig_type=std_logic lab=VH}
C {lab_pin.sym} -400 -310 2 0 {name=p29 sig_type=std_logic lab=VF}
C {capa.sym} -80 -290 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -80 -260 0 0 {name=l14 lab=0}
C {lab_pin.sym} -230 -330 2 0 {name=p1 sig_type=std_logic lab=vout}
C {lab_pin.sym} -80 -340 2 0 {name=p18 sig_type=std_logic lab=vout}
C {lab_pin.sym} -740 -130 0 1 {name=p19 sig_type=std_logic lab=biasn}
C {lab_pin.sym} -810 -330 0 1 {name=p21 sig_type=std_logic lab=biasn}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/vbias.sym} -690 -430 0 0 {name=x1}
C {gnd.sym} -520 -430 0 0 {name=Vbias2 lab=0}
C {lab_pin.sym} -530 -390 0 1 {name=p23 sig_type=std_logic lab=biasn}
C {lab_wire.sym} -520 -450 0 0 {name=p24 sig_type=std_logic lab=vp}
C {lab_pin.sym} -240 -400 0 1 {name=p11 sig_type=std_logic lab=up}
C {lab_pin.sym} -240 -280 0 1 {name=p20 sig_type=std_logic lab=dn}
C {vsource.sym} -1330 -660 0 0 {name=Vup2
value="PULSE(1.2 0 0n 10p 10p 5u 15u)" savecurrent=false}
C {gnd.sym} -1330 -630 0 0 {name=l11 lab=0}
C {vsource.sym} -1330 -550 0 0 {name=Vdn2
value="PULSE(0 1.2 7.5u 10p 10p 5u 15u)" savecurrent=false}
C {gnd.sym} -1330 -520 0 0 {name=l12 lab=0}
C {lab_pin.sym} -1330 -690 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} -1330 -580 0 1 {name=p31 sig_type=std_logic lab=dn}
