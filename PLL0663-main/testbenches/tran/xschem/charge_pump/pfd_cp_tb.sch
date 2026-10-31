v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 770 -100 800 -100 {lab=vp}
N 770 -80 800 -80 {lab=vout}
N 770 -60 800 -60 {lab=0}
N 370 -100 470 -100 {lab=up}
N 370 -100 370 -80 {lab=up}
N -10 -50 30 -50 {lab=up}
N 30 -80 30 -50 {lab=up}
N 30 -80 370 -80 {lab=up}
N -10 -110 20 -110 {lab=dn}
N 20 -110 20 -20 {lab=dn}
N 20 -20 460 -20 {lab=dn}
N 460 -80 460 -20 {lab=dn}
N 460 -80 470 -80 {lab=dn}
N -460 -110 -310 -110 {lab=#net1}
N -390 -50 -310 -50 {lab=#net2}
N 910 -70 910 -40 {lab=vout}
C {lab_pin.sym} 800 -100 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 800 -80 0 1 {name=p10 sig_type=std_logic lab=vout}
C {gnd.sym} 800 -60 0 0 {name=l7 lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/old_sch/cp_v1_no_mirror.sym} 620 -80 0 0 {name=x1}
C {vsource.sym} 50 -370 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 50 -340 0 0 {name=l16 lab=0}
C {lab_pin.sym} 50 -400 0 0 {name=p47 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_cell.sym} -160 -80 0 0 {name=x2}
C {devices/vsource.sym} -390 -20 0 0 {name=Vco value="dc 0 ac 0 pulse(0 \{Vp\} \{dly\} 10n 10n \{T/2\} \{T\}) "}
C {devices/vsource.sym} -460 -80 0 0 {name=Vref value="dc 0 ac 0 pulse(0 \{Vp\} \{T/2\} 10n 10n \{T/2\} \{T\}) "}
C {gnd.sym} -390 10 0 0 {name=l1 lab=0}
C {gnd.sym} -460 -50 0 0 {name=l2 lab=0}
C {lab_pin.sym} -160 -140 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_pin.sym} 410 -100 0 0 {name=p4 sig_type=std_logic lab=up}
C {lab_pin.sym} 400 -20 0 0 {name=p5 sig_type=std_logic lab=dn}
C {capa.sym} 910 -10 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 910 20 0 0 {name=l14 lab=0}
C {lab_pin.sym} 910 -70 0 1 {name=p24 sig_type=std_logic lab=vout}
C {gnd.sym} -160 -20 0 0 {name=l3 lab=0}
C {devices/code_shown.sym} -230 -700 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.param l=0.15u
.param Vp=1.2
.param dly=1u
.nodeset v(vbias)=0.6
.control

tran 100p 5u
save all
plot v(vout)
write pfd_cp.raw
set appendwrite
show all
.endc
"}
