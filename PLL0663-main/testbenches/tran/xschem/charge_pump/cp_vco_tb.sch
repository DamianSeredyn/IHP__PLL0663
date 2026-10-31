v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 130 -570 130 -480 {lab=vp}
N 130 -420 130 -380 {lab=0}
N 860 -220 860 -180 {lab=vp}
N 940 -160 940 -70 {lab=out}
N 980 -160 980 -100 {lab=out_pb}
N 980 -260 990 -260 {lab=#net1}
N 990 -320 990 -260 {lab=#net1}
N 980 -290 990 -320 {lab=#net1}
N 980 -70 1010 -50 {lab=0}
N 980 -40 1010 -50 {lab=0}
N 990 -320 1070 -410 {lab=#net1}
N 1070 -350 1070 -330 {lab=0}
N 860 -160 940 -160 {lab=out}
N 940 -260 940 -160 {lab=out}
N 980 -160 1090 -160 {lab=out_pb}
N 980 -230 980 -160 {lab=out_pb}
N 560 -180 560 -170 {lab=in}
N 350 -170 560 -170 {lab=in}
N -20 -210 10 -210 {lab=vp}
N -20 -190 190 -190 {lab=vout}
N -20 -170 20 -170 {lab=0}
N -350 -210 -320 -210 {lab=upb}
N -350 -190 -320 -190 {lab=dn}
N 250 -190 350 -170 {lab=in}
C {gnd.sym} 860 -140 0 0 {name=l1 lab=0
}
C {vsource.sym} 130 -450 0 0 {name=V2 value=1.2 savecurrent=false}
C {devices/code_shown.sym} 720 -530 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param wp=2u
.param wn=2u
.control

tran 100p 2u
write vco_tb.raw
set appendwrite
plot out dn upb
.endc
"}
C {devices/code_shown.sym} 290 -520 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} 130 -570 0 0 {name=p1 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 890 -160 0 0 {name=p3 sig_type=std_logic lab=out
}
C {lab_wire.sym} 860 -220 0 0 {name=p2 sig_type=std_logic lab=vp
}
C {gnd.sym} 130 -380 0 0 {name=l2 lab=0
}
C {connector.sym} 1090 -160 0 1 {name=c2 footprint=connector(1,1)}
C {sg13g2_pr/sg13_lv_pmos.sym} 960 -260 0 0 {name=M25
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 960 -70 0 0 {name=M27
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 1010 -50 0 0 {name=l3 lab=0
}
C {vsource.sym} 1070 -380 0 0 {name=V3 value=1.2 savecurrent=false}
C {gnd.sym} 1070 -330 0 0 {name=l4 lab=0
}
C {lab_wire.sym} 1040 -160 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {lab_wire.sym} 410 -170 0 0 {name=p13 sig_type=std_logic lab=in
}
C {capa.sym} 370 -140 0 0 {name=C1
m=1
value=20p
ic=0.6
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 370 -110 0 0 {name=l14 lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_cell_7.sym} 710 -160 0 0 {name=x1}
C {lab_wire.sym} 120 -190 0 0 {name=p16 sig_type=std_logic lab=vout
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp2_cs.sym} -170 -190 0 0 {name=x2}
C {lab_wire.sym} 10 -210 0 0 {name=p5 sig_type=std_logic lab=vp
}
C {gnd.sym} 20 -170 0 0 {name=l5 lab=0}
C {lab_pin.sym} -350 -210 0 0 {name=p6 sig_type=std_logic lab=upb}
C {lab_pin.sym} -330 -190 0 0 {name=p7 sig_type=std_logic lab=dn}
C {res.sym} 220 -190 3 0 {name=R1
value=500
footprint=1206
device=resistor
m=1}
C {vsource.sym} 230 -710 0 0 {name=Vupb
value="PULSE(1.2 0 50n 10p 10p 60n 200n)" savecurrent=false}
C {gnd.sym} 230 -680 0 0 {name=l6 lab=0}
C {vsource.sym} 590 -710 0 0 {name=Vdn
value="PULSE(0 1.2 150n 10p 10p 20n 200n)" savecurrent=false}
C {gnd.sym} 590 -680 0 0 {name=l7 lab=0}
C {lab_pin.sym} 230 -740 0 1 {name=p8 sig_type=std_logic lab=upb}
C {lab_pin.sym} 590 -740 0 1 {name=p9 sig_type=std_logic lab=dn}
