v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 900 -530 900 -500 {lab=vout}
N 730 -570 760 -570 {lab=vp}
N 730 -550 760 -550 {lab=vout}
N 730 -530 760 -530 {lab=0}
N 400 -550 430 -550 {lab=upb}
N 400 -570 430 -570 {lab=up}
N 1020 -530 1020 -500 {lab=vout}
C {vsource.sym} 350 -960 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 350 -930 0 0 {name=l16 lab=0}
C {lab_pin.sym} 350 -990 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 1170 -950 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 1180 -800 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.param wp=2.5u
.param wn=1.6u
.param l=0.15u
.control
tran 100p 5u
save all
plot v(vout)
write cp1_tb_3.raw
set appendwrite
show all
.endc
"}
C {vsource.sym} 510 -790 0 0 {name=Vup1
value="PULSE(1.2 0 50n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 510 -760 0 0 {name=l2 lab=0}
C {vsource.sym} 870 -790 0 0 {name=Vdn1
value="PULSE(0 1.2 150n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 870 -760 0 0 {name=l1 lab=0}
C {lab_pin.sym} 510 -820 0 1 {name=p4 sig_type=std_logic lab=up}
C {lab_pin.sym} 870 -820 0 1 {name=p5 sig_type=std_logic lab=dn}
C {capa.sym} 900 -470 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 900 -440 0 0 {name=l14 lab=0}
C {lab_pin.sym} 900 -530 0 1 {name=p24 sig_type=std_logic lab=vout}
C {lab_pin.sym} 400 -570 0 0 {name=p1 sig_type=std_logic lab=up}
C {lab_pin.sym} 400 -550 0 0 {name=p2 sig_type=std_logic lab=upb}
C {lab_pin.sym} 760 -570 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 760 -550 0 1 {name=p10 sig_type=std_logic lab=vout}
C {gnd.sym} 760 -530 0 0 {name=l7 lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp_v1_no_mirror.sym} 580 -550 0 0 {name=x1}
C {vsource.sym} 1020 -470 0 0 {name=Vvp1
value=0.6 savecurrent=false}
C {gnd.sym} 1020 -440 0 0 {name=l4 lab=0}
C {lab_pin.sym} 1020 -530 0 1 {name=p3 sig_type=std_logic lab=vout}
