vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/processing_system7_bfm_v2_0_5/hdl" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0_5/hdl" \
"../../../../zedboard.srcs/sources_1/ip/processing_system7_0/processing_system7_0_sim_netlist.v" \


vlog -work xil_defaultlib "glbl.v"

