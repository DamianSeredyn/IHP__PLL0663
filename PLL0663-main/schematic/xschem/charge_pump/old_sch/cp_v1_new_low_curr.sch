v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 890 -710 890 -660 {lab=vp}
N 410 -710 890 -710 {lab=vp}
N 500 -530 850 -530 {lab=biasp}
N 1100 -500 1100 -470 {lab=VH}
N 1140 -440 1170 -440 {lab=up}
N 1140 -340 1170 -340 {lab=dn}
N 1100 -310 1100 -290 {lab=VF}
N 890 -90 890 -60 {lab=gd}
N 410 -60 890 -60 {lab=gd}
N 1100 -390 1340 -390 {lab=vout}
N 1100 -410 1100 -390 {lab=vout}
N 890 -190 890 -150 {lab=net4}
N 550 -630 850 -630 {lab=net6}
N 850 -630 850 -620 {lab=net6}
N 490 -120 850 -120 {lab=#net3}
N 890 -120 900 -120 {lab=gd}
N 850 -130 850 -120 {lab=#net3}
N 890 -220 900 -220 {lab=gd}
N 510 -220 850 -220 {lab=biasn}
N 1090 -440 1100 -440 {lab=vp}
N 1090 -340 1100 -340 {lab=gd}
N 890 -630 900 -630 {lab=vp}
N 890 -470 900 -470 {lab=vp}
N 1100 -390 1100 -370 {lab=vout}
N 1090 -390 1100 -390 {lab=vout}
N 410 -710 410 -660 {lab=vp}
N 270 -710 410 -710 {lab=vp}
N 410 -90 410 -60 {lab=gd}
N 270 -90 270 -60 {lab=gd}
N 270 -60 410 -60 {lab=gd}
N 450 -430 500 -430 {lab=biasp}
N 450 -340 500 -340 {lab=biasn}
N 310 -120 340 -120 {lab=#net3}
N 410 -380 410 -370 {lab=net6}
N 410 -380 550 -380 {lab=net6}
N 410 -400 410 -380 {lab=net6}
N 550 -630 550 -380 {lab=net6}
N 450 -630 550 -630 {lab=net6}
N 400 -500 410 -500 {lab=vp}
N 400 -430 410 -430 {lab=vp}
N 400 -340 410 -340 {lab=0}
N 260 -270 270 -270 {lab=gd}
N 260 -120 270 -120 {lab=gd}
N 340 -120 370 -120 {lab=#net3}
N 370 -130 370 -120 {lab=#net3}
N 370 -130 490 -130 {lab=#net3}
N 490 -130 490 -120 {lab=#net3}
N 410 -120 420 -120 {lab=gd}
N 370 -230 370 -220 {lab=biasn}
N 510 -230 510 -220 {lab=biasn}
N 410 -220 420 -220 {lab=gd}
N 310 -220 370 -220 {lab=biasn}
N 500 -230 510 -230 {lab=biasn}
N 410 -190 410 -150 {lab=net7}
N 400 -630 410 -630 {lab=vp}
N 850 -530 850 -470 {lab=biasp}
N 890 -600 890 -500 {lab=net5}
N 890 -310 990 -310 {lab=VF}
N 990 -310 990 -290 {lab=VF}
N 990 -290 1100 -290 {lab=VF}
N 890 -440 890 -370 {lab=VH}
N 990 -500 990 -370 {lab=VH}
N 990 -500 1100 -500 {lab=VH}
N 270 -710 270 -600 {lab=vp}
N 500 -340 500 -230 {lab=biasn}
N 370 -230 500 -230 {lab=biasn}
N 500 -530 500 -430 {lab=biasp}
N 450 -530 500 -530 {lab=biasp}
N 890 -370 990 -370 {lab=VH}
N 310 -270 310 -220 {lab=biasn}
N 270 -350 270 -300 {lab=#net3}
N 340 -350 340 -120 {lab=#net3}
N 270 -350 340 -350 {lab=#net3}
N 270 -240 270 -150 {lab=net2}
N 410 -600 410 -530 {lab=net8}
N 450 -530 450 -500 {lab=biasp}
N 410 -310 410 -250 {lab=net10}
N 890 -310 890 -250 {lab=VF}
N 410 -470 410 -460 {lab=net9}
N 170 -560 230 -570 {lab=#net11}
N 270 -570 280 -570 {lab=vp}
N 270 -540 270 -410 {lab=net1}
C {sg13g2_pr/sg13_lv_pmos.sym} 870 -470 0 0 {name=M7
l=0.45u
w=1.8u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1120 -440 0 1 {name=M12
l=0.45u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1120 -340 0 1 {name=M14
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 870 -220 0 0 {name=M15
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 870 -120 0 0 {name=M16
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 890 -310 0 0 {name=p1 sig_type=std_logic lab=VF}
C {lab_wire.sym} 1100 -500 0 0 {name=p9 sig_type=std_logic lab=VH}
C {lab_pin.sym} 900 -630 2 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_pin.sym} 900 -470 2 0 {name=p36 sig_type=std_logic lab=vp}
C {lab_pin.sym} 1090 -440 2 1 {name=p18 sig_type=std_logic lab=vp}
C {ipin.sym} 1170 -440 0 1 {name=p24 lab=up}
C {ipin.sym} 1170 -340 0 1 {name=p27 lab=dn}
C {iopin.sym} 660 -710 0 0 {name=p28 lab=vp}
C {iopin.sym} 680 -60 0 0 {name=p29 lab=gd}
C {lab_pin.sym} 900 -220 0 1 {name=p39 sig_type=std_logic lab=gd}
C {lab_pin.sym} 900 -120 0 1 {name=p40 sig_type=std_logic lab=gd}
C {lab_pin.sym} 1090 -340 0 0 {name=p43 sig_type=std_logic lab=gd}
C {opin.sym} 1340 -390 0 1 {name=p45 lab=vout}
C {lab_pin.sym} 890 -170 0 1 {name=p54 sig_type=std_logic lab=net4}
C {lab_pin.sym} 890 -580 0 1 {name=p57 sig_type=std_logic lab=net5}
C {lab_pin.sym} 650 -530 0 1 {name=p4 sig_type=std_logic lab=biasp}
C {lab_pin.sym} 580 -220 0 1 {name=p5 sig_type=std_logic lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} 430 -340 0 1 {name=M1
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 430 -630 0 1 {name=M2
l=0.45u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 430 -500 0 1 {name=M5
l=0.45u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 430 -430 0 1 {name=M3
l=0.45u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 390 -220 0 0 {name=M6
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 390 -120 0 0 {name=M8
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 290 -270 0 1 {name=M9
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 290 -120 0 1 {name=M10
l=0.45u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 400 -430 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_pin.sym} 400 -500 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_pin.sym} 400 -630 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_pin.sym} 260 -270 0 0 {name=p46 sig_type=std_logic lab=gd}
C {gnd.sym} 400 -340 0 0 {name=l15 lab=0}
C {lab_pin.sym} 260 -120 0 0 {name=p21 sig_type=std_logic lab=gd}
C {lab_pin.sym} 420 -120 0 1 {name=p23 sig_type=std_logic lab=gd}
C {lab_pin.sym} 420 -220 0 1 {name=p12 sig_type=std_logic lab=gd}
C {lab_pin.sym} 410 -160 0 1 {name=p17 sig_type=std_logic lab=net7}
C {sg13g2_pr/sg13_lv_pmos.sym} 870 -630 0 0 {name=M11
l=0.45u
w=1.8u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {vsource.sym} 730 -500 0 0 {name=Vbiasp
value=0.4 savecurrent=false}
C {vsource.sym} 660 -190 0 0 {name=Vbiasn
value=0.6 savecurrent=false}
C {lab_pin.sym} 730 -470 0 1 {name=p2 sig_type=std_logic lab=gd}
C {lab_pin.sym} 660 -160 0 1 {name=p3 sig_type=std_logic lab=gd}
C {lab_pin.sym} 270 -460 0 1 {name=p6 sig_type=std_logic lab=net1}
C {lab_pin.sym} 270 -190 0 1 {name=p7 sig_type=std_logic lab=net2}
C {lab_pin.sym} 640 -630 0 1 {name=p11 sig_type=std_logic lab=net6}
C {lab_pin.sym} 410 -570 0 1 {name=p14 sig_type=std_logic lab=net8}
C {lab_pin.sym} 410 -470 0 1 {name=p15 sig_type=std_logic lab=net9}
C {lab_pin.sym} 410 -280 0 1 {name=p16 sig_type=std_logic lab=net10}
C {sg13g2_pr/sg13_lv_pmos.sym} 250 -570 0 0 {name=M4
l=0.45u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/curr_source.sym} 20 -560 0 0 {name=x1}
C {lab_pin.sym} 170 -580 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 170 -540 0 1 {name=p19 sig_type=std_logic lab=gd}
C {lab_pin.sym} 280 -570 0 0 {name=p20 sig_type=std_logic lab=vp}
C {vsource.sym} 270 -380 0 0 {name=Viref
value=0 savecurrent=false}
