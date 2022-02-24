transcript on

set designName src_calc
set moduleName mux_master
set projDir   C:/Users/Alex/Desktop/FPGA/top


cd $projDir
vlib work

vlog ./${moduleName}.v
vlog ./${moduleName}_tb.sv



vsim -L work -lib work -t ns -voptargs="+acc" ${moduleName}_tb;

#quit -sim
#add wave -unsigned *


configure wave -timelineunits ns
