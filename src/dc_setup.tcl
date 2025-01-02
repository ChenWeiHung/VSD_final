set_host_options -max_cores 16
set target_library "
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p7v125c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p7v25c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p7vm40c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p88v125c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p88v125c_i0p88v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p88v25c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p88v25c_i0p88v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p88vm40c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ff0p88vm40c_i0p88v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p6v125c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p6v25c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p6vm40c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p72v125c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p72v125c_i0p72v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p72v25c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p72v25c_i0p72v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p72vm40c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_ss0p72vm40c_i0p72v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p65v125c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p65v25c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p65vm40c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p72v125c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p72v25c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p72vm40c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p8v125c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p8v125c_i0p8v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p8v25c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p8v25c_i0p8v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p8vm40c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_dlvl_tt0p8vm40c_i0p8v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ff0p7v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ff0p7v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ff0p7vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ff0p88v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ff0p88v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ff0p88vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ff0p7v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ff0p7v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ff0p7vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ff0p88v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ff0p88v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ff0p88vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ss0p6v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ss0p6v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ss0p6vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ss0p72v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ss0p72v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_ss0p72vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_tt0p6v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_tt0p6v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_tt0p6vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_tt0p8v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_tt0p8v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_pg_tt0p8vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ss0p6v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ss0p6v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ss0p6vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ss0p72v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ss0p72v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ss0p72vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_tt0p6v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_tt0p6v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_tt0p6vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_tt0p8v125c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_tt0p8v25c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_tt0p8vm40c.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p7v125c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p7v25c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p7vm40c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p88v125c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p88v125c_i0p88v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p88v25c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p88v25c_i0p88v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p88vm40c_i0p7v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ff0p88vm40c_i0p88v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p6v125c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p6v25c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p6vm40c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p72v125c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p72v125c_i0p72v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p72v25c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p72v25c_i0p72v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p72vm40c_i0p6v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_ss0p72vm40c_i0p72v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p65v125c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p65v25c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p65vm40c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p8v125c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p8v125c_i0p8v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p8v25c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p8v25c_i0p8v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p8vm40c_i0p65v.db \
                    /home/summer/cell_library/SAED/14/stdcell_slvt/db_ccs/saed14slvt_ulvl_tt0p8vm40c_i0p8v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_ss0p72v125c_1p62v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_ff0p88v25c_1p96v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_ss0p72vm40c_1p62v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_tt0p8vm40c_1p8v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_ss0p72v25c_1p62v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_tt0p8v125c_1p8v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_ff0p88v125c_1p96v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_ff0p88vm40c_1p96v.db \
                    /home/summer/cell_library/SAED/14/io/lib/io_std/db_ccs/saed14io_fc_tt0p8v25c_1p8v.db \
                    /home/summer/cell_library/SAED/14/sram/lib/sram/logic_synth/dual/saed14sram_tt0p8v25c.db \
                    /home/summer/cell_library/SAED/14/sram/lib/sram/logic_synth/dual/saed14sram_ss0p72vm40c.db \
                    /home/summer/cell_library/SAED/14/sram/lib/sram/logic_synth/dual/saed14sram_ff0p88v125c.db \
                    /home/summer/cell_library/SAED/14/pll/lib/logic_synth/saed14pll_tt0p8v25c.db \
                    /home/summer/cell_library/SAED/14/pll/lib/logic_synth/saed14pll_ss0p72vm40c.db \
                    /home/summer/cell_library/SAED/14/pll/lib/logic_synth/saed14pll_ff0p88v125c.db \
                    "
set link_library "* $target_library dw_foundation.sldb"
set symbol_library    "generic.sdb"
set synthetic_library "dw_foundation.sldb"
set case_analysis_with_logic_constants true
set hdlin_translate_off_skip_text "TRUE"
set edifout_netlist_only "TRUE"
set verilogout_no_tri true

history keep 100
alias h history

#setup the design library
define_design_lib work -path ../work
analyze -f verilog -library work -format verilog Chip.v
elaborate Chip -architecture verilog -library work
link

#setup design environment
set_operating_conditions -min_library saed14slvt_ff0p88v125c -min ff0p88v125c  -max_library saed14slvt_ss0p6vm40c -max ss0p6vm40c
remove_wire_load_model
#set_leakage_optimization true
#set_attribute [get_libs typical.db:typical] default_threshold_voltage_group LVt -type string

set clock_period 1
#setup timing constraints
create_clock -name clk -period $clock_period [get_ports clk]
set_fix_hold [get_clocks clk]
set_ideal_network [get_ports {clk rst}]
set_dont_touch_network [get_ports {clk rst}]
set_clock_uncertainty 0.01 [get_clocks clk]
set all_inputs_except_clk_rst [remove_from_collection [all_inputs] [get_ports {clk rst}]]
set_input_delay -clock clk -max 0.6 $all_inputs_except_clk_rst
set_output_delay -clock clk -max 0.6 [all_outputs]
#set_load 40 [all_outputs]


#compile the design
set compile_enable_ccd true
compile_ultra -retime -timing_high_effort_script
#compile_ultra -incremental -retime

#write the design
change_names  -hierarchy -rules verilog
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule
write_file -format verilog -hier -o ./CPU.v
write_sdc ./CPU.sdc
write_sdf -version 2.1 ./CPU.sdf
write -hierarchy -format ddc

report_timing > ../reports/timing_report.rpt
report_area > ../reports/area_report.rpt
report_power > ../reports/power_report.rpt
report_clocks > ../reports/clock_report.rpt
report_reference > ../reports/reference_report.rpt
