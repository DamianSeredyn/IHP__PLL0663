v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -900 10 -900 20 {lab=VP}
N -900 230 -900 240 {lab=0}
N -900 80 -900 90 {lab=0}
N -900 150 -900 170 {lab=c0}
N -900 360 -900 370 {lab=0}
N -900 280 -900 300 {lab=c1}
N -900 490 -900 500 {lab=0}
N -900 410 -900 430 {lab=c2}
N -580 -170 -580 -160 {lab=0}
N -580 -250 -580 -230 {lab=f0}
N -580 -40 -580 -30 {lab=0}
N -580 -120 -580 -100 {lab=f1}
N 110 360 140 360 {lab=VP}
N 110 340 190 340 {lab=0}
N -210 360 -190 360 {lab=c1}
N -210 380 -190 380 {lab=c2}
N -210 400 -190 400 {lab=f0}
N -210 420 -190 420 {lab=f1}
N -210 340 -190 340 {lab=c0}
N -210 440 -190 440 {lab=f2}
N -210 460 -190 460 {lab=f3}
N -210 480 -190 480 {lab=f4}
N -210 500 -190 500 {lab=f5}
N 110 380 130 380 {lab=VCO_sel}
N 110 400 130 400 {lab=VCO2_11_sel}
N 110 420 130 420 {lab=VCO2_5_sel}
N 110 440 130 440 {lab=VCO3_11_sel}
N 110 460 130 460 {lab=VCO3_5_sel}
N 110 480 130 480 {lab=VCO4_11_sel}
N 110 500 130 500 {lab=VCO4_5_sel}
N 110 520 130 520 {lab=VCO5_11_sel}
N -580 100 -580 110 {lab=0}
N -580 20 -580 40 {lab=f2}
N -580 230 -580 240 {lab=0}
N -580 150 -580 170 {lab=f3}
N -580 370 -580 380 {lab=0}
N -580 290 -580 310 {lab=f4}
N -580 500 -580 510 {lab=0}
N -580 420 -580 440 {lab=f5}
C {devices/code_shown.sym} -180 -90 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -170 -20 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.options klu method=gear reltol=1e-3 gmin=1e-12 abstol=1e-12 rshunt=1e12 itl4=100
.options cshunt=1e-16
.param vdd=1.2
.control
op
print all
save all

tran 50p 801n
write VCO_decoder_tb.raw
set appendwrite




.endc
"}
C {vsource.sym} -900 50 0 0 {name=V1 value=\{vdd\} savecurrent=false}
C {vsource.sym} -900 200 0 0 {name=V_c0 value="PULSE(\{vdd\} 0 0 10p 10p 100n 200n)" savecurrent=false}
C {lab_wire.sym} -900 10 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -900 240 0 0 {name=l17 lab=0
}
C {gnd.sym} -900 90 0 0 {name=l19 lab=0
}
C {lab_wire.sym} -900 150 0 0 {name=p1 sig_type=std_logic lab=c0
}
C {vsource.sym} -580 -70 0 0 {name=V_f1 value="PULSE(\{vdd\} 0 0 10p 10p 3.125n 6.25n)" savecurrent=false}
C {gnd.sym} -900 370 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -900 280 0 0 {name=p5 sig_type=std_logic lab=c1
}
C {vsource.sym} -900 330 0 0 {name=V_c1 value="PULSE(\{vdd\} 0 0 10p 10p 200n 400n)" savecurrent=false}
C {gnd.sym} -900 500 0 0 {name=l2 lab=0
}
C {lab_wire.sym} -900 410 0 0 {name=p10 sig_type=std_logic lab=c2
}
C {vsource.sym} -900 460 0 0 {name=V_c2 value="PULSE(\{vdd\} 0 0 10p 10p 400n 800n)" savecurrent=false}
C {gnd.sym} -580 -160 0 0 {name=l3 lab=0
}
C {lab_wire.sym} -580 -250 0 0 {name=p11 sig_type=std_logic lab=f0
}
C {vsource.sym} -580 -200 0 0 {name=V_f0 value="PULSE(\{vdd\} 0 0 10p 10p 1.5625n 3.125n)" savecurrent=false}
C {gnd.sym} -580 -30 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -580 -120 0 0 {name=p12 sig_type=std_logic lab=f1
}
C {lab_wire.sym} 140 360 2 0 {name=p22 sig_type=std_logic lab=VP
}
C {gnd.sym} 190 340 0 0 {name=l9 lab=0
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/divider/VCO_decoder_cells.sym} -40 430 0 0 {name=x1}
C {lab_wire.sym} -210 360 2 1 {name=p56 sig_type=std_logic lab=c1}
C {lab_wire.sym} -210 380 2 1 {name=p58 sig_type=std_logic lab=c2}
C {lab_wire.sym} -210 400 2 1 {name=p60 sig_type=std_logic lab=f0}
C {lab_wire.sym} -210 420 2 1 {name=p63 sig_type=std_logic lab=f1}
C {lab_wire.sym} -210 340 2 1 {name=p21 sig_type=std_logic lab=c0}
C {lab_wire.sym} -210 440 2 1 {name=p2 sig_type=std_logic lab=f2}
C {lab_wire.sym} -210 460 2 1 {name=p24 sig_type=std_logic lab=f3}
C {lab_wire.sym} -210 480 2 1 {name=p26 sig_type=std_logic lab=f4}
C {lab_wire.sym} -210 500 2 1 {name=p28 sig_type=std_logic lab=f5}
C {lab_wire.sym} 130 380 2 0 {name=p3 sig_type=std_logic lab=VCO_sel
}
C {lab_wire.sym} 130 400 2 0 {name=p4 sig_type=std_logic lab=VCO2_11_sel
}
C {lab_wire.sym} 130 420 2 0 {name=p6 sig_type=std_logic lab=VCO2_5_sel
}
C {lab_wire.sym} 130 440 2 0 {name=p7 sig_type=std_logic lab=VCO3_11_sel
}
C {lab_wire.sym} 130 460 2 0 {name=p9 sig_type=std_logic lab=VCO3_5_sel
}
C {lab_wire.sym} 130 480 2 0 {name=p13 sig_type=std_logic lab=VCO4_11_sel
}
C {lab_wire.sym} 130 500 2 0 {name=p14 sig_type=std_logic lab=VCO4_5_sel
}
C {lab_wire.sym} 130 520 2 0 {name=p15 sig_type=std_logic lab=VCO5_11_sel
}
C {vsource.sym} -580 200 0 0 {name=V_f3 value="PULSE(\{vdd\} 0 0 10p 10p 12.5n 25n)" savecurrent=false}
C {gnd.sym} -580 110 0 0 {name=l5 lab=0
}
C {lab_wire.sym} -580 20 0 0 {name=p16 sig_type=std_logic lab=f2
}
C {vsource.sym} -580 70 0 0 {name=V_f2 value="PULSE(\{vdd\} 0 0 10p 10p 6.25n 12.5n)" savecurrent=false}
C {gnd.sym} -580 240 0 0 {name=l6 lab=0
}
C {lab_wire.sym} -580 150 0 0 {name=p17 sig_type=std_logic lab=f3
}
C {vsource.sym} -580 470 0 0 {name=V_f5 value="PULSE(\{vdd\} 0 0 10p 10p 50n 100n)" savecurrent=false}
C {gnd.sym} -580 380 0 0 {name=l7 lab=0
}
C {lab_wire.sym} -580 290 0 0 {name=p18 sig_type=std_logic lab=f4
}
C {vsource.sym} -580 340 0 0 {name=V_f4 value="PULSE(\{vdd\} 0 0 10p 10p 25n 50n)" savecurrent=false}
C {gnd.sym} -580 510 0 0 {name=l8 lab=0
}
C {lab_wire.sym} -580 420 0 0 {name=p19 sig_type=std_logic lab=f5
}
