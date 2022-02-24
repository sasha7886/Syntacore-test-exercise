transcript on

set designName src_calc
set moduleName master
set projDir   C:/Users/Alex/Desktop/FPGA/top


cd $projDir
vlib work

vlog ./top_0.sv
vlog ./slave.sv
vlog ./master.sv



vsim -L work -lib work -t ns -voptargs="+acc" top_0;

#quit -sim
#add wave -unsigned *


configure wave -timelineunits ns
