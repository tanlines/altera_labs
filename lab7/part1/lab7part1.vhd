LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY lab7part1 IS
	PORT ( 
		SW: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END lab7part1;
ARCHITECTURE Structural OF lab7part1 IS
	SIGNAL y : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL yn : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL w, z, clk, reset : STD_LOGIC;
	CONSTANT A : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000001";
	CONSTANT B : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000010";
	CONSTANT C : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000100";
	CONSTANT D : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000001000";
	CONSTANT E : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000010000";
	CONSTANT F : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000100000";
	CONSTANT G : STD_LOGIC_VECTOR(8 DOWNTO 0) := "001000000";
	CONSTANT H : STD_LOGIC_VECTOR(8 DOWNTO 0) := "010000000";
	CONSTANT I : STD_LOGIC_VECTOR(8 DOWNTO 0) := "100000000";
BEGIN
	w <= SW(1);
	clk <= KEY(0);
	reset <= SW(0);
	LEDG(0) <= z;
	LEDR(8 DOWNTO 0) <= y;
	z <= '1' WHEN (y = I OR y = E) ELSE '0';
	
	PROCESS (y,w)
	BEGIN
		IF reset THEN
			yn <= A;
		ELSE
			yn(1) <= NOT w AND 
						(y(0) OR
						y(5) OR
						y(6) OR
						y(7) OR
						y(8));
			yn(2) <= y(1) AND NOT w;
			yn(3) <= y(2) AND NOT w;
			yn(4) <= (y(3) AND NOT w) OR
						(y(4) AND NOT w);
			
			yn(5) <= w AND 
						(y(0) OR
						y(1) OR
						y(2) OR
						y(3) OR
						y(4));
			yn(6) <= y(5) AND w;
			yn(7) <= y(6) AND w;
			yn(8) <= (y(7) AND w) OR
						(y(8) AND w);
		END IF;
	END PROCESS;
	
	PROCESS (clk)
	BEGIN
		WAIT UNTIL clk'EVENT AND clk='1';
		y <= yn;
	END PROCESS;
END Structural;