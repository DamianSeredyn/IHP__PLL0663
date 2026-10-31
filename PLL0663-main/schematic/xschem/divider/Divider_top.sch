v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 270 360 350 360 {lab=MUX_out}
N 270 320 290 320 {lab=gd}
N -50 320 -30 320 {lab=a0}
N -50 340 -30 340 {lab=a1}
N -50 360 -30 360 {lab=a2}
N 270 340 290 340 {lab=VP}
N -50 380 -30 380 {lab=clk}
N -130 400 -30 400 {lab=div2}
N -130 420 -30 420 {lab=div4}
N -130 440 -30 440 {lab=div8}
N -130 460 -30 460 {lab=div16}
N -130 480 -30 480 {lab=div32}
N -130 500 -30 500 {lab=div64}
N -130 520 -30 520 {lab=div128}
N -130 360 -110 360 {lab=gd}
N -130 380 -110 380 {lab=VP}
N 180 -80 200 -80 {lab=gd}
N 180 -60 200 -60 {lab=VP}
N 180 -40 200 -40 {lab=clk}
N 170 170 190 170 {lab=out_div}
N 650 380 680 380 {lab=VP}
N 650 400 720 400 {lab=out_div}
N 320 400 350 400 {lab=d0}
N 320 420 350 420 {lab=d1}
N 320 440 350 440 {lab=d2}
N 320 460 350 460 {lab=d3}
N 320 480 350 480 {lab=d4}
N 320 500 350 500 {lab=d5}
N 650 360 670 360 {lab=gd}
N 180 -20 200 -20 {lab=d0}
N 180 0 200 0 {lab=d1}
N 180 20 200 20 {lab=d2}
N 180 40 200 40 {lab=d3}
N 180 60 200 60 {lab=d4}
N 180 80 200 80 {lab=d5}
N 180 100 200 100 {lab=a0}
N 180 120 200 120 {lab=a1}
N 180 140 200 140 {lab=a2}
N -450 360 -420 360 {lab=clk}
N 320 380 350 380 {lab=rst}
N 180 200 200 200 {lab=rst}
C {lab_wire.sym} 290 340 0 0 {name=p23 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 340 360 0 0 {name=p46 sig_type=std_logic lab=MUX_out
}
C {lab_wire.sym} -50 320 0 0 {name=p52 sig_type=std_logic lab=a0
}
C {lab_wire.sym} -50 340 0 0 {name=p53 sig_type=std_logic lab=a1
}
C {lab_wire.sym} -50 360 0 0 {name=p54 sig_type=std_logic lab=a2
}
C {lab_wire.sym} -450 360 2 1 {name=p55 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -50 380 2 1 {name=p56 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -110 380 2 0 {name=p57 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -70 520 2 1 {name=p58 sig_type=std_logic lab=div128
}
C {lab_wire.sym} -70 500 2 1 {name=p59 sig_type=std_logic lab=div64
}
C {lab_wire.sym} -70 480 2 1 {name=p60 sig_type=std_logic lab=div32
}
C {lab_wire.sym} -70 460 2 1 {name=p61 sig_type=std_logic lab=div16
}
C {lab_wire.sym} -70 440 2 1 {name=p62 sig_type=std_logic lab=div8
}
C {lab_wire.sym} -70 420 2 1 {name=p63 sig_type=std_logic lab=div4
}
C {lab_wire.sym} -70 400 2 1 {name=p64 sig_type=std_logic lab=div2
}
C {iopin.sym} 180 -80 2 0 {name=p3 lab=gd}
C {ipin.sym} 180 -40 0 0 {name=p65 lab=clk}
C {lab_pin.sym} 200 -80 2 0 {name=p66 sig_type=std_logic lab=gd}
C {iopin.sym} 180 -60 2 0 {name=p67 lab=VP}
C {lab_pin.sym} 200 -60 2 0 {name=p68 sig_type=std_logic lab=VP}
C {opin.sym} 170 170 2 0 {name=p69 lab=out_div}
C {lab_pin.sym} 200 -40 2 0 {name=p75 sig_type=std_logic lab=clk}
C {lab_pin.sym} 190 170 2 0 {name=p76 sig_type=std_logic lab=out_div}
C {lab_wire.sym} 720 400 0 0 {name=p71 sig_type=std_logic lab=out_div
}
C {lab_wire.sym} 320 460 0 0 {name=p72 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 320 420 0 0 {name=p73 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 320 440 0 0 {name=p74 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 320 400 0 0 {name=p77 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 320 500 0 0 {name=p78 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 320 480 0 0 {name=p79 sig_type=std_logic lab=d4
}
C {lab_pin.sym} 290 320 2 0 {name=p1 sig_type=std_logic lab=gd}
C {lab_pin.sym} 670 360 2 0 {name=p4 sig_type=std_logic lab=gd}
C {lab_wire.sym} 680 380 0 0 {name=p5 sig_type=std_logic lab=VP
}
C {lab_pin.sym} -110 360 2 0 {name=p6 sig_type=std_logic lab=gd}
C {ipin.sym} 180 -20 0 0 {name=p2 lab=d0}
C {lab_pin.sym} 200 -20 2 0 {name=p7 sig_type=std_logic lab=d0}
C {ipin.sym} 180 0 0 0 {name=p8 lab=d1}
C {lab_pin.sym} 200 0 2 0 {name=p9 sig_type=std_logic lab=d1}
C {ipin.sym} 180 20 0 0 {name=p10 lab=d2}
C {lab_pin.sym} 200 20 2 0 {name=p11 sig_type=std_logic lab=d2}
C {ipin.sym} 180 40 0 0 {name=p12 lab=d3}
C {lab_pin.sym} 200 40 2 0 {name=p13 sig_type=std_logic lab=d3}
C {ipin.sym} 180 60 0 0 {name=p14 lab=d4}
C {lab_pin.sym} 200 60 2 0 {name=p15 sig_type=std_logic lab=d4}
C {ipin.sym} 180 80 0 0 {name=p16 lab=d5}
C {lab_pin.sym} 200 80 2 0 {name=p17 sig_type=std_logic lab=d5}
C {ipin.sym} 180 100 0 0 {name=p18 lab=a0}
C {lab_pin.sym} 200 100 2 0 {name=p19 sig_type=std_logic lab=a0}
C {ipin.sym} 180 120 0 0 {name=p26 lab=a1}
C {lab_pin.sym} 200 120 2 0 {name=p28 sig_type=std_logic lab=a1}
C {ipin.sym} 180 140 0 0 {name=p29 lab=a2}
C {lab_pin.sym} 200 140 2 0 {name=p30 sig_type=std_logic lab=a2}
C {ipin.sym} 180 200 0 0 {name=p20 lab=rst}
C {lab_pin.sym} 200 200 2 0 {name=p21 sig_type=std_logic lab=rst}
C {lab_pin.sym} 320 380 2 1 {name=p22 sig_type=std_logic lab=rst}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/2Div.sym} -270 440 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/MUX_8to1.sym} 120 420 0 0 {name=x2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/pdiv.sym} 500 430 0 0 {name=x3}
