v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 180 -450 180 -440 {lab=vp}
N 180 -410 190 -410 {lab=vp}
N 190 -450 190 -410 {lab=vp}
N 180 -450 190 -450 {lab=vp}
N 180 -460 180 -450 {lab=vp}
N 180 -380 180 -300 {lab=#net1}
N 180 -240 180 -190 {lab=vout}
N 270 -190 270 -160 {lab=vout}
N 50 -430 70 -430 {lab=vp}
N 50 -410 140 -410 {lab=#net2}
N 50 -390 70 -390 {lab=0}
C {vsource.sym} 350 -360 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 350 -330 0 0 {name=l16 lab=0}
C {lab_pin.sym} 350 -390 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -320 -440 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 25

.control

op
save all
write cr_src.raw
set appendwrite
show all
.endc
"}
C {vsource.sym} 180 -270 0 0 {name=Viref1
value=0 savecurrent=false}
C {sg13g2_pr/sg13_lv_pmos.sym} 160 -410 0 0 {name=M1
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 180 -460 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_pin.sym} 180 -190 0 0 {name=p3 sig_type=std_logic lab=vout}
C {capa.sym} 270 -130 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 270 -100 0 0 {name=l14 lab=0}
C {lab_pin.sym} 270 -190 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 350 -130 0 0 {name=Vout
value=1 savecurrent=false}
C {gnd.sym} 350 -100 0 0 {name=l3 lab=0}
C {lab_pin.sym} 350 -160 0 1 {name=p4 sig_type=std_logic lab=vout}
C {gnd.sym} 70 -390 0 0 {name=l1 lab=0}
C {lab_pin.sym} 70 -430 0 1 {name=p1 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -220 -160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/curr_source.sym} -100 -410 0 0 {name=x1}
