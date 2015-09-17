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

COMPONENT alu_1 
PORT (
   a, b, c_in, less : IN STD_LOGIC;
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
   c_out, result, set: OUT STD_LOGIC
); END COMPONENT;

BEGIN

a_invert <= ALUControl (3);
b_negate <= ALUControl (2);
operation  <= ALUControl (1 downto 0);

--completer alu_32

END alu_32_archi;
