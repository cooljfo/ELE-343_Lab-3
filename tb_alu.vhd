--================ tb_alu.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- Chakib Tadj
-- =============================================================
-- Description: 
--   testbench pour tester alu_32.vhd
--   les donnees sont lues de data_in.txt
--   la sortie est dirigee vers data_out.txt
-- =============================================================

LIBRARY ieee;
LIBRARY std;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_textio.all;
--USE ieee.std_logic_textio;
USE std.textio.all;

USE WORK.txt_util.ALL;
--USE WORK.mypackage.ALL;

ENTITY tb_alu IS -- lentité du testbench est vide
   GENERIC (ALU_SIZE: integer := 31);
END tb_alu;

ARCHITECTURE tb_alu_arch OF tb_alu IS -- architecture composée de trois process
COMPONENT alu_32                      --déclaration du composant utilisé
   GENERIC (ALU_SIZE: integer := 31);
PORT (
   SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE downto 0);
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
   c_out: OUT STD_LOGIC;
   result: OUT STD_LOGIC_VECTOR (ALU_SIZE downto 0);
   zero: out std_logic
); END COMPONENT;

--declarer les signaux ici
-- ...
SIGNAL   OpType: STRING(1 to 3);


-- déclaration de la constante contrôlant la période de l'horloge.
CONSTANT PERIODE: time:=20 ns;

BEGIN -- de l'architecture tb_alu_arch
    alu32 : alu_32 PORT MAP(SrcA=>SrcA, SrcB=>SrcB, ALUControl=>ALUControl, 
                set=>set, c_out=>c_out,result=>result); --instantier composant


------------------------------------------------------------------
PROCESS -- process (#1) : circuit l'horloge
BEGIN
   clk<='1';
   WAIT FOR PERIODE/2;
   clk<='0';
   WAIT FOR PERIODE/2;
END PROCESS;

------------------------------------------------------------------
PROCESS(ALUControl) -- process (#2) pour l'esthetique. On peut s'en passer!
BEGIN
  Case ALUControl is  -- Plus agreable pour le fichier de sortie!
   when X"0"    =>  OpType  <= "AND"; --Operation ET logique
   when X"1"    =>  OpType  <= "OR "; --Operation OU logique
   when X"2"    =>  OpType  <= "ADD"; --Operation ADD logique
   when X"6"    =>  OpType  <= "SUB"; --Operation SUB logique
   when X"7"    =>  OpType  <= "SLT"; --Operation ET logique
   when Others  =>  OpType  <= "---";  --illegal
 END Case;
END PROCESS;


------------------------------------------------------------------
PROCESS -- process (#3) principal de test 

--A completer

END PROCESS; --fin du process de test

END tb_alu_arch; --fin de larchitecture

