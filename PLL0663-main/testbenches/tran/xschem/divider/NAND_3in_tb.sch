v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -510 -290 -510 -270 {lab=a}
N -400 -460 -400 -450 {lab=VP}
N -520 -390 -520 -370 {lab=0}
N -520 -470 -520 -450 {lab=gnd!}
N -400 -390 -400 -380 {lab=gnd!}
N -510 -210 -510 -200 {lab=gnd!}
N 110 -140 140 -140 {lab=VP}
N 110 -120 140 -120 {lab=gnd!}
N 130 -30 130 -10 {lab=gnd!}
N 110 -100 130 -100 {lab=y}
N 130 -100 130 -90 {lab=y}
N -500 -150 -500 -130 {lab=b}
N -500 -70 -500 -60 {lab=gnd!}
N -510 -10 -510 10 {lab=c}
N -510 70 -510 80 {lab=gnd!}
N -210 -140 -190 -140 {lab=a}
N -210 -120 -190 -120 {lab=b}
N -210 -100 -190 -100 {lab=c}
C {devices/code_shown.sym} -530 -560 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -220 -520 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write NAND_3in_tb.raw
set appendwrite

.endc
"}
C {vsource.sym} -400 -420 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -510 -240 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 1.5625n 3.125n)" savecurrent=false}
C {gnd.sym} -520 -370 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -510 -290 0 0 {name=p2 sig_type=std_logic lab=a
}
C {lab_wire.sym} -400 -460 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -520 -420 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -520 -460 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -510 -200 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -400 -380 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 140 -120 2 0 {name=p3 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 140 -140 0 0 {name=p10 sig_type=std_logic lab=VP
}
C {capa.sym} 130 -60 0 0 {name=C2
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 130 -10 0 0 {name=p23 sig_type=std_logic lab=gnd!
}
C {vsource.sym} -500 -100 0 0 {name=V3 value="PULSE(0 1.2 0 10p 10p 3.125n 6.25n)" savecurrent=false}
C {lab_wire.sym} -500 -150 0 0 {name=p1 sig_type=std_logic lab=b
}
C {lab_wire.sym} -500 -60 0 0 {name=p4 sig_type=std_logic lab=gnd!
}
C {vsource.sym} -510 40 0 0 {name=V4 value="PULSE(0 1.2 0 10p 10p 6.25n 12.5n)" savecurrent=false}
C {lab_wire.sym} -510 -10 0 0 {name=p5 sig_type=std_logic lab=c
}
C {lab_wire.sym} -510 80 0 0 {name=p6 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -210 -140 0 0 {name=p7 sig_type=std_logic lab=a
}
C {lab_wire.sym} -210 -120 3 0 {name=p11 sig_type=std_logic lab=b
}
C {lab_wire.sym} -210 -100 3 0 {name=p12 sig_type=std_logic lab=c
}
C {lab_wire.sym} 130 -100 2 0 {name=p14 sig_type=std_logic lab=y
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_3in.sym} -40 -120 0 0 {name=x1}
