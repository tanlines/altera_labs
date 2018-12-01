LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part3 IS
	PORT ( SW: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END part3;

ARCHITECTURE Structural OF part3 IS
	COMPONENT part2
		PORT ( Clk, D : IN STD_LOGIC;
		Q : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL Clk, D, Q_m, Q_s, Q: STD_LOGIC;
	ATTRIBUTE keep : boolean;
	ATTRIBUTE keep of Q_m,Q_s : SIGNAL IS true;
BEGIN
		D <= SW(0);
		Clk <= SW(1);
		s1 : part2 PORT MAP (NOT Clk, D, Q_m);
		s2 : part2 PORT MAP (CLK, Q_m, Q_s);
		Q <= Q_s;
		
		LEDR(0) <= Q;
END Structural;
