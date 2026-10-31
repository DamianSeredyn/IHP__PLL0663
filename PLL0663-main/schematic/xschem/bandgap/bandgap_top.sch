v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 260 -200 290 -200 {lab=#net1}
N 380 -230 380 -200 {lab=vp}
N 380 -230 390 -230 {lab=vp}
N 390 -250 390 -230 {lab=vp}
N 380 -250 390 -250 {lab=vp}
N 380 -350 380 -250 {lab=vp}
N 180 -350 380 -350 {lab=vp}
N 180 -350 180 -320 {lab=vp}
N 0 -350 180 -350 {lab=vp}
N 380 -40 380 -10 {lab=gd}
N 180 -10 380 -10 {lab=gd}
N 180 -160 180 -10 {lab=gd}
N 0 -10 180 -10 {lab=gd}
N 260 -240 500 -240 {lab=vref_res}
N 440 -120 500 -120 {lab=vref_sb}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/bandgap_selfbias_top.sym} 240 -120 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/bandgap_res_top.sym} 60 -240 0 0 {name=x2}
C {noconn.sym} 290 -200 0 1 {name=l1}
C {ipin.sym} 0 -350 0 0 {name=p1 lab=vp}
C {ipin.sym} 0 -10 0 0 {name=p2 lab=gd}
C {opin.sym} 500 -240 0 0 {name=p3 lab=vref_res}
C {opin.sym} 500 -120 0 0 {name=p4 lab=vref_sb}
