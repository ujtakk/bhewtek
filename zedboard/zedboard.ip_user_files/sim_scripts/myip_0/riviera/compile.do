vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib -v2k5 "+incdir+../../../../zedboard.srcs/sources_1/dist" "+incdir+../../../../zedboard.srcs/sources_1/dist" \
"../../../../zedboard.srcs/sources_1/dist/conv_wreg.v" \
"../../../../zedboard.srcs/sources_1/dist/conv_tree.v" \
"../../../../zedboard.srcs/sources_1/dist/pool.v" \
"../../../../zedboard.srcs/sources_1/dist/sram_feat.v" \
"../../../../zedboard.srcs/sources_1/dist/conv.v" \
"../../../../zedboard.srcs/sources_1/dist/accumulator.v" \
"../../../../zedboard.srcs/sources_1/dist/linebuf_feat.v" \
"../../../../zedboard.srcs/sources_1/dist/sram_input.v" \
"../../../../zedboard.srcs/sources_1/dist/linebuf_pix.v" \
"../../../../zedboard.srcs/sources_1/dist/sram_output.v" \
"../../../../zedboard.srcs/sources_1/dist/ctrl.v" \
"../../../../zedboard.srcs/sources_1/dist/mux_output.v" \
"../../../../zedboard.srcs/sources_1/dist/decoder.v" \
"../../../../zedboard.srcs/sources_1/dist/core.v" \
"../../../../zedboard.srcs/sources_1/dist/sram_weight.v" \
"../../../../zedboard.srcs/sources_1/ip/myip_0/hdl/myip_v1_0_S_AXI.v" \
"../../../../zedboard.srcs/sources_1/dist/top.v" \
"../../../../zedboard.srcs/sources_1/ip/myip_0/hdl/myip_v1_0.v" \
"../../../../zedboard.srcs/sources_1/ip/myip_0/sim/myip_0.v" \


vlog -work xil_defaultlib "glbl.v"

