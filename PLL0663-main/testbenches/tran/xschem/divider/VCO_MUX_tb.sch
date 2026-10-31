v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -340 -120 -340 -110 {lab=VP}
N -590 -60 -590 -50 {lab=0}
N -240 60 -240 80 {lab=VCO_sel}
N -240 140 -240 150 {lab=0}
N -340 -50 -340 -40 {lab=0}
N -590 -140 -590 -120 {lab=VCO}
N 180 120 200 120 {lab=VCO}
N 180 140 200 140 {lab=VCO2}
N 180 160 200 160 {lab=VCO3}
N 180 180 200 180 {lab=VCO4}
N 180 200 200 200 {lab=VCO5}
N -590 70 -590 80 {lab=0}
N -590 -10 -590 10 {lab=VCO2}
N -590 200 -590 210 {lab=0}
N -590 120 -590 140 {lab=VCO3}
N -590 330 -590 340 {lab=0}
N -590 250 -590 270 {lab=VCO4}
N -590 460 -590 470 {lab=0}
N -590 380 -590 400 {lab=VCO5}
N -240 200 -240 220 {lab=VCO2_sel}
N -240 280 -240 290 {lab=0}
N 180 220 200 220 {lab=VCO_sel}
N 180 240 200 240 {lab=VCO2_sel}
N 180 260 200 260 {lab=VCO3_sel}
N 180 280 200 280 {lab=VCO4_sel}
N 180 300 200 300 {lab=VCO5_sel}
N -240 340 -240 360 {lab=VCO3_sel}
N -240 420 -240 430 {lab=0}
N -90 60 -90 80 {lab=VCO4_sel}
N -90 140 -90 150 {lab=0}
N -90 200 -90 220 {lab=VCO5_sel}
N -90 280 -90 290 {lab=0}
N 500 140 530 140 {lab=VP}
N 500 120 580 120 {lab=0}
N 520 160 520 230 {lab=#net1}
N 500 160 520 160 {lab=#net1}
N 520 230 530 230 {lab=#net1}
N 600 230 620 230 {lab=#net2}
N 550 170 550 200 {lab=VP}
N 550 260 550 280 {lab=0}
N 690 230 710 230 {lab=out}
N 640 170 640 200 {lab=VP}
N 640 260 640 280 {lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/VCO_MUX.sym} 350 210 0 0 {name=x1}
C {devices/code_shown.sym} 180 -340 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 190 -280 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.control

op
print all
save all

tran 50p 1.11u
write VCO_MUX_tb.raw
set appendwrite




.endc
"}
C {vsource.sym} -340 -80 0 0 {name=V1 value=\{vdd\} savecurrent=false}
C {vsource.sym} -590 -90 0 0 {name=VCO value="PULSE(\{vdd\} 0 0 10p 10p 0.83n 1.66n)" savecurrent=false}
C {lab_wire.sym} -340 -120 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -240 110 0 0 {name=V3 value="PWL(
+ 0 \{vdd\}
+ 40n \{vdd\}
+ 40.01n 0)" savecurrent=false}
C {lab_wire.sym} -240 60 0 0 {name=p6 sig_type=std_logic lab=VCO_sel
}
C {gnd.sym} -590 -50 0 0 {name=l17 lab=0
}
C {gnd.sym} -240 150 0 0 {name=l18 lab=0
}
C {gnd.sym} -340 -40 0 0 {name=l19 lab=0
}
C {lab_wire.sym} -590 -140 0 0 {name=p1 sig_type=std_logic lab=VCO
}
C {lab_wire.sym} 180 120 0 0 {name=p2 sig_type=std_logic lab=VCO
}
C {lab_wire.sym} 180 140 0 0 {name=p3 sig_type=std_logic lab=VCO2
}
C {lab_wire.sym} 180 160 0 0 {name=p4 sig_type=std_logic lab=VCO3
}
C {lab_wire.sym} 180 180 0 0 {name=p7 sig_type=std_logic lab=VCO4
}
C {lab_wire.sym} 180 200 0 0 {name=p9 sig_type=std_logic lab=VCO5
}
C {vsource.sym} -590 430 0 0 {name=VCO5 value="PULSE(\{vdd\} 0 0 10p 10p 25n 50n)" savecurrent=false}
C {gnd.sym} -590 80 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -590 -10 0 0 {name=p5 sig_type=std_logic lab=VCO2
}
C {vsource.sym} -590 40 0 0 {name=VCO2 value="PULSE(\{vdd\} 0 0 10p 10p 3.125n 6.25n)" savecurrent=false}
C {gnd.sym} -590 210 0 0 {name=l2 lab=0
}
C {lab_wire.sym} -590 120 0 0 {name=p10 sig_type=std_logic lab=VCO3
}
C {vsource.sym} -590 170 0 0 {name=VCO3 value="PULSE(\{vdd\} 0 0 10p 10p 6.25n 12.5n)" savecurrent=false}
C {gnd.sym} -590 340 0 0 {name=l3 lab=0
}
C {lab_wire.sym} -590 250 0 0 {name=p11 sig_type=std_logic lab=VCO4
}
C {vsource.sym} -590 300 0 0 {name=VCO4 value="PULSE(\{vdd\} 0 0 10p 10p 12.5n 25n)" savecurrent=false}
C {gnd.sym} -590 470 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -590 380 0 0 {name=p12 sig_type=std_logic lab=VCO5
}
C {vsource.sym} -240 250 0 0 {name=V2 value="PWL(
+ 0 0
+ 40n 0
+ 40.01n \{vdd\}
+ 110n \{vdd\}
+ 110.01n 0)" savecurrent=false}
C {lab_wire.sym} -240 200 0 0 {name=p13 sig_type=std_logic lab=VCO2_sel
}
C {gnd.sym} -240 290 0 0 {name=l5 lab=0
}
C {lab_wire.sym} 180 220 0 0 {name=p14 sig_type=std_logic lab=VCO_sel
}
C {lab_wire.sym} 180 240 0 0 {name=p15 sig_type=std_logic lab=VCO2_sel
}
C {vsource.sym} -240 390 0 0 {name=V4 value="PWL(
+ 0 0
+ 110n 0
+ 110.01n \{vdd\}
+ 240n \{vdd\}
+ 240.01n 0)" savecurrent=false}
C {lab_wire.sym} -240 340 0 0 {name=p16 sig_type=std_logic lab=VCO3_sel
}
C {gnd.sym} -240 430 0 0 {name=l6 lab=0
}
C {lab_wire.sym} 180 260 0 0 {name=p17 sig_type=std_logic lab=VCO3_sel
}
C {vsource.sym} -90 110 0 0 {name=V5 value="PWL(
+ 0 0
+ 240n 0
+ 240.01n \{vdd\}
+ 500n \{vdd\}
+ 500.01n 0)" savecurrent=false}
C {lab_wire.sym} -90 60 0 0 {name=p18 sig_type=std_logic lab=VCO4_sel
}
C {gnd.sym} -90 150 0 0 {name=l7 lab=0
}
C {lab_wire.sym} 180 280 0 0 {name=p19 sig_type=std_logic lab=VCO4_sel
}
C {vsource.sym} -90 250 0 0 {name=V6 value="PWL(
+ 0 0
+ 500n 0
+ 500.01n \{vdd\}
+ 1100n \{vdd\}
+ 1100.01n 0)" savecurrent=false}
C {lab_wire.sym} -90 200 0 0 {name=p20 sig_type=std_logic lab=VCO5_sel
}
C {gnd.sym} -90 290 0 0 {name=l8 lab=0
}
C {lab_wire.sym} 180 300 0 0 {name=p21 sig_type=std_logic lab=VCO5_sel
}
C {lab_wire.sym} 530 140 2 0 {name=p22 sig_type=std_logic lab=VP
}
C {gnd.sym} 580 120 0 0 {name=l9 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 550 230 0 0 {name=x2}
C {lab_wire.sym} 550 170 2 0 {name=p27 sig_type=std_logic lab=VP
}
C {gnd.sym} 550 280 0 0 {name=l10 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/inverter.sym} 640 230 0 0 {name=x3}
C {gnd.sym} 640 280 0 0 {name=l11 lab=0
}
C {lab_wire.sym} 640 170 2 0 {name=p23 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 710 230 2 0 {name=p24 sig_type=std_logic lab=out
}
