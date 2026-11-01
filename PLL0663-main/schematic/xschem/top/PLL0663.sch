v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -190 70 -150 70 {lab=rst}
N -180 30 -150 30 {lab=vp}
N -180 10 -150 10 {lab=vph}
N -180 50 -150 50 {lab=gd}
N -190 90 -150 90 {lab=clk_ref}
N -190 110 -150 110 {lab=clk_in}
N -190 130 -150 130 {lab=data_en}
N -190 150 -150 150 {lab=data_in}
N 150 10 180 10 {lab=vout}
N 150 30 180 30 {lab=out}
N 150 50 180 50 {lab=debug_out}
N -200 -180 -160 -180 {lab=vp_bandgap}
N -200 -160 -160 -160 {lab=gd}
N 140 -180 170 -180 {lab=vref_res}
N 140 -160 170 -160 {lab=vref_sb}
N -180 170 -150 170 {lab=vph}
C {chip_top.sym} 0 80 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/bandgap_top.sym} -10 -170 0 0 {name=x2}
C {ipin.sym} -190 70 0 0 {name=p7 lab=rst}
C {ipin.sym} -310 -60 0 0 {name=p1 lab=vp}
C {ipin.sym} -310 -30 0 0 {name=p2 lab=gd}
C {ipin.sym} -310 -100 0 0 {name=p21 lab=vph}
C {lab_wire.sym} -180 30 0 0 {name=p15 sig_type=std_logic lab=vp}
C {lab_wire.sym} -180 10 0 0 {name=p3 sig_type=std_logic lab=vph}
C {lab_wire.sym} -180 50 0 0 {name=p4 sig_type=std_logic lab=gd}
C {ipin.sym} -190 90 0 0 {name=p5 lab=clk_ref}
C {ipin.sym} -190 110 0 0 {name=p6 lab=clk_in}
C {ipin.sym} -190 130 0 0 {name=p8 lab=data_en}
C {ipin.sym} -190 150 0 0 {name=p9 lab=data_in
}
C {opin.sym} 180 50 0 0 {name=p24 lab=debug_out}
C {opin.sym} 180 30 0 0 {name=p10 lab=out}
C {opin.sym} 180 10 0 0 {name=p11 lab=vout}
C {ipin.sym} -200 -180 0 0 {name=p13 lab=vp_bandgap}
C {lab_wire.sym} -200 -160 0 0 {name=p12 sig_type=std_logic lab=gd}
C {opin.sym} 170 -180 0 0 {name=p14 lab=vref_res}
C {opin.sym} 170 -160 0 0 {name=p16 lab=vref_sb}
C {ipin.sym} -130 -100 0 0 {name=p17 lab=vph_debug}
C {lab_wire.sym} -180 170 0 0 {name=p18 sig_type=std_logic lab=vph_debug}
