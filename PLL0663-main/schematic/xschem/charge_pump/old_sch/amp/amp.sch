v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 -170 450 -110 {lab=net1}
N 520 -220 610 -220 {lab=net1}
N 450 -170 520 -170 {lab=net1}
N 450 -190 450 -170 {lab=net1}
N 520 -220 520 -170 {lab=net1}
N 490 -220 520 -220 {lab=net1}
N 650 -140 650 -110 {lab=net2}
N 450 -80 470 -80 {lab=0}
N 470 -80 470 260 {lab=0}
N 450 -50 450 -10 {lab=net3}
N 630 -80 650 -80 {lab=0}
N 630 -80 630 260 {lab=0}
N 650 -50 650 -10 {lab=net3}
N 550 220 550 260 {lab=0}
N 550 -10 650 -10 {lab=net3}
N 330 130 330 160 {lab=net4}
N 330 220 330 260 {lab=0}
N 840 220 840 260 {lab=0}
N 840 190 860 190 {lab=0}
N 860 190 860 260 {lab=0}
N 840 260 860 260 {lab=0}
N 630 260 840 260 {lab=0}
N 550 190 570 190 {lab=0}
N 570 190 570 260 {lab=0}
N 550 260 570 260 {lab=0}
N 310 190 330 190 {lab=0}
N 310 190 310 260 {lab=0}
N 470 260 550 260 {lab=0}
N 310 260 330 260 {lab=0}
N 570 260 630 260 {lab=0}
N 330 260 470 260 {lab=0}
N 400 190 510 190 {lab=net4}
N 330 130 400 130 {lab=net4}
N 400 130 400 190 {lab=net4}
N 370 190 400 190 {lab=net4}
N 400 130 800 130 {lab=net4}
N 800 130 800 190 {lab=net4}
N 330 -190 330 130 {lab=net4}
N 650 -190 650 -140 {lab=net2}
N 840 -40 840 160 {lab=Vout}
N 330 -300 330 -250 {lab=#net5}
N 450 -300 450 -250 {lab=#net5}
N 430 -300 450 -300 {lab=#net5}
N 430 -220 450 -220 {lab=#net5}
N 430 -300 430 -220 {lab=#net5}
N 330 -300 430 -300 {lab=#net5}
N 650 -220 670 -220 {lab=#net5}
N 670 -300 670 -220 {lab=#net5}
N 650 -300 670 -300 {lab=#net5}
N 650 -300 650 -250 {lab=#net5}
N 450 -300 650 -300 {lab=#net5}
N 840 -300 840 -170 {lab=#net5}
N 840 -140 850 -140 {lab=#net5}
N 850 -300 850 -140 {lab=#net5}
N 840 -300 850 -300 {lab=#net5}
N 670 -300 840 -300 {lab=#net5}
N 260 -240 260 -220 {lab=0}
N 260 -300 330 -300 {lab=#net5}
N 110 100 110 120 {lab=0}
N 690 -80 690 -0 {lab=#net6}
N 110 0 690 -0 {lab=#net6}
N 110 0 110 40 {lab=#net6}
N 840 -40 970 -40 {lab=Vout}
N 550 110 550 160 {lab=#net7}
N 550 -10 550 50 {lab=net3}
N 450 -10 550 -10 {lab=net3}
N 110 -20 110 -0 {lab=#net6}
N 110 -80 410 -80 {lab=#net8}
N 650 -140 800 -140 {lab=net2}
N 840 -110 840 -40 {lab=Vout}
C {simulator_commands_shown.sym} 290 -510 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerDIO.lib dio_tt
"
      }
C {simulator_commands_shown.sym} 600 -600 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.param temp=27
.param mirror=1.5u
.control
save all
op
;dc V3 0 1.2 0.01
;dc V4 -100m 100m 0.0001
ac dec 100 1 1G
write amp.raw
show all > op_report.txt
plot db(v(vout))
plot (180/pi)*phase(v(vout))
;plot i(v2)
;plot deriv(v(vout))
.endc
"}
C {sg13g2_pr/sg13_lv_nmos.sym} 670 -80 0 1 {name=M1
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 430 -80 0 0 {name=M2
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 470 -220 0 1 {name=M3
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 630 -220 0 0 {name=M4
l=0.13u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {isource.sym} 330 -220 0 0 {name=I0 value=10u}
C {gnd.sym} 550 260 0 0 {name=l1 lab=0}
C {sg13g2_pr/sg13_lv_nmos.sym} 530 190 0 0 {name=M5
l=1u
w=\{mirror\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 350 190 0 1 {name=M6
l=1u
w=\{mirror\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 820 190 0 0 {name=M7
l=0.13u
w=10u
ng=1
m=2
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 820 -140 0 0 {name=M8
l=0.13u
w=10u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {vsource.sym} 260 -270 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 260 -220 0 0 {name=l2 lab=0}
C {lab_pin.sym} 970 -40 2 0 {name=p1 sig_type=std_logic lab=Vout
}
C {vsource.sym} 110 70 0 0 {name=V3 value=0.6 savecurrent=false}
C {gnd.sym} 110 120 0 0 {name=l3 lab=0}
C {lab_pin.sym} 450 -130 2 0 {name=p2 sig_type=std_logic lab=net1
}
C {lab_pin.sym} 650 -130 0 0 {name=p3 sig_type=std_logic lab=net2
}
C {lab_pin.sym} 450 -20 2 0 {name=p4 sig_type=std_logic lab=net3

}
C {lab_pin.sym} 330 -20 0 0 {name=p5 sig_type=std_logic lab=net4


}
C {vsource.sym} 550 80 0 0 {name=V2 value=0.0 savecurrent=false}
C {vsource.sym} 110 -50 2 0 {name=V4 value="0 ac 1" savecurrent=false}
