create_clock -period 5.000 -name clk -waveform {0.000 2.500} [get_ports clk]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


set_input_delay -clock [get_clocks *] 0.000 [get_ports -filter { NAME =~  "*" && DIRECTION == "IN" }]
