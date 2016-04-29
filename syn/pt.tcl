set DESIGN "core"
set REPORTS_DIR "reports"
set RESULTS_DIR "results"
set_host_options -max_cores 16

sh date
source ./synopsys_dc.setup
set power_enable_analysis "true"
set power_analysis_mode "averaged"

read_verilog ./${RESULTS_DIR}/${DESIGN}.mapped.v
#source -echo -verbose ${DESIGN}.const.tcl
current_design ${DESIGN}
link
read_sdc ./${RESULTS_DIR}/${DESIGN}.sdc

#set_wire_load_mode enclosed

#read_saif -strip_path test_core/core0 ./rtl_core.saif
#report_switching_activity -list_not_annotated
#
#check_timing
#update_timing
#report_timing > ${REPORTS_DIR}/timing/${DESIGN}0_1.timing.rpt
#
#check_power
#update_power
#report_power -verbose -hierarchy -levels 2 > ${REPORTS_DIR}/power/${DESIGN}0_1.power.rpt

for {set i 0} {$i < 10} {incr i} {
    for {set j 1} {$j <= 10} {incr j} {
        read_saif -strip_path test_core/core0 ../rtl_sim/saif/rtl_core${i}_${j}.saif
        report_switching_activity -list_not_annotated

        check_timing
        update_timing
        report_timing > ${REPORTS_DIR}/timing/${DESIGN}${i}_${j}.timing.rpt

        check_power
        update_power
        report_power -verbose -hierarchy -levels 2 > ${REPORTS_DIR}/power/${DESIGN}${i}_${j}.power.rpt
    }
}

quit
