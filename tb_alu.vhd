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
   GENERIC (ALU_SIZE: integer := 31);	--	déclaration de la constante
END tb_alu;

ARCHITECTURE tb_alu_arch OF tb_alu IS -- architecture composée de trois process
COMPONENT alu_32                      --déclaration du composant utilisé
   GENERIC (ALU_SIZE: integer := 31);
PORT (
   SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE downto 0);		-- 	bus de 32 bits pour les entrées A et B
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);			-- 	selectionne l'operation de l'ALU
   c_out: OUT STD_LOGIC;									-- 	retenue
   result: OUT STD_LOGIC_VECTOR (ALU_SIZE downto 0);		--	résultat
   zero: out std_logic										--
); END COMPONENT;

--declarer les signaux ici
SIGNAL SrcA,SrcB,result : std_logic_vector(ALU_SIZE downto 0);	
SIGNAL ALUControl 	: std_logic_vector(3 downto 0);				
SIGNAL c_out,zero,clk 	: std_logic;							

SIGNAL   OpType: STRING(1 to 3);								


-- déclaration de la constante contrôlant la période de l'horloge.
CONSTANT PERIODE: time:=20 ns;

BEGIN -- de l'architecture tb_alu_arch
    alu32 : alu_32 PORT MAP(SrcA=>SrcA, SrcB=>SrcB, ALUControl=>ALUControl, 
                c_out=>c_out,result=>result,zero=>zero); --instantier composant


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

   FILE data_txt: TEXT OPEN READ_MODE IS "data_in.txt";
   FILE data_out: TEXT OPEN WRITE_MODE IS "data_out.txt";

   VARIABLE ligne_texte, ligne_texte2: line;
   VARIABLE ALUControl_stimuli : std_logic_vector(3 downto 0);
   VARIABLE SrcA_stimuli,SrcB_stimuli,resultat_theorique: std_logic_vector (ALU_SIZE downto 0);
   VARIABLE Une_Erreur: std_logic:='0';
   
   VARIABLE operation_ok: boolean;
   VARIABLE char_pour_espace: character;
BEGIN 
   SrcA<=(others=>'0');       -- ou SrcA<=("00000000");
   SrcB<=(others=>'0');       -- ou SrcB<=("00000000");
   WAIT FOR PERIODE;
--Boucle pour lecture fichier
   w1:WHILE NOT ENDFILE(data_txt) LOOP
      READLINE(data_txt,ligne_texte);--lecture d'une ligne
      hread(ligne_texte,ALUControl_stimuli,operation_ok); 
      NEXT WHEN NOT operation_ok;--On veut ignorer les commantaire
           read (ligne_texte,char_pour_espace);--lecture espace
	   hread(ligne_texte,SrcA_stimuli);
           read(ligne_texte,char_pour_espace);
	   hread(ligne_texte,SrcB_stimuli);
	   read(ligne_texte,char_pour_espace);   
           hread(ligne_texte,resultat_theorique);
           ALUControl <= ALUControl_stimuli;
	   SrcA       <= SrcA_stimuli;
	   SrcB	      <= SrcB_stimuli;
	   WAIT FOR PERIODE;
             
           ASSERT (result/=resultat_theorique )
            REPORT "Operation reussie. Resultat = " & hstr(result)
             SEVERITY note;
           ASSERT (result=resultat_theorique )
            REPORT "ECHEC. Resultat = " & hstr(result)
             SEVERITY note;
       
           if (result=resultat_theorique) THEN
                 write(ligne_texte2,Optype & " " 
                       &hstr(SrcA_stimuli)&" "&hstr(SrcB_stimuli)&" "&hstr(resultat_theorique)&" "
	               &hstr(result) & " : SUCCES");
	         Une_Erreur := '0';         
           else
                 write(ligne_texte2,Optype & " " 
                       &hstr(SrcA_stimuli)&" "&hstr(SrcB_stimuli)&" "&hstr(resultat_theorique)&" "
	               &hstr(result) & " : ECHEC");
                 Une_Erreur := '1';           
           end if; 
           writeline(data_out, ligne_texte2);   
     END LOOP w1;
     ASSERT (Une_Erreur='1') 
         REPORT "testbench pour full_adder_8.vhd termine avec succes" SEVERITY note;
     ASSERT (Une_Erreur='0') 
         REPORT "testbench pour full_adder_8.vhd termine avec echec" SEVERITY note;

     file_close ( data_txt );
     file_close ( data_out );

     WAIT; --le process s'exécute seulement une fois
     
      
      


END PROCESS; --fin du process de test

END tb_alu_arch; --fin de larchitecture

