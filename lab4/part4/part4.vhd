LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all;
ENTITY part4 IS
	PORT (
	CLOCK_50 : IN STD_LOGIC;
	HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
	LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	) ;
END part4 ;

ARCHITECTURE Behaviour OF part4 IS
	COMPONENT binaryToHexDisplay
		PORT ( a : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
			HEX : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	
	COMPONENT counter26
		PORT ( T, Clk, Clear : IN STD_LOGIC ;
		Q : INOUT STD_LOGIC_VECTOR(25 DOWNTO 0)) ;
	END COMPONENT;
	
	COMPONENT counter4 IS
	PORT ( T, Clk, Clear : IN STD_LOGIC ;
	Q : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0)) ;
	END COMPONENT ;
	
	SIGNAL digit_clear,clock_clear : STD_LOGIC;
	SIGNAL digit0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL clock_count : STD_LOGIC_VECTOR(25 DOWNTO 0);
BEGIN
	LEDR(0) <= CLOCK_50;
	PROCESS (CLOCK_50,clock_count)
	BEGIN
		IF (CLOCK_50'EVENT AND CLOCK_50 = '0') THEN
			clock_clear <= '0';
			digit_clear <= '0';
			IF clock_count >= 50000000 THEN
				clock_clear <= '1';
			END IF;
			IF digit0 >= 9 THEN
				digit_clear <= '1';
			END IF;
		END IF;
	END PROCESS;
	
	digit_increment : counter4 PORT MAP('1',CLOCK_50,digit_clear,digit0);
	clock_increment : counter26 PORT MAP('1',CLOCK_50,clock_clear,clock_count);
	display0 : binaryToHexDisplay PORT MAP(digit0, HEX0);
END Behaviour;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY counter26 IS
	PORT ( T, Clk, Clear : IN STD_LOGIC ;
	Q : INOUT STD_LOGIC_VECTOR(25 DOWNTO 0)) ;
END counter26 ;
ARCHITECTURE Behavior OF counter26 IS
	COMPONENT myTff
		PORT ( T, Clk, Clear : IN STD_LOGIC ;
		Q : OUT STD_LOGIC) ;
	END COMPONENT;
	
	SIGNAL myT : STD_LOGIC_VECTOR(25 DOWNTO 0);
BEGIN
	myT(0) <= T;
	G1: FOR I IN 0 TO 25 GENERATE
		stages: myTff PORT MAP(myT(I),Clk,Clear,Q(I));
	END GENERATE;
	G2: FOR I IN 1 TO 25 GENERATE
		myT(I) <= myT(I-1) AND Q(I-1);
	END GENERATE;
END Behavior;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY counter4 IS
	PORT ( T, Clk, Clear : IN STD_LOGIC ;
	Q : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0)) ;
END counter4 ;
ARCHITECTURE Behavior OF counter4 IS
	COMPONENT myTff
		PORT ( T, Clk, Clear : IN STD_LOGIC ;
		Q : OUT STD_LOGIC) ;
	END COMPONENT;
	
	SIGNAL myT : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	myT(0) <= T;
	G1: FOR I IN 0 TO 3 GENERATE
		stages: myTff PORT MAP(myT(I),Clk,Clear,Q(I));
	END GENERATE;
	G2: FOR I IN 1 TO 3 GENERATE
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