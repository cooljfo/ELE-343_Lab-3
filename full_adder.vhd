--================ full_adder.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- =============================================================
-- Description: additionneur 1 bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY full_adder IS 							--	Entité full_adder	
PORT (											--	Déclaration des entrées et des sorties
  a, b, c_in : IN STD_LOGIC;					-- 	a,b signaux d'entrées logique, c_in entrée de la retenue	
  sum, c_out : OUT STD_LOGIC					--	sum résultat de l'addition, c_out sortie retenue
);
END full_adder;

ARCHITECTURE full_adder_archi OF full_adder IS 	--	Description de l'additionneur 1 bit full_adder
BEGIN											
  c_out <= (a AND b) or (c_in AND(a XOR b));
  sum <= a XOR b XOR c_in;
END full_adder_archi;