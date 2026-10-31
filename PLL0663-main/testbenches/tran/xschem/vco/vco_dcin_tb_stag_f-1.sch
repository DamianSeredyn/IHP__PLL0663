v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 250 -160 290 {lab=0}
N -240 250 -240 290 {lab=0}
N -240 150 -240 190 {lab=vdd}
N -160 150 -160 190 {lab=in}
N 4430 -70 4470 -70 {lab=out}
N 4570 -160 4570 -120 {lab=vdd}
N 4570 -20 4570 20 {lab=0}
N 4680 -70 4720 -70 {lab=out_pb}
N 70 40 150 40 {lab=in}
N 150 -130 190 -130 {lab=pgt}
N 190 -130 190 10 {lab=pgt}
N 4240 -70 4310 -70 {lab=out}
N 330 -70 370 -70 {lab=out}
N 330 -110 370 -110 {lab=pgt}
N 330 -30 370 -30 {lab=in}
N 510 -180 510 -130 {lab=vdd}
N 510 -10 510 40 {lab=0}
N 650 -70 690 -70 {lab=1-2}
N 650 -110 690 -110 {lab=pgt}
N 650 -30 690 -30 {lab=in}
N 830 -180 830 -130 {lab=vdd}
N 830 -10 830 40 {lab=0}
N 970 -70 1010 -70 {lab=2-3}
N 970 -110 1010 -110 {lab=pgt}
N 970 -30 1010 -30 {lab=in}
N 1150 -180 1150 -130 {lab=vdd}
N 1150 -10 1150 40 {lab=0}
N 1290 -70 1330 -70 {lab=3-4}
N 1290 -110 1330 -110 {lab=pgt}
N 1290 -30 1330 -30 {lab=in}
N 1470 -180 1470 -130 {lab=vdd}
N 1470 -10 1470 40 {lab=0}
N 3920 -110 3960 -110 {lab=pgt}
N 3920 -30 3960 -30 {lab=in}
N 4100 -180 4100 -130 {lab=vdd}
N 4100 -10 4100 40 {lab=0}
N 190 40 190 120 {lab=gnd}
N 150 -180 150 -130 {lab=pgt}
N 190 -150 190 -130 {lab=pgt}
N 190 -260 190 -180 {lab=vdd}
N 1860 -480 1860 -430 {lab=vdd}
N 1860 -310 1860 -260 {lab=0}
N 2200 -480 2200 -430 {lab=vdd}
N 2200 -310 2200 -260 {lab=0}
N 1700 -410 1720 -410 {lab=pgt}
N 1700 -330 1720 -330 {lab=in}
N 2040 -410 2060 -410 {lab=pgt}
N 2040 -330 2060 -330 {lab=in}
N 2000 -370 2060 -370 {lab=#net1}
N 2590 -480 2590 -430 {lab=vdd}
N 2590 -310 2590 -260 {lab=0}
N 2340 -370 2450 -370 {lab=#net2}
N 2930 -480 2930 -430 {lab=vdd}
N 2930 -310 2930 -260 {lab=0}
N 2430 -410 2450 -410 {lab=pgt}
N 2430 -330 2450 -330 {lab=in}
N 2770 -410 2790 -410 {lab=pgt}
N 2770 -330 2790 -330 {lab=in}
N 2730 -370 2790 -370 {lab=#net3}
N 3320 -480 3320 -430 {lab=vdd}
N 3320 -310 3320 -260 {lab=0}
N 3070 -370 3180 -370 {lab=#net4}
N 3660 -480 3660 -430 {lab=vdd}
N 3660 -310 3660 -260 {lab=0}
N 3160 -410 3180 -410 {lab=pgt}
N 3160 -330 3180 -330 {lab=in}
N 3500 -410 3520 -410 {lab=pgt}
N 3500 -330 3520 -330 {lab=in}
N 3460 -370 3520 -370 {lab=#net5}
N 1650 -70 1750 -70 {lab=#net6}
N 1650 -370 1720 -370 {lab=#net7}
N 3850 -370 3960 -370 {lab=#net8}
N 3850 -70 3960 -70 {lab=4-5}
N 1560 -210 1610 -210 {lab=en11}
N 1560 -190 1610 -190 {lab=gnd}
N 3760 -230 3810 -230 {lab=en11}
N 3760 -210 3810 -210 {lab=gnd}
N 1660 -100 1710 -100 {lab=en5}
N 1660 -80 1710 -80 {lab=gnd}
N 1650 -180 1650 -70 {lab=#net6}
N 1610 -70 1650 -70 {lab=#net6}
N 1650 -370 1650 -240 {lab=#net7}
N 1610 -370 1650 -370 {lab=#net7}
N 3850 -370 3850 -260 {lab=#net8}
N 3800 -370 3850 -370 {lab=#net8}
N 3850 -200 3850 -70 {lab=4-5}
N 3820 -70 3850 -70 {lab=4-5}
N 1750 -130 3630 -70 {lab=#net9}
N 3630 -10 3820 -70 {lab=4-5}
N 3550 -20 3590 -20 {lab=gnd}
N 3550 -40 3590 -40 {lab=en5}
N -30 200 20 200 {lab=en11}
N -30 260 20 260 {lab=gnd}
N 110 200 160 200 {lab=en5}
N 110 260 160 260 {lab=gnd}
C {vsource.sym} -160 220 0 0 {name=V1 value=\{vin\} savecurrent=false}
C {vsource.sym} -240 220 0 0 {name=V2 value=\{vdd\} savecurrent=false}
C {devices/code_shown.sym} -290 -400 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -240 150 0 0 {name=p1 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 4450 -70 0 0 {name=p3 sig_type=std_logic lab=out
}
C {gnd.sym} -160 290 0 0 {name=l2 lab=0
}
C {connector.sym} 4720 -70 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} 4720 -70 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 4570 -70 0 0 {name=x1}
C {lab_wire.sym} 4570 -160 0 0 {name=p5 sig_type=std_logic lab=vdd
}
C {gnd.sym} -240 290 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -160 150 0 0 {name=p6 sig_type=std_logic lab=in
}
C {gnd.sym} 4570 20 0 0 {name=l1 lab=0
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 40 0 0 {name=M1
l=\{Lcs\}
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 170 -180 0 0 {name=q
l=\{Lcs\}
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} 70 40 0 0 {name=p2 lab=in}
C {opin.sym} 4310 -70 0 0 {name=p7 lab=out}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 510 -70 0 0 {name=x2}
C {lab_wire.sym} 350 -70 0 0 {name=p8 sig_type=std_logic lab=out
}
C {lab_wire.sym} 350 -110 0 0 {name=p10 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 350 -30 0 0 {name=p11 sig_type=std_logic lab=in
}
C {lab_wire.sym} 190 -260 0 0 {name=p12 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 510 -180 0 0 {name=p13 sig_type=std_logic lab=vdd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 830 -70 0 0 {name=x3}
C {lab_wire.sym} 670 -70 0 0 {name=p9 sig_type=std_logic lab=1-2
}
C {lab_wire.sym} 670 -110 0 0 {name=p14 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 670 -30 0 0 {name=p16 sig_type=std_logic lab=in
}
C {lab_wire.sym} 830 -180 0 0 {name=p17 sig_type=std_logic lab=vdd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1150 -70 0 0 {name=x4}
C {lab_wire.sym} 990 -70 0 0 {name=p19 sig_type=std_logic lab=2-3
}
C {lab_wire.sym} 990 -110 0 0 {name=p20 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 990 -30 0 0 {name=p21 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1150 -180 0 0 {name=p22 sig_type=std_logic lab=vdd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1470 -70 0 0 {name=x5}
C {lab_wire.sym} 1310 -70 0 0 {name=p24 sig_type=std_logic lab=3-4
}
C {lab_wire.sym} 1310 -110 0 0 {name=p25 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1310 -30 0 0 {name=p26 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1470 -180 0 0 {name=p27 sig_type=std_logic lab=vdd
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 4100 -70 0 0 {name=x6}
C {lab_wire.sym} 3940 -70 0 0 {name=p29 sig_type=std_logic lab=4-5
}
C {lab_wire.sym} 3940 -110 0 0 {name=p30 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3940 -30 0 0 {name=p31 sig_type=std_logic lab=in
}
C {lab_wire.sym} 4100 -180 0 0 {name=p32 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 190 120 0 0 {name=p34 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 190 -60 0 0 {name=p35 sig_type=std_logic lab=pgt
}
C {gnd.sym} 510 40 0 0 {name=l7 lab=0
}
C {gnd.sym} 830 40 0 0 {name=l3 lab=0
}
C {gnd.sym} 1150 40 0 0 {name=l6 lab=0
}
C {gnd.sym} 1470 40 0 0 {name=l8 lab=0
}
C {gnd.sym} 4100 40 0 0 {name=l9 lab=0
}
C {devices/code_shown.sym} -300 -320 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.param vin=0.4
.param Lcs=12*4u
.param Ldrv=12*2u
.param enable11=0
.param enable5=1

.control

tran 40p 700n
write vco_tb.raw
set appendwrite
plot out
plot out_pb
.endc
"}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1860 -370 0 0 {name=x7}
C {lab_wire.sym} 1700 -410 0 0 {name=p18 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1700 -330 0 0 {name=p23 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1860 -480 0 0 {name=p28 sig_type=std_logic lab=vdd
}
C {gnd.sym} 1860 -260 0 0 {name=l5 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 2200 -370 0 0 {name=x8}
C {lab_wire.sym} 2040 -410 0 0 {name=p15 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2040 -330 0 0 {name=p33 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2200 -480 0 0 {name=p36 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2200 -260 0 0 {name=l10 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 2590 -370 0 0 {name=x9}
C {lab_wire.sym} 2430 -410 0 0 {name=p37 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2430 -330 0 0 {name=p38 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2590 -480 0 0 {name=p39 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2590 -260 0 0 {name=l11 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 2930 -370 0 0 {name=x10}
C {lab_wire.sym} 2770 -410 0 0 {name=p40 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2770 -330 0 0 {name=p41 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2930 -480 0 0 {name=p42 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2930 -260 0 0 {name=l12 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 3320 -370 0 0 {name=x11}
C {lab_wire.sym} 3160 -410 0 0 {name=p43 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3160 -330 0 0 {name=p44 sig_type=std_logic lab=in
}
C {lab_wire.sym} 3320 -480 0 0 {name=p45 sig_type=std_logic lab=vdd
}
C {gnd.sym} 3320 -260 0 0 {name=l13 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 3660 -370 0 0 {name=x12}
C {lab_wire.sym} 3500 -410 0 0 {name=p46 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3500 -330 0 0 {name=p47 sig_type=std_logic lab=in
}
C {lab_wire.sym} 3660 -480 0 0 {name=p48 sig_type=std_logic lab=vdd
}
C {gnd.sym} 3660 -260 0 0 {name=l14 lab=0
}
C {noconn.sym} 1610 -370 0 0 {name=l16}
C {noconn.sym} 3960 -370 0 0 {name=l15}
C {lab_wire.sym} 1610 -210 0 0 {name=p49 sig_type=std_logic lab=en11
}
C {lab_wire.sym} 1610 -190 0 0 {name=p50 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 1650 -210 0 0 {name=S1 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {lab_wire.sym} 3810 -230 0 0 {name=p51 sig_type=std_logic lab=en11
}
C {lab_wire.sym} 3810 -210 0 0 {name=p52 sig_type=std_logic lab=gnd
}
C {switch_ngspice.sym} 3850 -230 0 0 {name=S2 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {switch_ngspice.sym} 1750 -100 0 0 {name=S3 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {switch_ngspice.sym} 3630 -40 0 0 {name=S4 model=SW1
device_model=".MODEL SW1 SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G "}
C {lab_wire.sym} 1700 -100 0 0 {name=p53 sig_type=std_logic lab=en5
}
C {lab_wire.sym} 1700 -80 0 0 {name=p54 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 3580 -40 0 0 {name=p55 sig_type=std_logic lab=en5
}
C {lab_wire.sym} 3580 -20 0 0 {name=p56 sig_type=std_logic lab=gnd
}
C {vsource.sym} -30 230 0 0 {name=V3 value=\{enable11\} savecurrent=false}
C {lab_wire.sym} 20 200 0 0 {name=p57 sig_type=std_logic lab=en11
value=\{enable11\}}
C {lab_wire.sym} 20 260 0 0 {name=p58 sig_type=std_logic lab=gnd
value=\{enable11\}}
C {vsource.sym} 110 230 0 0 {name=V4 value=\{enable5\} savecurrent=false}
C {lab_wire.sym} 160 200 0 0 {name=p59 sig_type=std_logic lab=en5
value=\{enable5\}}
C {lab_wire.sym} 160 260 0 0 {name=p60 sig_type=std_logic lab=gnd
value=\{enable11\}}
