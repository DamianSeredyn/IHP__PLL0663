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
N 1470 480 1510 480 {lab=out}
N 1610 390 1610 430 {lab=vdd}
N 1610 530 1610 570 {lab=0}
N 1720 480 1760 480 {lab=out_pb}
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
N 1920 -750 1920 -700 {lab=vdd}
N 1920 -580 1920 -530 {lab=0}
N 2260 -750 2260 -700 {lab=vdd}
N 2260 -580 2260 -530 {lab=0}
N 1760 -680 1780 -680 {lab=pgt}
N 1760 -600 1780 -600 {lab=in}
N 2100 -680 2120 -680 {lab=pgt}
N 2100 -600 2120 -600 {lab=in}
N 2060 -640 2120 -640 {lab=#net1}
N 2650 -750 2650 -700 {lab=vdd}
N 2650 -580 2650 -530 {lab=0}
N 2400 -640 2510 -640 {lab=#net2}
N 2990 -750 2990 -700 {lab=vdd}
N 2990 -580 2990 -530 {lab=0}
N 2490 -680 2510 -680 {lab=pgt}
N 2490 -600 2510 -600 {lab=in}
N 2830 -680 2850 -680 {lab=pgt}
N 2830 -600 2850 -600 {lab=in}
N 2790 -640 2850 -640 {lab=#net3}
N 3380 -750 3380 -700 {lab=vdd}
N 3380 -580 3380 -530 {lab=0}
N 3130 -640 3240 -640 {lab=#net4}
N 3720 -750 3720 -700 {lab=vdd}
N 3720 -580 3720 -530 {lab=0}
N 3220 -680 3240 -680 {lab=pgt}
N 3220 -600 3240 -600 {lab=in}
N 3560 -680 3580 -680 {lab=pgt}
N 3560 -600 3580 -600 {lab=in}
N 3520 -640 3580 -640 {lab=#net5}
N 3900 -640 3900 -630 {lab=4-5}
N 1710 -640 1780 -640 {lab=4-5}
N 3880 -640 3900 -640 {lab=4-5}
N 3870 -70 3960 -70 {lab=4-5}
N 1710 -640 1710 -70 {lab=4-5}
N 1670 -640 1710 -640 {lab=4-5}
N 1610 -70 1710 -70 {lab=4-5}
N 3870 -70 3880 -640 {lab=4-5}
N 3860 -640 3880 -640 {lab=4-5}
C {vsource.sym} -160 220 0 0 {name=V1 value=\{vin\} savecurrent=false}
C {vsource.sym} -240 220 0 0 {name=V2 value=\{vdd\} savecurrent=false}
C {devices/code_shown.sym} -290 -400 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -240 150 0 0 {name=p1 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 1490 480 0 0 {name=p3 sig_type=std_logic lab=out
}
C {gnd.sym} -160 290 0 0 {name=l2 lab=0
}
C {connector.sym} 1760 480 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} 1760 480 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/buf/buf.sym} 1610 480 0 0 {name=x1}
C {lab_wire.sym} 1610 390 0 0 {name=p5 sig_type=std_logic lab=vdd
}
C {gnd.sym} -240 290 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -160 150 0 0 {name=p6 sig_type=std_logic lab=in
}
C {gnd.sym} 1610 570 0 0 {name=l1 lab=0
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 40 0 0 {name=M1
l=\{Lcs\}
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 170 -180 0 0 {name=M2
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
.param Lcs=0.32*4u
.param Ldrv=0.32*2u

.control

tran 40p 700n
write vco_tb.raw
set appendwrite
plot out
plot out_pb
.endc
"}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 1920 -640 0 0 {name=x7}
C {lab_wire.sym} 1760 -680 0 0 {name=p18 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1760 -600 0 0 {name=p23 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1920 -750 0 0 {name=p28 sig_type=std_logic lab=vdd
}
C {gnd.sym} 1920 -530 0 0 {name=l5 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 2260 -640 0 0 {name=x8}
C {lab_wire.sym} 2100 -680 0 0 {name=p15 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2100 -600 0 0 {name=p33 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2260 -750 0 0 {name=p36 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2260 -530 0 0 {name=l10 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 2650 -640 0 0 {name=x9}
C {lab_wire.sym} 2490 -680 0 0 {name=p37 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2490 -600 0 0 {name=p38 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2650 -750 0 0 {name=p39 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2650 -530 0 0 {name=l11 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 2990 -640 0 0 {name=x10}
C {lab_wire.sym} 2830 -680 0 0 {name=p40 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2830 -600 0 0 {name=p41 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2990 -750 0 0 {name=p42 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2990 -530 0 0 {name=l12 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 3380 -640 0 0 {name=x11}
C {lab_wire.sym} 3220 -680 0 0 {name=p43 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3220 -600 0 0 {name=p44 sig_type=std_logic lab=in
}
C {lab_wire.sym} 3380 -750 0 0 {name=p45 sig_type=std_logic lab=vdd
}
C {gnd.sym} 3380 -530 0 0 {name=l13 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_delay_cell.sym} 3720 -640 0 0 {name=x12}
C {lab_wire.sym} 3560 -680 0 0 {name=p46 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3560 -600 0 0 {name=p47 sig_type=std_logic lab=in
}
C {lab_wire.sym} 3720 -750 0 0 {name=p48 sig_type=std_logic lab=vdd
}
C {gnd.sym} 3720 -530 0 0 {name=l14 lab=0
}
C {noconn.sym} 3900 -630 0 0 {name=l15}
C {noconn.sym} 1670 -640 0 0 {name=l16}
