#-----------------------------------------------------------
# Vivado v2016.1 (64-bit)
# SW Build 1538259 on Fri Apr  8 15:45:23 MDT 2016
# IP Build 1537824 on Fri Apr  8 04:28:57 MDT 2016
# Start of session at: Tue Sep 27 18:41:54 2016
# Process ID: 24646
# Current directory: /ram/home/takau
# Command line: vivado
# Log file: /ram/home/takau/vivado.log
# Journal file: /ram/home/takau/vivado.jou
#-----------------------------------------------------------

# start_gui
open_project /ram/home/work/takau/bhewtek/zedboard/zedboard.xpr
update_compile_order -fileset sources_1
open_bd_design {/ram/home/work/takau/bhewtek/zedboard/zedboard.srcs/sources_1/bd/cnn_system/cnn_system.bd}
update_ip_catalog -rebuild -scan_changes
report_ip_status -name ip_status
export_ip_user_files -of_objects [get_ips  cnn_system_copro_0_0] -no_script -reset -quiet
upgrade_ip -vlnv ac.jp:user:copro:1.0 [get_ips  cnn_system_copro_0_0] -log ip_upgrade.log
generate_target all [get_files  /ram/home/work/takau/bhewtek/zedboard/zedboard.srcs/sources_1/bd/cnn_system/cnn_system.bd]
export_ip_user_files -of_objects [get_files /ram/home/work/takau/bhewtek/zedboard/zedboard.srcs/sources_1/bd/cnn_system/cnn_system.bd] -no_script -force -quiet
export_simulation -of_objects [get_files /ram/home/work/takau/bhewtek/zedboard/zedboard.srcs/sources_1/bd/cnn_system/cnn_system.bd] -directory /ram/home/work/takau/bhewtek/zedboard/zedboard.ip_user_files/sim_scripts -ip_user_files_dir /ram/home/work/takau/bhewtek/zedboard/zedboard.ip_user_files -ipstatic_source_dir /ram/home/work/takau/bhewtek/zedboard/zedboard.ip_user_files/ipstatic -force -quiet
report_ip_status -name ip_status 
reset_run synth_1
launch_runs synth_1 -jobs 2
wait_on_run synth_1
launch_runs impl_1 -jobs 2
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1
file copy -force /ram/home/work/takau/bhewtek/zedboard/zedboard.runs/impl_1/cnn_system_wrapper.sysdef /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/cnn_system_wrapper.hdf

# launch_sdk -workspace /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk -hwspec /ram/home/work/takau/bhewtek/zedboard/zedboard.sdk/cnn_system_wrapper.hdf
