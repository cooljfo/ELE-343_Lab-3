vcom alu_32.vhd
vsim alu_32

add wave *
force SrcA X"1"
force SrcB X"1"
force ALUControl "0110"
run 40ns
force SrcA X"100"
force SrcB X"1"
force ALUControl "0110"
run 40ns
force SrcA X"0"
force SrcB X"FFFFFFFF"
force ALUControl "0111"
run 40ns
force SrcA X"1"
force SrcB X"0"
force ALUControl "0111"
run 40ns
force SrcA X"FFFFFFFF"
force SrcB X"0"
force ALUControl "0111"
run 40ns
force SrcA X"FFFFFFFF"
force SrcB X"FFFFFFFF"
force ALUControl "0000"
run 40ns
force SrcA X"12345678"
force SrcB X"87654321"
force ALUControl "0000"
run 40ns
force SrcA X"12345678"
force SrcB X"87654321"
force ALUControl "0001"
run 40ns
wave zoom full

