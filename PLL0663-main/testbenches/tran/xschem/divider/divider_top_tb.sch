v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 0 -110 20 {lab=clk}
N 50 300 50 310 {lab=VP}
N -110 80 -110 100 {lab=0}
N 50 370 50 390 {lab=0}
N -390 430 -390 450 {lab=0}
N -270 430 -270 450 {lab=0}
N -150 430 -150 450 {lab=0}
N -390 340 -390 370 {lab=d0}
N -270 340 -270 370 {lab=d1}
N -150 340 -150 370 {lab=d2}
N -390 610 -390 630 {lab=0}
N -270 610 -270 630 {lab=0}
N -150 610 -150 630 {lab=0}
N -390 520 -390 550 {lab=d3}
N -270 520 -270 550 {lab=d4}
N -150 520 -150 550 {lab=d5}
N -80 450 -80 470 {lab=a1}
N -80 530 -80 550 {lab=0}
N -80 300 -80 320 {lab=a0}
N -80 380 -80 400 {lab=0}
N -80 600 -80 620 {lab=a2}
N -80 680 -80 700 {lab=0}
N 350 350 350 400 {lab=VP}
N 330 380 330 400 {lab=0}
N 170 640 170 660 {lab=0}
N 170 460 170 580 {lab=out_div}
N 170 460 220 460 {lab=out_div}
N 490 460 510 460 {lab=clk}
N 350 550 350 580 {lab=d0}
N 370 550 370 580 {lab=d1}
N 390 550 390 580 {lab=d2}
N 410 550 410 580 {lab=d3}
N 430 550 430 580 {lab=d4}
N 450 550 450 580 {lab=d5}
N 260 550 260 580 {lab=a0}
N 280 550 280 580 {lab=a1}
N 300 550 300 580 {lab=a2}
N -520 320 -520 340 {lab=reset}
N -520 400 -520 420 {lab=0}
N 220 420 220 440 {lab=reset}
C {vsource.sym} 50 340 0 0 {name=V1 value=\{vdd\} savecurrent=false}
C {vsource.sym} -110 50 0 0 {name=V2 value="PULSE(0 \{vdd\} 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {lab_wire.sym} -110 0 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 50 300 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -110 100 0 0 {name=l3 lab=0
}
C {gnd.sym} -390 450 0 0 {name=l5 lab=0
}
C {gnd.sym} -270 450 0 0 {name=l6 lab=0
}
C {gnd.sym} -150 450 0 0 {name=l7 lab=0
}
C {lab_wire.sym} -390 520 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -390 340 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} -150 340 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {gnd.sym} 50 390 0 0 {name=l13 lab=0
}
C {gnd.sym} -390 630 0 0 {name=l8 lab=0
}
C {gnd.sym} -270 630 0 0 {name=l10 lab=0
}
C {gnd.sym} -150 630 0 0 {name=l34 lab=0
}
C {lab_wire.sym} -150 520 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -270 340 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -270 520 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} -270 580 0 0 {name=V8 value=0 savecurrent=false}
C {vsource.sym} -150 580 0 0 {name=V9 value=0 savecurrent=false}
C {vsource.sym} -390 400 0 0 {name=V11 value=0 savecurrent=false}
C {vsource.sym} -270 400 0 0 {name=V10 value=\{vdd\}  savecurrent=false}
C {vsource.sym} -150 400 0 0 {name=V12 value=0 savecurrent=false}
C {vsource.sym} -390 580 0 0 {name=V7 value=0 savecurrent=false}
C {vsource.sym} -80 500 0 0 {name=V5 value=0 savecurrent=false}
C {lab_wire.sym} -80 450 0 0 {name=p24 sig_type=std_logic lab=a1
}
C {gnd.sym} -80 550 0 0 {name=l15 lab=0
}
C {vsource.sym} -80 350 0 0 {name=V6 value=\{vdd\} savecurrent=false}
C {lab_wire.sym} -80 300 0 0 {name=p25 sig_type=std_logic lab=a0
}
C {gnd.sym} -80 400 0 0 {name=l16 lab=0
}
C {vsource.sym} -80 650 0 0 {name=V13 value=0 savecurrent=false}
C {lab_wire.sym} -80 600 0 0 {name=p27 sig_type=std_logic lab=a2
}
C {gnd.sym} -80 700 0 0 {name=l17 lab=0
}
C {lab_wire.sym} 350 350 3 0 {name=p1 sig_type=std_logic lab=VP
}
C {gnd.sym} 330 380 2 1 {name=l2 lab=0
}
C {gnd.sym} 170 660 0 0 {name=l18 lab=0
}
C {lab_wire.sym} 220 460 0 0 {name=p3 sig_type=std_logic lab=out_div
}
C {lab_wire.sym} 510 460 1 0 {name=p4 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 350 580 0 0 {name=p5 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 370 580 0 0 {name=p6 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 390 580 0 0 {name=p7 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 410 580 0 0 {name=p9 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 430 580 0 0 {name=p10 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 450 580 0 0 {name=p11 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 260 580 3 0 {name=p12 sig_type=std_logic lab=a0
}
C {lab_wire.sym} 280 580 3 0 {name=p13 sig_type=std_logic lab=a1
}
C {lab_wire.sym} 300 580 3 0 {name=p14 sig_type=std_logic lab=a2
=======
C \{gnd.sym}
C {devices/code_shown.sym} -520 -190 0 0 {name=NGSPICE only_toplevel=false
value="
.options savecurrents
.param temp=27
.param vdd=1.2
.control
set num_threads=12
set maxdata = 1000
op
print all
save v(out_div)


tran 25p 400n

write divider_top_tb.raw 
set appendwrite

.endc
"}
C {devices/code_shown.sym} -530 210 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/Divider_top.sym} 340 460 0 0 {name=x1}
C {lab_wire.sym} -520 320 0 0 {name=p15 sig_type=std_logic lab=reset
}
C {gnd.sym} -520 420 0 0 {name=l1 lab=0
}
C {vsource.sym} -520 370 0 0 {name=V4 value="PWL(
+ 0 \{vdd\} 
+ 200n \{vdd\} 
+ 200.1n 0)" savecurrent=false}
C {lab_wire.sym} 220 420 0 0 {name=p16 sig_type=std_logic lab=reset
=======
C \{/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/Divider_top.sym}
C {capa.sym} 170 610 0 0 {name=C1
m=1
value=50f
footprint=1206
device="ceramic capacitor"}
