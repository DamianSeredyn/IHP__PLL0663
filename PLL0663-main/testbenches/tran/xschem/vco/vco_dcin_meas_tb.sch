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
N 280 -10 320 -10 {lab=out}
N 420 -100 420 -60 {lab=vdd}
N 100 80 100 120 {lab=0}
N 420 40 420 80 {lab=0}
N 530 -10 570 -10 {lab=out_pb}
N -350 250 -350 290 {lab=0}
N -350 150 -350 190 {lab=en5}
N -60 250 -60 290 {lab=0}
N -60 150 -60 190 {lab=v2i_vp}
N 70 -140 70 -100 {lab=v2i_vp}
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
C {lab_wire.sym} 300 -10 0 0 {name=p3 sig_type=std_logic lab=out
}
C {lab_wire.sym} 100 -140 0 0 {name=p2 sig_type=std_logic lab=vdd
}
C {gnd.sym} -160 290 0 0 {name=l2 lab=0
}
C {connector.sym} 570 -10 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} 570 -10 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 420 -10 0 0 {name=x1}
C {lab_wire.sym} 420 -100 0 0 {name=p5 sig_type=std_logic lab=vdd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_core_0_meas.sym} 100 -10 0 0 {name=x2}
C {gnd.sym} -240 290 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -160 150 0 0 {name=p6 sig_type=std_logic lab=in
}
C {gnd.sym} 100 120 0 0 {name=l3 lab=0
}
C {gnd.sym} 420 80 0 0 {name=l5 lab=0
}
C {vsource.sym} -350 220 0 0 {name=V3 value=0 savecurrent=false}
C {gnd.sym} -350 290 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -350 150 0 0 {name=p7 sig_type=std_logic lab=en5
}
C {connector.sym} -350 150 0 1 {name=c1 footprint=connector(1,1)}
C {vsource.sym} -60 220 0 0 {name=V4 value=\{vdd\} savecurrent=false}
C {lab_wire.sym} -60 150 0 0 {name=p8 sig_type=std_logic lab=v2i_vp
}
C {gnd.sym} -60 290 0 0 {name=l6 lab=0
}
C {lab_wire.sym} 70 -140 0 0 {name=p10 sig_type=std_logic lab=v2i_vp
}
