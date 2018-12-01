LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY part1 IS
	PORT ( T, Clk, Clear : IN STD_LOGIC ;
	Q : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)) ;
END part1 ;
ARCHITECTURE Behavior OF part1 IS
	COMPONENT myTff
		PORT ( T, Clk, Clear : IN STD_LOGIC ;
		Q : OUT STD_LOGIC) ;
	END COMPONENT;
	
	SIGNAL myT : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	myT(0) <= T;
	G1: FOR I IN 0 TO 7 GENERATE
		stages: myTff PORT MAP(myT(I),Clk,Clear,Q(I));
	END GENERATE;
	G2: FOR I IN 1 TO 7 GENERATE
		myT(I) <= myT(I-1) AND Q(I-1);
	END GENERATE;
END Behavior;


LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY myTff IS
	PORT ( T, Clk, Clear : IN STD_LOGIC ;
	Q : OUT STD_LOGIC) ;
END myTff ;

ARCHITECTURE Behavior OF myTff IS
	SIGNAL Q_a : STD_LOGIC;
BEGIN
	PROCESS (Clear, Clk)
	BEGIN
		IF (Clear = '1') THEN
			Q_a <= '0';
		ELSIF (Clk'Event AND Clk = '1') THEN
			Q_a <= T XOR Q_a;
		END IF;
	END PROCESS;
	
	Q <= Q_a;
END Behavior;