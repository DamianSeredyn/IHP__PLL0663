v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -200 250 -200 270 {lab=clk}
N 40 90 40 100 {lab=VP}
N -200 330 -200 350 {lab=0}
N 40 160 40 180 {lab=0}
N -140 520 -140 540 {lab=0}
N -20 520 -20 540 {lab=0}
N 100 520 100 540 {lab=0}
N -140 430 -140 460 {lab=d0}
N -20 430 -20 460 {lab=d1}
N 100 430 100 460 {lab=d2}
N -140 700 -140 720 {lab=0}
N -20 700 -20 720 {lab=0}
N 100 700 100 720 {lab=0}
N -140 610 -140 640 {lab=d3}
N -20 610 -20 640 {lab=d4}
N 100 610 100 640 {lab=d5}
N 550 270 580 270 {lab=VP}
N 550 250 620 250 {lab=0}
N 550 290 620 290 {lab=out_div}
N 220 290 250 290 {lab=d0}
N 220 310 250 310 {lab=d1}
N 220 330 250 330 {lab=d2}
N 220 350 250 350 {lab=d3}
N 220 370 250 370 {lab=d4}
N 220 390 250 390 {lab=d5}
N 230 270 250 270 {lab=reset}
N 230 250 250 250 {lab=clk}
N -340 250 -340 270 {lab=reset}
N -340 330 -340 350 {lab=0}
C {devices/code_shown.sym} -90 -10 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ff
"}
C {devices/code_shown.sym} 230 -70 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control
set maxdata = 1000
op
print all
save v(out_div), v(x1.out), v(x1.div2), v(x1.div4), v(x1.div8), v(x1.div16), v(x1.div32), v(x1.div64)

tran 50p 1u
write pdiv_tb.raw 
set appendwrite

.endc
"}
C {vsource.sym} 40 130 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -200 300 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {lab_wire.sym} -200 250 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 40 90 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -200 350 0 0 {name=l3 lab=0
}
C {gnd.sym} -140 540 0 0 {name=l5 lab=0
}
C {gnd.sym} -20 540 0 0 {name=l6 lab=0
}
C {gnd.sym} 100 540 0 0 {name=l7 lab=0
}
C {lab_wire.sym} -140 610 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -140 430 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 100 430 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {gnd.sym} 40 180 0 0 {name=l13 lab=0
}
C {gnd.sym} -140 720 0 0 {name=l8 lab=0
}
C {gnd.sym} -20 720 0 0 {name=l10 lab=0
}
C {gnd.sym} 100 720 0 0 {name=l34 lab=0
}
C {lab_wire.sym} 100 610 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -20 430 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -20 610 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} -20 670 0 0 {name=V8 value=1.2 savecurrent=false}
C {vsource.sym} 100 670 0 0 {name=V9 value=1.2 savecurrent=false}
C {vsource.sym} -140 490 0 0 {name=V11 value=0 savecurrent=false}
C {vsource.sym} -20 490 0 0 {name=V10 value=0 savecurrent=false}
C {vsource.sym} 100 490 0 0 {name=V12 value=0 savecurrent=false}
C {vsource.sym} -140 670 0 0 {name=V7 value=1.2 savecurrent=false}
C {gnd.sym} 610 250 3 0 {name=l24 lab=0
}
C {lab_wire.sym} 580 270 2 0 {name=p46 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 620 290 0 0 {name=p52 sig_type=std_logic lab=out_div
}
C {lab_wire.sym} 220 350 0 0 {name=p18 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 220 310 0 0 {name=p19 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 220 330 0 0 {name=p23 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 220 290 0 0 {name=p24 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 220 390 0 0 {name=p25 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 220 370 0 0 {name=p27 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 230 270 0 0 {name=p53 sig_type=std_logic lab=reset
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/pdiv.sym} 400 320 0 0 {name=x1}
C {lab_wire.sym} 230 250 0 0 {name=p1 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -340 250 0 0 {name=p3 sig_type=std_logic lab=reset
}
C {gnd.sym} -340 350 0 0 {name=l1 lab=0
}
C {vsource.sym} -340 300 0 0 {name=V4 value="PWL(
+ 0 1.2 
+ 200n 1.2 
+ 200.1n 0)" savecurrent=false}
