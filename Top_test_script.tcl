transcript on

set designName src_calc
set moduleName top
set projDir   C:/Users/Alex/Desktop/FPGA/$moduleName


cd $projDir
vlib work

vlog ./${moduleName}.v
vlog ./${moduleName}_tb.sv
vlog ./mux_master.v
vlog ./mux_slave.sv
vlog ./master.sv
vlog ./slave.sv
vlog ./arbiter_v2.v


vsim -L work -lib work -t ns -voptargs="+acc" ${moduleName}_tb;

#quit -sim
#add wave -unsigned *


configure wave -timelineunits ns
