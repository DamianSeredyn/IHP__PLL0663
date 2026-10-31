v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1080 -210 1080 -180 {lab=gd}
N 1060 -210 1060 -180 {lab=bias}
N 1080 -380 1080 -350 {lab=vp}
N 920 -250 920 -200 {lab=inm}
N 800 -310 800 -200 {lab=#net1}
N 920 -140 920 -100 {lab=#net2}
N 800 -140 800 -100 {lab=#net2}
N 920 -250 1000 -250 {lab=inm}
N 960 -190 980 -190 {lab=in}
N 960 -150 980 -150 {lab=gd}
N 740 -190 760 -190 {lab=in}
N 740 -150 760 -150 {lab=gd}
N 1250 -280 1250 -200 {lab=out}
N 1250 -140 1250 -100 {lab=gd}
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
N 860 -100 920 -100 {lab=#net2}
N 860 -100 860 -80 {lab=#net2}
N 800 -100 860 -100 {lab=#net2}
N 860 -20 860 0 {lab=gd}
N 1180 -280 1250 -280 {lab=out}
N 510 -290 510 -240 {lab=vp}
N 510 -120 510 -10 {lab=gd}
N 620 -180 680 -180 {lab=#net3}
N 680 -210 680 -180 {lab=#net3}
N 680 -290 680 -270 {lab=bias}
N 900 -310 1000 -310 {lab=inp}
N 800 -310 840 -310 {lab=#net1}
C {lab_wire.sym} 1060 -180 3 1 {name=p4 sig_type=std_logic lab=bias}
C {lab_wire.sym} 1080 -180 3 1 {name=p5 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1080 -380 3 0 {name=p6 sig_type=std_logic lab=vp}
C {vcvs.sym} 800 -170 0 0 {name=EINP value=0.5}
C {vcvs.sym} 920 -170 0 1 {name=EINM value=-0.5}
C {lab_wire.sym} 980 -310 0 0 {name=p7 sig_type=std_logic lab=inp}
C {lab_wire.sym} 980 -250 0 0 {name=p8 sig_type=std_logic lab=inm}
C {lab_wire.sym} 750 -150 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_wire.sym} 750 -190 0 0 {name=p12 sig_type=std_logic lab=in}
C {lab_wire.sym} 970 -150 0 1 {name=p13 sig_type=std_logic lab=gd}
C {lab_wire.sym} 970 -190 0 1 {name=p14 sig_type=std_logic lab=in}
C {capa-2.sym} 1250 -170 0 0 {name=C1
m=1
value=xcload
footprint=1206
device=polarized_capacitor}
C {lab_wire.sym} 1250 -100 3 1 {name=p15 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1240 -280 0 0 {name=p16 sig_type=std_logic lab=out}
C {vsource.sym} 140 -70 0 0 {name=VGD value=0 savecurrent=false}
C {vsource.sym} 140 -210 0 0 {name=VP value=xvp savecurrent=false}
C {vsource.sym} 230 -70 0 0 {name=VSUB value=0 savecurrent=false}
C {sg13cmos5l_pr/sub.sym} 230 -20 0 0 {name=l1 lab=sub!}
C {lab_wire.sym} 140 -20 3 0 {name=p17 sig_type=std_logic lab=0}
C {lab_wire.sym} 200 -140 0 0 {name=p18 sig_type=std_logic lab=gd}
C {lab_wire.sym} 140 -270 3 0 {name=p19 sig_type=std_logic lab=vp}
C {simulator_commands_shown.sym} 0 -960 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerDIO.lib dio_tt
.lib cornerPNP.lib typ

.param xvp=3.3
.param xibias=10u
.param xvioff=79.9743u
.param xcload=1p

.param xtemp=25

.probe alli
.probe V(X1)
.probe isub(x1)
.save all

.temp 25
.ac DEC 101 1 1G


.control
run
save all
set filetype=ascii
write opamp_ac_tb.raw all
.endc
"
      }
C {vsource.sym} 320 -210 0 0 {name=VIN value="DC 0 AC 1" ac=1 savecurrent=false}
C {lab_wire.sym} 320 -270 3 0 {name=p20 sig_type=std_logic lab=in}
C {vsource.sym} 860 -50 0 0 {name=VCM value='xvp/2' savecurrent=false}
C {lab_wire.sym} 860 -10 3 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_wire.sym} 510 -20 3 0 {name=p1 sig_type=std_logic lab=gd}
C {vsource.sym} 680 -240 0 0 {name=Vibias value=0 savecurrent=true}
C {lab_wire.sym} 680 -290 3 0 {name=p2 sig_type=std_logic lab=bias}
C {lab_wire.sym} 510 -280 3 0 {name=p3 sig_type=std_logic lab=vp}
C {vsource.sym} 870 -310 1 1 {name=Vioff value=xvioff savecurrent=false}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/opamp_folded.sym} 1000 -310 0 0 {name=x1}
C {/foss/designs/IHP__PLL0663/PLL0663-main/schematic/xschem/bandgap/const_gm_bias.sym} 420 -180 0 0 {name=x2}
