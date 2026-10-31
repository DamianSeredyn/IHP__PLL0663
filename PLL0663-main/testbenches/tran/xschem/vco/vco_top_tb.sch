v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -0 210 -0 260 {lab=gd}
N 0 -200 0 -150 {lab=Vp}
N -830 270 -830 300 {lab=d0}
N -760 270 -760 300 {lab=d1}
N -680 270 -680 300 {lab=d2}
N -610 270 -610 300 {lab=d3}
N -550 270 -550 300 {lab=d4}
N -460 270 -460 300 {lab=d5}
N -760 440 -760 460 {lab=a1}
N -760 520 -760 540 {lab=gd}
N -830 440 -830 460 {lab=a0}
N -830 520 -830 540 {lab=gd}
N -690 440 -690 460 {lab=a2}
N -690 520 -690 540 {lab=gd}
N -830 360 -830 380 {lab=gd}
N -760 360 -760 380 {lab=gd}
N -680 360 -680 380 {lab=gd}
N -610 360 -610 380 {lab=gd}
N -550 360 -550 380 {lab=gd}
N -460 360 -460 380 {lab=gd}
N -280 -60 -220 -60 {lab=a0}
N -280 -40 -220 -40 {lab=a1}
N -280 -20 -220 -20 {lab=a2}
N -280 0 -220 -0 {lab=d0}
N -280 20 -220 20 {lab=d1}
N -280 60 -220 60 {lab=d3}
N -280 80 -220 80 {lab=d4}
N -280 100 -220 100 {lab=d5}
N -280 40 -220 40 {lab=d2}
N -370 120 -220 120 {lab=#net1}
N 240 30 400 30 {lab=out}
N -340 470 -340 490 {lab=gd}
N -340 370 -340 410 {lab=Vp}
N -210 470 -210 520 {lab=GND}
N -210 370 -210 410 {lab=gd}
N -370 180 -370 210 {lab=gd}
N 300 90 300 110 {lab=gd}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_top.sym} -80 30 0 0 {name=x1}
C {devices/code_shown.sym} -1160 -780 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=25
.param T = 31.25u
.option klu method=gear reltol=1e-3 gmin=1e-12 abstol=1e-12 rshunt=1e12
.options cshunt=2.5f
.param Vp=1.2
.param Vph=3.3
.control 

* Operating Point Analysis



write vco_top_tb.raw
set appendwrite
save all 
tran 0.1n 100u


write PLL_top_tb.raw
.endc
"}
C {lab_wire.sym} -610 270 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -830 270 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} -680 270 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {lab_wire.sym} -460 270 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -760 270 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -550 270 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} -550 330 0 0 {name=V8 value=0 savecurrent=false}
C {vsource.sym} -460 330 0 0 {name=V9 value=0 savecurrent=false}
C {vsource.sym} -830 330 0 0 {name=V11 value=1.2 savecurrent=false}
C {vsource.sym} -760 330 0 0 {name=V10 value=1.2  savecurrent=false}
C {vsource.sym} -680 330 0 0 {name=V12 value=0 savecurrent=false}
C {vsource.sym} -610 330 0 0 {name=V7 value=0 savecurrent=false}
C {vsource.sym} -760 490 0 0 {name=V5 value=1.2 savecurrent=false}
C {lab_wire.sym} -760 440 0 0 {name=p24 sig_type=std_logic lab=a1
}
C {vsource.sym} -830 490 0 0 {name=V6 value=1.2 savecurrent=false}
C {lab_wire.sym} -830 440 0 0 {name=p25 sig_type=std_logic lab=a0
}
C {vsource.sym} -690 490 0 0 {name=V13 value=1.2 savecurrent=false}
C {lab_wire.sym} -690 440 0 0 {name=p27 sig_type=std_logic lab=a2
}
C {lab_wire.sym} -830 380 0 0 {name=p26 sig_type=std_logic lab=gd}
C {lab_wire.sym} -760 380 0 0 {name=p28 sig_type=std_logic lab=gd}
C {lab_wire.sym} -680 380 0 0 {name=p29 sig_type=std_logic lab=gd}
C {lab_wire.sym} -610 380 0 0 {name=p30 sig_type=std_logic lab=gd}
C {lab_wire.sym} -550 380 0 0 {name=p31 sig_type=std_logic lab=gd}
C {lab_wire.sym} -460 380 0 0 {name=p32 sig_type=std_logic lab=gd}
C {lab_wire.sym} -830 540 0 0 {name=p33 sig_type=std_logic lab=gd}
C {lab_wire.sym} -760 540 0 0 {name=p34 sig_type=std_logic lab=gd}
C {lab_wire.sym} -690 540 0 0 {name=p35 sig_type=std_logic lab=gd}
C {lab_wire.sym} -280 0 1 0 {name=p1 sig_type=std_logic lab=d0
}
C {lab_wire.sym} -280 20 1 0 {name=p2 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -280 40 1 0 {name=p3 sig_type=std_logic lab=d2
}
C {lab_wire.sym} -280 60 1 0 {name=p4 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -280 80 1 0 {name=p5 sig_type=std_logic lab=d4
}
C {lab_wire.sym} -280 100 1 0 {name=p6 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 0 260 0 0 {name=p7 sig_type=std_logic lab=gd}
C {lab_wire.sym} 400 30 0 0 {name=p8 sig_type=std_logic lab=out}
C {devices/vsource.sym} -340 440 0 0 {name=Vp value="dc \{Vp\}"}
C {lab_wire.sym} -340 370 0 0 {name=p9 sig_type=std_logic lab=Vp}
C {lab_wire.sym} -340 490 0 0 {name=p38 sig_type=std_logic lab=gd}
C {lab_wire.sym} 0 -200 0 0 {name=p10 sig_type=std_logic lab=Vp}
C {devices/vsource.sym} -210 440 0 0 {name=Vp2 value="dc 0"}
C {lab_wire.sym} -210 370 0 0 {name=p40 sig_type=std_logic lab=gd}
C {devices/gnd.sym} -210 520 0 0 {name=l2 lab=GND}
C {lab_wire.sym} -280 -60 0 0 {name=p11 sig_type=std_logic lab=a0
}
C {lab_wire.sym} -280 -40 0 0 {name=p12 sig_type=std_logic lab=a1
}
C {lab_wire.sym} -280 -20 0 0 {name=p13 sig_type=std_logic lab=a2
}
C {devices/vsource.sym} -370 150 0 0 {name=Vp1 value="dc 0.5"}
C {lab_wire.sym} -370 210 0 0 {name=p14 sig_type=std_logic lab=gd}
C {capa.sym} 300 60 0 0 {name=C1
m=1
value=25f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 300 110 0 0 {name=p23 sig_type=std_logic lab=gd
value=25f}
