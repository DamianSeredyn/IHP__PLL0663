v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -230 -70 -130 -70 {lab=D}
N -110 -140 -110 -100 {lab=vp}
N -110 -40 -110 0 {lab=gd}
N -90 -40 -90 0 {lab=clk_n}
N -90 -140 -90 -100 {lab=clk}
N 110 -70 110 10 {lab=2}
N 70 -70 110 -70 {lab=2}
N 130 -40 130 10 {lab=rst}
N 20 -40 20 0 {lab=gd}
N 20 -140 20 -100 {lab=vp}
N 110 -70 300 -70 {lab=2}
N 320 -140 320 -100 {lab=vp}
N 320 -40 320 0 {lab=gd}
N 340 -40 340 0 {lab=clk}
N 340 -140 340 -100 {lab=clk_n}
N 440 -70 530 -70 {lab=3}
N 660 130 660 170 {lab=vp}
N 640 130 640 170 {lab=clk}
N 660 230 660 270 {lab=gd}
N 640 230 640 270 {lab=clk_n}
N 30 280 30 320 {lab=vp}
N 30 380 30 420 {lab=gd}
N 10 280 10 320 {lab=clk_n}
N -40 -70 -0 -70 {lab=1}
N 0 -300 70 -300 {lab=clk}
N 140 -300 220 -300 {lab=clk_n}
N 90 -360 90 -330 {lab=vp}
N 90 -270 90 -240 {lab=gd}
N 470 -90 530 -90 {lab=rst}
N 910 80 910 120 {lab=gd}
N 910 -20 910 20 {lab=vp}
N 860 50 890 50 {lab=Q}
N 960 50 960 200 {lab=NQ}
N 960 200 1030 200 {lab=NQ}
N -40 350 -30 350 {lab=1}
N 10 380 10 420 {lab=clk}
N -40 -70 -40 350 {lab=1}
N 440 -70 440 200 {lab=3}
N 380 -70 440 -70 {lab=3}
N -50 -70 -40 -70 {lab=1}
N -100 470 -100 490 {lab=gd}
N -100 350 -40 350 {lab=1}
N 570 -170 570 -140 {lab=vp}
N 570 -20 570 20 {lab=gd}
N 860 -80 1030 -80 {lab=Q}
N 860 -80 860 50 {lab=Q}
N 650 -80 860 -80 {lab=Q}
N 180 50 220 50 {lab=vp}
N 40 50 60 50 {lab=gd}
N 120 130 120 350 {lab=post_NOR}
N 440 200 600 200 {lab=3}
N 680 200 960 200 {lab=NQ}
N 50 350 120 350 {lab=post_NOR}
N -100 350 -100 360 {lab=1}
N -110 350 -100 350 {lab=1}
N -130 400 -130 470 {lab=gd}
N -130 470 -100 470 {lab=gd}
N -100 400 -100 470 {lab=gd}
N -100 470 -70 470 {lab=gd}
N -70 400 -70 470 {lab=gd}
N 440 310 440 330 {lab=gd}
N 410 240 410 310 {lab=gd}
N 410 310 440 310 {lab=gd}
N 440 240 440 310 {lab=gd}
N 440 310 470 310 {lab=gd}
N 470 240 470 310 {lab=gd}
N 260 40 260 60 {lab=gd}
N 230 -30 230 40 {lab=gd}
N 230 40 260 40 {lab=gd}
N 260 -30 260 40 {lab=gd}
N 260 40 290 40 {lab=gd}
N 290 -30 290 40 {lab=gd}
C {ipin.sym} -230 -70 0 0 {name=p1 lab=D}
C {opin.sym} 1030 -80 0 0 {name=p2 lab=Q}
C {opin.sym} 1030 200 0 0 {name=p3 lab=NQ}
C {lab_wire.sym} -110 -140 0 0 {name=p5 sig_type=std_logic lab=vp}
C {lab_wire.sym} 20 -140 0 0 {name=p6 sig_type=std_logic lab=vp}
C {lab_wire.sym} 320 -140 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 570 -170 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_wire.sym} 220 50 0 0 {name=p9 sig_type=std_logic lab=vp}
C {lab_wire.sym} 30 280 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} 660 130 0 0 {name=p11 sig_type=std_logic lab=vp}
C {ipin.sym} 0 -300 0 0 {name=p12 lab=clk}
C {lab_wire.sym} 220 -300 0 0 {name=p13 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} 90 -360 0 0 {name=p14 sig_type=std_logic lab=vp}
C {lab_wire.sym} 40 50 0 0 {name=p15 sig_type=std_logic lab=gd}
C {lab_wire.sym} 30 420 0 1 {name=p16 sig_type=std_logic lab=gd}
C {lab_wire.sym} -110 0 0 0 {name=p17 sig_type=std_logic lab=gd}
C {lab_wire.sym} 20 0 0 0 {name=p18 sig_type=std_logic lab=gd}
C {lab_wire.sym} 320 0 0 0 {name=p19 sig_type=std_logic lab=gd}
C {lab_wire.sym} 90 -240 0 0 {name=p20 sig_type=std_logic lab=gd}
C {lab_wire.sym} 570 20 0 0 {name=p21 sig_type=std_logic lab=gd}
C {lab_wire.sym} 660 270 0 0 {name=p23 sig_type=std_logic lab=gd}
C {ipin.sym} 440 -290 0 0 {name=p24 lab=rst}
C {lab_wire.sym} 490 -90 0 0 {name=p25 sig_type=std_logic lab=rst}
C {lab_wire.sym} 130 -40 0 0 {name=p26 sig_type=std_logic lab=rst}
C {lab_wire.sym} -90 0 0 1 {name=p27 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} 340 -140 0 1 {name=p28 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} 10 280 0 0 {name=p29 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} 640 270 0 0 {name=p30 sig_type=std_logic lab=clk_n}
C {lab_wire.sym} -90 -140 0 1 {name=p31 sig_type=std_logic lab=clk}
C {lab_wire.sym} 10 420 0 1 {name=p32 sig_type=std_logic lab=clk}
C {lab_wire.sym} 640 130 0 0 {name=p33 sig_type=std_logic lab=clk}
C {lab_wire.sym} 340 0 0 1 {name=p34 sig_type=std_logic lab=clk}
C {ipin.sym} 0 -190 0 0 {name=p35 lab=gd}
C {ipin.sym} 0 -220 0 0 {name=p36 lab=vp}
C {lab_wire.sym} -10 -70 0 0 {name=p37 sig_type=std_logic lab=1}
C {lab_wire.sym} 170 -70 0 0 {name=p38 sig_type=std_logic lab=2}
C {lab_wire.sym} 430 -70 0 0 {name=p39 sig_type=std_logic lab=3}
C {lab_wire.sym} 910 -20 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} 910 120 0 0 {name=p22 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_passgate.sym} 10 350 0 1 {name=x8}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_passgate.sym} 340 -70 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_passgate.sym} 640 200 0 1 {name=x7}
C {lab_wire.sym} -100 490 0 0 {name=p42 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_NOR.sym} 650 -80 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_NOR.sym} 120 130 1 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_passgate.sym} -90 -70 0 0 {name=x1}
C {lab_wire.sym} 120 190 0 0 {name=p44 sig_type=std_logic lab=post_NOR}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} -100 380 1 0 {name=M1
l=5u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 440 330 0 0 {name=p40 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 440 220 1 0 {name=M2
l=5u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 260 60 0 0 {name=p41 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 260 -50 1 0 {name=M3
l=5u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_inverter_x8.sym} 30 -70 0 0 {name=x9}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_inverter_x8.sym} 920 50 0 0 {name=x6}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_inverter_x4.sym} 90 -300 0 0 {name=x2}
