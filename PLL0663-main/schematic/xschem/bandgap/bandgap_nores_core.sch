v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -340 100 -340 {lab=gd}
N 140 -340 270 -340 {lab=#net1}
N 460 -340 520 -340 {lab=gd}
N 180 -220 240 -220 {lab=vp}
N 320 -220 380 -220 {lab=vp}
N 320 -60 380 -60 {lab=gd}
N 380 -110 440 -110 {lab=#net2}
N 440 -110 440 -60 {lab=#net2}
N 420 -60 440 -60 {lab=#net2}
N 560 -10 760 -10 {lab=gd}
N 700 -220 760 -220 {lab=vp}
N 760 -170 820 -170 {lab=#net3}
N 820 -220 820 -170 {lab=#net3}
N 760 -190 760 -170 {lab=#net3}
N 800 -220 820 -220 {lab=#net3}
N 560 -270 560 -250 {lab=#net4}
N 660 -270 760 -270 {lab=#net4}
N 760 -270 760 -250 {lab=#net4}
N 180 -270 180 -250 {lab=#net5}
N 280 -270 380 -270 {lab=#net5}
N 380 -270 380 -250 {lab=#net5}
N 480 -220 520 -220 {lab=d1}
N 560 -220 620 -220 {lab=vp}
N 760 -60 820 -60 {lab=gd}
N 420 -220 460 -220 {lab=d1}
N 480 -220 480 -160 {lab=d1}
N 460 -220 480 -220 {lab=d1}
N 480 -160 490 -160 {lab=d1}
N 180 -270 280 -270 {lab=#net5}
N 560 -270 660 -270 {lab=#net4}
N 100 -220 140 -220 {lab=d1}
N 270 -350 270 -340 {lab=#net1}
N 270 -350 290 -350 {lab=#net1}
N 290 -350 290 -340 {lab=#net1}
N 400 -340 420 -340 {lab=#net1}
N 40 -480 100 -480 {lab=vp}
N 100 -530 100 -510 {lab=vp}
N 100 -330 100 -220 {lab=d1}
N 460 -330 460 -220 {lab=d1}
N 100 -430 160 -430 {lab=#net6}
N 100 -450 100 -430 {lab=#net6}
N 160 -480 160 -430 {lab=#net6}
N 140 -480 160 -480 {lab=#net6}
N 100 -430 100 -370 {lab=#net6}
N 380 -190 380 -110 {lab=#net2}
N 180 -190 180 -10 {lab=gd}
N 380 -30 380 -10 {lab=gd}
N 180 -10 380 -10 {lab=gd}
N 760 -30 760 -10 {lab=gd}
N 760 -170 760 -90 {lab=#net3}
N 560 -190 560 -10 {lab=gd}
N 380 -10 560 -10 {lab=gd}
N 440 -60 550 -60 {lab=#net2}
N 550 -70 550 -60 {lab=#net2}
N 550 -70 570 -70 {lab=#net2}
N 570 -70 570 -60 {lab=#net2}
N 570 -60 720 -60 {lab=#net2}
N 820 -170 860 -170 {lab=#net3}
N 280 -480 340 -480 {lab=vp}
N 280 -530 280 -510 {lab=vp}
N 160 -480 240 -480 {lab=#net6}
N 280 -450 280 -270 {lab=#net5}
N 460 -480 520 -480 {lab=vp}
N 460 -530 460 -510 {lab=vp}
N 660 -480 720 -480 {lab=vp}
N 660 -530 660 -510 {lab=vp}
N 400 -480 420 -480 {lab=#net6}
N 160 -430 270 -430 {lab=#net6}
N 270 -440 270 -430 {lab=#net6}
N 270 -440 290 -440 {lab=#net6}
N 290 -440 290 -430 {lab=#net6}
N 290 -430 400 -430 {lab=#net6}
N 400 -480 400 -430 {lab=#net6}
N 400 -430 450 -430 {lab=#net6}
N 450 -440 450 -430 {lab=#net6}
N 450 -440 470 -440 {lab=#net6}
N 470 -440 470 -430 {lab=#net6}
N 470 -430 600 -430 {lab=#net6}
N 600 -480 600 -430 {lab=#net6}
N 600 -480 620 -480 {lab=#net6}
N 460 -390 460 -370 {lab=#net1}
N 660 -450 660 -270 {lab=#net4}
N 100 -220 100 -160 {lab=d1}
N 100 -160 110 -160 {lab=d1}
N 460 -530 660 -530 {lab=vp}
N 100 -530 280 -530 {lab=vp}
N 280 -530 460 -530 {lab=vp}
N 0 -530 100 -530 {lab=vp}
N 0 -10 180 -10 {lab=gd}
N 400 -390 400 -340 {lab=#net1}
N 290 -340 400 -340 {lab=#net1}
N 400 -390 460 -390 {lab=#net1}
N 460 -450 460 -390 {lab=#net1}
N 380 -110 380 -90 {lab=#net2}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 120 -340 0 1 {name=M1
l=0.9u
w=1.2u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 160 -220 0 0 {name=M2
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 40 -340 0 0 {name=p1 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 440 -340 0 0 {name=M3
l=0.9u
w=1.2u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 520 -340 0 1 {name=p2 sig_type=std_logic lab=gd}
C {lab_wire.sym} 240 -220 0 1 {name=p3 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 400 -220 0 1 {name=M4
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 320 -220 0 0 {name=p4 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 400 -60 0 1 {name=M5
l=0.9u
w=1.2u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 320 -60 0 0 {name=p5 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_hv_nmos.sym} 740 -60 0 0 {name=M6
l=0.9u
w=1.2u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {lab_wire.sym} 820 -60 0 1 {name=p6 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 540 -220 0 0 {name=M7
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 620 -220 0 1 {name=p7 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 780 -220 0 1 {name=M8
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 700 -220 0 0 {name=p8 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 120 -480 0 1 {name=M9
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 40 -480 0 0 {name=p9 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 260 -480 0 0 {name=M10
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 340 -480 0 1 {name=p10 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 440 -480 0 0 {name=M11
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 520 -480 0 1 {name=p11 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_hv_pmos.sym} 640 -480 0 0 {name=M12
l=0.4u
w=0.3u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {lab_wire.sym} 720 -480 0 1 {name=p12 sig_type=std_logic lab=vp}
C {ipin.sym} 0 -530 0 0 {name=p13 lab=vp}
C {ipin.sym} 0 -10 0 0 {name=p14 lab=gd}
C {opin.sym} 110 -160 0 0 {name=p15 lab=d1}
C {opin.sym} 490 -160 0 0 {name=p16 lab=d8}
