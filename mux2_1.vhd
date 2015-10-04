LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
--USE WORK.mypackage.all; --Pour creer un package, il suffit de mettre dans un fichier vide (e.g. mypackage.vhdl)
				--toute les declarations de components souhaites
				--et compiler avec vcom mypackage.vhdl en n'oubliant pas d'inserrer les librairies ieee, std...


ENTITY mux2_1 IS 									--	Entité mux2_1
PORT ( i0, i1, sel : IN std_logic;					--	i0,i1 signaux entrées, sel 
        q : OUT std_logic);							--	signal de sortie
END mux2_1;

ARCHITECTURE mux2_1_archi OF mux2_1 IS				--	Description du multiplexeur mux2_1
BEGIN												
q<= i1 when(sel ='1') else i0;						-- 	q = i[sel]
END mux2_1_archi;
