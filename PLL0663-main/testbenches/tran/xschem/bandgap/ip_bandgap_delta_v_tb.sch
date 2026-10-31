v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 340 -20 680 -20 {}
L 4 340 -470 680 -470 {}
L 4 340 -470 340 -20 {}
L 4 680 -470 680 -20 {}
L 4 680 -470 680 -20 {}
T {Diode biasing} 350 -460 0 0 0.4 0.4 {}
N 110 -60 110 -30 {lab=gd}
N 110 -200 110 -120 {lab=ibias_ref}
N 30 -200 30 -120 {lab=gd}
N 30 -60 30 -30 {lab=0}
N 30 -290 30 -260 {lab=vp}
N 460 -70 460 -40 {lab=gd}
N 400 -100 420 -100 {lab=gd}
N 400 -100 400 -40 {lab=gd}
N 400 -40 460 -40 {lab=gd}
N 610 -70 610 -40 {lab=gd}
N 550 -100 570 -100 {lab=gd}
N 550 -100 550 -40 {lab=gd}
N 550 -40 610 -40 {lab=gd}
N 460 -340 460 -130 {lab=vd1}
N 610 -340 610 -130 {lab=vd2}
N 390 -350 420 -350 {lab=gd}
N 390 -390 420 -390 {lab=ibias_ref}
N 460 -430 460 -400 {lab=vp}
N 610 -430 610 -400 {lab=vp}
N 540 -390 570 -390 {lab=ibias_ref}
N 540 -350 570 -350 {lab=gd}
N 200 -290 200 -260 {lab=vibias}
N 110 -290 110 -260 {lab=vp}
N 200 -200 200 -30 {lab=gd}
C {isource.sym} 110 -230 0 0 {name=Ibias value=xibias}
C {res.sym} 110 -90 0 0 {name=Rref
value=1
footprint=1206
device=resistor
m=1}
C {lab_wire.sym} 110 -190 3 0 {name=p1 sig_type=std_logic lab=ibias_ref}
C {vsource.sym} 30 -90 0 0 {name=V1 value=0 savecurrent=false}
C {vsource.sym} 30 -230 0 0 {name=V2 value=xvp savecurrent=false}
C {lab_wire.sym} 30 -290 3 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 30 -50 3 0 {name=p3 sig_type=std_logic lab=0}
C {lab_wire.sym} 30 -190 3 0 {name=p4 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/pnpMPA.sym} 440 -100 0 0 {name=Q1
model=pnpMPA
spiceprefix=X
w=2.0e-6
l=2.0e-6
m=1
}
C {sg13cmos5l_pr/pnpMPA.sym} 590 -100 0 0 {name=Q2
model=pnpMPA
spiceprefix=X
w=2.0e-6
l=2.0e-6
m=8
}
C {lab_wire.sym} 110 -50 3 0 {name=p6 sig_type=std_logic lab=gd}
C {lab_wire.sym} 400 -60 3 0 {name=p7 sig_type=std_logic lab=gd
}
C {lab_wire.sym} 550 -60 3 0 {name=p8 sig_type=std_logic lab=gd}
C {vccs.sym} 460 -370 0 0 {name=G1 value=1}
C {vccs.sym} 610 -370 0 0 {name=G2 value=1}
C {lab_wire.sym} 460 -420 3 0 {name=p9 sig_type=std_logic lab=vp}
C {lab_wire.sym} 610 -420 3 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} 410 -350 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_wire.sym} 560 -350 0 0 {name=p12 sig_type=std_logic lab=gd}
C {lab_wire.sym} 410 -390 0 0 {name=p13 sig_type=std_logic lab=ibias_ref}
C {lab_wire.sym} 560 -390 0 0 {name=p14 sig_type=std_logic lab=ibias_ref}
C {lab_wire.sym} 460 -330 3 0 {name=p15 sig_type=std_logic lab=vd1}
C {lab_wire.sym} 610 -330 3 0 {name=p16 sig_type=std_logic lab=vd2}
C {simulator_commands_shown.sym} 20 -1290 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerDIO.lib dio_tt
.lib cornerPNP.lib typ

.param xvp=3.3
.param xibias=100u

.param xtemp=25

.param dummy=0

.save all

.temp 'xtemp'
.dc Ibias 5u 200u 0.25u

.control
let temp_start	= -50
let temp_stop	= 100
let temp_delta	= 1
let temp_act	= temp_start

run
save all
set filetype=ascii
write ip_bandgap_delta_v_tb.raw all

shell 'rm -rf temp-sweep.out'
shell 'echo Sweep:temp-sweep >> temp-sweep.out'

while temp_act < 100
	option temp=$&temp_act
	run
	set appendwrite
	shell 'echo Sweep value:$&temp_act >> temp-sweep.out'
	write temp-sweep.out (v(vd1)-v(vd2)) v(vd1) v(vd2) 
	let temp_act = temp_act + temp_delta
end

.endc
"
      }
C {lab_wire.sym} 200 -290 3 0 {name=p41 sig_type=std_logic lab=vibias}
C {vsource.sym} 200 -230 0 0 {name=Vibias value=xibias savecurrent=false}
C {lab_wire.sym} 110 -290 3 0 {name=p42 sig_type=std_logic lab=vp}
C {lab_wire.sym} 200 -50 3 0 {name=p5 sig_type=std_logic lab=gd}
