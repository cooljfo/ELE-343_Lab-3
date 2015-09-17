LIBRARY ieee; USE ieee.std_logic_1164.all; USE ieee.std_logic_arith.all;

ENTITY mux4_1 IS 
GENERIC(MUX_SIZE    : integer := 3;
	SIGNAL_SIZE : integer := 1
); 
 					 
PORT( i0, i1, i2, i3: IN std_logic;
    sel: IN std_logic_vector(1 downto 0) ;
    q : OUT std_logic);
END mux4_1;

ARCHITECTURE mux4_1_archi OF mux4_1 IS

COMPONENT mux2_1 
PORT ( i0, i1, sel : IN std_logic;
        q : OUT std_logic);
END COMPONENT;

signal s_mux : std_logic_vector(SIGNAL_SIZE downto 0);

BEGIN

U1 : mux2_1
port map(i0,i1,sel(0),s_mux(0));
U2 : mux2_1
port map(i2,i3,sel(0),s_mux(1));
U3 : mux2_1
port map(s_mux(0),s_mux(1),sel(1),q);


END mux4_1_archi;
