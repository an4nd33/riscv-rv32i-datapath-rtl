check_design -checks pre_clock_tree_stage
# set NDR
create_routing_rule  clk_rule -widths  {M6 0.112 M7 0.112 } -spacings  {M6 0.112 M7 0.112 }

#check_clock_tree

# specify clock tree cell list
set_lib_cell_purpose -exclude cts [get_lib_cells]
#set_lib_cell_purpose -include cts [get_lib_cells "saed14rvt_tt0p8v125c/SAEDRVT14_BUF_S_4 saed14rvt_tt0p8v125c/SAEDRVT14_BUF_S_6 saed14rvt_tt0p8v125c/SAEDRVT14_BUF_S_8"]

set_lib_cell_purpose -include cts [get_lib_cells "saed14rvt_base_frame_timing/SAEDRVT14_BUF_S_4 saed14rvt_base_frame_timing/SAEDRVT14_BUF_S_6 saed14rvt_base_frame_timing/SAEDRVT14_BUF_S_8"]


#Specify Max fanout
set_app_options -name  cts.common.max_fanout -value 30

# set clock target skew and latency
set_clock_tree_options -clocks [all_clocks] -target_latency 0.050 -target_skew 0.030
#set_clock_tree_options -clocks [get_clocks -filter "is_virtual==false"] -target_latency 0.25 -target_skew 0.03


set_clock_routing_rules -clocks [all_clocks ] -net_type {internal} -rules clk_rule -min_routing_layer M6 -max_routing_layer M7
set_clock_routing_rules -clocks [all_clocks ] -net_type {root} -rules clk_rule -min_routing_layer M6 -max_routing_layer M7

clock_opt

# Make the logical connection of PG nets  for all the standard cells
	
connect_pg_net -net VDD [get_pins -hier * -filter "name == VDD"]
connect_pg_net -net VSS [get_pins -hier * -filter "name == VSS"]

save_block -as cts_done_trial
