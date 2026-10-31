v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -370 110 -370 130 {lab=in}
N 220 0 260 0 {lab=out_pg}
N 160 -70 160 -30 {lab=en_}
N 150 -70 160 -70 {lab=en_}
N 160 30 160 40 {lab=en}
N 70 40 160 40 {lab=en}
N 330 -0 380 -0 {lab=out_inv}
N -260 -60 -260 -50 {lab=VP}
N -380 10 -380 30 {lab=0}
N -380 -70 -380 -50 {lab=gnd!}
N 130 0 140 0 {lab=in}
N -260 10 -260 20 {lab=gnd!}
N -260 120 -260 130 {lab=gnd!}
N -370 190 -370 200 {lab=gnd!}
N -260 50 -260 60 {lab=en}
N 60 -70 80 -70 {lab=en}
N 100 -120 100 -100 {lab=VP}
N 100 -40 100 -20 {lab=gnd!}
N 200 -50 200 -30 {lab=VP}
N 200 30 200 70 {lab=gnd!}
N 280 30 280 50 {lab=gnd!}
N 280 -50 280 -30 {lab=VP}
N 380 60 380 80 {lab=gnd!}
C {devices/code_shown.sym} -390 -160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -130 -450 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write passgate_tb.raw
set appendwrite
plot v(out_inv) v(out_pg)
plot v(out_inv) v(en) 
plot X1.VP
.endc
"}
C {vsource.sym} -260 -20 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -370 160 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {capa.sym} 380 30 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -380 30 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -370 110 0 0 {name=p2 sig_type=std_logic lab=in
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 100 -70 0 0 {name=x3}
C {vsource.sym} -260 90 0 0 {name=V3 value="PULSE(0 1.2 0 10p 10p 26.68n 53.36n)" savecurrent=false}
C {lab_wire.sym} -260 50 0 0 {name=p4 sig_type=std_logic lab=en
}
C {lab_wire.sym} 160 -70 1 0 {name=p5 sig_type=std_logic lab=en_
}
C {lab_wire.sym} 250 0 0 0 {name=p6 sig_type=std_logic lab=out_pg
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 280 0 0 0 {name=x4}
C {lab_wire.sym} 370 0 0 0 {name=p7 sig_type=std_logic lab=out_inv
}
C {lab_wire.sym} 90 40 0 0 {name=p1 sig_type=std_logic lab=en
}
C {lab_wire.sym} -260 -60 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -380 -20 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -380 -60 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 130 0 0 0 {name=p11 sig_type=std_logic lab=in
}
C {lab_wire.sym} -260 130 0 0 {name=p12 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -370 200 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 60 -70 0 0 {name=p14 sig_type=std_logic lab=en
}
C {lab_wire.sym} -260 20 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 200 -50 0 0 {name=p16 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 280 -50 0 0 {name=p17 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 100 -120 0 0 {name=p18 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 100 -20 0 0 {name=p19 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 200 70 0 0 {name=p20 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 280 50 0 0 {name=p21 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 380 80 0 0 {name=p22 sig_type=std_logic lab=gnd!
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/passgate.sym} 160 20 0 0 {name=x1}
