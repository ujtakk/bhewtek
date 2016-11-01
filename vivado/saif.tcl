
for {set i 0} {$i < 10} {incr i} {
    for {set j 1} {$j <= 10} {incr j} {
        read_saif -strip_path test_top/dut0 -file ../saif_rtl/saif8/rtl_top${i}_${j}.saif
        report_switching_activity -signal_rate -static_probability [all_outputs]

        check_timing
        report_timing -file $reportDir/timing/top${i}_${j}.timing.rpt

        report_power -verbose -file $reportDir/power/top${i}_${j}.power.rpt
    }
}
