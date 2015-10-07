--================ alu_1.vhd =================================
-- ELE-340 Conception des syst�mes ordin�s
-- ETE 2007, Ecole de technologie sup�rieure
-- Chakib Tadj
-- =============================================================
-- Description: alu_1 realise une ALU 1-bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
--USE WORK.mypackage.all; --Pour creer un package, il suffit de mettre dans un fichier vide (e.g. mypackage.vhdl)
				--toute les declarations de components souhaites
				--et compiler avec vcom mypackage.vhdl en n'oubliant pas d'inserrer les librairies ieee, std...

													
ENTITY alu_1 IS 									-- 	Entit� alu_1 --
PORT (												--	Declaration des entr�es et sorties
   a, b, c_in, less : IN STD_LOGIC;					--	a,b entr�e logique  c_in entr�e retenue pour l'additionneur 1 bit
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);	--	entr�es qui dictent le comportement de l'ALU 
   c_out, result, set: OUT STD_LOGIC				--	sortie de la retenue de l'additionneur 1 bit
); END alu_1;

ARCHITECTURE alu_1_archi OF alu_1 IS
COMPONENT full_adder 								--	D�claration de l'additionneur 1 bit
PORT (
   a, b, c_in: IN STD_LOGIC;						--	entr�es de l'additionneur
   sum, c_out: OUT STD_LOGIC						--	sorties de l'additionneur
); 
end COMPONENT;

COMPONENT mux4_1									--	D�claration du multiplexeurs 4 entr�es
PORT ( i0, i1, i2, i3: IN std_logic;				--	entr�es du multiplexeur 4 entr�es
    sel: IN std_logic_vector(1 downto 0) ;			--	selectionne le signal d'entr�e
    q : OUT std_logic);								--	sortie du multiplexeur 4 entr�es
END COMPONENT;

COMPONENT mux2_1									--	D�claration du multiplexeurs 2 entr�es
PORT ( i0, i1, sel : IN std_logic;					--	entr�es (i0 et i1) et selection
    q : OUT std_logic);								--	sortie du multiplexeur
end COMPONENT;

signal s_a,s_b : std_logic;							--	signaux reliants les sorties des multiplexeurs mux2_1 et les entr�es des porte ET et OU
signal a_invert,b_invert : std_logic;				--	signaux a et b invers�s pour les entr�s des multiplexeurs mux2_1
signal s_result_and,s_result_or,s_result_add : std_logic;	-- signaux reliants les sorties de la porte ET, OU et de l'additionneur 1 bit et 
													--	les entr�es du multiplexeurs mux4_1

													--	connection des composants
BEGIN
U1 : mux2_1	PORT MAP (a,a_invert,ALUControl(ALUControl'HIGH),s_a);	--	multiplexeur apr�s l'entr�e a controlant le signal s_a
U2 : mux2_1 PORT MAP (b,b_invert,ALUControl(ALUControl'HIGH-1),s_b);	--	multiplexeur apr�s l'entr�e b controlant le signal s_b
														--	multiplexeur controlant la sortie result
U3 : mux4_1 PORT MAP (s_result_and,s_result_or,s_result_add,less,ALUControl(1 downto 0),result);
U4 : full_adder PORT MAP (s_a,s_b,c_in,s_result_add,c_out);	-- additionneur 1 bit qui additionne s_a et s_b

set	     <= s_result_add;							--	resultat de l'additionneur 1 bit			

a_invert     <= not a;								--	a invers�
b_invert     <= not b;								--	b invers�
s_result_and <= s_a and s_b;						--	sortie de la porte ET avec a et b en entr�es
s_result_or  <= s_a or  s_b;						--	sortie de la porte OU avec a et b en entr�es

END alu_1_archi;