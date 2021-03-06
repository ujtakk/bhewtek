vlib work
vlib activehdl

vlib activehdl/processing_system7_bfm_v2_0_5
vlib activehdl/xil_defaultlib
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/proc_sys_reset_v5_0_9
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/fifo_generator_v13_1_1
vlib activehdl/axi_data_fifo_v2_1_8
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_register_slice_v2_1_9
vlib activehdl/axi_protocol_converter_v2_1_9

vmap processing_system7_bfm_v2_0_5 activehdl/processing_system7_bfm_v2_0_5
vmap xil_defaultlib activehdl/xil_defaultlib
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_9 activehdl/proc_sys_reset_v5_0_9
vmap generic_baseblocks_v2_1_0 activehdl/generic_baseblocks_v2_1_0
vmap fifo_generator_v13_1_1 activehdl/fifo_generator_v13_1_1
vmap axi_data_fifo_v2_1_8 activehdl/axi_data_fifo_v2_1_8
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_9 activehdl/axi_register_slice_v2_1_9
vmap axi_protocol_converter_v2_1_9 activehdl/axi_protocol_converter_v2_1_9

vlog -work processing_system7_bfm_v2_0_5 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr_4.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd_4.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp2_3.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp0_1.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ssw_hp.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_sparse_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_reg_map.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocm_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_wr_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_rd_mem.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_fmsw_gp.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_regc.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocmc.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_interconnect_model.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_reset.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_clock.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ddrc.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_slave.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_master.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_afi_slave.v" \
"../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_processing_system7_bfm.v" \

vlog -work xil_defaultlib -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../bd/cnn_system/ip/cnn_system_processing_system7_0_0/sim/cnn_system_processing_system7_0_0.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl/copro_v1_0_s_axi.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mem_linebuf.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/conv_tree.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/conv_wreg.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/bias.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/ctrl_bias.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/linebuf.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/ctrl_conv.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/pool.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/ctrl_pool.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/conv.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/ctrl_relu.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/accumulator.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mem_feat.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/ctrl_core.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/relu.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mem_bias.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mux_output.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mem_input.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/newctrl.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/core.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mem_weight.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/mem_output.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/decoder.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/src/top.v" \
"../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl/copro_v1_0.v" \
"../../../bd/cnn_system/ip/cnn_system_copro_0_0/sim/cnn_system_copro_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \

vcom -work proc_sys_reset_v5_0_9 -93 \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
"../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/cnn_system/ip/cnn_system_rst_processing_system7_0_100M_0/sim/cnn_system_rst_processing_system7_0_100M_0.vhd" \

vlog -work xil_defaultlib -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../bd/cnn_system/hdl/cnn_system.v" \

vlog -work generic_baseblocks_v2_1_0 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
"../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \

vlog -work fifo_generator_v13_1_1 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/fifo_generator_v13_1/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_1 -93 \
"../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_1 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work axi_data_fifo_v2_1_8 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
"../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \

vlog -work axi_infrastructure_v1_1_0 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
"../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \

vlog -work axi_register_slice_v2_1_9 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
"../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \

vlog -work axi_protocol_converter_v2_1_9 -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
"../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \

vlog -work xil_defaultlib -v2k5 "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" "+incdir+../../../bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" "+incdir+../../../ipstatic/processing_system7_bfm_v2_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/hdl" "+incdir+../../../../zedboard.srcs/sources_1/bd/cnn_system/ipshared/ac.jp/copro_v1_0/src" \
"../../../bd/cnn_system/ip/cnn_system_auto_pc_0/sim/cnn_system_auto_pc_0.v" \

vlog -work xil_defaultlib "glbl.v"

