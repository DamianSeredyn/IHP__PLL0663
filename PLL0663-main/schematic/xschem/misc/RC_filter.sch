v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 50 -20 230 -20 {lab=in}
N 230 90 230 120 {lab=gd}
N 230 -20 230 30 {lab=in}
N 50 -20 50 20 {lab=in}
N -70 -20 50 -20 {lab=in}
N 50 150 50 230 {lab=gd}
N 50 80 50 90 {lab=#net1}
C {ipin.sym} -70 -20 0 0 {name=p1 lab=in}
C {lab_pin.sym} 230 120 0 0 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 50 230 0 0 {name=p3 sig_type=std_logic lab=gd}
C {ipin.sym} 280 190 0 0 {name=gd lab=gd}
C {res.sym} 50 50 0 0 {name=R1
value=50k
footprint=1206
device=resistor
m=1}
C {capa.sym} 50 120 0 0 {name=C1
m=1
value=40p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 230 60 0 0 {name=C2
m=1
value=700p
footprint=1206
device="ceramic capacitor"}
