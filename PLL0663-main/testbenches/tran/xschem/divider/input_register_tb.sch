v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 410 -130 420 {lab=VP}
N -130 320 -130 330 {lab=0}
N -60 400 -60 420 {lab=d}
N -60 480 -60 490 {lab=0}
N 640 240 640 310 {lab=d0}
N 700 240 700 310 {lab=d1}
N 820 240 820 310 {lab=d3}
N 760 240 760 310 {lab=d2}
N 640 560 640 580 {lab=0}
N 640 430 640 500 {lab=d4}
N 700 560 700 580 {lab=0}
N 760 560 760 580 {lab=0}
N 700 430 700 500 {lab=d5}
N 820 560 820 580 {lab=0}
N 820 430 820 500 {lab=d7}
N 760 430 760 500 {lab=d6}
N 640 370 640 390 {lab=0}
N 700 370 700 390 {lab=0}
N 760 370 760 390 {lab=0}
N 820 370 820 390 {lab=0}
N -130 480 -130 490 {lab=0}
N -130 770 -130 790 {lab=data_en}
N -130 850 -130 860 {lab=0}
N -130 240 -130 260 {lab=clk_in}
N 640 750 640 770 {lab=0}
N 640 620 640 690 {lab=d8}
N 150 240 170 240 {lab=d}
N 150 220 170 220 {lab=data_en}
N 150 200 170 200 {lab=clk_in}
N 470 200 510 200 {lab=VP}
N 470 220 510 220 {lab=0}
N 470 400 480 400 {lab=d8}
N 470 380 480 380 {lab=d7}
N 470 360 480 360 {lab=d6}
N 470 340 480 340 {lab=d5}
N 470 320 480 320 {lab=d4}
N 470 300 480 300 {lab=d3}
N 470 280 480 280 {lab=d2}
N 470 260 480 260 {lab=d1}
N 470 240 480 240 {lab=d0}
N 470 460 480 460 {lab=d11}
N 470 440 480 440 {lab=d10}
N 470 420 480 420 {lab=d9}
N 700 750 700 770 {lab=0}
N 700 620 700 690 {lab=d9}
N 760 750 760 770 {lab=0}
N 760 620 760 690 {lab=d10}
N 820 750 820 770 {lab=0}
N 820 620 820 690 {lab=d11}
C {devices/code_shown.sym} 140 910 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 150 630 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=27
.control

op
print all
save all

tran 50p 300n
write input_register_tb.raw
set appendwrite




.endc
"}
C {vsource.sym} -130 450 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -130 290 0 0 {name=V2 value="PULSE(1.2 0 0 10p 10p 5n 10n)" savecurrent=false}
C {capa.sym} 640 340 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} -130 410 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 640 240 2 0 {name=p4 sig_type=std_logic lab=d0
}
C {vsource.sym} -60 450 0 0 {name=V3 value="PWL(
+ 0 0 
+ 142.5n 0 
+ 142.51n 1.2
+ 162.5n 1.2 
+ 162.51n 0
+ 172.5n 0
+ 172.51n 1.2
+ 182.5n 1.2
+ 182.51n 0
+ 212.5n 0
+ 212.51n 1.2
+ 222.5n 1.2
+ 222.51n 0
+ 232.5n 0)" savecurrent=false}
C {lab_wire.sym} -60 400 0 0 {name=p6 sig_type=std_logic lab=d
}
C {capa.sym} 700 340 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 700 240 2 0 {name=p14 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 760 240 2 0 {name=p20 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 820 240 2 0 {name=p26 sig_type=std_logic lab=d3
}
C {capa.sym} 640 530 0 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 640 430 2 0 {name=p33 sig_type=std_logic lab=d4

}
C {capa.sym} 700 530 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 700 430 2 0 {name=p37 sig_type=std_logic lab=d5
}
C {capa.sym} 760 530 0 0 {name=C7
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 760 430 2 0 {name=p42 sig_type=std_logic lab=d6
}
C {capa.sym} 820 530 0 0 {name=C8
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 820 430 2 0 {name=p47 sig_type=std_logic lab=d7
}
C {gnd.sym} 640 580 0 0 {name=l2 lab=0
}
C {gnd.sym} 700 580 0 0 {name=l3 lab=0
}
C {gnd.sym} 760 580 0 0 {name=l4 lab=0
}
C {gnd.sym} 820 580 0 0 {name=l5 lab=0
}
C {capa.sym} 760 340 0 0 {name=C9
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 820 340 0 0 {name=C10
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 640 390 0 0 {name=l6 lab=0
}
C {gnd.sym} 700 390 0 0 {name=l7 lab=0
}
C {gnd.sym} 760 390 0 0 {name=l8 lab=0
}
C {gnd.sym} 820 390 0 0 {name=l9 lab=0
}
C {gnd.sym} -130 330 0 0 {name=l17 lab=0
}
C {gnd.sym} -60 490 0 0 {name=l18 lab=0
}
C {gnd.sym} -130 490 0 0 {name=l19 lab=0
}
C {vsource.sym} -130 820 0 0 {name=V4 value="PWL(
+ 0 1.2 
+ 232.5n 1.2
+ 232.51n 0)" savecurrent=false}
C {lab_wire.sym} -130 770 0 0 {name=p5 sig_type=std_logic lab=data_en
}
C {gnd.sym} -130 860 0 0 {name=l21 lab=0
}
C {lab_wire.sym} 150 200 0 0 {name=p9 sig_type=std_logic lab=clk_in
}
C {lab_wire.sym} 150 220 0 0 {name=p11 sig_type=std_logic lab=data_en
}
C {lab_wire.sym} -130 240 0 0 {name=p13 sig_type=std_logic lab=clk_in
}
C {capa.sym} 640 720 0 0 {name=C3
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 640 620 2 0 {name=p22 sig_type=std_logic lab=d8

}
C {gnd.sym} 640 770 0 0 {name=l23 lab=0
}
C {lab_wire.sym} 150 240 0 0 {name=p54 sig_type=std_logic lab=d
}
C {lab_wire.sym} 510 200 2 0 {name=p2 sig_type=std_logic lab=VP
}
C {gnd.sym} 510 220 0 0 {name=l20 lab=0
}
C {lab_wire.sym} 480 240 2 0 {name=p1 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 480 260 2 0 {name=p3 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 480 280 2 0 {name=p7 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 480 300 2 0 {name=p10 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 480 320 2 0 {name=p12 sig_type=std_logic lab=d4

}
C {lab_wire.sym} 480 340 2 0 {name=p15 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 480 360 2 0 {name=p16 sig_type=std_logic lab=d6
}
C {lab_wire.sym} 480 380 2 0 {name=p17 sig_type=std_logic lab=d7
}
C {lab_wire.sym} 480 400 2 0 {name=p18 sig_type=std_logic lab=d8

}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/input_register.sym} 320 330 0 0 {name=x1}
C {lab_wire.sym} 480 420 2 0 {name=p19 sig_type=std_logic lab=d9
}
C {lab_wire.sym} 480 440 2 0 {name=p21 sig_type=std_logic lab=d10
}
C {lab_wire.sym} 480 460 2 0 {name=p23 sig_type=std_logic lab=d11

}
C {capa.sym} 700 720 0 0 {name=C4
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 700 770 0 0 {name=l1 lab=0
}
C {capa.sym} 760 720 0 0 {name=C11
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 760 770 0 0 {name=l10 lab=0
}
C {capa.sym} 820 720 0 0 {name=C12
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 820 770 0 0 {name=l11 lab=0
}
C {lab_wire.sym} 700 620 2 0 {name=p24 sig_type=std_logic lab=d9
}
C {lab_wire.sym} 760 620 2 0 {name=p25 sig_type=std_logic lab=d10
}
C {lab_wire.sym} 820 620 2 0 {name=p27 sig_type=std_logic lab=d11

}
