v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 330 470 330 490 {lab=a}
N 440 300 440 310 {lab=VP}
N 440 370 440 380 {lab=0}
N 330 550 330 560 {lab=0}
N 950 620 980 620 {lab=VP}
N 950 640 980 640 {lab=0}
N 970 730 970 750 {lab=0}
N 950 660 970 660 {lab=y}
N 970 660 970 670 {lab=y}
N 340 610 340 630 {lab=b}
N 340 690 340 700 {lab=0}
N 630 620 650 620 {lab=a}
N 630 640 650 640 {lab=b}
C {devices/code_shown.sym} 310 200 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 570 -90 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write xnor_tb.raw
set appendwrite
plot v(a) v(b) v(c)
plot v(y)
plot X1.VP
.endc
"}
C {vsource.sym} 440 340 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} 330 520 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {gnd.sym} 440 380 0 0 {name=l1 lab=0
}
C {lab_wire.sym} 330 470 0 0 {name=p2 sig_type=std_logic lab=a
}
C {lab_wire.sym} 440 300 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 980 620 0 0 {name=p10 sig_type=std_logic lab=VP
}
C {capa.sym} 970 700 0 0 {name=C2
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 340 610 0 0 {name=p1 sig_type=std_logic lab=b
}
C {lab_wire.sym} 630 620 0 0 {name=p7 sig_type=std_logic lab=a
}
C {lab_wire.sym} 630 640 3 0 {name=p11 sig_type=std_logic lab=b
}
C {lab_wire.sym} 970 660 2 0 {name=p14 sig_type=std_logic lab=y
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/XNOR.sym} 800 640 0 0 {name=x1}
C {gnd.sym} 980 640 0 0 {name=l2 lab=0
}
C {gnd.sym} 970 750 0 0 {name=l3 lab=0
}
C {gnd.sym} 330 560 0 0 {name=l4 lab=0
}
C {gnd.sym} 340 700 0 0 {name=l5 lab=0
}
C {vsource.sym} 340 660 0 0 {name=V3 value="PULSE(0 1.2 2n 10p 10p 3.335n 6.67n)" savecurrent=false}
