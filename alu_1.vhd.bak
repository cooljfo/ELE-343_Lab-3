--================ alu_1.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
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

ENTITY alu_1 IS PORT (
   a, b, c_in, less : IN STD_LOGIC;
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
   c_out, result, set: OUT STD_LOGIC
); END alu_1;

ARCHITECTURE alu_1_archi OF alu_1 IS

COMPONENT full_adder 
PORT (
   a, b, c_in: IN STD_LOGIC;
   sum, c_out: OUT STD_LOGIC
); 
end COMPONENT;

COMPONENT mux4_1
PORT ( i0, i1, i2, i3: IN std_logic;
    sel: IN std_logic_vector(1 downto 0) ;
    q : OUT std_logic);
END COMPONENT;

COMPONENT mux2_1
PORT ( i0, i1, sel : IN std_logic;
    q : OUT std_logic);
end COMPONENT;

--declarer les signaux ici 

BEGIN

--completer alu_1

END alu_1_archi;