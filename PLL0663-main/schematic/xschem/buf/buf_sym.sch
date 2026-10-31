v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -450 -290 -450 -270 {lab=VDD}
N -450 -210 -450 -190 {lab=0}
N -360 -210 -360 -190 {lab=0}
N -360 -300 -360 -270 {lab=Vin}
N -220 -10 -90 -10 {lab=Vin}
N 10 -90 10 -60 {lab=VDD}
N 10 40 10 70 {lab=0}
N 230 -10 290 -10 {lab=Vout}
N 230 90 230 110 {lab=0}
N 230 -10 230 30 {lab=Vout}
N 120 -10 230 -10 {lab=Vout}
C {buf.sym} 10 -10 0 0 {name=x1}
C {simulator_commands_shown.sym} 80 -410 0 0 {
name=Libs_Ngspice1
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerDIO.lib dio_tt
"}
C {simulator_commands_shown.sym} 90 -230 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.param temp=27
.control
save all
tran 0.01n 1u
write buf.raw
show all > op_report.txt
.endc
"}
C {vsource.sym} -450 -240 0 0 {name=Vdd value=1.2 savecurrent=false}
C {vdd.sym} -450 -290 0 0 {name=l3 lab=VDD}
C {gnd.sym} -450 -190 0 0 {name=l4 lab=0}
C {vsource.sym} -360 -240 0 0 {name=Vin 
value="pulse(0 1.2 1ns 100ps 100ps 3.333ns 6.667ns)" 
savecurrent=false}
C {gnd.sym} -360 -190 0 0 {name=Vin1 lab=0
value=0}
C {lab_pin.sym} -220 -10 0 0 {name=p1 sig_type=std_logic lab=Vin
}
C {lab_pin.sym} -360 -300 2 0 {name=p2 sig_type=std_logic lab=Vin
}
C {vdd.sym} 10 -90 0 0 {name=l1 lab=VDD}
C {gnd.sym} 10 70 0 0 {name=l2 lab=0}
C {lab_pin.sym} 290 -10 2 0 {name=p3 sig_type=std_logic lab=Vout

}
C {capa-2.sym} 230 60 0 0 {name=C1
m=1
value=1p
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 230 110 0 0 {name=l9 lab=0}
