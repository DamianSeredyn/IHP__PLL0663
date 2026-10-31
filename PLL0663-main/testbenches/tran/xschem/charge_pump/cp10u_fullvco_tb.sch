v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 610 -120 730 -120 {lab=#net1}
N 600 -500 1090 -500 {lab=0}
N 1090 -580 1090 -560 {lab=f0}
N 1030 -580 1030 -560 {lab=f1}
N 980 -580 980 -560 {lab=f2}
N 920 -580 920 -560 {lab=f3}
N 860 -580 860 -560 {lab=f4}
N 810 -580 810 -560 {lab=f5}
N 730 -580 730 -560 {lab=c0}
N 670 -580 670 -560 {lab=c1}
N 600 -580 600 -560 {lab=c2}
N 700 -300 730 -300 {lab=c0}
N 700 -280 730 -280 {lab=c1}
N 700 -260 730 -260 {lab=c2}
N 700 -240 730 -240 {lab=f0}
N 700 -220 730 -220 {lab=f1}
N 700 -200 730 -200 {lab=f2}
N 700 -180 730 -180 {lab=f3}
N 700 -160 730 -160 {lab=f4}
N 700 -140 730 -140 {lab=f5}
N 2170 -170 2170 -150 {lab=0}
N 1730 -150 1740 -150 {lab=#net2}
N 1740 -150 1740 -130 {lab=#net2}
N 1420 -130 1740 -130 {lab=#net2}
N 1420 -190 1420 -130 {lab=#net2}
N 1420 -190 1430 -190 {lab=#net2}
N 1730 -190 1750 -190 {lab=vp}
N 1730 -170 1750 -170 {lab=0}
N 2460 -390 2460 -340 {lab=vph}
N 2460 -240 2460 -200 {lab=0}
N 2140 -360 2140 -330 {lab=vp}
N 2190 -360 2190 -330 {lab=vph}
N 2250 -290 2360 -290 {lab=aft_LS}
N 2570 -290 2690 -290 {lab=vout}
N 1730 -210 1820 -210 {lab=out_PLL_divided}
N 1890 -210 1950 -210 {lab=#net3}
N 1840 -260 1840 -240 {lab=vp}
N 1840 -180 1840 -160 {lab=0}
N 2020 -210 2080 -210 {lab=pre_LS}
N 1970 -260 1970 -240 {lab=vp}
N 1970 -180 1970 -160 {lab=0}
N 1190 -210 1430 -210 {lab=voutvco}
N 2680 -230 2680 -200 {lab=0}
N 610 -60 610 -30 {lab=0}
N -50 60 -50 80 {lab=vph}
N -140 -70 -140 -50 {lab=vp}
C {devices/code_shown.sym} 210 -390 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerMOShv.lib mos_tt



"}
C {devices/code_shown.sym} -160 -520 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp 25
.param Vp=1.2
.option klu method=gear reltol=1e-3 gmin=1e-12 abstol=1e-12 rshunt=1e12
.options cshunt=2.5f

.save v(up) v(rst) v(dn) v(voutvco) v(vco_in) v(vout) v(vp)
.control

tran 0.1n 0.2u

write aa_cp_vco2.raw

set filetype=ascii

set appendwrite
.endc
"}
C {vsource.sym} -140 -20 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -140 10 0 0 {name=l16 lab=0}
C {lab_pin.sym} -140 -60 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_pin.sym} 950 -390 0 0 {name=p2 sig_type=std_logic lab=vp}
C {gnd.sym} 950 -30 0 0 {name=l3 lab=0}
C {lab_pin.sym} 1290 -210 0 1 {name=p3 sig_type=std_logic lab=voutvco}
C {vsource.sym} 600 -530 0 0 {name=Vvp1
value=1.2 savecurrent=false}
C {vsource.sym} 670 -530 0 0 {name=Vvp2
value=1.2 savecurrent=false}
C {vsource.sym} 730 -530 0 0 {name=Vvp3
value=1.2 savecurrent=false}
C {vsource.sym} 810 -530 0 0 {name=Vvp4
value=0 savecurrent=false}
C {vsource.sym} 860 -530 0 0 {name=Vvp5
value=1.2 savecurrent=false}
C {vsource.sym} 920 -530 0 0 {name=Vvp6
value=1.2 savecurrent=false}
C {vsource.sym} 980 -530 0 0 {name=Vvp7
value=0 savecurrent=false}
C {vsource.sym} 1030 -530 0 0 {name=Vvp8
value=0 savecurrent=false}
C {gnd.sym} 770 -500 0 0 {name=l4 lab=0}
C {vsource.sym} 1090 -530 0 0 {name=Vvp9
value=0 savecurrent=false}
C {lab_wire.sym} 700 -300 2 1 {name=p4 sig_type=std_logic lab=c0}
C {lab_wire.sym} 700 -280 2 1 {name=p6 sig_type=std_logic lab=c1}
C {lab_wire.sym} 700 -260 2 1 {name=p10 sig_type=std_logic lab=c2}
C {lab_wire.sym} 700 -240 2 1 {name=p12 sig_type=std_logic lab=f0}
C {lab_wire.sym} 700 -220 2 1 {name=p18 sig_type=std_logic lab=f1}
C {lab_wire.sym} 700 -200 2 1 {name=p19 sig_type=std_logic lab=f2}
C {lab_wire.sym} 700 -180 2 1 {name=p20 sig_type=std_logic lab=f3}
C {lab_wire.sym} 700 -160 2 1 {name=p21 sig_type=std_logic lab=f4}
C {lab_wire.sym} 700 -140 2 1 {name=p22 sig_type=std_logic lab=f5}
C {lab_wire.sym} 600 -580 2 1 {name=p5 sig_type=std_logic lab=c2}
C {lab_wire.sym} 670 -580 2 1 {name=p9 sig_type=std_logic lab=c1}
C {lab_wire.sym} 730 -580 2 1 {name=p11 sig_type=std_logic lab=c0}
C {lab_wire.sym} 810 -580 2 1 {name=p13 sig_type=std_logic lab=f5}
C {lab_wire.sym} 860 -580 2 1 {name=p14 sig_type=std_logic lab=f4}
C {lab_wire.sym} 920 -580 2 1 {name=p15 sig_type=std_logic lab=f3}
C {lab_wire.sym} 980 -580 2 1 {name=p16 sig_type=std_logic lab=f2}
C {lab_wire.sym} 1030 -580 2 1 {name=p17 sig_type=std_logic lab=f1}
C {lab_wire.sym} 1090 -580 2 1 {name=p27 sig_type=std_logic lab=f0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_top.sym} 870 -210 0 0 {name=x2}
C {lab_pin.sym} 1750 -190 2 0 {name=p42 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 2460 -290 0 0 {name=xBUF}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/d_flip_flop.sym} 1580 -180 0 0 {name=xOutFlipFlop}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/level_shifter.sym} 2230 -270 0 0 {name=xLS}
C {lab_pin.sym} 2140 -360 2 0 {name=p32 sig_type=std_logic lab=vp}
C {lab_pin.sym} 2190 -360 2 0 {name=p33 sig_type=std_logic lab=vph}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x2.sym} 1850 -210 0 0 {name=x3}
C {lab_wire.sym} 1840 -260 0 0 {name=p50 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter_x4.sym} 1970 -210 0 0 {name=x4}
C {lab_wire.sym} 1970 -260 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2460 -390 0 0 {name=p35 sig_type=std_logic lab=vph}
C {lab_wire.sym} 1800 -210 0 0 {name=p57 sig_type=std_logic lab=out_PLL_divided}
C {lab_wire.sym} 2060 -210 0 0 {name=p58 sig_type=std_logic lab=pre_LS}
C {lab_wire.sym} 2320 -290 0 0 {name=p59 sig_type=std_logic lab=aft_LS}
C {capa.sym} 2680 -260 0 0 {name=C3
m=1
value=20p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 2680 -200 0 0 {name=l6 lab=0}
C {vsource.sym} 610 -90 0 0 {name=Vup1
value=0.57 savecurrent=false}
C {gnd.sym} 610 -30 0 0 {name=l1 lab=0}
C {lab_pin.sym} 2590 -290 0 1 {name=p7 sig_type=std_logic lab=vout}
C {vsource.sym} -50 110 0 0 {name=Vvp10
value=3.3 savecurrent=false}
C {gnd.sym} -50 140 0 0 {name=l2 lab=0}
C {lab_pin.sym} -50 70 0 0 {name=p8 sig_type=std_logic lab=vph}
C {gnd.sym} 2460 -200 0 0 {name=l5 lab=0}
C {gnd.sym} 2170 -150 0 0 {name=l7 lab=0}
C {gnd.sym} 1970 -160 0 0 {name=l8 lab=0}
C {gnd.sym} 1840 -160 0 0 {name=l9 lab=0}
C {gnd.sym} 1750 -170 0 0 {name=l10 lab=0}
