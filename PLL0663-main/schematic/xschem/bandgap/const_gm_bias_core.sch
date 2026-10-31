v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 280 -580 280 20 {dash=10}
T {Start-up} 20 -590 0 0 0.4 0.4 {}
T {Bias core} 300 -590 0 0 0.4 0.4 {}
N 690 -120 770 -120 {lab=gd}
N 450 -120 530 -120 {lab=gd}
N 450 -500 530 -500 {lab=vp}
N 690 -500 770 -500 {lab=vp}
N 530 -560 530 -530 {lab=vp}
N 690 -560 690 -530 {lab=vp}
N 910 -500 990 -500 {lab=vp}
N 830 -500 870 -500 {lab=pbias}
N 910 -560 910 -530 {lab=vp}
N 690 -560 910 -560 {lab=vp}
N 670 -40 690 -40 {lab=res}
N 690 -90 690 -40 {lab=res}
N 160 -500 240 -500 {lab=vp}
N 0 -560 160 -560 {lab=vp}
N 80 -80 160 -80 {lab=gd}
N 160 -220 160 -110 {lab=stup}
N 340 -220 420 -220 {lab=gd}
N 200 -80 240 -80 {lab=nbias}
N 160 -220 230 -220 {lab=stup}
N 230 -230 230 -220 {lab=stup}
N 230 -230 250 -230 {lab=stup}
N 250 -230 250 -220 {lab=stup}
N 530 -560 690 -560 {lab=vp}
N 160 0 340 0 {lab=gd}
N 160 -560 530 -560 {lab=vp}
N 340 0 530 0 {lab=gd}
N 250 -220 310 -220 {lab=stup}
N 340 -280 340 -250 {lab=pbias}
N 420 -280 520 -280 {lab=pbias}
N 520 -290 520 -280 {lab=pbias}
N 520 -290 540 -290 {lab=pbias}
N 540 -290 540 -280 {lab=pbias}
N 540 -280 690 -280 {lab=pbias}
N 420 -350 530 -350 {lab=nbias}
N 240 -350 240 -80 {lab=nbias}
N 530 -90 530 0 {lab=gd}
N 340 -190 340 0 {lab=gd}
N 160 -50 160 0 {lab=gd}
N 40 -0 160 0 {lab=gd}
N 40 -500 120 -500 {lab=gd}
N 0 0 40 -0 {lab=gd}
N 40 -400 40 -0 {lab=gd}
N 160 -560 160 -530 {lab=vp}
N 590 -120 650 -120 {lab=nbias}
N 620 -500 650 -500 {lab=pbias}
N 530 -170 530 -150 {lab=nbias}
N 530 -470 530 -350 {lab=nbias}
N 690 -280 690 -150 {lab=pbias}
N 570 -500 620 -500 {lab=pbias}
N 620 -500 620 -450 {lab=pbias}
N 830 -500 830 -440 {lab=pbias}
N 910 -470 910 -420 {lab=ibias}
N 160 -400 240 -400 {lab=vp}
N 160 -470 160 -430 {lab=#net1}
N 40 -400 120 -400 {lab=gd}
N 40 -500 40 -400 {lab=gd}
N 160 -370 160 -220 {lab=stup}
N 910 -420 930 -420 {lab=ibias}
N 420 -300 420 -280 {lab=pbias}
N 340 -280 420 -280 {lab=pbias}
N 420 -300 440 -300 {lab=pbias}
N 420 -350 420 -330 {lab=nbias}
N 240 -350 420 -350 {lab=nbias}
N 420 -330 440 -330 {lab=nbias}
N 590 -170 590 -120 {lab=nbias}
N 570 -120 590 -120 {lab=nbias}
N 530 -170 590 -170 {lab=nbias}
N 530 -350 530 -170 {lab=nbias}
N 620 -450 690 -450 {lab=pbias}
N 690 -470 690 -450 {lab=pbias}
N 690 -440 690 -280 {lab=pbias}
N 690 -440 830 -440 {lab=pbias}
N 690 -450 690 -440 {lab=pbias}
N 160 160 240 160 {lab=vp}
N 160 100 160 130 {lab=vp}
N 90 160 120 160 {lab=vp}
N 160 190 160 220 {lab=vp}
N 340 160 420 160 {lab=vp}
N 270 160 300 160 {lab=#net2}
N 340 100 340 130 {lab=#net3}
N 340 190 340 220 {lab=#net4}
C {lab_wire.sym} 770 -120 0 0 {name=p15 sig_type=std_logic lab=gd}
C {lab_wire.sym} 450 -120 0 1 {name=p16 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 550 -120 0 1 {name=M1
l=4u
w=0.6u
ng=1
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 670 -120 0 0 {name=M2
l=4u
w=0.6u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 450 -500 0 1 {name=p35 sig_type=std_logic lab=vp}
C {lab_wire.sym} 770 -500 0 0 {name=p36 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 670 -500 0 0 {name=M4
l=4u
w=0.6u
ng=1
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 550 -500 0 1 {name=M3
l=4u
w=0.6u
ng=1
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 990 -500 0 0 {name=p24 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 890 -500 0 0 {name=M5
l=4u
w=0.6u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {ipin.sym} 0 -560 0 0 {name=p1 lab=vp}
C {ipin.sym} 0 0 0 0 {name=p2 lab=gd}
C {opin.sym} 930 -420 0 0 {name=p3 lab=ibias}
C {opin.sym} 670 -40 2 0 {name=p11 lab=res
}
C {lab_wire.sym} 240 -500 0 0 {name=p4 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 140 -500 0 0 {name=M8
l=4.38u
w=0.6u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 80 -80 0 1 {name=p5 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 180 -80 0 1 {name=M6
l=2u
w=0.6u
ng=1
m=4
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 420 -220 0 0 {name=p6 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 320 -220 0 0 {name=M9
l=2u
w=0.6u
ng=1
m=2
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 220 -220 0 0 {name=p10 sig_type=std_logic lab=stup}
C {lab_wire.sym} 240 -400 0 0 {name=p18 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 140 -400 0 0 {name=M7
l=4.38u
w=0.6u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {opin.sym} 440 -330 0 0 {name=p8 lab=nbias}
C {opin.sym} 440 -300 0 0 {name=p9 lab=pbias}
C {lab_wire.sym} 240 160 0 0 {name=p7 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 140 160 0 0 {name=M10
l=2u
w=0.6u
ng=1
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 160 100 0 0 {name=p12 sig_type=std_logic lab=vp}
C {lab_wire.sym} 90 160 0 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_wire.sym} 160 220 0 0 {name=p14 sig_type=std_logic lab=vp}
C {lab_wire.sym} 420 160 0 0 {name=p17 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 320 160 0 0 {name=M11
l=4u
w=0.6u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 340 220 0 0 {name=p19 sig_type=std_logic lab=vp}
C {lab_wire.sym} 270 160 0 0 {name=p20 sig_type=std_logic lab=vp}
C {lab_wire.sym} 340 100 0 0 {name=p21 sig_type=std_logic lab=vp}
