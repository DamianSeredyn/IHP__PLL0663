v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 440 -10 450 -10 {lab=d1}
N 450 -10 450 10 {lab=d1}
N 440 10 450 10 {lab=d1}
N 440 10 440 20 {lab=d1}
N 500 -10 510 -10 {lab=d8}
N 510 -10 510 10 {lab=d8}
N 500 10 510 10 {lab=d8}
N 500 10 500 20 {lab=d8}
N 600 -170 660 -170 {lab=vref}
N 320 -170 400 -170 {lab=vbias}
N 320 -210 320 -170 {lab=vbias}
N 320 -210 340 -210 {lab=vbias}
N 110 -300 540 -300 {lab=vp}
N 110 -0 540 0 {lab=gd}
N 240 -170 320 -170 {lab=vbias}
N 240 -150 290 -150 {lab=nbias}
N 240 -190 290 -190 {lab=pbias}
N 0 0 110 -0 {lab=gd}
N 540 -90 540 0 {lab=gd}
N 500 -90 500 -10 {lab=d8}
N 440 -90 440 -10 {lab=d1}
N 110 -20 110 -0 {lab=gd}
N 540 -300 540 -250 {lab=vp}
N 110 -300 110 -250 {lab=vp}
N 0 -300 110 -300 {lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/bandgap_res_core.sym} 400 -170 0 0 {name=xbandgap}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/const_gm_bias.sym} 20 -40 0 0 {name=xbias}
C {ipin.sym} 0 -300 0 0 {name=p1 lab=vp}
C {ipin.sym} 0 0 0 0 {name=p2 lab=gd}
C {opin.sym} 660 -170 0 0 {name=p3 lab=vref
}
C {opin.sym} 440 20 1 0 {name=p4 lab=d1
}
C {opin.sym} 500 20 1 0 {name=p5 lab=d8}
C {opin.sym} 340 -210 0 0 {name=p6 lab=vbias}
C {noconn.sym} 290 -150 0 1 {name=l1}
C {noconn.sym} 290 -190 0 1 {name=l2}
C {lab_wire.sym} 260 -190 0 1 {name=p7 sig_type=std_logic lab=pbias}
C {lab_wire.sym} 260 -150 0 1 {name=p8 sig_type=std_logic lab=nbias}
