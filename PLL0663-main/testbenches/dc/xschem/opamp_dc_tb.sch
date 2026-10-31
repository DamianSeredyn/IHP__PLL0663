v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1130 -210 1130 -180 {lab=gd}
N 1110 -210 1110 -180 {lab=bias}
N 1130 -380 1130 -350 {lab=vp}
N 970 -250 970 -200 {lab=inm}
N 850 -310 850 -200 {lab=inp}
N 970 -140 970 -100 {lab=#net1}
N 850 -140 850 -100 {lab=#net1}
N 970 -250 1050 -250 {lab=inm}
N 1010 -190 1030 -190 {lab=in}
N 1010 -150 1030 -150 {lab=gd}
N 790 -190 810 -190 {lab=in}
N 790 -150 810 -150 {lab=gd}
N 1300 -280 1300 -200 {lab=out}
N 1300 -140 1300 -100 {lab=gd}
N 140 -40 140 -0 {lab=0}
N 140 -140 140 -80 {lab=gd}
N 230 -40 230 -20 {lab=sub!}
N 230 -140 230 -100 {lab=gd}
N 140 -180 140 -140 {lab=gd}
N 140 -280 140 -240 {lab=vp}
N 140 -140 230 -140 {lab=gd}
N 320 -280 320 -240 {lab=in}
N 230 -140 320 -140 {lab=gd}
N 320 -180 320 -140 {lab=gd}
N 910 -100 970 -100 {lab=#net1}
N 910 -100 910 -80 {lab=#net1}
N 850 -100 910 -100 {lab=#net1}
N 910 -20 910 0 {lab=gd}
N 1230 -280 1300 -280 {lab=out}
N 490 -370 490 -320 {lab=vp}
N 490 -100 490 10 {lab=gd}
N 700 -210 720 -210 {lab=bias}
N 850 -310 1050 -310 {lab=inp}
N 620 -210 640 -210 {lab=#net2}
C {lab_wire.sym} 1110 -180 3 1 {name=p4 sig_type=std_logic lab=bias}
C {lab_wire.sym} 1130 -180 3 1 {name=p5 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1130 -380 3 0 {name=p6 sig_type=std_logic lab=vp}
C {vcvs.sym} 850 -170 0 0 {name=EINP value=0.5}
C {vcvs.sym} 970 -170 0 1 {name=EINM value=-0.5}
C {lab_wire.sym} 1030 -310 0 0 {name=p7 sig_type=std_logic lab=inp}
C {lab_wire.sym} 1030 -250 0 0 {name=p8 sig_type=std_logic lab=inm}
C {lab_wire.sym} 800 -150 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_wire.sym} 800 -190 0 0 {name=p12 sig_type=std_logic lab=in}
C {lab_wire.sym} 1020 -150 0 1 {name=p13 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1020 -190 0 1 {name=p14 sig_type=std_logic lab=in}
C {capa-2.sym} 1300 -170 0 0 {name=C1
m=1
value=xcload
footprint=1206
device=polarized_capacitor}
C {lab_wire.sym} 1300 -100 3 1 {name=p15 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1290 -280 0 0 {name=p16 sig_type=std_logic lab=out}
C {vsource.sym} 140 -70 0 0 {name=VGD value=0 savecurrent=false}
C {vsource.sym} 140 -210 0 0 {name=VP value=xvp savecurrent=false}
C {vsource.sym} 230 -70 0 0 {name=VSUB value=0 savecurrent=false}
C {sg13cmos5l_pr/sub.sym} 230 -20 0 0 {name=l1 lab=sub!}
C {lab_wire.sym} 140 -20 3 0 {name=p17 sig_type=std_logic lab=0}
C {lab_wire.sym} 200 -140 0 0 {name=p18 sig_type=std_logic lab=gd}
C {lab_wire.sym} 140 -270 3 0 {name=p19 sig_type=std_logic lab=vp}
C {vsource.sym} 320 -210 0 0 {name=VIN value="DC xvid" ac=1 savecurrent=false}
C {lab_wire.sym} 320 -270 3 0 {name=p20 sig_type=std_logic lab=in}
C {vsource.sym} 910 -50 0 0 {name=VCM value='xvp/2' savecurrent=false}
C {lab_wire.sym} 910 -10 3 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_wire.sym} 490 0 3 0 {name=p1 sig_type=std_logic lab=gd}
C {vsource.sym} 670 -210 1 0 {name=Vibias value=0 savecurrent=true}
C {lab_wire.sym} 720 -210 0 0 {name=p2 sig_type=std_logic lab=bias}
C {lab_wire.sym} 490 -360 3 0 {name=p3 sig_type=std_logic lab=vp}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/opamp_folded.sym} 1050 -310 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/const_gm_bias.sym} 400 -120 0 0 {name=x2}
C {netlist.sym} 20 -830 0 0 {name=s1 
value="
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerPNP.lib typ

.param xvp=3.3
.param xvid=0
.param xcload=1p
.param xtemp=25

.probe v(out)
.probe v(inp)
.probe v(inm
.probe isub(x2)

.temp 'xtemp'
.dc VIN -10m 10m 1u

.option rshunt=1e12
.option gmin=1e-12

.control
run
save all
set filetype=ascii
write opamp_dc_tb.raw all
.endc
"
      
}
