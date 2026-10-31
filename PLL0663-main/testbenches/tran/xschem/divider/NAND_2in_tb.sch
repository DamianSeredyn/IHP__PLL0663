v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 190 -10 210 {lab=a}
N 100 20 100 30 {lab=VP}
N -20 90 -20 110 {lab=0}
N -20 10 -20 30 {lab=gnd!}
N 100 90 100 100 {lab=gnd!}
N -10 270 -10 280 {lab=gnd!}
N 610 340 640 340 {lab=VP}
N 610 360 640 360 {lab=gnd!}
N 630 450 630 470 {lab=gnd!}
N 610 380 630 380 {lab=y}
N 630 380 630 390 {lab=y}
N 0 330 0 350 {lab=b}
N 0 410 0 420 {lab=gnd!}
N 290 340 310 340 {lab=a}
N 290 360 310 360 {lab=b}
C {devices/code_shown.sym} -30 -80 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 280 -40 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write NAND_2in_tb.raw
set appendwrite

.endc
"}
C {vsource.sym} 100 60 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -10 240 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 1.5625n 3.125n)" savecurrent=false}
C {gnd.sym} -20 110 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -10 190 0 0 {name=p2 sig_type=std_logic lab=a
}
C {lab_wire.sym} 100 20 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -20 60 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -20 20 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -10 280 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 100 100 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 640 360 2 0 {name=p3 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 640 340 0 0 {name=p10 sig_type=std_logic lab=VP
}
C {capa.sym} 630 420 0 0 {name=C2
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 630 470 0 0 {name=p23 sig_type=std_logic lab=gnd!
}
C {vsource.sym} 0 380 0 0 {name=V3 value="PULSE(0 1.2 0 10p 10p 3.125n 6.25n)" savecurrent=false}
C {lab_wire.sym} 0 330 0 0 {name=p1 sig_type=std_logic lab=b
}
C {lab_wire.sym} 0 420 0 0 {name=p4 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 290 340 0 0 {name=p7 sig_type=std_logic lab=a
}
C {lab_wire.sym} 290 360 3 0 {name=p11 sig_type=std_logic lab=b
}
C {lab_wire.sym} 630 380 2 0 {name=p14 sig_type=std_logic lab=y
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/NAND_2in.sym} 460 360 0 0 {name=x1}
