v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 200 -50 220 -50 {lab=xxx}
N 200 -50 200 0 {lab=xxx}
N 200 0 260 0 {lab=xxx}
N 260 -20 260 0 {lab=xxx}
N 100 0 200 0 {lab=xxx}
N 100 -20 100 0 {lab=xxx}
N 40 -50 60 -50 {lab=xxx}
N 40 -50 40 0 {lab=xxx}
N 40 0 100 0 {lab=xxx}
N 100 -120 100 -80 {lab=d1}
N 260 -120 260 -80 {lab=d8}
N 0 -0 40 -0 {lab=xxx}
C {sg13cmos5l_pr/pnpMPA.sym} 80 -50 0 0 {name=Q1
model=pnpMPA
spiceprefix=X
w=2.0e-6
l=2.0e-6
m=1
}
C {sg13cmos5l_pr/pnpMPA.sym} 240 -50 0 0 {name=Q2
model=pnpMPA
spiceprefix=X
w=2.0e-6
l=2.0e-6
m=8
}
C {ipin.sym} 0 0 0 0 {name=p1 lab=gd}
C {ipin.sym} 100 -120 1 0 {name=p2 lab=d1}
C {ipin.sym} 260 -120 1 0 {name=p3 lab=d8}
