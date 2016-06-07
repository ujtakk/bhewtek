# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# Block Designs: bd/zboard/zboard.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard || ORIG_REF_NAME==zboard}]

# IP: bd/zboard/ip/zboard_processing_system7_0_0/zboard_processing_system7_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard_processing_system7_0_0 || ORIG_REF_NAME==zboard_processing_system7_0_0}]

# IP: bd/zboard/ip/zboard_axi_slave_top_wrapper_0_0/zboard_axi_slave_top_wrapper_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard_axi_slave_top_wrapper_0_0 || ORIG_REF_NAME==zboard_axi_slave_top_wrapper_0_0}]

# IP: bd/zboard/ip/zboard_processing_system7_0_axi_periph_0/zboard_processing_system7_0_axi_periph_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard_processing_system7_0_axi_periph_0 || ORIG_REF_NAME==zboard_processing_system7_0_axi_periph_0}]

# IP: bd/zboard/ip/zboard_rst_processing_system7_0_100M_0/zboard_rst_processing_system7_0_100M_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==zboard_rst_processing_system7_0_100M_0}]

# IP: bd/zboard/ip/zboard_auto_pc_0/zboard_auto_pc_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard_auto_pc_0 || ORIG_REF_NAME==zboard_auto_pc_0}]

# IP: bd/zboard/ip/zboard_auto_us_0/zboard_auto_us_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==zboard_auto_us_0 || ORIG_REF_NAME==zboard_auto_us_0}]

# XDC: bd/zboard/ip/zboard_processing_system7_0_0/zboard_processing_system7_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==zboard_processing_system7_0_0 || ORIG_REF_NAME==zboard_processing_system7_0_0}] {/inst }]/inst ]]

# XDC: bd/zboard/ip/zboard_rst_processing_system7_0_100M_0/zboard_rst_processing_system7_0_100M_0_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==zboard_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==zboard_rst_processing_system7_0_100M_0}] {/U0 }]/U0 ]]

# XDC: bd/zboard/ip/zboard_rst_processing_system7_0_100M_0/zboard_rst_processing_system7_0_100M_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==zboard_rst_processing_system7_0_100M_0 || ORIG_REF_NAME==zboard_rst_processing_system7_0_100M_0}] {/U0 }]/U0 ]]

# XDC: bd/zboard/ip/zboard_rst_processing_system7_0_100M_0/zboard_rst_processing_system7_0_100M_0_ooc.xdc

# XDC: bd/zboard/ip/zboard_auto_pc_0/zboard_auto_pc_0_ooc.xdc

# XDC: bd/zboard/ip/zboard_auto_us_0/zboard_auto_us_0_ooc.xdc

# XDC: bd/zboard/ip/zboard_auto_us_0/zboard_auto_us_0_clocks.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==zboard_auto_us_0 || ORIG_REF_NAME==zboard_auto_us_0}] {/inst }]/inst ]]

# XDC: bd/zboard/zboard_ooc.xdc