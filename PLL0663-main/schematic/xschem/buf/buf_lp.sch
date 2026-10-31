v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -260 150 -210 150 {lab=INPUT}
N -210 100 -210 150 {lab=INPUT}
N -210 100 -190 100 {lab=INPUT}
N -210 150 -210 190 {lab=INPUT}
N -210 190 -190 190 {lab=INPUT}
N -150 60 -150 70 {lab=VDD}
N -150 150 -150 160 {lab=#net1}
N -150 100 -130 100 {lab=VDD}
N -130 60 -130 100 {lab=VDD}
N -150 60 -130 60 {lab=VDD}
N -150 190 -130 190 {lab=GND}
N -130 190 -130 230 {lab=GND}
N -150 230 -130 230 {lab=GND}
N -150 220 -150 230 {lab=GND}
N -30 100 -30 150 {lab=#net1}
N -30 100 -10 100 {lab=#net1}
N -30 150 -30 190 {lab=#net1}
N -30 190 -10 190 {lab=#net1}
N 30 60 30 70 {lab=VDD}
N 30 230 30 290 {lab=GND}
N 30 150 30 160 {lab=#net2}
N 30 100 50 100 {lab=VDD}
N 50 60 50 100 {lab=VDD}
N 30 60 50 60 {lab=VDD}
N 30 190 50 190 {lab=GND}
N 50 190 50 230 {lab=GND}
N 30 230 50 230 {lab=GND}
N 30 220 30 230 {lab=GND}
N -150 130 -150 150 {lab=#net1}
N 30 150 130 150 {lab=#net2}
N 30 130 30 150 {lab=#net2}
N -150 150 -30 150 {lab=#net1}
N 130 100 130 150 {lab=#net2}
N 130 100 150 100 {lab=#net2}
N 130 150 130 190 {lab=#net2}
N 130 190 150 190 {lab=#net2}
N 190 60 190 70 {lab=VDD}
N 190 230 190 290 {lab=GND}
N 190 100 210 100 {lab=VDD}
N 210 60 210 100 {lab=VDD}
N 190 60 210 60 {lab=VDD}
N 190 190 210 190 {lab=GND}
N 210 190 210 230 {lab=GND}
N 190 230 210 230 {lab=GND}
N 190 220 190 230 {lab=GND}
N 190 150 190 160 {lab=#net3}
N 190 150 290 150 {lab=#net3}
N 290 100 290 150 {lab=#net3}
N 290 100 310 100 {lab=#net3}
N 290 150 290 190 {lab=#net3}
N 290 190 310 190 {lab=#net3}
N 350 60 350 70 {lab=VDD}
N 350 230 350 290 {lab=GND}
N 350 100 370 100 {lab=VDD}
N 370 60 370 100 {lab=VDD}
N 350 60 370 60 {lab=VDD}
N 350 190 370 190 {lab=GND}
N 370 190 370 230 {lab=GND}
N 350 230 370 230 {lab=GND}
N 350 220 350 230 {lab=GND}
N 190 130 190 150 {lab=#net3}
N 350 150 350 160 {lab=OUT}
N 30 -40 190 -40 {lab=VDD}
N -150 -40 -150 60 {lab=VDD}
N 30 -40 30 60 {lab=VDD}
N -150 -40 30 -40 {lab=VDD}
N 190 -40 190 60 {lab=VDD}
N 190 -40 350 -40 {lab=VDD}
N 350 -40 350 60 {lab=VDD}
N -150 230 -150 290 {lab=GND}
N -150 290 30 290 {lab=GND}
N 190 290 350 290 {lab=GND}
N 30 290 190 290 {lab=GND}
N 350 150 440 150 {lab=OUT}
N 350 130 350 150 {lab=OUT}
C {ipin.sym} -260 150 0 0 {name=p4 lab=INPUT}
C {iopin.sym} 110 -40 3 0 {name=p1 lab=VDD}
C {iopin.sym} 110 290 1 0 {name=p5 lab=GND}
C {opin.sym} 440 150 0 0 {name=p6 lab=OUT}
C {sg13g2_pr/sg13_hv_pmos.sym} 330 100 0 0 {name=M9
l=0.4u
w=3u
 ng=1
 m=4
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 170 100 0 0 {name=M6
l=0.4u
w=3u
 ng=1
 m=3
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 10 100 0 0 {name=M4
l=0.4u
w=3u
 ng=1
 m=2
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -170 100 0 0 {name=M2
l=0.4u
w=3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 330 190 0 0 {name=M1
l=0.45u
w=2u
 ng=1
 m=4
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 170 190 0 0 {name=M3
l=0.45u
w=2u
 ng=1
 m=3
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 10 190 0 0 {name=M5
l=0.45u
w=2u
 ng=1
 m=2
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} -170 190 0 0 {name=M7
l=0.45u
w=2u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
