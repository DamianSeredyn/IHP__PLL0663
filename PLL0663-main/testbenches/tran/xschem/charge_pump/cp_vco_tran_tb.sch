v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 380 30 380 90 {lab=#net1}
N 310 -10 340 -10 {lab=rst}
N 380 -10 400 -10 {lab=#net1}
N 400 -10 400 30 {lab=#net1}
N 380 30 400 30 {lab=#net1}
N 380 20 380 30 {lab=#net1}
N -330 -60 -330 -30 {lab=rst}
N 590 -160 610 -160 {lab=out_cp2}
N 380 -160 380 -40 {lab=#net2}
N 310 -160 380 -160 {lab=#net2}
N 510 -160 510 -120 {lab=out_cp2}
N 380 -160 400 -160 {lab=#net2}
N 460 -160 510 -160 {lab=out_cp2}
N 510 -40 510 -10 {lab=0}
N 510 -40 540 -40 {lab=0}
N 510 -80 510 -40 {lab=0}
N 540 -80 540 -40 {lab=0}
N 480 -40 510 -40 {lab=0}
N 480 -80 480 -40 {lab=0}
N 610 -310 610 -160 {lab=out_cp2}
N 590 -30 590 0 {lab=0}
N 590 -30 620 -30 {lab=0}
N 590 -70 590 -30 {lab=0}
N 620 -70 620 -30 {lab=0}
N 560 -30 590 -30 {lab=0}
N 560 -70 560 -30 {lab=0}
N 660 -30 660 0 {lab=0}
N 660 -30 690 -30 {lab=0}
N 660 -70 660 -30 {lab=0}
N 690 -70 690 -30 {lab=0}
N 630 -30 660 -30 {lab=0}
N 630 -70 630 -30 {lab=0}
N 590 -160 590 -110 {lab=out_cp2}
N 510 -160 590 -160 {lab=out_cp2}
N 610 -160 660 -160 {lab=out_cp2}
N 660 -160 660 -110 {lab=out_cp2}
C {devices/code_shown.sym} -180 -600 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
C {devices/code_shown.sym} -420 -680 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp 27
.param Vp=1.2

.param Lcs=0.16*4u
.param Ldrv=0.16*2u

.control

tran 10n 5u

wrdata cp_test.txt v(x1.bias)
plot v(out_cp2) v(out_vco)
write aa_cp_vco.raw

set filetype=ascii

set appendwrite
.endc
"}
C {vsource.sym} -380 -220 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -380 -190 0 0 {name=l16 lab=0}
C {lab_pin.sym} -380 -250 0 0 {name=p47 sig_type=std_logic lab=vp}
C {vsource.sym} -260 -220 0 0 {name=Vup2
value=1.2 savecurrent=false}
C {gnd.sym} -260 -190 0 0 {name=l11 lab=0}
C {vsource.sym} -260 -110 0 0 {name=Vdn2
value=0 savecurrent=false}
C {gnd.sym} -330 30 0 0 {name=l12 lab=0}
C {lab_pin.sym} -260 -250 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} -260 -140 0 1 {name=p31 sig_type=std_logic lab=dn}
C {gnd.sym} 380 150 0 0 {name=l2 lab=0}
C {lab_pin.sym} 310 -10 0 0 {name=p5 sig_type=std_logic lab=rst}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 360 -10 0 0 {name=M2
l=0.6u
w=2.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {vsource.sym} 380 120 0 0 {name=Voutbias
value=0.4 savecurrent=false}
C {gnd.sym} 510 -10 0 0 {name=l1 lab=0}
C {vsource.sym} -330 0 0 0 {name=Vrst
value="PULSE(0 1.2 0 1n 1n 0.2u 1)" savecurrent=false}
C {lab_pin.sym} -330 -60 0 0 {name=p1 sig_type=std_logic lab=rst}
C {lab_pin.sym} 970 -310 0 1 {name=p3 sig_type=std_logic lab=out_vco}
C {gnd.sym} -260 -80 0 0 {name=l3 lab=0}
C {lab_pin.sym} 150 -230 0 0 {name=p4 sig_type=std_logic lab=vp}
C {gnd.sym} 150 -90 0 0 {name=l4 lab=0}
C {lab_pin.sym} 10 -190 0 0 {name=p6 sig_type=std_logic lab=up}
C {lab_pin.sym} 10 -130 0 0 {name=p7 sig_type=std_logic lab=dn}
C {lab_pin.sym} 790 -400 0 0 {name=p8 sig_type=std_logic lab=vp}
C {gnd.sym} 790 -220 0 0 {name=l5 lab=0}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13g2_pr/rppd.sym} 430 -160 1 0 {name=R2
w=0.5e-6
l=0.5e-6
model=rppd
body=gd
spiceprefix=X
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 510 -100 1 0 {name=M1
l=10u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/charge_pump/charge_pump_cell.sym} 160 -160 0 0 {name=x1}
C {lab_pin.sym} 570 -160 0 0 {name=p9 sig_type=std_logic lab=out_cp2}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/vco/vco_core_0.sym} 790 -310 0 0 {name=x2}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 590 -90 1 0 {name=M3
l=10u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 660 -90 1 0 {name=M4
l=10u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} 590 0 0 0 {name=l6 lab=0}
C {gnd.sym} 660 0 0 0 {name=l7 lab=0}
