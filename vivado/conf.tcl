#
# STEP#0: define the output directory area.
#
source ./lib.tcl

set design top
set reportDir reports
file mkdir $design
file mkdir $reportDir
file mkdir $reportDir/timing
file mkdir $reportDir/power

create_project -force top $design -part xc7z020clg484-1
add_files [ glob ../rtl/*.v ]
add_files [ glob ../rtl/*.vh ]
add_files -fileset sim_1 ../rtl/test_top.v
import_files -force -norecurse
#import_files -fileset constrs_1 -force -norecurse ./Sources/bft_full_kintex7.xdc

# Mimic GUI behavior of automatically setting top and file compile order
set_property top top [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Launch Synthesis
launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1

# Generate a timing and power reports and write to disk
report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $reportDir/syn_timing.rpt
report_power -file $reportDir/syn_power.rpt
#write_hwdef -file $design.hwdef

source ./const.tcl
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# Launch Implementation
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# Generate a timing and power reports and write to disk
# comment out the open_run for batch mode
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file $reportDir/imp_timing.rpt
report_power -file $reportDir/imp_power.rpt
#write_sysdef -bitfile -hwdef $design.hwdef -file $design.sysdef

# comment out the for batch mode
#start_gui
