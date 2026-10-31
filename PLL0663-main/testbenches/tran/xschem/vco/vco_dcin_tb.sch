v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 250 -160 290 {lab=0}
N -240 250 -240 290 {lab=0}
N 100 -140 100 -100 {lab=vdd}
N -240 150 -240 190 {lab=vdd}
N -160 150 -160 190 {lab=in}
N -120 -10 -80 -10 {lab=in}
N 100 80 100 120 {lab=0}
N -560 240 -560 280 {lab=0}
N -560 140 -560 180 {lab=en5}
N 680 50 680 70 {lab=0}
N 100 280 140 280 {lab=en5}
N 210 280 280 280 {lab=nen5}
N 160 210 160 250 {lab=vdd}
N 160 310 160 350 {lab=0}
N 440 280 480 280 {lab=en5}
N 550 280 620 280 {lab=en11}
N 500 210 500 250 {lab=vdd}
N 500 310 500 350 {lab=0}
N 110 480 150 480 {lab=en11}
N 220 480 290 480 {lab=nen11}
N 170 410 170 450 {lab=vdd}
N 170 510 170 550 {lab=0}
N -120 -60 -80 -60 {lab=en5}
N -150 -40 -80 -40 {lab=nen5}
N -120 20 -80 20 {lab=en11}
N -150 40 -80 40 {lab=nen11}
N 570 -10 680 -10 {lab=out_pb}
N 410 -130 410 -90 {lab=vdd}
N 410 70 410 110 {lab=0}
N 280 -10 370 -10 {lab=out}
C {vsource.sym} -160 220 0 0 {name=V1 value="\{vin\} ac 1" savecurrent=true}
C {vsource.sym} -240 220 0 0 {name=V2 value=\{vdd\} savecurrent=false}
C {devices/code_shown.sym} -300 -330 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.param vin=0.4

.control

tran 40p 700n
write vco_tb.raw
set appendwrite
plot out
plot out_pb
.endc
"}
C {devices/code_shown.sym} -290 -400 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -120 -10 0 0 {name=p9 sig_type=std_logic lab=in
}
C {lab_wire.sym} -240 150 0 0 {name=p1 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 320 -10 0 0 {name=p3 sig_type=std_logic lab=out
}
C {lab_wire.sym} 100 -140 0 0 {name=p2 sig_type=std_logic lab=vdd
}
C {gnd.sym} -160 290 0 0 {name=l2 lab=0
}
C {lab_wire.sym} 680 -10 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {lab_wire.sym} 410 -130 0 0 {name=p5 sig_type=std_logic lab=vdd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_core_2.sym} 100 -10 0 0 {name=x2}
C {gnd.sym} -240 290 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -160 150 0 0 {name=p6 sig_type=std_logic lab=in
}
C {gnd.sym} 100 120 0 0 {name=l3 lab=0
}
C {gnd.sym} 410 110 0 0 {name=l5 lab=0
}
C {vsource.sym} -560 210 0 0 {name=V3 value=0 savecurrent=false}
C {gnd.sym} -560 280 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -560 140 0 0 {name=p7 sig_type=std_logic lab=en5
}
C {connector.sym} -560 140 0 1 {name=c1 footprint=connector(1,1)}
C {capa.sym} 680 20 0 0 {name=C3
m=1
value=50f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 680 70 0 0 {name=l6 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 160 280 0 0 {name=x14}
C {lab_wire.sym} 110 280 0 0 {name=p8 sig_type=std_logic lab=en5
}
C {lab_wire.sym} 270 280 0 0 {name=p10 sig_type=std_logic lab=nen5
}
C {connector.sym} 280 280 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} 160 210 0 0 {name=p11 sig_type=std_logic lab=vdd
}
C {gnd.sym} 160 350 0 0 {name=l7 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 500 280 0 0 {name=x3}
C {lab_wire.sym} 450 280 0 0 {name=p12 sig_type=std_logic lab=en5
}
C {lab_wire.sym} 610 280 0 0 {name=p13 sig_type=std_logic lab=en11
}
C {connector.sym} 620 280 0 1 {name=c4 footprint=connector(1,1)}
C {lab_wire.sym} 500 210 0 0 {name=p14 sig_type=std_logic lab=vdd
}
C {gnd.sym} 500 350 0 0 {name=l8 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 170 480 0 0 {name=x4}
C {lab_wire.sym} 120 480 0 0 {name=p15 sig_type=std_logic lab=en11
}
C {lab_wire.sym} 280 480 0 0 {name=p16 sig_type=std_logic lab=nen11
}
C {connector.sym} 290 480 0 1 {name=c5 footprint=connector(1,1)}
C {lab_wire.sym} 170 410 0 0 {name=p17 sig_type=std_logic lab=vdd
}
C {gnd.sym} 170 550 0 0 {name=l9 lab=0
}
C {lab_wire.sym} -110 -60 0 0 {name=p18 sig_type=std_logic lab=en5
}
C {lab_wire.sym} -90 -40 0 0 {name=p19 sig_type=std_logic lab=nen5
}
C {lab_wire.sym} -110 20 0 0 {name=p20 sig_type=std_logic lab=en11
}
C {lab_wire.sym} -90 40 0 0 {name=p21 sig_type=std_logic lab=nen11
}
C {connector.sym} -150 -40 0 0 {name=c8 footprint=connector(1,1)}
C {connector.sym} -120 20 0 0 {name=c9 footprint=connector(1,1)}
C {connector.sym} -150 40 0 0 {name=c10 footprint=connector(1,1)}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/0_buf.sym} 450 80 0 0 {name=x1}
C {connector.sym} -120 -60 0 0 {name=c6 footprint=connector(1,1)}
