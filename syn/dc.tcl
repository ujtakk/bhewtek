set DESIGN "top"
set REPORTS_DIR "reports"
set RESULTS_DIR "results"
file mkdir $REPORTS_DIR
file mkdir $RESULTS_DIR
set_host_options -max_cores 16

sh date
source ./synopsys_dc.setup
read_file -format verilog accumulator.v
read_file -format verilog conv.v
read_file -format verilog conv_tree.v
read_file -format verilog conv_wreg.v
read_file -format verilog core.v
read_file -format verilog ctrl.v
read_file -format verilog linebuf_feat.v
read_file -format verilog linebuf_pix.v
read_file -format verilog pool.v
read_file -format verilog sram_feat.v
read_file -format verilog sram_input.v
read_file -format verilog sram_output.v
read_file -format verilog sram_weight.v
read_file -format verilog test_top.v
read_file -format verilog top.v
#read_file -format verilog ${DESIGN}.v

source -echo -verbose ${DESIGN}.const.tcl
current_design ${DESIGN}

link
#set dont_touch_network true
set_wire_load_mode enclosed

set_max_area 0
#compile_ultra -gate_clock
#compile_ultra
#set_fix_multiple_port_nets -all -buffer_constants
compile -power_effort high
#ungroup -flatten -all
#define_name_rules verilog -allowed "a-zA-Z0-9_" -remove_port_bus
change_names -rules verilog -hierarchy
check_design

write -format verilog -hierarchy -output ./${RESULTS_DIR}/${DESIGN}.mapped.v
write -format vhdl -hierarchy -output ./${RESULTS_DIR}/${DESIGN}.mapped.vhd
write -format ddc -output ${RESULTS_DIR}/${DESIGN}.mapped.ddc
write_sdf ./${RESULTS_DIR}/${DESIGN}.sdf
write_sdc -nosplit -version 1.9 ./${RESULTS_DIR}/${DESIGN}.sdc

report_qor > ${REPORTS_DIR}/${DESIGN}.mapped.qor.rpt
report_area -nosplit > ${REPORTS_DIR}/${DESIGN}.mapped.area.rpt
report_timing -transition_time -nets -attributes -nosplit -group clk > ${REPORTS_DIR}/${DESIGN}.mapped.timing.rpt
report_power -verbose -analysis_effort high -hierarchy -levels 2 > ${REPORTS_DIR}/${DESIGN}.mapped.power.rpt

quit
