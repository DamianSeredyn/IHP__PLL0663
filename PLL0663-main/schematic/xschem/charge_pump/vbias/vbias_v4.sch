v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 3730 -2850 3730 -2810 {lab=#net1}
N 3730 -2700 3730 -2660 {lab=0}
N 3610 -2910 3690 -2910 {lab=#net2}
N 3540 -2850 3540 -2700 {lab=0}
N 3540 -2700 3730 -2700 {lab=0}
N 3730 -2750 3730 -2700 {lab=0}
N 3520 -2910 3540 -2910 {lab=0}
N 3520 -2910 3520 -2850 {lab=0}
N 3520 -2850 3540 -2850 {lab=0}
N 3540 -2880 3540 -2850 {lab=0}
N 3730 -2910 3760 -2910 {lab=#net1}
N 3760 -2910 3760 -2850 {lab=#net1}
N 3730 -2850 3760 -2850 {lab=#net1}
N 3730 -2880 3730 -2850 {lab=#net1}
N 3540 -2970 3540 -2940 {lab=#net2}
N 3730 -3110 3730 -2940 {lab=#net3}
N 3660 -3190 3690 -3190 {lab=#net3}
N 3660 -3130 3730 -3130 {lab=#net3}
N 3730 -3160 3730 -3130 {lab=#net3}
N 3660 -3190 3660 -3130 {lab=#net3}
N 3580 -3190 3660 -3190 {lab=#net3}
N 3540 -3260 3540 -3220 {lab=#net4}
N 3540 -3260 3730 -3260 {lab=#net4}
N 3730 -3260 3730 -3220 {lab=#net4}
N 3530 -3260 3540 -3260 {lab=#net4}
N 3730 -3190 3740 -3190 {lab=#net4}
N 3740 -3260 3740 -3190 {lab=#net4}
N 3730 -3260 3740 -3260 {lab=#net4}
N 3530 -3190 3540 -3190 {lab=#net4}
N 3530 -3260 3530 -3190 {lab=#net4}
N 3520 -3260 3530 -3260 {lab=#net4}
N 3990 -2960 3990 -2940 {lab=#net5}
N 3990 -2960 4140 -2960 {lab=#net5}
N 3990 -3150 3990 -2960 {lab=#net5}
N 4180 -2860 4180 -2810 {lab=#net6}
N 3990 -2700 4180 -2700 {lab=0}
N 4180 -2750 4180 -2700 {lab=0}
N 3990 -2880 3990 -2700 {lab=0}
N 3980 -2700 3990 -2700 {lab=0}
N 4030 -2910 4180 -2910 {lab=#net6}
N 4180 -2930 4180 -2910 {lab=#net6}
N 3980 -2910 3990 -2910 {lab=0}
N 3980 -2910 3980 -2700 {lab=0}
N 3730 -2700 3980 -2700 {lab=0}
N 4180 -2960 4210 -2960 {lab=0}
N 4210 -2960 4210 -2700 {lab=0}
N 4180 -2700 4210 -2700 {lab=0}
N 3980 -3260 3990 -3260 {lab=#net4}
N 3990 -3260 3990 -3210 {lab=#net4}
N 4180 -3030 4180 -2990 {lab=#net7}
N 3980 -3180 3990 -3180 {lab=#net4}
N 3980 -3260 3980 -3180 {lab=#net4}
N 3740 -3260 3980 -3260 {lab=#net4}
N 4170 -3260 4180 -3260 {lab=#net4}
N 4180 -3260 4180 -3120 {lab=#net4}
N 4170 -3090 4180 -3090 {lab=#net4}
N 4170 -3260 4170 -3090 {lab=#net4}
N 3990 -3260 4170 -3260 {lab=#net4}
N 3730 -3110 4060 -3110 {lab=#net3}
N 3730 -3130 3730 -3110 {lab=#net3}
N 4240 -3090 4270 -3090 {lab=#net7}
N 4180 -3030 4240 -3030 {lab=#net7}
N 4180 -3060 4180 -3030 {lab=#net7}
N 4240 -3090 4240 -3030 {lab=#net7}
N 4220 -3090 4240 -3090 {lab=#net7}
N 4180 -2860 4400 -2860 {lab=#net6}
N 4180 -2910 4180 -2860 {lab=#net6}
N 4400 -3150 4400 -2860 {lab=#net6}
N 4060 -3180 4060 -3110 {lab=#net3}
N 4030 -3180 4060 -3180 {lab=#net3}
N 4060 -3180 4360 -3180 {lab=#net3}
N 4400 -3260 4400 -3210 {lab=#net4}
N 4400 -3180 4410 -3180 {lab=#net4}
N 4410 -3260 4410 -3180 {lab=#net4}
N 4400 -3260 4410 -3260 {lab=#net4}
N 4180 -3260 4400 -3260 {lab=#net4}
N 3540 -2970 3610 -2970 {lab=#net2}
N 3540 -3160 3540 -2970 {lab=#net2}
N 3610 -2970 3610 -2910 {lab=#net2}
N 3580 -2910 3610 -2910 {lab=#net2}
C {sg13g2_pr/sg13_lv_nmos.sym} 3560 -2910 0 1 {name=M1
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 3560 -3190 0 1 {name=M3
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 3710 -2910 0 0 {name=M2
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 3710 -3190 0 0 {name=M4
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {res.sym} 3730 -2780 0 0 {name=R3
value=500
footprint=1206
device=resistor
m=1}
C {sg13g2_pr/sg13_lv_nmos.sym} 4010 -2910 0 1 {name=M5
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 4160 -2960 0 0 {name=M6
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 4180 -2780 0 0 {name=R1
value=500
footprint=1206
device=resistor
m=1}
C {sg13g2_pr/sg13_lv_pmos.sym} 4010 -3180 0 1 {name=M7
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 4200 -3090 0 1 {name=M8
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {gnd.sym} 3730 -2660 0 0 {name=l1 lab=0}
C {sg13g2_pr/sg13_lv_pmos.sym} 4380 -3180 0 0 {name=M9
l=1u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
