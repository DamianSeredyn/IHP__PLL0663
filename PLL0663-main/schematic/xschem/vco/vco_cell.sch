v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 570 -520 730 -520 {lab=vp}
N 730 -520 730 -390 {lab=vp}
N 570 -520 570 -390 {lab=vp}
N 380 -520 570 -520 {lab=vp}
N 380 -520 380 -390 {lab=vp}
N 260 -520 380 -520 {lab=vp}
N 220 -520 220 -390 {lab=vp}
N 40 -520 220 -520 {lab=vp}
N 40 -520 40 -390 {lab=vp}
N -120 -520 40 -520 {lab=vp}
N -160 -560 -160 -320 {lab=chwcto}
N 530 -560 690 -560 {lab=chwcto}
N 690 -560 690 -390 {lab=chwcto}
N 530 -560 530 -390 {lab=chwcto}
N 340 -560 530 -560 {lab=chwcto}
N 340 -560 340 -390 {lab=chwcto}
N 180 -560 180 -390 {lab=chwcto}
N 0 -560 180 -560 {lab=chwcto}
N 0 -560 0 -390 {lab=chwcto}
N -160 -560 0 -560 {lab=chwcto}
N 180 -560 340 -560 {lab=chwcto}
N 150 -660 260 -660 {lab=vp}
N 40 -360 40 -230 {lab=1up}
N 0 -140 0 -50 {lab=out}
N 180 -140 180 -50 {lab=1-2}
N 340 -140 340 -50 {lab=2-3}
N 530 -140 530 -40 {lab=3-4}
N 690 -140 690 -40 {lab=4-5}
N 40 -140 40 -80 {lab=1-2}
N 220 -140 220 -80 {lab=2-3}
N 380 -140 380 -80 {lab=3-4}
N 570 -140 570 -70 {lab=4-5}
N 730 -140 730 -70 {lab=out}
N 40 -140 180 -140 {lab=1-2}
N 40 -200 40 -140 {lab=1-2}
N 180 -230 180 -140 {lab=1-2}
N 220 -140 340 -140 {lab=2-3}
N 220 -200 220 -140 {lab=2-3}
N 340 -230 340 -140 {lab=2-3}
N 380 -140 530 -140 {lab=3-4}
N 380 -200 380 -140 {lab=3-4}
N 530 -230 530 -140 {lab=3-4}
N 570 -140 690 -140 {lab=4-5}
N 570 -200 570 -140 {lab=4-5}
N 690 -230 690 -140 {lab=4-5}
N -40 -140 0 -140 {lab=out}
N -0 -230 0 -140 {lab=out}
N -40 -160 -40 -140 {lab=out}
N -40 -160 730 -160 {lab=out}
N 730 -200 730 -160 {lab=out}
N 730 -140 780 -140 {lab=out}
N 730 -160 730 -140 {lab=out}
N 220 -360 220 -230 {lab=2up}
N 380 -360 380 -230 {lab=3up}
N 570 -360 570 -230 {lab=4up}
N 730 -360 730 -230 {lab=5up}
N 40 -50 40 70 {lab=1dn}
N 220 -50 220 70 {lab=2dn}
N 380 -50 380 70 {lab=3dn}
N 570 -40 570 80 {lab=4dn}
N 730 -40 730 80 {lab=5dn}
N -0 100 -0 180 {lab=in}
N 530 180 690 180 {lab=in}
N 690 110 690 180 {lab=in}
N 530 110 530 180 {lab=in}
N 340 180 530 180 {lab=in}
N 340 100 340 180 {lab=in}
N 180 180 340 180 {lab=in}
N 180 100 180 180 {lab=in}
N -0 180 180 180 {lab=in}
N 570 240 730 240 {lab=gnd}
N 40 240 220 240 {lab=gnd}
N 260 240 380 240 {lab=gnd}
N 380 240 570 240 {lab=gnd}
N -120 -320 -120 70 {lab=chwcto}
N -120 100 -120 240 {lab=gnd}
N -120 240 40 240 {lab=gnd}
N 260 240 260 310 {lab=gnd}
N 220 240 260 240 {lab=gnd}
N 220 310 260 310 {lab=gnd}
N -200 100 -160 100 {lab=in}
N -200 100 -200 180 {lab=in}
N -240 100 -200 100 {lab=in}
N -200 180 -0 180 {lab=in}
N 40 100 40 240 {lab=gnd}
N 220 100 220 240 {lab=gnd}
N 380 100 380 240 {lab=gnd}
N 570 110 570 240 {lab=gnd}
N 730 110 730 240 {lab=gnd}
N -160 -320 -120 -320 {lab=chwcto}
N -120 -360 -120 -320 {lab=chwcto}
N -120 -520 -120 -390 {lab=vp}
N 260 -660 260 -520 {lab=vp}
N 220 -520 260 -520 {lab=vp}
C {sg13g2_pr/sg13_lv_nmos.sym} -140 100 0 0 {name=M1
l=0.420u
w=0.405u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -140 -390 0 0 {name=M2
l=0.18u
w=1.21u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -390 0 0 {name=M3
l=0.18u
w=1.21u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -390 0 0 {name=M4
l=0.18u
w=1.21u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -390 0 0 {name=M5
l=0.18u
w=1.21u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 550 -390 0 0 {name=M6
l=0.18u
w=1.21u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 710 -390 0 0 {name=M7
l=0.18u
w=1.21u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -230 0 0 {name=M8
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -230 0 0 {name=M9
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -230 0 0 {name=M10
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 550 -230 0 0 {name=M11
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 710 -230 0 0 {name=M12
l=0.18u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 20 -50 0 0 {name=M13
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -50 0 0 {name=M14
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 -50 0 0 {name=M15
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 550 -40 0 0 {name=M16
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 710 -40 0 0 {name=M17
l=0.18u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 20 100 0 0 {name=M18
l=0.420u
w=0.405u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 100 0 0 {name=M19
l=0.420u
w=0.405u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 100 0 0 {name=M20
l=0.420u
w=0.405u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 550 110 0 0 {name=M21
l=0.420u
w=0.405u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 710 110 0 0 {name=M22
l=0.420u
w=0.405u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} -240 100 0 0 {name=p1 lab=in}
C {iopin.sym} 220 310 0 1 {name=p2 lab=gnd}
C {iopin.sym} 150 -660 0 1 {name=p3 lab=vp
}
C {opin.sym} 780 -140 0 0 {name=p4 lab=out}
C {lab_wire.sym} -70 -560 0 0 {name=p14 sig_type=std_logic lab=chwcto
}
C {lab_wire.sym} 110 -140 0 0 {name=p5 sig_type=std_logic lab=1-2
}
C {lab_wire.sym} 290 -140 0 0 {name=p6 sig_type=std_logic lab=2-3
}
C {lab_wire.sym} 460 -140 0 0 {name=p7 sig_type=std_logic lab=3-4
}
C {lab_wire.sym} 640 -140 0 0 {name=p8 sig_type=std_logic lab=4-5}
C {lab_wire.sym} 40 -310 0 0 {name=p9 sig_type=std_logic lab=1up
}
C {lab_wire.sym} 40 30 0 0 {name=p10 sig_type=std_logic lab=1dn}
C {lab_wire.sym} 220 -310 0 0 {name=p11 sig_type=std_logic lab=2up
}
C {lab_wire.sym} 380 -310 0 0 {name=p12 sig_type=std_logic lab=3up
}
C {lab_wire.sym} 570 -310 0 0 {name=p13 sig_type=std_logic lab=4up
}
C {lab_wire.sym} 730 -310 0 0 {name=p15 sig_type=std_logic lab=5up
}
C {lab_wire.sym} 220 30 0 0 {name=p16 sig_type=std_logic lab=2dn}
C {lab_wire.sym} 380 30 0 0 {name=p17 sig_type=std_logic lab=3dn}
C {lab_wire.sym} 570 30 0 0 {name=p18 sig_type=std_logic lab=4dn}
C {lab_wire.sym} 730 30 0 0 {name=p19 sig_type=std_logic lab=5dn}
