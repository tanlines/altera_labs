LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY part5 IS
	PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0) ;
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	HEX0,HEX1,HEX2,HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6));
END part5 ;

ARCHITECTURE Behavior OF part5 IS
	COMPONENT binaryToHexDisplay
		PORT ( a : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
			HEX : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	SIGNAL A_0, A_1, B_0, B_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D, Clk : STD_LOGIC;
	ATTRIBUTE keep : boolean;
	ATTRIBUTE keep of A_0, A_1, B_0, B_1 : SIGNAL IS true;
BEGIN
	D <= KEY(0);
	Clk <= KEY(1);
	digit0 : binaryToHexDisplay PORT MAP (A_0,HEX0);
	digit1 : binaryToHexDisplay PORT MAP (A_1,HEX1);
	digit2 : binaryToHexDisplay PORT MAP (B_0,HEX2);
	digit3 : binaryToHexDisplay PORT MAP (B_1,HEX3);
	PROCESS (Clk,A_0,A_1,B_0,B_1,SW)
		BEGIN
			IF D = '0' THEN
				B_0 <= "0000";
				B_1 <= "0000";
				A_0 <= "0000";
				A_1 <= "0000";
			ELSIF (Clk'EVENT AND Clk = '0') THEN
				A_0 <= SW(3 DOWNTO 0);
				A_1 <= SW(7 DOWNTO 4);
			ELSIF (Clk'EVENT AND Clk = '1') THEN
				B_0 <= SW(3 DOWNTO 0);
				B_1 <= SW(7 DOWNTO 4);
			END IF ;
	END PROCESS ;
END Behavior;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY binaryToHexDisplay IS
	PORT ( a : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
	HEX : OUT STD_LOGIC_VECTOR(0 TO 6));
END binaryToHexDisplay ;
ARCHITECTURE Behavior OF binaryToHexDisplay IS
BEGIN
	WITH a SELECT
		HEX <= 	"0000001" WHEN "0000", --0
					"1001111" WHEN "0001",
					"0010010" WHEN "0010",
					"0000110" WHEN "0011",
					"1001100" WHEN "0100",
					"0100100" WHEN "0101", --5
					"0100000" WHEN "0110",
					"0001101" WHEN "0111",
					"0000000" WHEN "1000",
					"0000100" WHEN "1001", --9
					"0001000" WHEN "1010", --a
					"1100000" WHEN "1011",
					"1110010" WHEN "1100",
					"1000010" WHEN "1101", --d
					"0110000" WHEN "1110",
					"0111000" WHEN "1111", --f
					"1111111" WHEN OTHERS;
END Behavior;
