#===========================================================
# CLOCK
#===========================================================
create_clock -name clk -period $PERIOD [get_ports clk]

# Clock uncertainty (jitter + skew margin)
set_clock_uncertainty 0.2 [get_clocks clk]

# Clock latency (CTS estimate)
set_clock_latency 0.5 [get_clocks clk]

#===========================================================
# RESET (Asynchronous)
#===========================================================
set_false_path -from [get_ports reset]

# Reset input delay
set_input_delay -clock clk -max 2 [get_ports reset]
set_input_delay -clock clk -min 0.5 [get_ports reset]
set_input_transition 0.1 [get_ports reset]

#===========================================================
# INPUT / OUTPUT DELAYS
#===========================================================
# Output delay for all outputs
set_output_delay -clock clk -max 2 [all_outputs]
set_output_delay -clock clk -min 0.5 [all_outputs]

#===========================================================
# DRIVE STRENGTH AND LOAD
#===========================================================
# Use buffer as driving cell for reset
set_driving_cell -lib_cell SAEDRVT14_BUF_4 [get_ports reset]

# Output load
set_load 0.05 [all_outputs]

#===========================================================
# DESIGN RULE CONSTRAINTS (DRV)
#===========================================================
set_max_transition 0.25 [current_design]
set_max_fanout 6 [current_design]
set_max_capacitance 0.4 [current_design]

