LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY part1b IS
	PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0) ;
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
	HEX0,HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6)) ;
END part1b ;

ARCHITECTURE Behaviour OF part1b IS
	COMPONENT binaryToHexDisplay
		PORT ( a : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
			HEX : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	COMPONENT part1
		PORT ( T, Clk, Clear : IN STD_LOGIC ;
		Q : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)) ;
	END COMPONENT;
	
	SIGNAL Enable, Clear, Clock : STD_LOGIC;
	SIGNAL digit0, digit1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL fullNumber : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	Enable <= SW(1);
	Clear <= SW(0);
	Clock <= KEY(0);
	digit0 <= fullNumber(3 DOWNTO 0);
	digit1 <= fullNumber(7 DOWNTO 4);
	num : part1 PORT MAP(Enable, Clock, Clear, fullNumber);
	display0 : binaryToHexDisplay PORT MAP(digit0, HEX0);
	display1 : binaryToHexDisplay PORT MAP(digit1, HEX1);
END Behaviour;
