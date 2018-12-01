LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part3 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
LEDG : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));

END part3;

ARCHITECTURE Behavior OF part3 IS
COMPONENT fullAdder 
	PORT ( 
	A : IN STD_LOGIC;
	B : IN STD_LOGIC;
	Cin : IN STD_LOGIC;
	Cout : OUT STD_LOGIC;
	S : OUT STD_LOGIC);
END COMPONENT;

SIGNAL c : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
	LEDR <= SW;
	stage1: fullAdder PORT MAP (SW(4), SW(0), SW(8),c(0),LEDG(0));
	stage2: fullAdder PORT MAP (SW(5), SW(1), c(0),c(1),LEDG(1));
	stage3: fullAdder PORT MAP (SW(6), SW(2), c(1),c(2),LEDG(2));
	stage4: fullAdder PORT MAP (SW(7), SW(3), c(2),LEDG(4),LEDG(3));
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY fullAdder IS
PORT ( 
A : IN STD_LOGIC;
B : IN STD_LOGIC;
Cin : IN STD_LOGIC;
Cout : OUT STD_LOGIC;
S : OUT STD_LOGIC);
END fullAdder;
ARCHITECTURE Behavior OF fullAdder IS

BEGIN
	Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);
	S <= A XOR B XOR Cin;

END Behavior;