v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -790 -140 -750 -140 {lab=up}
N -790 -70 -750 -70 {lab=dn}
N -600 -30 -600 -10 {lab=0}
N -600 -200 -600 -190 {lab=vp}
N -750 -80 -750 -70 {lab=dn}
N -330 -20 -330 10 {lab=#net1}
N -330 -120 -330 -80 {lab=vout}
N -330 70 -330 100 {lab=0}
N -230 20 -230 100 {lab=0}
N -330 100 -230 100 {lab=0}
N -230 -120 -230 -40 {lab=vout}
N -330 -120 -230 -120 {lab=vout}
N -590 60 -590 80 {lab=rst}
N -450 -80 -400 -80 {lab=rst}
N -450 -120 -330 -120 {lab=vout}
N -230 -120 -170 -120 {lab=vout}
C {vsource.sym} -1120 -80 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -1120 -50 0 0 {name=l16 lab=0}
C {lab_pin.sym} -1120 -110 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -1010 -410 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
C {vsource.sym} -1010 -30 0 0 {name=Vup2
value="PULSE(0 1.2 5u 10p 10p 20u 60u)" savecurrent=false}
C {gnd.sym} -1010 0 0 0 {name=l11 lab=0}
C {vsource.sym} -1010 80 0 0 {name=Vdn2
value="PULSE(0 1.2 35u 10p 10p 20u 60u)" savecurrent=false}
C {gnd.sym} -1010 110 0 0 {name=l12 lab=0}
C {devices/code_shown.sym} -1250 -490 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp 25
.param Vp=1.2

.control

tran 100n 240u
plot v(vout) v(rst) v(up) v(dn)
wrdata cp_test.txt v(vout) v(x1.bias)
write aa_cp_tran.raw

set filetype=ascii

set appendwrite
.endc
"}
C {lab_pin.sym} -790 -70 0 0 {name=p1 sig_type=std_logic lab=dn}
C {lab_pin.sym} -790 -140 0 0 {name=p2 sig_type=std_logic lab=up}
C {lab_pin.sym} -170 -120 2 0 {name=p4 sig_type=std_logic lab=vout}
C {vsource.sym} -590 110 0 0 {name=Vrst
value="PULSE(1.2 0 0 1n 1n 5u 1)" savecurrent=false}
C {gnd.sym} -590 140 0 0 {name=l3 lab=0}
C {lab_pin.sym} -590 60 0 0 {name=p6 sig_type=std_logic lab=rst}
C {lab_pin.sym} -1010 -60 0 1 {name=p7 sig_type=std_logic lab=up}
C {lab_pin.sym} -1010 50 0 1 {name=p8 sig_type=std_logic lab=dn}
C {gnd.sym} -600 -10 0 0 {name=l8 lab=0}
C {lab_pin.sym} -600 -200 0 0 {name=p9 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/charge_pump_cell_newbias.sym} -600 -100 0 0 {name=x1}
C {res.sym} -330 -50 0 0 {name=R1
value=25k
footprint=1206
device=resistor
m=1}
C {capa.sym} -330 40 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} -230 -10 0 0 {name=C3
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -280 100 0 0 {name=l2 lab=0}
C {lab_pin.sym} -400 -80 0 0 {name=p3 sig_type=std_logic lab=rst}
