v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -10 -80 -10 {lab=in}
N -160 50 -160 90 {lab=0}
N -250 -100 -250 -10 {lab=vp}
N -250 50 -250 90 {lab=0}
N -250 90 -160 90 {lab=0}
N 220 -50 220 -10 {lab=vp}
N 300 10 300 100 {lab=out}
N 340 10 340 70 {lab=out_pb}
N 340 -90 350 -90 {lab=#net1}
N 350 -150 350 -90 {lab=#net1}
N 340 -120 350 -150 {lab=#net1}
N 340 100 370 120 {lab=0}
N 340 130 370 120 {lab=0}
N 350 -150 430 -240 {lab=#net1}
N 430 -180 430 -160 {lab=0}
N 220 10 300 10 {lab=out}
N 300 -90 300 10 {lab=out}
N 340 10 450 10 {lab=out_pb}
N 340 -60 340 10 {lab=out_pb}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_cell.sym} 70 10 0 0 {}
C {vsource.sym} -160 20 0 0 {name=V1 value=1 savecurrent=false}
C {gnd.sym} 220 30 0 0 {name=l1 lab=0
}
C {vsource.sym} -250 20 0 0 {name=V2 value=1.2 savecurrent=false}
C {devices/code_shown.sym} 80 -360 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

tran 20p 20n
write vco_tb.raw
set appendwrite
plot out
plot out_pb
.endc
"}
C {devices/code_shown.sym} -350 -350 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -110 -10 0 0 {name=p9 sig_type=std_logic lab=in
}
C {lab_wire.sym} -250 -100 0 0 {name=p1 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 250 10 0 0 {name=p3 sig_type=std_logic lab=out
}
C {lab_wire.sym} 220 -50 0 0 {name=p2 sig_type=std_logic lab=vp
}
C {gnd.sym} -210 90 0 0 {name=l2 lab=0
}
C {connector.sym} 450 10 0 1 {name=c2 footprint=connector(1,1)}
C {sg13g2_pr/sg13_lv_pmos.sym} 320 -90 0 0 {name=M25
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 320 100 0 0 {name=M27
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 370 120 0 0 {name=l3 lab=0
}
C {vsource.sym} 430 -210 0 0 {name=V3 value=1.2 savecurrent=false}
C {gnd.sym} 430 -160 0 0 {name=l4 lab=0
}
C {lab_wire.sym} 400 10 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
