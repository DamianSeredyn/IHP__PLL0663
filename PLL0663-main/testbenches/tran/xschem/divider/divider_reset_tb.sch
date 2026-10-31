v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -400 240 -400 260 {lab=clk}
N -160 80 -160 90 {lab=VP}
N -400 320 -400 340 {lab=0}
N 210 530 210 550 {lab=0}
N -400 420 -400 440 {lab=reset}
N -400 500 -400 520 {lab=0}
N -160 150 -160 170 {lab=0}
N -240 330 -240 340 {lab=reset}
N -240 330 -210 330 {lab=reset}
N -130 310 -110 310 {lab=clk}
N 270 530 270 550 {lab=0}
N 330 530 330 550 {lab=0}
N 390 530 390 550 {lab=0}
N 450 530 450 550 {lab=0}
N 510 530 510 550 {lab=0}
N 210 450 210 470 {lab=div64}
N 190 450 210 450 {lab=div64}
N 190 430 270 430 {lab=div32}
N 270 430 270 470 {lab=div32}
N 330 410 330 470 {lab=div16}
N 190 410 330 410 {lab=div16}
N 190 390 390 390 {lab=div8}
N 390 390 390 470 {lab=div8}
N 190 370 450 370 {lab=div4}
N 450 370 450 470 {lab=div4}
N 190 350 510 350 {lab=div2}
N 510 350 510 470 {lab=div2}
N 190 330 240 330 {lab=VP}
N 190 310 250 310 {lab=0}
N -190 260 -170 260 {lab=VP}
N -190 260 -190 300 {lab=VP}
N -140 330 -110 330 {lab=#net1}
N -190 360 -190 380 {lab=0}
C {devices/code_shown.sym} -290 -20 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 30 -80 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control
set maxdata = 1000
op
print all
save all

tran 50p 3u
write divider_reset_tb.raw 
set appendwrite

.endc
"}
C {vsource.sym} -160 120 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -400 290 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 3.335n 6.67n)" savecurrent=false}
C {gnd.sym} -160 170 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -400 240 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -160 80 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {capa.sym} 210 500 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {vsource.sym} -400 470 0 0 {name=V5 value="PWL(
+ 0 0 
+ 1u 0
+ 1.001u 1.2
+ 1.02u 1.2
+ 1.021u 0)" savecurrent=false}
C {gnd.sym} -400 340 0 0 {name=l3 lab=0
}
C {gnd.sym} -400 520 0 0 {name=l4 lab=0
}
C {gnd.sym} 210 550 0 0 {name=l11 lab=0
}
C {lab_wire.sym} -240 340 3 0 {name=p1 sig_type=std_logic lab=reset
}
C {lab_wire.sym} -400 420 0 0 {name=p4 sig_type=std_logic lab=reset
}
C {lab_wire.sym} -130 310 0 0 {name=p3 sig_type=std_logic lab=clk
}
C {capa.sym} 270 500 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 270 550 0 0 {name=l2 lab=0
}
C {capa.sym} 330 500 0 0 {name=C3
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 330 550 0 0 {name=l5 lab=0
}
C {capa.sym} 390 500 0 0 {name=C4
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 390 550 0 0 {name=l6 lab=0
}
C {capa.sym} 450 500 0 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 450 550 0 0 {name=l7 lab=0
}
C {capa.sym} 510 500 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 510 550 0 0 {name=l8 lab=0
}
C {lab_wire.sym} 240 330 2 0 {name=p5 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 510 350 2 0 {name=p6 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 450 370 2 0 {name=p7 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 390 390 2 0 {name=p9 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 330 410 2 0 {name=p10 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 270 430 2 0 {name=p11 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 210 450 2 0 {name=p12 sig_type=std_logic lab=div64
}
C {gnd.sym} 250 310 3 0 {name=l10 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/div_with_reset.sym} 40 380 0 0 {name=x1}
C {lab_wire.sym} -170 260 2 0 {name=p33 sig_type=std_logic lab=VP
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} -190 330 0 0 {name=x8}
C {gnd.sym} -190 380 0 0 {name=l9 lab=0
}
