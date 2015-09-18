--================ alu_32.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- Chakib Tadj
-- =============================================================
-- Description: 
--	alu_32 realise une ALU 32-bit
--	En faisant appel a ALU 1-bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;
--USE WORK.mypackage.ALL;

ENTITY alu_32 IS 
   GENERIC (ALU_SIZE: integer := 31); 
PORT (
   SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE downto 0);
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
   c_out: OUT STD_LOGIC;
   result: OUT STD_LOGIC_VECTOR (ALU_SIZE downto 0);
   zero: out std_logic
); END alu_32 ;

ARCHITECTURE alu_32_archi OF alu_32 IS

--declarer les signaux ici. Entre autres a_invert, b_negate, operation, ...
signal a_invert,b_negate       : std_logic;
signal s_less,s_set 	       : std_logic_vector(ALU_SIZE downto 0);
signal s_Cout_Cin              : std_logic_vector(ALU_SIZE+1 downto 0);		
signal operation 	       : std_logic_vector(1 downto 0);



COMPONENT alu_1 
PORT (
   a, b, c_in, less  : IN  STD_LOGIC;
   ALUControl        : IN  STD_LOGIC_VECTOR (3 downto 0);
   c_out, result, set: OUT STD_LOGIC
); END COMPONENT;

BEGIN

a_invert       <= ALUControl (3);
b_negate       <= ALUControl (2);
operation      <= ALUControl (1 downto 0);
s_Cout_Cin(0)  <= ALUControl (2);
s_less         <= (0 => s_set(ALU_SIZE),others=>'0');
c_out          <= s_Cout_Cin(ALU_SIZE + 1);


alu_32_generic : FOR i IN 0 TO ALU_SIZE GENERATE
alu_1_x : alu_1 PORT MAP (SrcA(i),SrcB(i),s_Cout_Cin(i),s_less(i),ALUControl,s_Cout_Cin(i+1),result(i),s_set(i));
END GENERATE alu_32_generic;



END alu_32_archi;
