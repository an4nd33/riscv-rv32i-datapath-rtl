fix_eco_drc -type max_transition -verbose -methods size_cell
fix_eco_drc -type max_capacitance -verbose -methods size_cell

fix_eco_drc -type max_transition -verbose -buffer_list {SAEDLVT14_BUF_ECO_1 SAEDLVT14_BUF_ECO_2 SAEDLVT14_BUF_ECO_3 SAEDLVT14_BUF_ECO_4 SAEDLVT14_BUF_ECO_6 SAEDLVT14_BUF_ECO_7 SAEDLVT14_BUF_ECO_8}

fix_eco_drc -type max_capacitance -verbose -buffer_list {SAEDLVT14_BUF_ECO_1 SAEDLVT14_BUF_ECO_2 SAEDLVT14_BUF_ECO_3 SAEDLVT14_BUF_ECO_4 SAEDLVT14_BUF_ECO_6 SAEDLVT14_BUF_ECO_7 SAEDLVT14_BUF_ECO_8}

fix_eco_timing -type setup -slack_lesser_than 0 -methods size_cell

fix_eco_timing -type setup -slack_lesser_than 0 -buffer_list {SAEDLVT14_BUF_ECO_1 SAEDLVT14_BUF_ECO_2 SAEDLVT14_BUF_ECO_3 SAEDLVT14_BUF_ECO_4 SAEDLVT14_BUF_ECO_6 SAEDLVT14_BUF_ECO_7 SAEDLVT14_BUF_ECO_8}

fix_eco_timing -type hold -slack_lesser_than 0 -methods size_cell

fix_eco_timing -type hold -slack_lesser_than 0 -buffer_list {SAEDHVT14_BUF_ECO_1 SAEDHVT14_BUF_ECO_2 SAEDHVT14_BUF_ECO_3 SAEDHVT14_BUF_ECO_4 SAEDHVT14_BUF_ECO_6 SAEDHVT14_BUF_ECO_7 SAEDHVT14_BUF_ECO_8}

write_changes -format icc2tcl -output timing_eco.tcl

