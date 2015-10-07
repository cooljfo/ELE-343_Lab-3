--================ alu_32.vhd =================================
-- ELE-340 Conception des syst�mes ordin�s
-- ETE 2007, Ecole de technologie sup�rieure
-- Chakib Tadj
-- =============================================================
-- Description: 
--	alu_32 realise une ALU 32-bit
--	En faisant appel a ALU 1-bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_misc.all;
--USE WORK.mypackage.ALL;

ENTITY alu_32 IS 
   GENERIC (ALU_SIZE: integer := 31); 				--	Delacration de la constante ALU_SIZE
PORT (
   SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE downto 0);	        --	entr�es 32 bits 
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);		--	entr�es qui dictent le comportement de l'ALU
   c_out: OUT STD_LOGIC;					--	sortie de la retenue de l'additionneur
   result: OUT STD_LOGIC_VECTOR (ALU_SIZE downto 0);	        --	resultat de l'ALU
   zero: out std_logic						--	sortie pour savoir si le resultat vaut 0
); END alu_32 ;

ARCHITECTURE alu_32_archi OF alu_32 IS

--declarer les signaux ici. Entre autres a_invert, b_negate, operation, ...
--signal a_invert,b_negate       : std_logic;				--	signaux qui repr�sente les positions 3 et 2 de ALUControl
signal s_less,s_set,s_result   : std_logic_vector(ALU_SIZE downto 0);	--	Signaux 
signal s_Cout_Cin              : std_logic_vector(ALU_SIZE+1 downto 0);	--	Signaux entre la sortie de la retenue et l'entr�e de la retenu du prochain ALU 																		
--signal operation 	       	   : std_logic_vector(1 downto 0);	--	signaux qui dictent le comportement de l'ALU

--ALIAS
ALIAS a_invert  : STD_LOGIC is ALUControl(ALUControl'HIGH);
ALIAS b_invert  : STD_LOGIC is ALUControl(ALUControl'HIGH-1);
ALIAS operation : STD_LOGIC_VECTOR(1 downto 0) is ALUControl(1 downto 0);


COMPONENT alu_1 						--	D�claration de l'alu_1
PORT (
   a, b, c_in, less  : IN  STD_LOGIC;				--	a,b entr�e logique  c_in entr�e retenue pour l'additionneur 1 bit
   ALUControl        : IN  STD_LOGIC_VECTOR (3 downto 0);	--	entr�es qui dictent le comportement de l'ALU
   c_out, result, set: OUT STD_LOGIC				--	sortie de la retenue de l'additionneur 1 bit
); END COMPONENT;

BEGIN	
s_Cout_Cin(s_Cout_Cin'LOW)              <= b_invert;				--	la valeur de l'entr�e de la retenue du premier ALU est �gal au bit 2 de ALUControl
s_less(s_less'HIGH downto s_less'LOW+1) <= (others =>'0');
s_less(s_less'LOW)                      <=s_set(ALU_SIZE);
c_out                                   <= s_Cout_Cin(ALU_SIZE + 1);		--	sortie de la retenue du dernier ALU
result                                  <= s_result;				--	sortie de 32 bit, resultat de l'op�ration des ALU. 
zero                                    <= not (or_reduce(s_result));		--	confirme que le resultat est 0. Actif � 1	

alu_32_generic : FOR i IN 0 TO ALU_SIZE GENERATE				--	Boucle qui fait les connections entre les ALU.
alu_1_x : alu_1 PORT MAP (SrcA(i),SrcB(i),s_Cout_Cin(i),s_less(i),ALUControl,s_Cout_Cin(i+1),s_result(i),s_set(i));
END GENERATE alu_32_generic;



END alu_32_archi;
