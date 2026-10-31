v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -10 -80 -10 {lab=in}
N -160 50 -160 90 {lab=0}
N -250 -100 -250 -10 {lab=vdd}
N -250 50 -250 90 {lab=0}
N -250 90 -160 90 {lab=0}
N 220 -50 220 -10 {lab=vdd}
N 220 10 300 10 {lab=out}
N 510 10 660 10 {lab=out_pb}
N 400 -110 400 -40 {lab=vdd}
N 400 60 400 100 {lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_cell.sym} 70 10 0 0 {name=x2}
C {vsource.sym} -160 20 0 0 {name=V1 value=1 savecurrent=false}
C {gnd.sym} 220 30 0 0 {name=l1 lab=0
}
C {vsource.sym} -250 20 0 0 {name=V2 value=\{vdd\} savecurrent=false}
C {devices/code_shown.sym} 10 -300 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.control

tran 20p 20n
write vco_tb.raw
set appendwrite
plot out
plot out_pb
.endc
"}
C {devices/code_shown.sym} -270 -300 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -110 -10 0 0 {name=p9 sig_type=std_logic lab=in
}
C {lab_wire.sym} -250 -100 0 0 {name=p1 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 250 10 0 0 {name=p3 sig_type=std_logic lab=out
}
C {lab_wire.sym} 220 -50 0 0 {name=p2 sig_type=std_logic lab=vdd
}
C {gnd.sym} -210 90 0 0 {name=l2 lab=0
}
C {connector.sym} 660 10 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} 600 10 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 400 10 0 0 {name=x1}
C {gnd.sym} 400 100 0 0 {name=l3 lab=0
}
C {lab_wire.sym} 400 -110 0 0 {name=p5 sig_type=std_logic lab=vdd
}
