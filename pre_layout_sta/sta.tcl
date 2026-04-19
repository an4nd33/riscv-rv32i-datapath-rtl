set_host_options -max_cores 4

set REPORT_DIR  ./reports
set LOG_DIR     ./logs

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

set DESIGN_REF_PATH "/home/synopsys/installs/LIBRARIES/SAED14_EDK"

set TARGET_LIBRARY_FILES "\
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_ss0p72v125c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_RVT/liberty/nldm/base/saed14rvt_base_ff0p88vm40c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_HVT/liberty/nldm/base/saed14hvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_STD_LVT/liberty/nldm/base/saed14lvt_base_tt0p8v25c.db \
$DESIGN_REF_PATH/SAED14nm_EDK_SRAM/liberty/nldm/saed14sram_tt0p8v25c.db"

set link_library "* $TARGET_LIBRARY_FILES"
set target_library "$TARGET_LIBRARY_FILES"

# Remove old design (IMPORTANT)
remove_design -all

# Read netlist
read_verilog ./top_system_10ns_netlist.v

# Link TOP LEVEL
link_design top_system
current_design top_system

# Now read constraints
read_sdc ./top_system_10ns.sdc

# Read delays
read_sdf ./top_system_10ns.sdf

# Timing
check_timing
update_timing

# Reports
report_analysis_coverage > $REPORT_DIR/coverage.rpt
report_timing > $REPORT_DIR/setup.rpt
report_timing -delay_type min > $REPORT_DIR/hold.rpt
report_hierarchy > $REPORT_DIR/hierarchy.rpt
