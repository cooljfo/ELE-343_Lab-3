--================ full_adder.vhd =================================
-- ELE-340 Conception des syst�mes ordin�s
-- ETE 2007, Ecole de technologie sup�rieure
-- =============================================================
-- Description: additionneur 1 bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY full_adder IS 							--	Entit� full_adder	
PORT (											--	D�claration des entr�es et des sorties
  a, b, c_in : IN STD_LOGIC;					-- 	a,b signaux d'entr�es logique, c_in entr�e de la retenue	
  sum, c_out : OUT STD_LOGIC					--	sum r�sultat de l'addition, c_out sortie retenue
);
END full_adder;

ARCHITECTURE full_adder_archi OF full_adder IS 	--	Description de l'additionneur 1 bit full_adder
BEGIN											
  c_out <= (a AND b) or (c_in AND(a XOR b));	--	c_out = (a ET b) OU (c_in ET (a OU EXLUSIF b))
  sum <= a XOR b XOR c_in;						--	resultat de l'addition = a OU EXLUSIF b OU EXLUSIF c_in
END full_adder_archi;