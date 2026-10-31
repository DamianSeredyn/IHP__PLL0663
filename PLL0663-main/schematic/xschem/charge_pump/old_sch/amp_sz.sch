v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 440 -490 440 -430 {lab=net1}
N 510 -540 600 -540 {lab=net1}
N 440 -490 510 -490 {lab=net1}
N 440 -510 440 -490 {lab=net1}
N 510 -540 510 -490 {lab=net1}
N 480 -540 510 -540 {lab=net1}
N 640 -460 640 -430 {lab=net2}
N 440 -400 460 -400 {lab=gd}
N 460 -400 460 -60 {lab=gd}
N 440 -370 440 -330 {lab=net3}
N 620 -400 640 -400 {lab=gd}
N 620 -400 620 -60 {lab=gd}
N 640 -370 640 -330 {lab=net3}
N 540 -100 540 -60 {lab=gd}
N 540 -330 640 -330 {lab=net3}
N 320 -190 320 -160 {lab=net4}
N 320 -100 320 -60 {lab=gd}
N 830 -100 830 -60 {lab=gd}
N 830 -130 850 -130 {lab=gd}
N 850 -130 850 -60 {lab=gd}
N 830 -60 850 -60 {lab=gd}
N 620 -60 830 -60 {lab=gd}
N 540 -130 560 -130 {lab=gd}
N 560 -130 560 -60 {lab=gd}
N 540 -60 560 -60 {lab=gd}
N 300 -130 320 -130 {lab=gd}
N 300 -130 300 -60 {lab=gd}
N 460 -60 540 -60 {lab=gd}
N 300 -60 320 -60 {lab=gd}
N 560 -60 620 -60 {lab=gd}
N 320 -60 460 -60 {lab=gd}
N 390 -130 500 -130 {lab=net4}
N 320 -190 390 -190 {lab=net4}
N 390 -190 390 -130 {lab=net4}
N 360 -130 390 -130 {lab=net4}
N 390 -190 790 -190 {lab=net4}
N 790 -190 790 -130 {lab=net4}
N 320 -510 320 -190 {lab=net4}
N 640 -510 640 -460 {lab=net2}
N 830 -360 830 -160 {lab=vout}
N 320 -620 320 -570 {lab=vp}
N 440 -620 440 -570 {lab=vp}
N 420 -620 440 -620 {lab=vp}
N 420 -540 440 -540 {lab=vp}
N 420 -620 420 -540 {lab=vp}
N 320 -620 420 -620 {lab=vp}
N 640 -540 660 -540 {lab=vp}
N 660 -620 660 -540 {lab=vp}
N 640 -620 660 -620 {lab=vp}
N 640 -620 640 -570 {lab=vp}
N 440 -620 640 -620 {lab=vp}
N 830 -620 830 -490 {lab=vp}
N 830 -460 840 -460 {lab=vp}
N 840 -620 840 -460 {lab=vp}
N 830 -620 840 -620 {lab=vp}
N 660 -620 830 -620 {lab=vp}
N 680 -400 680 -320 {lab=vin_plus}
N 100 -320 680 -320 {lab=vin_plus}
N 830 -360 960 -360 {lab=vout}
N 540 -330 540 -160 {lab=net3}
N 440 -330 540 -330 {lab=net3}
N 100 -400 400 -400 {lab=vin_min}
N 640 -460 790 -460 {lab=net2}
N 830 -430 830 -360 {lab=vout}
C {sg13g2_pr/sg13_lv_nmos.sym} 660 -400 0 1 {name=M1
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 420 -400 0 0 {name=M2
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 460 -540 0 1 {name=M3
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 620 -540 0 0 {name=M4
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {isource.sym} 320 -540 0 0 {name=I0 value=10u}
C {sg13g2_pr/sg13_lv_nmos.sym} 520 -130 0 0 {name=M5
l=1u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 340 -130 0 1 {name=M6
l=1u
w=1.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 810 -130 0 0 {name=M7
l=0.13u
w=10u
ng=1
m=2
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 810 -460 0 0 {name=M8
l=0.13u
w=10u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 440 -450 2 0 {name=p2 sig_type=std_logic lab=net1
}
C {lab_pin.sym} 640 -450 0 0 {name=p3 sig_type=std_logic lab=net2
}
C {lab_pin.sym} 440 -340 2 0 {name=p4 sig_type=std_logic lab=net3

}
C {lab_pin.sym} 320 -340 0 0 {name=p5 sig_type=std_logic lab=net4


}
C {ipin.sym} 100 -400 0 0 {name=p13 lab=vin_min}
C {ipin.sym} 100 -320 0 0 {name=p14 lab=vin_plus}
C {ipin.sym} 960 -360 0 1 {name=p1 lab=vout}
C {iopin.sym} 650 -60 0 0 {name=p12 lab=gd}
C {iopin.sym} 520 -620 0 0 {name=p6 lab=vp}
