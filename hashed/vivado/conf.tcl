#
# STEP#0: define the output directory area.
#
source ./lib.tcl

set design zedboard_wrapper
set resultDir ./results
set reportDir ./reports
file mkdir $resultDir
file mkdir $reportDir
file mkdir $reportDir/timing
file mkdir $reportDir/power

#
# STEP#1: setup design sources and constraints
#
read_verilog  [ glob ../rtl/*.v ]
#read_verilog  [ glob ../zedboard/zedboard.srcs/sources_1/bd/design_1/hdl/*.v ]
read_xdc ./zedboard_master_XDC_RevC_D_v2.xdc

#
# STEP#2: run synthesis, report utilization and timing estimates, write checkpoint design
#
synth_design -top top_hash -part xc7z020clg484-1
source ./const.tcl
#write_checkpoint -force $resultDir/post_synth
report_timing_summary -file $reportDir/post_synth_timing_summary.rpt
report_power -verbose -file $reportDir/post_synth_power.rpt
#
# Run custom script to report critical timing paths
reportCriticalPaths $reportDir/post_synth_critpath_report.csv
write_verilog -force $resultDir/${design}_synth_netlist.v

for {set i 0} {$i < 10} {incr i} {
    for {set j 1} {$j <= 10} {incr j} {
        read_saif -strip_path rtl_top_hash/dut0 -file ../saif_rtl/saif8/rtl_top_hash${i}_${j}.saif
        report_switching_activity -signal_rate -static_probability [all_outputs]

        check_timing
        report_timing -file $reportDir/timing/top_hash${i}_${j}.timing.rpt

        report_power -verbose -file $reportDir/power/top_hash${i}_${j}.power.rpt
    }
}

#
# STEP#2.5: I/O Planning
#
#
# Ports
#place_ports
#
# I/O Standard
#set_property IOSTANDARD <standard_value> [get_ports *]
#
# NOT RECOMMENDED
#set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
#set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

#
# STEP#3: run placement and logic optimzation, report utilization and timing estimates, write checkpoint design
#
#opt_design
#place_design
#phys_opt_design
#write_checkpoint -force $resultDir/post_place
#report_timing_summary -file $reportDir/post_place_timing_summary.rpt
#write_hwdef -force -file $resultDir/$design.hwdef

#
# STEP#4: run router, report actual utilization and timing, write checkpoint design, run drc, write verilog and xdc out
#
#route_design
#write_checkpoint -force $resultDir/post_route
#report_timing_summary -file $reportDir/post_route_timing_summary.rpt
#report_timing -sort_by group -max_paths 100 -path_type summary -file $reportDir/post_route_timing.rpt
#report_clock_utilization -file $reportDir/clock_util.rpt
#report_utilization -file $reportDir/post_route_util.rpt
#report_power -file $reportDir/post_route_power.rpt
#report_drc -file $reportDir/post_imp_drc.rpt
#reportCriticalPaths $reportDir/post_impl_critpath_report.csv
#write_verilog -force $resultDir/${design}_impl_netlist.v
#write_xdc -no_fixed_only -force $resultDir/${design}_impl.xdc

#
# STEP#5: generate a bitstream
#
#write_bitstream -force $resultDir/$design.bit
#write_sysdef -force -bitfile $resultDir/$design.bit -hwdef $resultDir/$design.hwdef -file $resultDir/$design.sysdef

