v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -640 -120 -640 -90 {lab=vout}
N -810 -160 -780 -160 {lab=vp}
N -810 -140 -780 -140 {lab=vout}
N -810 -120 -780 -120 {lab=0}
N -1140 -140 -1110 -140 {lab=dn}
N -1140 -160 -1110 -160 {lab=up}
C {vsource.sym} -1170 -340 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -1170 -310 0 0 {name=l16 lab=0}
C {lab_pin.sym} -1170 -370 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -370 -540 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -360 -390 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.param l=0.15u
.param Vp=1.2
.control

tran 1n 30u
save all
plot v(vout)
write cp_test_low_curr.raw
wrdata v(vout) i(v.x1.vip) i(v.x1.vin)
set appendwrite
.endc
"}
C {capa.sym} -640 -60 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -640 -30 0 0 {name=l14 lab=0}
C {lab_pin.sym} -640 -120 0 1 {name=p24 sig_type=std_logic lab=vout}
C {lab_pin.sym} -1140 -160 0 0 {name=p1 sig_type=std_logic lab=up}
C {lab_pin.sym} -780 -160 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} -780 -140 0 1 {name=p10 sig_type=std_logic lab=vout}
C {gnd.sym} -780 -120 0 0 {name=l7 lab=0}
C {lab_pin.sym} -1140 -140 0 0 {name=p2 sig_type=std_logic lab=dn}
C {vsource.sym} -1020 -340 0 0 {name=Vup2
value="PULSE(1.2 0 0n 10p 10p 5u 15u)" savecurrent=false}
C {gnd.sym} -1020 -310 0 0 {name=l4 lab=0}
C {vsource.sym} -660 -340 0 0 {name=Vdn2
value="PULSE(0 1.2 7.5u 10p 10p 5u 15u)" savecurrent=false}
C {gnd.sym} -660 -310 0 0 {name=l5 lab=0}
C {lab_pin.sym} -1020 -370 0 1 {name=p6 sig_type=std_logic lab=up}
C {lab_pin.sym} -660 -370 0 1 {name=p7 sig_type=std_logic lab=dn}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp_v1_low_curr.sym} -960 -140 0 0 {name=x1}
