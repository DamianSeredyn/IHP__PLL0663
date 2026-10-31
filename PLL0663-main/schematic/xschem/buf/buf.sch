v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 240 -170 290 -170 {lab=INPUT}
N 290 -220 290 -170 {lab=INPUT}
N 290 -220 310 -220 {lab=INPUT}
N 290 -170 290 -130 {lab=INPUT}
N 290 -130 310 -130 {lab=INPUT}
N 350 -260 350 -250 {lab=VDD}
N 350 -170 350 -160 {lab=#net1}
N 350 -220 370 -220 {lab=VDD}
N 370 -260 370 -220 {lab=VDD}
N 350 -260 370 -260 {lab=VDD}
N 350 -130 370 -130 {lab=GND}
N 370 -130 370 -90 {lab=GND}
N 350 -90 370 -90 {lab=GND}
N 350 -100 350 -90 {lab=GND}
N 470 -220 470 -170 {lab=#net1}
N 470 -220 490 -220 {lab=#net1}
N 470 -170 470 -130 {lab=#net1}
N 470 -130 490 -130 {lab=#net1}
N 530 -260 530 -250 {lab=VDD}
N 530 -90 530 -30 {lab=GND}
N 530 -170 530 -160 {lab=#net2}
N 530 -220 550 -220 {lab=VDD}
N 550 -260 550 -220 {lab=VDD}
N 530 -260 550 -260 {lab=VDD}
N 530 -130 550 -130 {lab=GND}
N 550 -130 550 -90 {lab=GND}
N 530 -90 550 -90 {lab=GND}
N 530 -100 530 -90 {lab=GND}
N 350 -190 350 -170 {lab=#net1}
N 530 -170 630 -170 {lab=#net2}
N 530 -190 530 -170 {lab=#net2}
N 350 -170 470 -170 {lab=#net1}
N 630 -220 630 -170 {lab=#net2}
N 630 -220 650 -220 {lab=#net2}
N 630 -170 630 -130 {lab=#net2}
N 630 -130 650 -130 {lab=#net2}
N 690 -260 690 -250 {lab=VDD}
N 690 -90 690 -30 {lab=GND}
N 690 -220 710 -220 {lab=VDD}
N 710 -260 710 -220 {lab=VDD}
N 690 -260 710 -260 {lab=VDD}
N 690 -130 710 -130 {lab=GND}
N 710 -130 710 -90 {lab=GND}
N 690 -90 710 -90 {lab=GND}
N 690 -100 690 -90 {lab=GND}
N 690 -170 690 -160 {lab=#net3}
N 690 -170 790 -170 {lab=#net3}
N 790 -220 790 -170 {lab=#net3}
N 790 -220 810 -220 {lab=#net3}
N 790 -170 790 -130 {lab=#net3}
N 790 -130 810 -130 {lab=#net3}
N 850 -260 850 -250 {lab=VDD}
N 850 -90 850 -30 {lab=GND}
N 850 -220 870 -220 {lab=VDD}
N 870 -260 870 -220 {lab=VDD}
N 850 -260 870 -260 {lab=VDD}
N 850 -130 870 -130 {lab=GND}
N 870 -130 870 -90 {lab=GND}
N 850 -90 870 -90 {lab=GND}
N 850 -100 850 -90 {lab=GND}
N 690 -190 690 -170 {lab=#net3}
N 850 -170 850 -160 {lab=OUT}
N 530 -360 690 -360 {lab=VDD}
N 350 -360 350 -260 {lab=VDD}
N 530 -360 530 -260 {lab=VDD}
N 350 -360 530 -360 {lab=VDD}
N 690 -360 690 -260 {lab=VDD}
N 690 -360 850 -360 {lab=VDD}
N 850 -360 850 -260 {lab=VDD}
N 350 -90 350 -30 {lab=GND}
N 350 -30 530 -30 {lab=GND}
N 690 -30 850 -30 {lab=GND}
N 530 -30 690 -30 {lab=GND}
N 850 -170 940 -170 {lab=OUT}
N 850 -190 850 -170 {lab=OUT}
C {ipin.sym} 240 -170 0 0 {name=p4 lab=INPUT}
C {iopin.sym} 610 -360 3 0 {name=p1 lab=VDD}
C {iopin.sym} 610 -30 1 0 {name=p5 lab=GND}
C {opin.sym} 940 -170 0 0 {name=p6 lab=OUT}
C {sg13g2_pr/sg13_hv_pmos.sym} 830 -220 0 0 {name=M9
l=0.4u
w=10u
 ng=1
 m=12
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 670 -220 0 0 {name=M6
l=0.4u
w=10u
 ng=1
 m=4
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 510 -220 0 0 {name=M4
l=0.4u
w=10u
 ng=1
 m=2
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 330 -220 0 0 {name=M2
l=0.4u
w=10u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 830 -130 0 0 {name=M1
l=0.45u
w=10u
 ng=1
 m=12
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 670 -130 0 0 {name=M3
l=0.45u
w=10u
 ng=1
 m=4
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 510 -130 0 0 {name=M5
l=0.45u
w=10u
 ng=1
 m=2
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 330 -130 0 0 {name=M7
l=0.45u
w=10u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
