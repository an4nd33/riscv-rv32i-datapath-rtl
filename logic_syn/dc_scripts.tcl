###############################################################################
# Design Compiler Script – Clock Period Sweep (top_system)
###############################################################################

set_host_options -max_cores 4

# ---------------- Directory Setup ----------------
set REPORT_DIR  ./reports
set NETLIST_DIR ./netlist
set LOG_DIR     ./logs

file mkdir $REPORT_DIR
file mkdir $NETLIST_DIR
file mkdir $LOG_DIR

# ---------------- Library Setup ------------------
set DESIGN_REF_PATH "/home/synopsys/installs/LIBRARIES/SAED14_EDK"

set TARGET_LIBRARY_FILES "\
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/base/saed14hvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_SRAM/liberty/nldm/saed14sram_tt0p8v25c.db"

set link_library   "* $TARGET_LIBRARY_FILES"
set target_library "$TARGET_LIBRARY_FILES"

# ---------------- Clock Period Sweep ----------------
set PERIOD_LIST {10}

foreach PER $PERIOD_LIST {

    puts "\n================================================="
    puts " Running synthesis for PERIOD = $PER ns"
    puts "=================================================\n"

    # -------- Clean state --------
    remove_design -all

    # -------- Read RTL --------
    analyze -library WORK -format verilog { ./soc.v }
    elaborate top_system
    current_design top_system
    link

    # -------- Operating conditions --------
    set_operating_conditions tt0p8v25c

    # -------- Wire load --------
    set auto_wire_load_selection false
    set_wire_load_model -name "16000"
    set_wire_load_mode top

    # -------- Apply constraints --------
    set PERIOD $PER
    source ./soc.sdc

    # -------- Fix multi-driver nets (I2C SDA open drain) --------
    set_fix_multiple_port_nets -all -buffer_constants

    

    # ============================================================
    # Compile Stage 1 – Timing Optimization
    # ============================================================
    compile_ultra -retime -no_autoungroup

    # ============================================================
    # Compile Stage 2 – Hold Fixing
    # ============================================================
    set_fix_hold [get_clocks clk]
    compile_ultra -incremental -hold

    # ============================================================
    # Compile Stage 3 – DRV Fixing (Buffering)
    # ============================================================
    compile_ultra -incremental -buffer

    # -------- Reports --------
    report_area                   > $REPORT_DIR/area_${PER}ns.rpt
    report_power                  > $REPORT_DIR/power_${PER}ns.rpt
    report_qor                    > $REPORT_DIR/qor_${PER}ns.rpt

    report_timing                 > $REPORT_DIR/timing_setup_${PER}ns.rpt
    report_timing -delay_type min > $REPORT_DIR/timing_hold_${PER}ns.rpt

    report_constraint -all_violators > $REPORT_DIR/violations_${PER}ns.rpt
    report_timing_requirements       > $REPORT_DIR/timing_req_${PER}ns.rpt
    check_timing                     > $REPORT_DIR/check_timing_${PER}ns.rpt

    # -------- Write Netlist --------
    change_names -rules verilog -hierarchy
    write -f verilog -hierarchy -output $NETLIST_DIR/top_system_${PER}ns_netlist.v
    write_sdc $NETLIST_DIR/top_system_${PER}ns.sdc
    write_sdf $NETLIST_DIR/top_system_${PER}ns.sdf
}

###############################################################################
# End of script
###############################################################################