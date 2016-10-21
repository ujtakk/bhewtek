connect -url tcp:127.0.0.1:3121
source /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/SPM_ZED_HwPlatform/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248772850" && level==0} -index 1
fpga -file /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/SPM_ZED_HwPlatform/design_1_wrapper.bit
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
loadhw /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/SPM_ZED_HwPlatform/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
ps7_init
ps7_post_config
ps7_debug
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
dow /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/SPM_ZED_HwPlatform/executables/memstride_sw.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248772850"} -index 0
con
