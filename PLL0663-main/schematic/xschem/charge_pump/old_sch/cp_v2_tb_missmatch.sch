v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1030 -380 1030 -210 {lab=vout}
N 620 -400 660 -400 {lab=vp}
N 620 -360 660 -360 {lab=0}
N 280 -400 320 -400 {lab=upb}
N 280 -380 320 -380 {lab=dn}
N 890 -380 1030 -380 {lab=vout}
N 890 -380 890 -350 {lab=vout}
N 620 -380 890 -380 {lab=vout}
C {capa.sym} 1030 -180 0 0 {name=C1
m=1
value=50p
ic=0.8V
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1030 -150 0 0 {name=l14 lab=0}
C {lab_pin.sym} 1030 -210 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 110 -560 0 0 {name=VP
value=1.2 savecurrent=false}
C {gnd.sym} 110 -530 0 0 {name=l16 lab=0}
C {lab_pin.sym} 110 -590 0 0 {name=p10 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 1070 -580 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 1080 -430 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param wp=2u
.param wn=1.8u
.param l=0.15u
.control
tran 100p 3u
plot v(vout)
show all
set appendwrite
write cp2_tb2g.raw
.endc
"}
C {lab_pin.sym} 280 -400 0 0 {name=p1 sig_type=std_logic lab=upb}
C {lab_pin.sym} 280 -380 0 0 {name=p2 sig_type=std_logic lab=dn}
C {lab_pin.sym} 660 -400 0 1 {name=p3 sig_type=std_logic lab=vp}
C {gnd.sym} 660 -360 0 0 {name=l1 lab=0}
C {vsource.sym} 390 -700 0 0 {name=Vupb1
value="PULSE(1.2 0 100n 10p 10p 40n 200n)" savecurrent=false}
C {gnd.sym} 390 -670 0 0 {name=l4 lab=0}
C {vsource.sym} 750 -700 0 0 {name=Vdn1
value="PULSE(0 1.2 200n 10p 10p 40n 200n)" savecurrent=false}
C {gnd.sym} 750 -670 0 0 {name=l5 lab=0}
C {lab_pin.sym} 390 -730 0 1 {name=p6 sig_type=std_logic lab=upb}
C {lab_pin.sym} 750 -730 0 1 {name=p7 sig_type=std_logic lab=dn}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp2_simple_ideal.sym} 470 -380 0 0 {name=x2}
