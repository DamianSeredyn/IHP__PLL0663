v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 110 570 110 590 {lab=d12}
N 40 280 40 290 {lab=VP}
N 110 650 110 660 {lab=0}
N 960 290 960 310 {lab=0}
N 960 220 960 230 {lab=check}
N -160 440 -160 460 {lab=c11}
N -160 520 -160 530 {lab=0}
N 40 350 40 360 {lab=0}
N 520 220 560 220 {lab=VP}
N 520 240 560 240 {lab=VP}
N 520 260 560 260 {lab=VP}
N 520 280 560 280 {lab=VP}
N 520 300 560 300 {lab=VP}
N 520 320 560 320 {lab=VP}
N 520 340 560 340 {lab=VP}
N 520 360 560 360 {lab=VP}
N 520 380 560 380 {lab=VP}
N 520 400 560 400 {lab=VP}
N 520 420 560 420 {lab=VP}
N 520 440 560 440 {lab=c11}
N 520 460 560 460 {lab=c12}
N 520 480 560 480 {lab=VP}
N 520 500 560 500 {lab=VP}
N 520 520 560 520 {lab=VP}
N 520 540 560 540 {lab=VP}
N 520 560 560 560 {lab=VP}
N 520 580 560 580 {lab=VP}
N 520 600 560 600 {lab=VP}
N 520 620 560 620 {lab=VP}
N 520 640 560 640 {lab=VP}
N 520 660 560 660 {lab=VP}
N 520 680 560 680 {lab=VP}
N 520 700 560 700 {lab=d11}
N 520 720 560 720 {lab=d12}
N 860 240 890 240 {lab=VP}
N 860 220 960 220 {lab=check}
N 880 260 880 290 {lab=0}
N 860 260 880 260 {lab=0}
N -160 570 -160 590 {lab=c12}
N -160 650 -160 660 {lab=0}
N 110 440 110 460 {lab=d11}
N 110 520 110 530 {lab=0}
C {devices/code_shown.sym} 60 200 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 550 -100 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control
set maxdata = 1000
op
print all
save all

tran 50p 200n
write count_check_tb.raw
set appendwrite

plot v(check) v(c11) v(c12) v(d11) v(d12)
.endc
"}
C {vsource.sym} 40 320 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 40 360 0 0 {name=l1 lab=0
}
C {lab_wire.sym} 520 720 0 0 {name=p2 sig_type=std_logic lab=d12
}
C {lab_wire.sym} 40 280 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {capa.sym} 960 260 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} -160 440 0 0 {name=p6 sig_type=std_logic lab=c11
}
C {vsource.sym} -160 490 0 0 {name=V3 value="PULSE(0 1.2 0 100p 100p 6.25n 12.5n)" savecurrent=false}
C {gnd.sym} -160 530 0 0 {name=l2 lab=0
}
C {gnd.sym} 110 660 0 0 {name=l3 lab=0
}
C {gnd.sym} 960 310 0 0 {name=l4 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/count_data_check.sym} 710 470 0 0 {name=x1}
C {lab_wire.sym} 520 220 0 0 {name=p1 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 480 0 0 {name=p3 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 500 0 0 {name=p4 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 240 0 0 {name=p5 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 260 0 0 {name=p7 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 280 0 0 {name=p9 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 300 0 0 {name=p10 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 320 0 0 {name=p11 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 520 0 0 {name=p12 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 540 0 0 {name=p13 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 560 0 0 {name=p14 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 580 0 0 {name=p15 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 600 0 0 {name=p16 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 620 0 0 {name=p17 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 640 0 0 {name=p18 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 660 0 0 {name=p19 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 680 0 0 {name=p20 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 340 0 0 {name=p21 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 360 0 0 {name=p22 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 380 0 0 {name=p23 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 400 0 0 {name=p24 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 520 420 0 0 {name=p25 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 890 240 1 0 {name=p26 sig_type=std_logic lab=VP
}
C {gnd.sym} 880 290 0 0 {name=l5 lab=0
}
C {lab_wire.sym} -160 570 0 0 {name=p27 sig_type=std_logic lab=c12
}
C {gnd.sym} -160 660 0 0 {name=l6 lab=0
}
C {lab_wire.sym} 110 440 0 0 {name=p28 sig_type=std_logic lab=d11
}
C {gnd.sym} 110 530 0 0 {name=l7 lab=0
}
C {lab_wire.sym} 520 440 0 0 {name=p29 sig_type=std_logic lab=c11
}
C {lab_wire.sym} 520 460 0 0 {name=p30 sig_type=std_logic lab=c12
}
C {lab_wire.sym} 520 700 0 0 {name=p31 sig_type=std_logic lab=d11
}
C {lab_wire.sym} 110 570 0 0 {name=p32 sig_type=std_logic lab=d12
}
C {vsource.sym} -160 620 0 0 {name=V5 value="PULSE(0 1.2 0 100p 100p 12.5n 25n)" savecurrent=false}
C {vsource.sym} 110 490 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 25n 50n)" savecurrent=false}
C {vsource.sym} 110 620 0 0 {name=V4 value="PULSE(0 1.2 1.2n 10p 10p 50n 100n)" savecurrent=false}
C {lab_wire.sym} 940 220 0 0 {name=p33 sig_type=std_logic lab=check
}
