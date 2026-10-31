v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -0 -130 -0 -80 {lab=vp}
N 50 -130 50 -80 {lab=vph}
N 30 80 30 120 {lab=GND}
N -130 310 -130 350 {lab=GND}
N -130 210 -130 250 {lab=in}
N -250 210 -250 250 {lab=vp}
N -250 310 -250 350 {lab=GND}
N -370 210 -370 250 {lab=vph}
N -370 310 -370 360 {lab=GND}
N -410 100 -400 100 {lab=#net1}
N -400 100 -400 120 {lab=#net1}
N -720 120 -400 120 {lab=#net1}
N -720 60 -720 120 {lab=#net1}
N -720 60 -710 60 {lab=#net1}
N -410 60 -390 60 {lab=vp}
N -410 80 -360 80 {lab=GND}
N -410 40 -320 40 {lab=out_PLL_divided}
N -250 40 -190 40 {lab=#net2}
N -300 -10 -300 10 {lab=vp}
N -300 80 -300 90 {lab=GND}
N -170 -10 -170 10 {lab=vp}
N -170 80 -170 90 {lab=GND}
N -120 40 -60 40 {lab=pre_LS}
N -790 40 -710 40 {lab=in}
N -360 80 -360 110 {lab=GND}
N 270 -140 270 -90 {lab=vph}
N 270 10 270 50 {lab=GND}
N 380 -40 490 -40 {lab=out}
N 490 20 490 50 {lab=GND}
N 110 -40 170 -40 {lab=aft_LS}
N -360 80 -300 80 {lab=GND}
N -300 70 -300 80 {lab=GND}
N -300 80 -170 80 {lab=GND}
N -170 70 -170 80 {lab=GND}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/level_shifter.sym} 90 -20 0 0 {name=x1}
C {vsource.sym} -250 280 0 0 {name=V1 value=\{Vp\} savecurrent=false}
C {vsource.sym} -370 280 0 0 {name=V2 value=\{Vph\} savecurrent=false}
C {capa.sym} 490 -10 0 0 {name=C1
m=1
value=20p
footprint=1206
device="ceramic capacitor"}
C {devices/vsource.sym} -130 280 0 0 {name=Vco value="dc 0 ac 0 pulse(1u \{Vp\} 0 10p 10p \{T/2\} \{T\}) "}
C {gnd.sym} 30 120 0 0 {name=l1 lab=GND
}
C {lab_wire.sym} 0 -130 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 50 -130 0 0 {name=p3 sig_type=std_logic lab=vph}
C {lab_wire.sym} -130 210 0 0 {name=p4 sig_type=std_logic lab=in}
C {lab_wire.sym} 450 -40 0 0 {name=p5 sig_type=std_logic lab=out}
C {devices/code_shown.sym} -610 -230 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt 
"}
C {devices/code_shown.sym} -580 -700 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=25
.param T = 5n
.param Vp=1.2
.param Vph=3.3
.control
save all

tran 0.5n 100n

meas tran VOUT_MAX MAX v(out) from=75n to=100n

meas tran VOUT_AVG AVG v(out) from=75n to=100n


plot v(VOUT_MAX) v(VOUT_AVG)
write level_shifter.raw
.endc
"}
C {devices/code_shown.sym} -620 -170 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOShv.lib mos_tt
"}
C {lab_wire.sym} -250 210 0 0 {name=p1 sig_type=std_logic lab=vp}
C {gnd.sym} -130 350 0 0 {name=l2 lab=GND
}
C {gnd.sym} -250 350 0 0 {name=l3 lab=GND
}
C {lab_wire.sym} -370 210 0 0 {name=p6 sig_type=std_logic lab=vph}
C {gnd.sym} -370 360 0 0 {name=l4 lab=GND
}
C {lab_pin.sym} -390 60 2 0 {name=p42 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} -560 70 0 0 {name=x5}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x2.sym} -290 40 0 0 {name=x2}
C {lab_wire.sym} -300 -10 0 0 {name=p50 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} -170 40 0 0 {name=x3}
C {lab_wire.sym} -170 -10 0 0 {name=p24 sig_type=std_logic lab=vp}
C {lab_wire.sym} -350 40 0 0 {name=p57 sig_type=std_logic lab=out_PLL_divided}
C {lab_wire.sym} -760 40 0 0 {name=p7 sig_type=std_logic lab=in}
C {gnd.sym} -360 110 0 0 {name=l5 lab=GND
}
C {lab_wire.sym} -80 40 0 0 {name=p58 sig_type=std_logic lab=pre_LS}
C {lab_wire.sym} 150 -40 0 0 {name=p8 sig_type=std_logic lab=aft_LS}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 270 -40 0 0 {name=xBUF1}
C {lab_wire.sym} 270 -140 0 0 {name=p61 sig_type=std_logic lab=vph}
C {gnd.sym} 270 50 0 0 {name=l6 lab=GND
}
C {gnd.sym} 490 50 0 0 {name=l7 lab=GND
}
