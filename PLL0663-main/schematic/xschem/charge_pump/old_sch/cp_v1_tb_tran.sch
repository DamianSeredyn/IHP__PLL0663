v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 650 -140 650 -110 {lab=vout}
N 480 -180 510 -180 {lab=vp}
N 480 -160 510 -160 {lab=vout}
N 480 -140 510 -140 {lab=0}
N 150 -160 180 -160 {lab=dn}
N 150 -180 180 -180 {lab=up}
C {vsource.sym} 120 -360 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 120 -330 0 0 {name=l16 lab=0}
C {lab_pin.sym} 120 -390 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 920 -560 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 930 -410 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.param l=0.15u
.param Vp=1.2
.control

op
tran 100p 5u
save all
write cp_test.raw
set filetype=ascii
wrdata cp_test.txt time v(vout) i(v.x1.vip) i(v.x1.vin) v(x1.biasp) v(x1.biasn) i(Vdn2) i(Vup2) i(Vvp) v(up) v(dn)
set appendwrite
.endc
"}
C {capa.sym} 650 -80 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 650 -50 0 0 {name=l14 lab=0}
C {lab_pin.sym} 650 -140 0 1 {name=p24 sig_type=std_logic lab=vout}
C {lab_pin.sym} 150 -180 0 0 {name=p1 sig_type=std_logic lab=up}
C {lab_pin.sym} 510 -180 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 510 -160 0 1 {name=p10 sig_type=std_logic lab=vout}
C {gnd.sym} 510 -140 0 0 {name=l7 lab=0}
C {lab_pin.sym} 150 -160 0 0 {name=p2 sig_type=std_logic lab=dn}
C {vsource.sym} 270 -360 0 0 {name=Vup2
value="PULSE(1.2 0 50n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 270 -330 0 0 {name=l4 lab=0}
C {vsource.sym} 630 -360 0 0 {name=Vdn2
value="PULSE(0 1.2 150n 10p 10p 30n 200n)" savecurrent=false}
C {gnd.sym} 630 -330 0 0 {name=l5 lab=0}
C {lab_pin.sym} 270 -390 0 1 {name=p6 sig_type=std_logic lab=up}
C {lab_pin.sym} 630 -390 0 1 {name=p7 sig_type=std_logic lab=dn}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp_v1_no_mirror.sym} 330 -160 0 0 {name=x1}
