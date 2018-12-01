LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part1 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(3 downto 0);
HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6));

END part1;

ARCHITECTURE Behavior OF part1 IS
COMPONENT display
	PORT ( 
		x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		y : OUT STD_LOGIC_VECTOR(0 TO 6));
END COMPONENT;
BEGIN
	a1 : display PORT MAP (SW(7 DOWNTO 4), HEX0);
	b1 : display PORT MAP (SW(3 DOWNTO 0), HEX1);
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY display IS
PORT ( 
x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
y : OUT STD_LOGIC_VECTOR(0 TO 6));

END display;
ARCHITECTURE Behavior OF display IS
SIGNAL yy : STD_LOGIC_VECTOR(0 TO 6);
BEGIN
	yy(0) <= (NOT x(2) OR x(0) OR x(1)) AND
				(NOT x(0) OR x(1) OR x(2) OR x(3));
	yy(1) <= (NOT x(2) OR NOT x(0) OR x(1)) AND
				(NOT x(2) OR x(0) OR NOT x(1));
	yy(2) <= x(0) OR NOT x(1) OR x(2) OR x(3);
	yy(3) <= (NOT x(2) OR x(0) OR x(1)) AND 
				(x(2) OR x(1) OR NOT x(0)) AND
				(NOT x(2) OR NOT x(0) OR NOT x(1));
	yy(4) <= (x(1) AND NOT x(0)) OR
				(NOT x(1) AND NOT x(2) AND NOT x(0));
	yy(5) <= (NOT x(0) OR NOT x(1)) AND
				(NOT x(0) OR x(2) OR x(3)) AND
				(NOT x(1) OR x(2) OR x(3));
	yy(6) <= (x(1) OR x(2) OR x(3)) AND
				(NOT x(2) OR NOT x(0) OR NOT x(1));
	y <= NOT yy;
END Behavior;
