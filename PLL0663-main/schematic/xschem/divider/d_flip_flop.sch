v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -400 -320 -380 -320 {lab=VP}
N -400 -300 -380 -300 {lab=GND}
N -400 -270 -380 -270 {lab=clk}
N -400 -250 -380 -250 {lab=d}
N 170 -310 190 -310 {lab=VP}
N 170 -290 190 -290 {lab=GND}
N 170 -460 190 -460 {lab=VP}
N 170 -440 190 -440 {lab=GND}
N 180 -610 200 -610 {lab=VP}
N 180 -590 200 -590 {lab=GND}
N 170 -130 190 -130 {lab=VP}
N 170 -110 190 -110 {lab=GND}
N 680 -310 700 -310 {lab=VP}
N 680 -290 700 -290 {lab=GND}
N 690 -460 710 -460 {lab=VP}
N 690 -440 710 -440 {lab=GND}
N 170 -420 200 -420 {lab=#net1}
N 200 -420 200 -390 {lab=#net1}
N -150 -310 -130 -310 {lab=#net1}
N -150 -340 -150 -310 {lab=#net1}
N -150 -340 200 -390 {lab=#net1}
N 750 -420 780 -420 {lab=q}
N 750 -270 780 -270 {lab=q_}
N 750 -340 750 -270 {lab=q_}
N 680 -270 750 -270 {lab=q_}
N 750 -420 750 -400 {lab=q}
N 690 -420 750 -420 {lab=q}
N 360 -310 380 -310 {lab=q}
N 360 -340 360 -310 {lab=q}
N 360 -440 390 -440 {lab=q_}
N 360 -440 360 -400 {lab=q_}
N 360 -400 750 -340 {lab=q_}
N 360 -340 750 -400 {lab=q}
N 200 -420 280 -420 {lab=#net1}
N 280 -460 280 -420 {lab=#net1}
N 280 -460 390 -460 {lab=#net1}
N -160 -460 -130 -460 {lab=#net2}
N -160 -480 -160 -460 {lab=#net2}
N 180 -570 230 -570 {lab=#net2}
N 230 -570 230 -540 {lab=#net2}
N -160 -480 230 -540 {lab=#net2}
N 280 -500 280 -460 {lab=#net1}
N -160 -590 -120 -590 {lab=#net1}
N -160 -590 -160 -540 {lab=#net1}
N -160 -540 280 -500 {lab=#net1}
N 170 -270 250 -270 {lab=#net3}
N -150 -270 -130 -270 {lab=#net4}
N -150 -270 -150 -240 {lab=#net4}
N -150 -130 -130 -130 {lab=#net3}
N -150 -160 -150 -130 {lab=#net3}
N 170 -90 250 -90 {lab=#net4}
N 250 -160 250 -90 {lab=#net4}
N 250 -270 250 -240 {lab=#net3}
N -150 -160 250 -240 {lab=#net3}
N -150 -240 250 -160 {lab=#net4}
N 250 -290 380 -290 {lab=#net3}
N 250 -290 250 -270 {lab=#net3}
N -200 -610 -120 -610 {lab=#net4}
N -200 -610 -200 -270 {lab=#net4}
N -200 -270 -150 -270 {lab=#net4}
N -240 -290 -130 -290 {lab=clk}
N -240 -440 -240 -290 {lab=clk}
N -240 -440 -130 -440 {lab=clk}
N -230 -110 -130 -110 {lab=d}
C {iopin.sym} -400 -300 2 0 {name=p2 lab=GND}
C {ipin.sym} -400 -270 0 0 {name=p3 lab=clk}
C {iopin.sym} -400 -320 2 0 {name=p5 lab=VP}
C {ipin.sym} -400 -250 0 0 {name=p6 lab=d}
C {lab_pin.sym} -380 -250 2 0 {name=p8 sig_type=std_logic lab=d}
C {lab_pin.sym} -380 -270 2 0 {name=p9 sig_type=std_logic lab=clk}
C {lab_pin.sym} -380 -300 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -380 -320 2 0 {name=p11 sig_type=std_logic lab=VP}
C {lab_pin.sym} 190 -290 2 0 {name=p1 sig_type=std_logic lab=GND}
C {lab_pin.sym} 190 -310 2 0 {name=p12 sig_type=std_logic lab=VP}
C {lab_pin.sym} 190 -440 2 0 {name=p13 sig_type=std_logic lab=GND}
C {lab_pin.sym} 190 -460 2 0 {name=p14 sig_type=std_logic lab=VP}
C {lab_pin.sym} 200 -590 2 0 {name=p15 sig_type=std_logic lab=GND}
C {lab_pin.sym} 200 -610 2 0 {name=p16 sig_type=std_logic lab=VP}
C {lab_pin.sym} 190 -110 2 0 {name=p17 sig_type=std_logic lab=GND}
C {lab_pin.sym} 190 -130 2 0 {name=p18 sig_type=std_logic lab=VP}
C {lab_pin.sym} 700 -290 2 0 {name=p19 sig_type=std_logic lab=GND}
C {lab_pin.sym} 700 -310 2 0 {name=p20 sig_type=std_logic lab=VP}
C {lab_pin.sym} 710 -440 2 0 {name=p21 sig_type=std_logic lab=GND}
C {lab_pin.sym} 710 -460 2 0 {name=p22 sig_type=std_logic lab=VP}
C {lab_pin.sym} -230 -110 0 0 {name=p4 sig_type=std_logic lab=d}
C {lab_pin.sym} -240 -290 0 0 {name=p7 sig_type=std_logic lab=clk}
C {opin.sym} 780 -420 0 0 {name=p23 lab=q}
C {opin.sym} 780 -270 0 0 {name=p24 lab=q_}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in.sym} 20 -290 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} 30 -590 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} 20 -440 0 0 {name=x3}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} 540 -440 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} 530 -290 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in_x2.sym} 20 -110 0 0 {name=x6}
