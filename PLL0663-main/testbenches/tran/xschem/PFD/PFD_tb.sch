v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 370 -660 1170 -260 {flags=graph
y1=0.52
y2=1.82
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00017300861
x2=2.6991337e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color="4 7"
node="cvco
cref"
legend=1}
B 2 -1050 220 -250 620 {flags=graph
y1=0
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00017300861
x2=2.6991337e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=up
color=7
dataset=-1
unitx=1
logx=0
logy=0
y2=1.3}
B 2 -170 220 630 620 {flags=graph
y1=2.6
y2=3.9
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00017300861
x2=2.6991337e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=down
color=12
dataset=-1
unitx=1
logx=0
logy=0
}
B 2 710 220 1510 620 {flags=graph
y1=1.2
y2=3.2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=-0.00017300861
x2=2.6991337e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=4
node="v(up) - v(down)"}
N -40 -160 -40 -110 {lab=vp}
N -640 -160 -640 -120 {lab=vp}
N -560 -80 -560 -70 {lab=CRef_prebuf}
N -560 -80 -390 -80 {lab=CRef_prebuf}
N -500 -20 -190 -20 {lab=CVco}
N -640 -60 -640 60 {lab=GND}
N -560 -10 -560 60 {lab=GND}
N -40 10 -40 60 {lab=GND}
N -640 60 -560 60 {lab=GND}
N -40 60 -40 80 {lab=GND}
N 310 60 340 60 {lab=GND}
N 200 50 200 60 {lab=GND}
N -40 60 200 60 {lab=GND}
N 200 -20 200 -10 {lab=DOWN}
N 110 -20 200 -20 {lab=DOWN}
N 310 -80 310 -10 {lab=UP}
N 110 -80 310 -80 {lab=UP}
N 310 50 310 60 {lab=GND}
N 200 60 310 60 {lab=GND}
N -370 -160 -40 -160 {lab=vp}
N -370 -160 -370 -110 {lab=vp}
N -500 50 -500 60 {lab=GND}
N -190 -20 -190 -10 {lab=CVco}
N -500 60 -370 60 {lab=GND}
N -560 60 -500 60 {lab=GND}
N -370 60 -40 60 {lab=GND}
N -640 -160 -370 -160 {lab=vp}
N -370 -50 -370 60 {lab=GND}
N -310 -80 -190 -80 {lab=CRef}
N -500 -20 -500 -10 {lab=CVco}
N -250 -50 -190 -50 {lab=rst}
N -760 60 -640 60 {lab=GND}
N -760 -30 -760 60 {lab=GND}
N -760 -160 -760 -90 {lab=rst}
C {devices/code_shown.sym} -860 -1000 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=125
.param T = 31.25u
.param dly=0.1u
.param Vp=1.2
.param Vph=3.3
.control
save all
tran 0.5u 250u

meas tran pw_up avg v(UP) from=120u to=250u
meas tran pw_down avg v(DOWN) from=120u to=250u
plot v(pw_up) v(pw_down)
write PFD_tb.raw
.endc
"}
C {gnd.sym} -40 80 0 0 {name=l1 lab=GND
}
C {lab_wire.sym} -210 -80 0 0 {name=p1 sig_type=std_logic lab=CRef}
C {lab_wire.sym} -460 -20 0 0 {name=p2 sig_type=std_logic lab=CVco}
C {lab_wire.sym} 300 -80 0 0 {name=p3 sig_type=std_logic lab=UP
}
C {lab_wire.sym} 190 -20 0 0 {name=p4 sig_type=std_logic lab=DOWN

}
C {devices/vsource.sym} -560 -40 0 0 {name=Vref value="dc 0 ac 0 pulse(0 \{Vph\} \{T/2\} 10n 10n \{T/2\} \{T\}) "}
C {devices/vsource.sym} -500 20 0 0 {name=Vco value="dc 0 ac 0 pulse(1u \{Vp\} \{dly\} 10n 10n \{T/2\} \{T\})"}
C {launcher.sym} 580 -210 0 0 {name=h5
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/PFD_tb.raw tran"
}
C {devices/vsource.sym} -640 -90 0 0 {name=Vp value="dc \{Vp\}"}
C {capa.sym} 310 20 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 200 20 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/code_shown.sym} -580 -410 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ff
.lib cornerRES.lib res_typ
.lib cornerMOShv.lib mos_tt
.lib cornerMOSCAP.lib moscap_tt

"}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/misc/buffer_hv.sym} -280 -80 0 0 {name=x2}
C {lab_wire.sym} -450 -80 0 0 {name=p5 sig_type=std_logic lab=CRef_prebuf}
C {devices/vsource.sym} -760 -60 0 0 {name=Vp1 value="dc 0 ac 0 PULSE(\{Vp\} 0 63u 1p 1p 1 2"}
C {lab_wire.sym} -760 -160 0 0 {name=p6 sig_type=std_logic lab=rst}
C {lab_wire.sym} -250 -50 0 0 {name=p7 sig_type=std_logic lab=rst}
C {lab_wire.sym} -220 -160 0 0 {name=p8 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/PFD/PFD_cell_2.sym} -40 -50 0 0 {name=x1}
