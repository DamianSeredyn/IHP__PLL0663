v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 840 -180 840 -150 {lab=vout}
N 670 -200 700 -200 {lab=vp}
N 670 -180 840 -180 {lab=vout}
N 670 -160 700 -160 {lab=0}
N 340 -140 370 -140 {lab=dn}
N 340 -160 370 -160 {lab=dnb}
N 340 -180 370 -180 {lab=upb}
N 340 -200 370 -200 {lab=up}
C {vsource.sym} 290 -590 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 290 -560 0 0 {name=l16 lab=0}
C {vsource.sym} 180 -590 0 0 {name=VVbn
value=0.7V savecurrent=false}
C {gnd.sym} 180 -560 0 0 {name=l5 lab=0}
C {lab_pin.sym} 180 -620 0 1 {name=p45 sig_type=std_logic lab=Vbn}
C {lab_pin.sym} 290 -620 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 1110 -580 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 1120 -430 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param l=0.15u
.control
op
write cp1_tb.raw
set appendwrite
show all
.endc
"}
C {capa.sym} 840 -120 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 840 -90 0 0 {name=l14 lab=0}
C {lab_pin.sym} 840 -180 0 1 {name=p24 sig_type=std_logic lab=vout}
C {lab_pin.sym} 340 -200 0 0 {name=p1 sig_type=std_logic lab=up}
C {lab_pin.sym} 340 -180 0 0 {name=p2 sig_type=std_logic lab=upb}
C {lab_pin.sym} 340 -160 0 0 {name=p6 sig_type=std_logic lab=dnb}
C {lab_pin.sym} 340 -140 0 0 {name=p7 sig_type=std_logic lab=dn}
C {lab_pin.sym} 700 -200 0 1 {name=p9 sig_type=std_logic lab=vp}
C {gnd.sym} 700 -160 0 0 {name=l7 lab=0}
C {vsource.sym} 80 -590 0 0 {name=VVbn1
value=0.5V savecurrent=false}
C {gnd.sym} 80 -560 0 0 {name=l4 lab=0}
C {lab_pin.sym} 80 -620 0 1 {name=p13 sig_type=std_logic lab=Vbp}
C {vsource.sym} 440 -360 0 0 {name=Vup3
value=0 savecurrent=false}
C {gnd.sym} 440 -330 0 0 {name=l8 lab=0}
C {vsource.sym} 800 -360 0 0 {name=Vdn3
value=0 savecurrent=false}
C {gnd.sym} 800 -330 0 0 {name=l9 lab=0}
C {lab_pin.sym} 440 -390 0 1 {name=p10 sig_type=std_logic lab=up}
C {lab_pin.sym} 800 -390 0 1 {name=p14 sig_type=std_logic lab=dn}
C {vsource.sym} 440 -470 0 0 {name=Vup4
value=1 savecurrent=false}
C {gnd.sym} 440 -440 0 0 {name=l10 lab=0}
C {vsource.sym} 800 -470 0 0 {name=Vdn4
value=1 savecurrent=false}
C {gnd.sym} 800 -440 0 0 {name=l11 lab=0}
C {lab_pin.sym} 440 -500 0 1 {name=p15 sig_type=std_logic lab=upb}
C {lab_pin.sym} 800 -500 0 1 {name=p16 sig_type=std_logic lab=dnb}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp_v1_no_mirror.sym} 520 -170 0 0 {name=x1}
C {vsource.sym} 770 -150 0 0 {name=Vdn1
value=0.8 savecurrent=false}
C {gnd.sym} 770 -120 0 0 {name=l1 lab=0}
