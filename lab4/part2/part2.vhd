LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all;
ENTITY part2 IS
	PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0) ;
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
	HEX0,HEX1,HEX2,HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6)) ;
END part2 ;

ARCHITECTURE Behaviour OF part2 IS
	COMPONENT binaryToHexDisplay
		PORT ( a : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
			HEX : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	
	SIGNAL Enable, Clear, Clock : STD_LOGIC;
	SIGNAL digit0, digit1, digit2, digit3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL fullNumber : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
	Enable <= SW(1);
	Clear <= SW(0);
	Clock <= KEY(0);
	digit0 <= fullNumber(3 DOWNTO 0);
	digit1 <= fullNumber(7 DOWNTO 4);
	digit2 <= fullNumber(11 DOWNTO 8);
	digit3 <= fullNumber(15 DOWNTO 12);
	PROCESS (Clear,Clock,Clear)
	BEGIN
		IF (Clock'EVENT AND Clock = '1') THEN
			IF Clear = '1' THEN
				fullNumber <= "0000000000000000";
			ELSIF Enable = '1' THEN
				fullNumber <= fullNumber + 7;
			END IF;
		END IF;
	END PROCESS;
	display0 : binaryToHexDisplay PORT MAP(digit0, HEX0);
	display1 : binaryToHexDisplay PORT MAP(digit1, HEX1);
	display2 : binaryToHexDisplay PORT MAP(digit2, HEX2);
	display3 : binaryToHexDisplay PORT MAP(digit3, HEX3);
END Behaviour;
