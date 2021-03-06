--================ tb_alu.vhd =================================
-- ELE-340 Conception des syst�mes ordin�s
-- ETE 2007, Ecole de technologie sup�rieure
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

ENTITY tb_alu IS -- l'entit� du testbench est vide
   GENERIC (ALU_SIZE: integer := 31); --Constante pour le nombre de bit de L'ALU dans le testbench
END tb_alu;

ARCHITECTURE tb_alu_arch OF tb_alu IS -- architecture compos�e de trois process
COMPONENT alu_32                      --d�claration du composant utilis�
   GENERIC (ALU_SIZE: integer := 31); --Constante pour le nombre de bit de L'ALU
PORT (
      SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE downto 0); 
      ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);     
      c_out: OUT STD_LOGIC;				  
      result: OUT STD_LOGIC_VECTOR (ALU_SIZE downto 0);    
      zero: out std_logic				  
     ); END COMPONENT;


SIGNAL SrcA,SrcB        : std_logic_vector(ALU_SIZE downto 0);  --Signaux entre les entr�es SrcA et SrcB du testbench vers l'ALU
SIGNAL result           : std_logic_vector(ALU_SIZE downto 0);  --Signal entre le r�sultat de l'ALU et la sortie du testbench
SIGNAL ALUControl 	: std_logic_vector(3 downto 0);         --Signal entre l'entr�e du testbench ALUControl et l'entr�e pour les commandes de l'ALU
SIGNAL c_out      	: std_logic;				--Signaux entre la retenue de l'additionneur de l'ALU et et celui du testbench
SIGNAL zero		: std_logic;			        --Signal pour savoir si le r�sultat est z�ro entre l'ALU et le testbench
SIGNAL clk	        : std_logic;	                        --Signal entre les modules pour l'horloge du circuit

SIGNAL   OpType: STRING(1 to 3);			        --Signal qui d�fini en mot le type d'op�ration pour le fichier de sortie


-- d�claration de la constante contr�lant la p�riode de l'horloge.
CONSTANT PERIODE: time:=20 ns;

BEGIN -- de l'architecture tb_alu_arch
   
    alu32 : alu_32    --Instantiation du composant de l'ALU
    PORT MAP(SrcA=>SrcA,SrcB=>SrcB,ALUControl=>ALUControl,c_out=>c_out,result=>result,zero=>zero); --Lien entre le testbench et l'ALU


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

   FILE data_txt: TEXT OPEN READ_MODE IS "data_in.txt";   --Fichier d'entr�e lu par le testbench
   FILE data_out: TEXT OPEN WRITE_MODE IS "data_out.txt"; --Fichier de sortie du testbench

   VARIABLE ligne_texte, ligne_texte2: line; 			             
   VARIABLE ALUControl_stimuli       : std_logic_vector(3 downto 0);        
   VARIABLE SrcA_stimuli,SrcB_stimuli: std_logic_vector (ALU_SIZE downto 0);
   VARIABLE resultat_theorique       : std_logic_vector (ALU_SIZE downto 0); 
   VARIABLE Une_Erreur               : std_logic:='0';			      
   
   VARIABLE operation_ok: boolean;					    
   VARIABLE char_pour_espace: character;				     
BEGIN 
   SrcA<=(others=>'0');       -- ou SrcA<=("00000000");			    
   SrcB<=(others=>'0');       -- ou SrcB<=("00000000");			    
   WAIT FOR PERIODE;							     --Attendre pour prochaine p�riode
--Boucle pour lecture fichier
--On va ignorer la premi�re ligne de commantaires pour apr�s lire la ligne avec l'op�ration
--Une fois la ligne lu, on attribut les entr�es lu (SrcA_stimuli,SrcB_stimuli)dans le module de l'ALU32
--Une fois le r�sultat compar�, on ecrit dans le fichier de sorti selon le mod�le.
   w1:WHILE NOT ENDFILE(data_txt) LOOP                  
      READLINE(data_txt,ligne_texte);			 
      hread(ligne_texte,ALUControl_stimuli,operation_ok); 
      NEXT WHEN NOT operation_ok;			 --On veut ignorer les commantaire
           read (ligne_texte,char_pour_espace);          --lecture espace
	   hread(ligne_texte,SrcA_stimuli);		 --lecture de l'op�rande A
           read(ligne_texte,char_pour_espace);          
	   hread(ligne_texte,SrcB_stimuli);              --lecture de l'op�rande B
	   read(ligne_texte,char_pour_espace);           
           hread(ligne_texte,resultat_theorique);        --lecture du r�sultat th�orique
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
                  				     -- On ecrit dans une ligne selon le format suivant : 			
                 write(ligne_texte2,Optype & " "     --Op�ration	  		
                       &hstr(SrcA_stimuli)&" " 	     --Op�rande A
                       &hstr(SrcB_stimuli)&" "       --Op�rande B
                       &hstr(resultat_theorique)&" " --R�sultat th�orique 
	               &hstr(result) & " : SUCCES"); -- r�sultat calcul� succ�s ou echec
	         Une_Erreur := '0';	                      
           else					    
                 				     
                 write(ligne_texte2,Optype & " "     
                       &hstr(SrcA_stimuli)&" "       
	               &hstr(SrcB_stimuli)&" "       
                       &hstr(resultat_theorique)&" " 
	               &hstr(result) & " : ECHEC");  
                 Une_Erreur := '1';                   
           end if; 
           writeline(data_out, ligne_texte2);	     --On �crit dans le fichier de sortie la ligne contenant toute l'information sur l'op�ration effectu�e   
     END LOOP w1;
     ASSERT (Une_Erreur='1') 			     				     
         REPORT "testbench pour full_adder_8.vhd termine avec succes" SEVERITY note; 
     ASSERT (Une_Erreur='0') 				  			     
         REPORT "testbench pour full_adder_8.vhd termine avec echec" SEVERITY note; 

     file_close ( data_txt ); 
     file_close ( data_out ); 

     WAIT; --le process s'ex�cute seulement une fois
     
      
      


END PROCESS; --fin du process de test

END tb_alu_arch; --fin de larchitecture

