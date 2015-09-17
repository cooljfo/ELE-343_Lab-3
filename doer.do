vcom mux4_1.vhd
vsim mux4_1
add wave *
force i0 1
force i1 0
force i2 0
force i3 1
force sel "00"
run 40ns
force sel "01"
run 40ns 
force sel "10"
run 40ns
force sel "11"
run 40ns

wave zoom full

