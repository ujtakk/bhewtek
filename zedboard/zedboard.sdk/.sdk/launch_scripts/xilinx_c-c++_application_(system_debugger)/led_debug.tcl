connect -url tcp:127.0.0.1:3121
source /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/cnn_system_wrapper_hw_platform_0/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248772850" && level==0} -index 1
fpga -file /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/cnn_system_wrapper_hw_platform_0/cnn_system_wrapper.bit
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
loadhw /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/cnn_system_wrapper_hw_platform_0/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
dow /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/led/Debug/led.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
con
