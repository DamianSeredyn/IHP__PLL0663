v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -460 200 -440 200 {lab=VP}
N -460 220 -440 220 {lab=GND}
N -460 250 -440 250 {lab=clk}
N -460 270 -440 270 {lab=d}
N 110 210 130 210 {lab=VP}
N 110 230 130 230 {lab=GND}
N 110 60 130 60 {lab=VP}
N 110 80 130 80 {lab=GND}
N 120 -90 140 -90 {lab=VP}
N 120 -70 140 -70 {lab=GND}
N 110 390 130 390 {lab=VP}
N 110 410 130 410 {lab=GND}
N 620 210 640 210 {lab=VP}
N 620 230 640 230 {lab=GND}
N 630 60 650 60 {lab=VP}
N 630 80 650 80 {lab=GND}
N 110 100 140 100 {lab=#net1}
N 140 100 140 130 {lab=#net1}
N -210 210 -190 210 {lab=#net1}
N -210 180 -210 210 {lab=#net1}
N -210 180 140 130 {lab=#net1}
N 690 100 720 100 {lab=q}
N 690 250 720 250 {lab=q_}
N 690 180 690 250 {lab=q_}
N 620 250 690 250 {lab=q_}
N 690 100 690 120 {lab=q}
N 630 100 690 100 {lab=q}
N 300 210 320 210 {lab=q}
N 300 180 300 210 {lab=q}
N 300 80 330 80 {lab=q_}
N 300 80 300 120 {lab=q_}
N 300 120 690 180 {lab=q_}
N 300 180 690 120 {lab=q}
N 140 100 220 100 {lab=#net1}
N 220 60 220 100 {lab=#net1}
N 220 60 330 60 {lab=#net1}
N -220 60 -190 60 {lab=#net2}
N -220 40 -220 60 {lab=#net2}
N 120 -50 170 -50 {lab=#net2}
N 170 -50 170 -20 {lab=#net2}
N -220 40 170 -20 {lab=#net2}
N 220 20 220 60 {lab=#net1}
N -220 -70 -180 -70 {lab=#net1}
N -220 -70 -220 -20 {lab=#net1}
N -220 -20 220 20 {lab=#net1}
N 110 250 190 250 {lab=#net3}
N -210 250 -190 250 {lab=#net4}
N -210 250 -210 280 {lab=#net4}
N -210 390 -190 390 {lab=#net3}
N -210 360 -210 390 {lab=#net3}
N 110 430 190 430 {lab=#net4}
N 190 360 190 430 {lab=#net4}
N 190 250 190 280 {lab=#net3}
N -210 360 190 280 {lab=#net3}
N -210 280 190 360 {lab=#net4}
N 190 230 320 230 {lab=#net3}
N 190 230 190 250 {lab=#net3}
N -260 -90 -180 -90 {lab=#net4}
N -260 -90 -260 250 {lab=#net4}
N -260 250 -210 250 {lab=#net4}
N -300 230 -190 230 {lab=clk}
N -300 80 -300 230 {lab=clk}
N -300 80 -190 80 {lab=clk}
N -290 410 -190 410 {lab=d}
N -460 290 -440 290 {lab=reset}
N 300 250 320 250 {lab=reset}
N -210 430 -190 430 {lab=reset}
N -210 100 -190 100 {lab=reset}
C {iopin.sym} -460 220 2 0 {name=p2 lab=GND}
C {ipin.sym} -460 250 0 0 {name=p3 lab=clk}
C {iopin.sym} -460 200 2 0 {name=p5 lab=VP}
C {ipin.sym} -460 270 0 0 {name=p6 lab=d}
C {lab_pin.sym} -440 270 2 0 {name=p8 sig_type=std_logic lab=d}
C {lab_pin.sym} -440 250 2 0 {name=p9 sig_type=std_logic lab=clk}
C {lab_pin.sym} -440 220 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -440 200 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} 130 230 2 0 {name=p1 sig_type=std_logic lab=GND}
C {lab_pin.sym} 130 210 2 0 {name=p12 sig_type=std_logic lab=VP}
C {lab_pin.sym} 130 80 2 0 {name=p13 sig_type=std_logic lab=GND}
C {lab_pin.sym} 130 60 2 0 {name=p14 sig_type=std_logic lab=VP}
C {lab_pin.sym} 140 -70 2 0 {name=p15 sig_type=std_logic lab=GND}
C {lab_pin.sym} 140 -90 2 0 {name=p16 sig_type=std_logic lab=VP}
C {lab_pin.sym} 130 410 2 0 {name=p17 sig_type=std_logic lab=GND}
C {lab_pin.sym} 130 390 2 0 {name=p18 sig_type=std_logic lab=VP}
C {lab_pin.sym} 640 230 2 0 {name=p19 sig_type=std_logic lab=GND}
C {lab_pin.sym} 640 210 2 0 {name=p20 sig_type=std_logic lab=VP}
C {lab_pin.sym} 650 80 2 0 {name=p21 sig_type=std_logic lab=GND}
C {lab_pin.sym} 650 60 2 0 {name=p22 sig_type=std_logic lab=VP}
C {lab_pin.sym} -290 410 0 0 {name=p4 sig_type=std_logic lab=d}
C {lab_pin.sym} -300 230 0 0 {name=p7 sig_type=std_logic lab=clk}
C {opin.sym} 720 100 0 0 {name=p23 lab=q}
C {opin.sym} 720 250 0 0 {name=p24 lab=q_}
C {ipin.sym} -460 290 0 0 {name=p25 lab=reset}
C {lab_pin.sym} -440 290 2 0 {name=p26 sig_type=std_logic lab=reset}
C {lab_pin.sym} 300 250 0 0 {name=p27 sig_type=std_logic lab=reset}
C {lab_pin.sym} -210 430 0 0 {name=p28 sig_type=std_logic lab=reset}
C {lab_pin.sym} -210 100 0 0 {name=p29 sig_type=std_logic lab=reset}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in_x3.sym} 470 230 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in_x3.sym} -40 410 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in_x3.sym} -40 80 0 0 {name=x6}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} 480 80 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} -30 -70 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in_x3.sym} -40 230 0 0 {name=x1}
