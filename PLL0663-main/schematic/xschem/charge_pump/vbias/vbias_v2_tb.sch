v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 190 -300 190 -290 {lab=vp}
N 290 -200 290 -180 {lab=0}
N 290 -200 320 -200 {lab=0}
N 190 -300 320 -300 {lab=vp}
N 500 -300 550 -300 {lab=bias1}
N 500 -280 550 -280 {lab=bias2}
N 500 -260 550 -260 {lab=bias3}
N 500 -220 550 -220 {lab=bias5}
N 500 -240 550 -240 {lab=bias4}
N 500 -200 550 -200 {lab=bias6}
C {vsource.sym} 190 -260 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 190 -230 0 0 {name=l16 lab=0}
C {lab_pin.sym} 190 -290 0 0 {name=p47 sig_type=std_logic lab=vp}
C {gnd.sym} 290 -180 0 0 {name=l7 lab=0}
C {vbias_v2.sym} -80 140 0 0 {name=x1}
C {lab_pin.sym} 550 -300 0 1 {name=p10 sig_type=std_logic lab=bias1}
C {lab_pin.sym} 550 -280 0 1 {name=p1 sig_type=std_logic lab=bias2}
C {lab_pin.sym} 550 -260 0 1 {name=p2 sig_type=std_logic lab=bias3}
C {lab_pin.sym} 550 -240 0 1 {name=p3 sig_type=std_logic lab=bias4}
C {lab_pin.sym} 550 -220 0 1 {name=p4 sig_type=std_logic lab=bias5}
C {devices/code_shown.sym} 630 -620 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ff
"}
C {devices/code_shown.sym} 640 -470 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.param Vp=1.2
.control

op
save all
show all > show_all.txt
write vbias_v2.raw
.endc
"}
C {lab_pin.sym} 550 -200 0 1 {name=p5 sig_type=std_logic lab=bias6}
