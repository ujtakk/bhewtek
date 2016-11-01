set top_dir [exec git rev-parse --show-toplevel]
set board   zedboard
set sdk     $top_dir/$board/$board.sdk
set cable   "Digilent Zed 210248772850"

# specify your own address:port
connect -url tcp:127.0.0.1:3121

source $sdk/cnn_system_wrapper_hw_platform_0/ps7_init.tcl

targets -set -filter {name =~"APU" && jtag_cable_name =~ $cable} -index 0
rst -system

after 3000

targets -set -filter {jtag_cable_name =~ $cable && level==0} -index 1
fpga -file $sdk/cnn_system_wrapper_hw_platform_0/cnn_system_wrapper.bit

targets -set -filter {name =~"APU" && jtag_cable_name =~ $cable} -index 0
loadhw $sdk/cnn_system_wrapper_hw_platform_0/system.hdf

targets -set -filter {name =~"APU" && jtag_cable_name =~ $cable} -index 0
ps7_init
ps7_post_config

targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ $cable} -index 0
dow $sdk/cnn/Debug/cnn.elf
con
