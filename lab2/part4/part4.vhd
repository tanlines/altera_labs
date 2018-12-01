LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part4 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);
LEDG : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));

END part4;

ARCHITECTURE Behavior OF part4 IS
		COMPONENT display
		PORT ( 
		x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		y : OUT STD_LOGIC_VECTOR(0 TO 6));

		END COMPONENT;
		COMPONENT bcdAdder 
			PORT ( 
			a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Cin : IN STD_LOGIC;
			Cout : OUT STD_LOGIC;
			s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
		END COMPONENT;
		COMPONENT bcdToDisplay 
			PORT ( 
			a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Cin : IN STD_LOGIC;
			HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6));
		END COMPONENT;
	SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Cin : STD_LOGIC;
	SIGNAL Cout : STD_LOGIC;
	SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0);

	BEGIN
		LEDR <= SW;
		A <= SW(7 DOWNTO 4);
		B <= SW(3 DOWNTO 0);
		Cin <= SW(8);
		LEDG(4) <= Cout;
		LEDG(3 DOWNTO 0) <= sum;
		stage1: bcdAdder PORT MAP (A, B, Cin,Cout, sum);
		numA:	display PORT MAP (A, HEX3);
		numB: display PORT MAP (B, HEX2);
		sumDisplay: bcdToDisplay PORT MAP (sum, Cout,HEX0,HEX1);
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

--Sum two BCD numbers
ENTITY bcdAdder IS
	PORT ( 
	a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Cin : IN STD_LOGIC;
	Cout : OUT STD_LOGIC;
	s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END bcdAdder;
ARCHITECTURE Behavior OF bcdAdder IS
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
		stage1: fullAdder PORT MAP (a(0), b(0), Cin,c(0),s(0));
		stage2: fullAdder PORT MAP (a(1), b(1), c(0),c(1),s(1));
		stage3: fullAdder PORT MAP (a(2), b(2), c(1),c(2),s(2));
		stage4: fullAdder PORT MAP (a(3), b(3), c(2),Cout,s(3));
END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
--Convert a BCD to the HEX values ready to display
ENTITY bcdToDisplay IS
	PORT (
	a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Cin : IN STD_LOGIC;
	HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
	HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6));

END bcdToDisplay;

ARCHITECTURE Behavior OF bcdToDisplay IS
		COMPONENT display
		PORT ( 
		x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		y : OUT STD_LOGIC_VECTOR(0 TO 6));

		END COMPONENT;
		COMPONENT circuitA
		PORT ( 
		a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		b : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));

		END COMPONENT;
		
		COMPONENT circuitB
		PORT ( 
		a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));

		END COMPONENT;

		COMPONENT comparator
		PORT ( 
		a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		b : OUT STD_LOGIC);

		END COMPONENT;

	SIGNAL RESULTA : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL RESULTB : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL M : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL V : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL y : STD_LOGIC;
	SIGNAL z : STD_LOGIC;
	SIGNAL tens : STD_LOGIC;
	BEGIN
		V <= a;
		--if Cin (>15) or the bcd is > 9, then second digit is 1
		--z means between 10 and 15 inclusive, tens is > 9
		com: comparator PORT MAP (V, y);
		z <= NOT Cin AND y;
		tens <= y OR Cin;
		
		cA: circuitA PORT MAP (V(2 DOWNTO 0),RESULTA);
		cB: circuitB PORT MAP (V,RESULTB);
		M(0) <= (V(0) AND NOT z AND NOT Cin) OR (RESULTA(0) AND z) OR (RESULTB(0) AND Cin);
		M(1) <= (V(1) AND NOT z AND NOT Cin) OR (RESULTA(1) AND z) OR (RESULTB(1) AND Cin);
		M(2) <= (V(2) AND NOT z AND NOT Cin) OR (RESULTA(2) AND z) OR (RESULTB(2) AND Cin);
		M(3) <= (V(3) AND NOT z AND NOT Cin) OR (RESULTB(3) AND Cin);
		digit0 : display PORT MAP (M,HEX0);
		digit1 : display PORT MAP ((2 DOWNTO 0 => '0') & tens,HEX1);
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--Interprets lower 4 bits as BCD greater than 15
ENTITY circuitB IS
	PORT ( 
	a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));

END circuitB;

	ARCHITECTURE Behavior OF circuitB IS
	BEGIN
		b(0) <= a(0);
		b(1) <= NOT a(1);
		b(2) <= NOT (a(1) XOR a(2));
		b(3) <= (a(1) OR a(2)) AND NOT a(3);
END Behavior;