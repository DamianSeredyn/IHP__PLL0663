v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -430 -80 -430 -60 {lab=clk}
N -430 -250 -430 -240 {lab=VP}
N -430 -180 -430 -160 {lab=0}
N -430 0 -430 20 {lab=0}
N 130 -80 150 -80 {lab=0}
N 130 -60 160 -60 {lab=VP}
N 150 180 150 200 {lab=0}
N 200 160 200 180 {lab=0}
N 250 160 250 180 {lab=0}
N 300 160 300 180 {lab=0}
N 350 160 350 180 {lab=0}
N 400 160 400 180 {lab=0}
N 150 80 150 100 {lab=div128}
N 130 80 150 80 {lab=div128}
N 200 60 200 100 {lab=div64}
N 350 0 350 100 {lab=div8}
N 400 -20 400 100 {lab=div4}
N 450 160 450 180 {lab=0}
N 130 60 200 60 {lab=div64}
N 250 40 250 100 {lab=div32}
N 130 40 250 40 {lab=div32}
N 300 20 300 100 {lab=div16}
N 130 20 300 20 {lab=div16}
N 130 -0 350 0 {lab=div8}
N 130 -20 400 -20 {lab=div4}
N 130 -40 450 -40 {lab=div2}
N 450 -40 450 100 {lab=div2}
N -190 -80 -170 -80 {lab=clk}
N 400 180 450 180 {lab=0}
N 150 180 200 180 {lab=0}
N 200 180 250 180 {lab=0}
N 250 180 300 180 {lab=0}
N 300 180 350 180 {lab=0}
N 350 180 400 180 {lab=0}
N 150 160 150 180 {lab=0}
C {vsource.sym} -430 -210 0 0 {name=V1 value=\{vdd\} savecurrent=false}
C {vsource.sym} -430 -30 0 0 {name=V2 value="PULSE(0 \{vdd\} 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {gnd.sym} -430 -160 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -430 -80 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -430 -250 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {devices/code_shown.sym} -490 -400 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -170 -460 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.control
set maxdata = 1000
op
print all
save all

tran 50p 4u
write 2div_tb.raw
set appendwrite

.endc
"}
C {gnd.sym} 150 -80 3 0 {name=l2 lab=0
}
C {lab_wire.sym} 160 -60 2 0 {name=p1 sig_type=std_logic lab=VP
}
C {capa.sym} 150 130 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 200 130 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 250 130 0 0 {name=C3
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 300 130 0 0 {name=C4
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 350 130 0 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 400 130 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 450 130 0 0 {name=C7
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} -190 -80 0 0 {name=p11 sig_type=std_logic lab=clk
}
C {gnd.sym} -430 20 0 0 {name=l3 lab=0
}
C {lab_wire.sym} 400 -20 2 0 {name=p21 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 450 -40 2 0 {name=p12 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 350 0 2 0 {name=p13 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 300 20 2 0 {name=p14 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 250 40 2 0 {name=p15 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 200 60 2 0 {name=p16 sig_type=std_logic lab=div64
}
C {lab_wire.sym} 150 80 2 0 {name=p17 sig_type=std_logic lab=div128
}
C {gnd.sym} 150 200 0 0 {name=l4 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/2Div.sym} -20 0 0 0 {name=x1}
