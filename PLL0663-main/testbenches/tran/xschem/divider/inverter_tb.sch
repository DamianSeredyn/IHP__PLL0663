v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -170 -70 -170 -30 {lab=VP}
N -170 -70 -0 -70 {lab=VP}
N -0 -70 0 -30 {lab=VP}
N 0 30 -0 120 {lab=0}
N -90 120 0 120 {lab=0}
N -170 30 -170 120 {lab=0}
N -90 -0 -90 20 {lab=in}
N -90 -0 -20 0 {lab=in}
N 50 -0 110 0 {lab=out}
N 110 0 110 10 {lab=out}
N -90 80 -90 120 {lab=0}
N -170 120 -90 120 {lab=0}
N 0 120 110 120 {lab=0}
N 110 70 110 120 {lab=0}
C {devices/code_shown.sym} -380 -160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 90 -310 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 20n
write inverter_tb.raw
set appendwrite
plot v(out) v(in)
plot X1.VP
.endc
"}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 0 0 0 0 {name=x1}
C {vsource.sym} -170 0 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -90 50 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {capa.sym} 110 40 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -170 120 0 0 {name=l1 lab=0
}
C {lab_wire.sym} 110 0 0 0 {name=p1 sig_type=std_logic lab=out
}
C {lab_wire.sym} -90 0 0 0 {name=p2 sig_type=std_logic lab=in
}
C {lab_wire.sym} 0 -70 0 0 {name=p3 sig_type=std_logic lab=VP
}
