vcom alu_32.vhd
vsim alu_32

add wave *
force SrcA X"1010"
force SrcB X"1111"
force ALUControl "0000"
run 40ns
force ALUControl "0001"
run 40ns
force ALUControl "0010"
run 40ns
force ALUControl "0110"
run 40ns
force ALUControl "0111"
run 40ns



wave zoom full

