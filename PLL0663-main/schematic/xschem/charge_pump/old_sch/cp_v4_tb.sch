v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 820 -150 820 -120 {lab=vout}
N 650 -170 680 -170 {lab=vp}
N 650 -150 820 -150 {lab=vout}
N 650 -130 680 -130 {lab=0}
N 320 -150 350 -150 {lab=dn}
N 320 -170 350 -170 {lab=up}
C {vsource.sym} 270 -560 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 270 -530 0 0 {name=l16 lab=0}
C {lab_pin.sym} 270 -590 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 1090 -550 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 1100 -400 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param l=0.15u
.control
tran 100p 3u
plot v(vout)
write cp1_tb.raw
set appendwrite
show all
.endc
"}
C {capa.sym} 820 -90 0 0 {name=C1
m=1
value=20p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 820 -60 0 0 {name=l14 lab=0}
C {lab_pin.sym} 820 -150 0 1 {name=p24 sig_type=std_logic lab=vout}
C {lab_pin.sym} 320 -170 0 0 {name=p1 sig_type=std_logic lab=up}
C {lab_pin.sym} 320 -150 0 0 {name=p2 sig_type=std_logic lab=dn}
C {lab_pin.sym} 680 -170 0 1 {name=p9 sig_type=std_logic lab=vp}
C {gnd.sym} 680 -130 0 0 {name=l7 lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp_v4.sym} 500 -150 0 0 {name=x1}
C {vsource.sym} 410 -520 0 0 {name=Vup2
value="PULSE(1.2 0 50n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 410 -490 0 0 {name=l3 lab=0}
C {vsource.sym} 770 -520 0 0 {name=Vdn2
value="PULSE(0 1.2 150n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 770 -490 0 0 {name=l4 lab=0}
C {lab_pin.sym} 410 -550 0 1 {name=p3 sig_type=std_logic lab=up}
C {lab_pin.sym} 770 -550 0 1 {name=p6 sig_type=std_logic lab=dn}
