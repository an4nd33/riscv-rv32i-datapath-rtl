add_buffer [get_nets -of [get_ports *]] [get_lib_cells saed14rvt_base_frame_timing/SAEDRVT14_BUF_4]
magnet_placement [get_ports *]
set_attribute [get_cells eco_cel*] physical_status fixed

check_design -checks pre_placement_stage

set_app_options -name place.coarse.continue_on_missing_scandef -value true

##placement density setting
#Specify a maximum density that controls how densely the tool can place cells in uncongested areas during wire-length-driven placement
set_app_options -name place.coarse.max_density -value 0.6

#Specify a maximum utilization that controls how densely the tool can place cells in less congested areas that surround highly congested areas, so 
#that the cells in the congested areas can be spread out to reduce the congestion
set_app_options -name place.coarse.congestion_driven_max_util -value 0.6

#to analyze all cells have proper or legal location
#analyze_lib_cell_placement -lib_cells *
#for placement of cells
create_placement -effort high -timing_driven

#set RC delay for timings which were set during "DATA PREPARATION"
set_parasitic_parameters -early_spec best_para
set_parasitic_parameters -late_spec worst_para

check_legality -verbose

legalize_placement

#TIMING REPORT 
report_qor -summary

### setting VTH percentage

#set_attribute [get_lib_cells */*LVT*] threshold_voltage_group LVT
#set_threshold_voltage_group_type -type low_vt LVT
#set_multi_vth_constraint -low_vt_percentage 5 -cost cell_count

###Analyzing bufferability of nets
#check_bufferability -nets < give any net name>

### analyzing violations that cannot be fixed
analyze_design_violations

#for OPTIMIZATION

place_opt -to final_opto

connect_pg_net -net VDD [get_pins -hier * -filter "name==VDD"]
connect_pg_net -net VSS [get_pins -hier * -filter "name==VSS"]

save_block -as placement_done


#TIMING REPORT

report_qor -summary

report_timing

# Report Utilization
#create_utilization_configuration -scope block core_utilization -include {all}
#report_utilization -config core_utilization


#Logical connection
#connect_pg_net -net VDD [get_pins -hier * -filter "name==VDD"]
#connect_pg_net -net VSS [get_pins -hier * -filter "name==VSS"]


