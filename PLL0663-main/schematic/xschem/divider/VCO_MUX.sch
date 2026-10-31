v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 240 -50 240 -30 {lab=VP}
N 200 30 200 50 {lab=VCO_sel}
N 240 30 240 50 {lab=gd}
N 260 0 280 0 {lab=out}
N -120 -60 -100 -60 {lab=gd}
N -120 -40 -100 -40 {lab=VP}
N -120 10 -100 10 {lab=VCO2_in}
N -120 30 -100 30 {lab=VCO3_in}
N -120 50 -100 50 {lab=VCO4_in}
N -120 70 -100 70 {lab=VCO5_in}
N -120 210 -100 210 {lab=out}
N -120 -10 -100 -10 {lab=VCO_in}
N -120 120 -100 120 {lab=VCO2_sel}
N -120 140 -100 140 {lab=VCO3_sel}
N -120 100 -100 100 {lab=VCO_sel}
N -120 160 -100 160 {lab=VCO4_sel}
N -120 180 -100 180 {lab=VCO5_sel}
N 190 -80 200 -80 {lab=#net1}
N 200 -80 200 -30 {lab=#net1}
N 100 -80 100 50 {lab=VCO_sel}
N 170 0 180 0 {lab=VCO_in}
N 100 -80 120 -80 {lab=VCO_sel}
N 100 50 200 50 {lab=VCO_sel}
N 140 -130 140 -110 {lab=VP}
N 140 -50 140 -40 {lab=gd}
N 240 140 240 160 {lab=VP}
N 200 220 200 240 {lab=VCO2_sel}
N 240 220 240 240 {lab=gd}
N 260 190 280 190 {lab=out}
N 190 110 200 110 {lab=#net2}
N 200 110 200 160 {lab=#net2}
N 100 110 100 240 {lab=VCO2_sel}
N 170 190 180 190 {lab=VCO2_in}
N 100 110 120 110 {lab=VCO2_sel}
N 100 240 200 240 {lab=VCO2_sel}
N 140 60 140 80 {lab=VP}
N 140 140 140 150 {lab=gd}
N 460 -50 460 -30 {lab=VP}
N 420 30 420 50 {lab=VCO3_sel}
N 460 30 460 50 {lab=gd}
N 480 0 500 0 {lab=out}
N 410 -80 420 -80 {lab=#net3}
N 420 -80 420 -30 {lab=#net3}
N 320 -80 320 50 {lab=VCO3_sel}
N 390 0 400 0 {lab=VCO3_in}
N 320 -80 340 -80 {lab=VCO3_sel}
N 320 50 420 50 {lab=VCO3_sel}
N 360 -130 360 -110 {lab=VP}
N 360 -50 360 -40 {lab=gd}
N 460 140 460 160 {lab=VP}
N 420 220 420 240 {lab=VCO4_sel}
N 460 220 460 240 {lab=gd}
N 480 190 500 190 {lab=out}
N 410 110 420 110 {lab=#net4}
N 420 110 420 160 {lab=#net4}
N 320 110 320 240 {lab=VCO4_sel}
N 390 190 400 190 {lab=VCO4_in}
N 320 110 340 110 {lab=VCO4_sel}
N 320 240 420 240 {lab=VCO4_sel}
N 360 60 360 80 {lab=VP}
N 360 140 360 150 {lab=gd}
N 680 -50 680 -30 {lab=VP}
N 640 30 640 50 {lab=VCO5_sel}
N 680 30 680 50 {lab=gd}
N 700 0 720 0 {lab=out}
N 630 -80 640 -80 {lab=#net5}
N 640 -80 640 -30 {lab=#net5}
N 540 -80 540 50 {lab=VCO5_sel}
N 610 0 620 0 {lab=VCO5_in}
N 540 -80 560 -80 {lab=VCO5_sel}
N 540 50 640 50 {lab=VCO5_sel}
N 580 -130 580 -110 {lab=VP}
N 580 -50 580 -40 {lab=gd}
C {iopin.sym} -120 -60 2 0 {name=p46 lab=gd}
C {lab_wire.sym} -100 -60 2 0 {name=p53 sig_type=std_logic lab=gd}
C {iopin.sym} -120 -40 2 0 {name=p54 lab=VP}
C {ipin.sym} -120 10 0 0 {name=p2 lab=VCO2_in}
C {lab_wire.sym} -100 10 2 0 {name=p56 sig_type=std_logic lab=VCO2_in}
C {ipin.sym} -120 30 0 0 {name=p57 lab=VCO3_in}
C {lab_wire.sym} -100 30 2 0 {name=p58 sig_type=std_logic lab=VCO3_in}
C {ipin.sym} -120 50 0 0 {name=p59 lab=VCO4_in}
C {lab_wire.sym} -100 50 2 0 {name=p60 sig_type=std_logic lab=VCO4_in}
C {ipin.sym} -120 70 0 0 {name=p61 lab=VCO5_in}
C {lab_wire.sym} -100 70 2 0 {name=p63 sig_type=std_logic lab=VCO5_in}
C {opin.sym} -120 210 0 1 {name=p68 lab=out}
C {lab_pin.sym} -100 210 2 0 {name=p69 sig_type=std_logic lab=out}
C {ipin.sym} -120 -10 0 0 {name=p20 lab=VCO_in}
C {lab_wire.sym} -100 -10 2 0 {name=p21 sig_type=std_logic lab=VCO_in}
C {lab_wire.sym} -100 -40 2 0 {name=p1 sig_type=std_logic lab=VP}
C {lab_wire.sym} 240 50 2 0 {name=p3 sig_type=std_logic lab=gd}
C {lab_wire.sym} 240 -50 2 0 {name=p4 sig_type=std_logic lab=VP}
C {lab_wire.sym} 280 0 2 0 {name=p5 sig_type=std_logic lab=out}
C {ipin.sym} -120 120 0 0 {name=p6 lab=VCO2_sel}
C {lab_wire.sym} -100 120 2 0 {name=p7 sig_type=std_logic lab=VCO2_sel}
C {ipin.sym} -120 140 0 0 {name=p8 lab=VCO3_sel}
C {lab_wire.sym} -100 140 2 0 {name=p9 sig_type=std_logic lab=VCO3_sel}
C {ipin.sym} -120 100 0 0 {name=p14 lab=VCO_sel}
C {lab_wire.sym} -100 100 2 0 {name=p15 sig_type=std_logic lab=VCO_sel}
C {ipin.sym} -120 160 0 0 {name=p10 lab=VCO4_sel}
C {lab_wire.sym} -100 160 2 0 {name=p11 sig_type=std_logic lab=VCO4_sel}
C {ipin.sym} -120 180 0 0 {name=p12 lab=VCO5_sel}
C {lab_wire.sym} -100 180 2 0 {name=p13 sig_type=std_logic lab=VCO5_sel}
C {lab_wire.sym} 170 0 0 0 {name=p16 sig_type=std_logic lab=VCO_in}
C {lab_wire.sym} 140 -130 2 0 {name=p17 sig_type=std_logic lab=VP}
C {lab_wire.sym} 140 -40 2 0 {name=p18 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_dek.sym} 140 -80 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate_scaled.sym} 200 210 0 0 {name=x3}
C {lab_wire.sym} 240 240 2 0 {name=p19 sig_type=std_logic lab=gd}
C {lab_wire.sym} 240 140 2 0 {name=p22 sig_type=std_logic lab=VP}
C {lab_wire.sym} 280 190 2 0 {name=p23 sig_type=std_logic lab=out}
C {lab_wire.sym} 140 60 2 0 {name=p25 sig_type=std_logic lab=VP}
C {lab_wire.sym} 140 150 2 0 {name=p26 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_dek.sym} 140 110 0 0 {name=x4}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate_scaled.sym} 420 20 0 0 {name=x5}
C {lab_wire.sym} 460 50 2 0 {name=p24 sig_type=std_logic lab=gd}
C {lab_wire.sym} 460 -50 2 0 {name=p27 sig_type=std_logic lab=VP}
C {lab_wire.sym} 500 0 2 0 {name=p28 sig_type=std_logic lab=out}
C {lab_wire.sym} 360 -130 2 0 {name=p29 sig_type=std_logic lab=VP}
C {lab_wire.sym} 360 -40 2 0 {name=p30 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_dek.sym} 360 -80 0 0 {name=x6}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate_scaled.sym} 420 210 0 0 {name=x7}
C {lab_wire.sym} 460 240 2 0 {name=p31 sig_type=std_logic lab=gd}
C {lab_wire.sym} 460 140 2 0 {name=p32 sig_type=std_logic lab=VP}
C {lab_wire.sym} 500 190 2 0 {name=p33 sig_type=std_logic lab=out}
C {lab_wire.sym} 360 60 2 0 {name=p34 sig_type=std_logic lab=VP}
C {lab_wire.sym} 360 150 2 0 {name=p35 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_dek.sym} 360 110 0 0 {name=x8}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate_scaled.sym} 640 20 0 0 {name=x9}
C {lab_wire.sym} 680 50 2 0 {name=p36 sig_type=std_logic lab=gd}
C {lab_wire.sym} 680 -50 2 0 {name=p37 sig_type=std_logic lab=VP}
C {lab_wire.sym} 720 0 2 0 {name=p38 sig_type=std_logic lab=out}
C {lab_wire.sym} 580 -130 2 0 {name=p39 sig_type=std_logic lab=VP}
C {lab_wire.sym} 580 -40 2 0 {name=p40 sig_type=std_logic lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_dek.sym} 580 -80 0 0 {name=x10}
C {lab_wire.sym} 170 190 0 0 {name=p41 sig_type=std_logic lab=VCO2_in}
C {lab_wire.sym} 390 0 0 0 {name=p42 sig_type=std_logic lab=VCO3_in}
C {lab_wire.sym} 390 190 0 0 {name=p43 sig_type=std_logic lab=VCO4_in}
C {lab_wire.sym} 610 0 0 0 {name=p44 sig_type=std_logic lab=VCO5_in}
C {lab_wire.sym} 100 -80 0 0 {name=p45 sig_type=std_logic lab=VCO_sel}
C {lab_wire.sym} 100 110 0 0 {name=p47 sig_type=std_logic lab=VCO2_sel}
C {lab_wire.sym} 320 -80 0 0 {name=p49 sig_type=std_logic lab=VCO3_sel}
C {lab_wire.sym} 320 110 0 0 {name=p48 sig_type=std_logic lab=VCO4_sel}
C {lab_wire.sym} 540 -80 0 0 {name=p50 sig_type=std_logic lab=VCO5_sel}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/vco_passgate_mux.sym} 200 20 0 0 {name=x1}
