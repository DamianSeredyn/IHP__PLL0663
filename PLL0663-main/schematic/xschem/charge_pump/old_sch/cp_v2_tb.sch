v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1110 -640 1110 -470 {lab=vout}
N 700 -640 1110 -640 {lab=vout}
N 700 -660 740 -660 {lab=vp}
N 700 -620 740 -620 {lab=0}
N 360 -660 400 -660 {lab=upb}
N 360 -640 400 -640 {lab=dn}
C {capa.sym} 1110 -440 0 0 {name=C1
m=1
value=20p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1110 -410 0 0 {name=l14 lab=0}
C {lab_pin.sym} 1110 -470 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 190 -820 0 0 {name=VP
value=1.2 savecurrent=false}
C {gnd.sym} 190 -790 0 0 {name=l16 lab=0}
C {lab_pin.sym} 190 -850 0 0 {name=p10 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 1150 -840 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 1160 -690 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param wp=2.92u
.param wn=2u
.param l=0.15u
.control
tran 100p 3u
plot v(vout)
write cp2_tb.raw
set appendwrite
plot Vtest1 Vtest2
show all
.endc
"}
C {lab_pin.sym} 360 -660 0 0 {name=p1 sig_type=std_logic lab=upb}
C {lab_pin.sym} 360 -640 0 0 {name=p2 sig_type=std_logic lab=dn}
C {lab_pin.sym} 740 -660 0 1 {name=p3 sig_type=std_logic lab=vp}
C {gnd.sym} 740 -620 0 0 {name=l1 lab=0}
C {vsource.sym} 440 -850 0 0 {name=Vupb
value="PULSE(1.2 0 50n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 440 -820 0 0 {name=l2 lab=0}
C {vsource.sym} 800 -850 0 0 {name=Vdn
value="PULSE(0 1.2 150n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 800 -820 0 0 {name=l3 lab=0}
C {lab_pin.sym} 440 -880 0 1 {name=p4 sig_type=std_logic lab=upb}
C {lab_pin.sym} 800 -880 0 1 {name=p5 sig_type=std_logic lab=dn}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp2_cs.sym} 550 -640 0 0 {name=x1}
