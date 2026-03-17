# ==============================================================================
# SDC File for 16-bit Carry Save Adder
# ==============================================================================

# 1. Define Timing Units (Standard for most libraries: nanoseconds and picofarads)
set_units -time ns -capacitance pF

# 2. Create a Virtual Clock
# Since this module is combinational, we create a virtual clock 'vclk' 
# with a 5.0ns period (200 MHz) to act as a reference for I/O delays.
create_clock -name vclk -period 5.0

# 3. Input Delays
# Assuming the data arrives at the input pins 1.0ns after the virtual clock edge.
# This accounts for the delay of whatever logic comes before this adder.
set_input_delay -clock vclk 1.0 [get_ports {a[*]}]
set_input_delay -clock vclk 1.0 [get_ports {b[*]}]
set_input_delay -clock vclk 1.0 [get_ports {c[*]}]

# 4. Output Delays
# Assuming the next block needs the data 1.0ns before the next virtual clock edge.
set_output_delay -clock vclk 1.0 [get_ports {final_sum[*]}]

# 5. Pure Combinational Delay (Alternative to Virtual Clock)
# If you don't want to use a virtual clock, you can restrict the maximum 
# propagation delay from any input to any output directly. (Uncomment to use).
# set_max_delay 4.0 -from [get_ports {a[*] b[*] c[*]}] -to [get_ports {final_sum[*]}]

# 6. Environmental Constraints: Driving Cells & Loads
# Set a realistic input transition time to model the driving gates (e.g., 0.1ns)
set_input_transition 0.1 [get_ports {a[*] b[*] c[*]}]

# Set an output load capacitance to model the inputs of the next logic stage (e.g., 50fF)
set_load 0.05 [get_ports {final_sum[*]}]

# 7. Area Constraint
# Forces the synthesis tool to make the design as small as possible 
# while still meeting the timing constraints above.
set_max_area 0
