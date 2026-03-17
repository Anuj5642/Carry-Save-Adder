set_db lib_search_path {/home/install/FOUNDRY/digital/90nm/dig/lib}
set_db library {slow.lib}

# -------- Read RTL --------
read_hdl CSA16bit.v

# Set top module
elaborate carry_save_adder_16bit

# -------- Constraints --------
read_sdc CSA.sdc

# -------- Synthesis Effort --------
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

# -------- Synthesis Flow --------
syn_generic
syn_map
syn_opt

gui_show

# -------- Reports --------
report_timing > timing.rpt
report_area > area.rpt
report_power > power.rpt
report_gates > gate.rpt
# -------- Netlist --------
write_hdl > carry_save_adder_16bit_synth.v
write_sdc > carry_save_adder_16bit_tool.sdc
