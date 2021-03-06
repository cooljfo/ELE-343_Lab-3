--================ mux4_1.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- Michael Deslauriers
-- Christian Daigneault-St-Arnaud
-- Jean-François Chenier
-- =============================================================
-- Description: mux4_1 realise un multiplexeur 4 entrées
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
ENTITY mux4_1 IS 
GENERIC(											--	Declaration des constantes
	MUX_SIZE    : integer := 3;						--	Declaration de MUX_SIZE
	SIGNAL_SIZE : integer := 1						--	Declaration de SIGNAL_SIZE
); 
 					 
PORT( i0, i1, i2, i3: IN std_logic;					--	entrées logique du multiplexeur
    sel: IN std_logic_vector(1 downto 0) ;			--	selectionne le signal d'entrée 
    q : OUT std_logic);								--	signal de sortie
END mux4_1;

ARCHITECTURE mux4_1_archi OF mux4_1 IS				--	Description du multiplexeur mux4_1

COMPONENT mux2_1 
PORT ( i0, i1, sel : IN std_logic;					--	entrées (i0 et i1) et selection
        q : OUT std_logic);							--	sortie du multiplexeur
END COMPONENT;
													--	signaux entre les sorties de U1 et U2
													--	et les entrées de U3
signal s_mux : std_logic_vector(SIGNAL_SIZE downto 0);

BEGIN												--	connection entre les 3 multiplexeurs mux2_1
U1 : mux2_1 port map(i0,i1,sel(0),s_mux(0));		-- 	multiplexeur controlant le signal s_mux(0)
U2 : mux2_1 port map(i2,i3,sel(0),s_mux(1));		--	multiplexeur controlant le signal s_mux(1)
U3 : mux2_1 port map(s_mux(0),s_mux(1),sel(1),q);	--	multiplexeur controlant la sortie q
END mux4_1_archi;
