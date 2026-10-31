v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 280 -20 330 -20 {lab=vout}
N -170 -20 -90 -20 {lab=rst}
N -200 0 -90 -0 {lab=clk_ref}
N 280 10 400 10 {lab=out}
N 90 -100 90 -70 {lab=vp}
N 70 -100 70 -70 {lab=vph}
N -40 -100 -40 -70 {lab=gd}
N -140 180 -60 180 {lab=#net1}
N -60 70 -60 180 {lab=#net1}
N -140 200 -40 200 {lab=#net2}
N -40 70 -40 200 {lab=#net2}
N -140 220 -20 220 {lab=#net3}
N -20 70 -20 220 {lab=#net3}
N 10 70 10 240 {lab=#net4}
N -140 240 10 240 {lab=#net4}
N -140 260 30 260 {lab=#net5}
N 30 70 30 260 {lab=#net5}
N -140 280 50 280 {lab=#net6}
N 50 70 50 280 {lab=#net6}
N 70 70 70 300 {lab=#net7}
N -140 300 70 300 {lab=#net7}
N -140 320 90 320 {lab=#net8}
N 90 70 90 320 {lab=#net8}
N -140 340 110 340 {lab=#net9}
N 110 70 110 340 {lab=#net9}
N -140 140 -110 140 {lab=vp}
N -140 160 -110 160 {lab=gd}
N -540 180 -440 180 {lab=#net10}
N -660 290 -540 290 {lab=#net10}
N -540 180 -540 290 {lab=#net10}
N -660 160 -440 160 {lab=#net11}
N -660 40 -460 40 {lab=#net12}
N -460 40 -460 140 {lab=#net12}
N -460 140 -440 140 {lab=#net12}
N -790 40 -740 40 {lab=clk_in}
N -790 160 -740 160 {lab=data_en}
N -790 290 -740 290 {lab=data_in}
N -720 100 -720 130 {lab=vp}
N -720 -10 -720 10 {lab=vp}
N -720 70 -680 70 {lab=gd}
N -720 190 -720 220 {lab=gd}
N -720 240 -720 260 {lab=vp}
N -720 320 -720 350 {lab=gd}
N -140 360 470 360 {lab=#net13}
N 470 300 470 360 {lab=#net13}
N -140 380 490 380 {lab=#net14}
N 490 300 490 380 {lab=#net14}
N -140 400 510 400 {lab=#net15}
N 510 300 510 400 {lab=#net15}
N 640 160 680 160 {lab=vp}
N 640 140 680 140 {lab=gd}
N 640 200 770 200 {lab=debug_out}
N 230 70 230 130 {lab=#net16}
N 230 130 340 130 {lab=#net16}
N 210 150 340 150 {lab=#net17}
N 210 70 210 150 {lab=#net17}
N 190 70 190 170 {lab=#net18}
N 190 170 340 170 {lab=#net18}
N 170 190 340 190 {lab=#net19}
N 170 70 170 190 {lab=#net19}
N 150 70 150 210 {lab=#net20}
N 150 210 340 210 {lab=#net20}
N 130 230 340 230 {lab=#net21}
N 130 70 130 230 {lab=#net21}
N 280 250 340 250 {lab=gd}
N 280 270 340 270 {lab=gd}
N 640 180 680 180 {lab=vph}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/top/PLL_top.sym} 60 -80 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/input_register.sym} -290 270 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/buffer_hv.sym} -630 290 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/buffer_hv.sym} -630 160 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/buffer_hv.sym} -630 40 0 0 {name=x5}
C {ipin.sym} -530 -310 0 0 {name=p1 lab=vp}
C {ipin.sym} -530 -280 0 0 {name=p2 lab=gd}
C {ipin.sym} -790 40 0 0 {name=p3 lab=clk_in}
C {ipin.sym} -790 160 0 0 {name=p4 lab=data_en}
C {ipin.sym} -790 290 0 0 {name=p5 lab=data_in}
C {ipin.sym} -200 0 0 0 {name=p6 lab=clk_ref}
C {ipin.sym} -170 -20 0 0 {name=p7 lab=rst}
C {lab_wire.sym} -110 140 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_wire.sym} 90 -100 0 0 {name=p9 sig_type=std_logic lab=vp}
C {lab_wire.sym} 70 -100 0 0 {name=p10 sig_type=std_logic lab=vph}
C {lab_wire.sym} -40 -100 0 0 {name=p11 sig_type=std_logic lab=gd}
C {opin.sym} 400 10 0 0 {name=p12 lab=out}
C {opin.sym} 330 -20 0 0 {name=p13 lab=vout}
C {lab_wire.sym} -110 160 0 0 {name=p14 sig_type=std_logic lab=gd}
C {lab_wire.sym} -720 -10 0 0 {name=p15 sig_type=std_logic lab=vp}
C {lab_wire.sym} -720 100 0 0 {name=p16 sig_type=std_logic lab=vp}
C {lab_wire.sym} -680 70 0 0 {name=p17 sig_type=std_logic lab=gd}
C {lab_wire.sym} -720 220 0 0 {name=p18 sig_type=std_logic lab=gd}
C {lab_wire.sym} -720 240 0 0 {name=p19 sig_type=std_logic lab=vp}
C {lab_wire.sym} -720 350 0 0 {name=p20 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/Test_mux.sym} 490 200 0 0 {name=x6}
C {ipin.sym} -530 -350 0 0 {name=p21 lab=vph}
C {lab_wire.sym} 680 140 0 0 {name=p22 sig_type=std_logic lab=gd}
C {lab_wire.sym} 680 160 0 0 {name=p23 sig_type=std_logic lab=vp}
C {opin.sym} 770 200 0 0 {name=p24 lab=debug_out}
C {lab_wire.sym} 280 250 0 0 {name=p29 sig_type=std_logic lab=gd}
C {lab_wire.sym} 280 270 0 0 {name=p30 sig_type=std_logic lab=gd}
C {lab_wire.sym} 680 180 0 0 {name=p31 sig_type=std_logic lab=vph}
