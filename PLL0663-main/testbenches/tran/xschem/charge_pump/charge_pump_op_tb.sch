v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -230 -170 -200 -170 {lab=vout}
N -380 -260 -380 -240 {lab=vp}
N -550 -190 -530 -190 {lab=up}
N -550 -120 -530 -120 {lab=dn}
N -380 -80 -380 -60 {lab=0}
N -230 -130 -130 -130 {lab=#net1}
N -130 -0 -130 10 {lab=0}
N -130 -130 -130 -60 {lab=#net1}
N -530 -130 -530 -120 {lab=dn}
N 70 -70 70 -40 {lab=#net2}
N 70 -170 70 -130 {lab=vout}
N 70 20 70 50 {lab=0}
N 170 -30 170 50 {lab=0}
N 70 50 170 50 {lab=0}
N 170 -170 170 -90 {lab=vout}
N 70 -170 170 -170 {lab=vout}
N 170 -170 230 -170 {lab=vout}
C {vsource.sym} -250 -350 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} -250 -320 0 0 {name=l16 lab=0}
C {lab_pin.sym} -250 -380 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -910 -350 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 25

.control
op
show n.x1.x11.nsg13_lv_pmos

save all
write aa_cp_lay_op.raw
set appendwrite
show all
.endc
"}
C {vsource.sym} -460 -350 0 0 {name=Vup2
value=1.2 savecurrent=false}
C {gnd.sym} -460 -320 0 0 {name=l11 lab=0}
C {vsource.sym} -360 -350 0 0 {name=Vdn2
value=1.2 savecurrent=false}
C {gnd.sym} -360 -320 0 0 {name=l12 lab=0}
C {lab_pin.sym} -460 -380 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} -360 -380 0 1 {name=p31 sig_type=std_logic lab=dn}
C {vsource.sym} -80 -150 0 0 {name=Vup1
value=0.6 savecurrent=false}
C {gnd.sym} -80 -120 0 0 {name=l3 lab=0}
C {lab_pin.sym} -80 -180 0 1 {name=p22 sig_type=std_logic lab=vout}
C {lab_pin.sym} -200 -170 0 1 {name=p1 sig_type=std_logic lab=vout}
C {lab_pin.sym} -380 -260 0 1 {name=p4 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -510 0 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
C {lab_pin.sym} -550 -190 0 0 {name=p5 sig_type=std_logic lab=up}
C {lab_pin.sym} -550 -120 0 0 {name=p6 sig_type=std_logic lab=dn}
C {gnd.sym} -380 -60 0 0 {name=l2 lab=0}
C {vsource.sym} -130 -30 0 0 {name=Vrst
value=1.2 savecurrent=false}
C {gnd.sym} -130 10 0 0 {name=l1 lab=0}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/charge_pump_cell_newbias.sym} -380 -150 0 0 {name=x1}
C {lab_pin.sym} 230 -170 2 0 {name=p2 sig_type=std_logic lab=vout}
C {res.sym} 70 -100 0 0 {name=R1
value=25k
footprint=1206
device=resistor
m=1}
C {capa.sym} 70 -10 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 170 -60 0 0 {name=C3
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 120 50 0 0 {name=l4 lab=0}
