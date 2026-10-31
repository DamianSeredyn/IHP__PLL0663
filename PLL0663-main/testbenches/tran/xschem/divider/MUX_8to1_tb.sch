v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -710 10 -710 30 {lab=clk}
N -710 -160 -710 -150 {lab=VP}
N -710 -90 -710 -70 {lab=0}
N -710 90 -710 110 {lab=0}
N 520 -150 590 -150 {lab=out}
N 520 -190 540 -190 {lab=0}
N -440 -10 -440 10 {lab=a1}
N -440 70 -440 90 {lab=0}
N -440 -160 -440 -140 {lab=a0}
N -440 -80 -440 -60 {lab=0}
N -440 140 -440 160 {lab=a2}
N -440 220 -440 240 {lab=0}
N 590 -70 590 -50 {lab=0}
N 590 -150 590 -130 {lab=out}
N 200 -190 220 -190 {lab=a0}
N 200 -170 220 -170 {lab=a1}
N 200 -150 220 -150 {lab=a2}
N 520 -170 540 -170 {lab=VP}
N -200 -150 -180 -150 {lab=clk}
N 200 -130 220 -130 {lab=clk}
N 120 -110 220 -110 {lab=div2}
N 120 -90 220 -90 {lab=div4}
N 120 -70 220 -70 {lab=div8}
N 120 -50 220 -50 {lab=div16}
N 120 -30 220 -30 {lab=div32}
N 120 -10 220 -10 {lab=div64}
N 120 10 220 10 {lab=div128}
N 120 -150 140 -150 {lab=0}
N 120 -130 140 -130 {lab=VP}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/2Div.sym} -30 -70 0 0 {name=x2}
C {vsource.sym} -710 -120 0 0 {name=V1 value=\{vdd\} savecurrent=false}
C {vsource.sym} -710 60 0 0 {name=V2 value="PULSE(0 \{vdd\} 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {gnd.sym} -710 -70 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -710 10 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -710 -160 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {devices/code_shown.sym} -720 -250 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -420 -450 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.control
set maxdata = 1000
op
print all
save all

tran 50p 12.01u
write MUX_8to1_tb.raw
set appendwrite

.endc
"}
C {gnd.sym} -710 110 0 0 {name=l3 lab=0
}
C {gnd.sym} 540 -190 3 0 {name=l5 lab=0
}
C {lab_wire.sym} 540 -170 2 0 {name=p5 sig_type=std_logic lab=VP
}
C {vsource.sym} -440 40 0 0 {name=V3 value="PULSE(0 \{vdd\} 0 100p 100p 3u 6u)" savecurrent=false}
C {lab_wire.sym} -440 -10 0 0 {name=p15 sig_type=std_logic lab=a1
}
C {gnd.sym} -440 90 0 0 {name=l2 lab=0
}
C {vsource.sym} -440 -110 0 0 {name=V4 value="PULSE(0 \{vdd\} 0 100p 100p 1.5u 3u)" savecurrent=false}
C {lab_wire.sym} -440 -160 0 0 {name=p16 sig_type=std_logic lab=a0
}
C {gnd.sym} -440 -60 0 0 {name=l7 lab=0
}
C {vsource.sym} -440 190 0 0 {name=V5 value="PULSE(0 \{vdd\} 0 100p 100p 6u 12u)" savecurrent=false}
C {lab_wire.sym} -440 140 0 0 {name=p17 sig_type=std_logic lab=a2
}
C {gnd.sym} -440 240 0 0 {name=l8 lab=0
}
C {capa.sym} 590 -100 0 0 {name=C9
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 590 -150 0 1 {name=p18 sig_type=std_logic lab=out
}
C {gnd.sym} 590 -50 0 0 {name=l9 lab=0
}
C {lab_wire.sym} 200 -190 0 0 {name=p19 sig_type=std_logic lab=a0
}
C {lab_wire.sym} 200 -170 0 0 {name=p20 sig_type=std_logic lab=a1
}
C {lab_wire.sym} 200 -150 0 0 {name=p21 sig_type=std_logic lab=a2
}
C {lab_wire.sym} -200 -150 2 1 {name=p1 sig_type=std_logic lab=clk
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/MUX_8to1.sym} 370 -90 0 0 {name=x1}
C {lab_wire.sym} 200 -130 2 1 {name=p3 sig_type=std_logic lab=clk
}
C {gnd.sym} 140 -150 3 0 {name=l4 lab=0
}
C {lab_wire.sym} 140 -130 2 0 {name=p4 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 180 10 2 1 {name=p6 sig_type=std_logic lab=div128
}
C {lab_wire.sym} 180 -10 2 1 {name=p7 sig_type=std_logic lab=div64
}
C {lab_wire.sym} 180 -30 2 1 {name=p9 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 180 -50 2 1 {name=p10 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 180 -70 2 1 {name=p11 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 180 -90 2 1 {name=p12 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 180 -110 2 1 {name=p13 sig_type=std_logic lab=div2
}
