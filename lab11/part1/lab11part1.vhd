LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
ENTITY lab11part1 IS
PORT( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		CLOCK_50 : IN STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END lab11part1 ;
ARCHITECTURE Behavior OF lab11part1 IS
COMPONENT shiftCounter
PORT( Clock, Resetn : IN STD_LOGIC ;
		LA, s : IN STD_LOGIC ;
		Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
		B : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0) ;
		AA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
		Done : OUT STD_LOGIC ) ;
END COMPONENT;

SIGNAL LA, Resetn,s, Done : STD_LOGIC;
SIGNAL Data : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
SIGNAL B : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL AA : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
BEGIN
	Data <= SW(7 DOWNTO 0);
	s <= SW(8);
	Resetn <= KEY(0);
	LA <= KEY(1);
	counterr : shiftCounter PORT MAP (CLOCK_50,Resetn,LA,s,Data,B,AA,Done);
	LEDG(0) <= Done;
	LEDR(2 DOWNTO 0) <= B;
END Behavior;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
ENTITY shiftCounter IS
PORT( Clock, Resetn : IN STD_LOGIC ;
		LA, s : IN STD_LOGIC ;
		Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;
		B : BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0) ;
		AA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;
		Done : OUT STD_LOGIC ) ;
END shiftCounter ;
ARCHITECTURE Behavior OF shiftCounter IS
	COMPONENT shiftrne -- left-to-right shift register with async reset
		GENERIC ( K : INTEGER := 4 ) ;
		PORT (	Q 			: IN 	STD_LOGIC_VECTOR(1 TO K);
		LA,EA, w,Clock 	: IN	STD_LOGIC; 
			A : OUT 	STD_LOGIC_VECTOR(1 TO K)) ;
	END COMPONENT ;

	TYPE State_type IS ( S1, S2, S3 ) ;
	SIGNAL y : State_type ;
	SIGNAL A : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
	ATTRIBUTE keep : boolean;
	ATTRIBUTE keep of y : SIGNAL IS true;
	SIGNAL z, EA, LB, EB, low : STD_LOGIC ;
BEGIN
	AA <= A;
	FSM_transitions: PROCESS ( Resetn, Clock )
	BEGIN
		IF Resetn = '0' THEN
			y <= S1 ;
			ELSIF (Clock'EVENT AND Clock = '1') THEN
			CASE y IS
			WHEN S1 =>
			IF s = '0' THEN y <= S1 ;
			ELSE y <= S2 ; END IF ;
			WHEN S2 =>
			IF z = '0' THEN y <= S2 ;
			ELSE y <= S3 ; END IF ;
			WHEN S3 =>
			IF s = '1' THEN y <= S3 ;
			ELSE y <= S1 ; END IF ;
			END CASE ;
		END IF ;
	END PROCESS ;

	FSM_outputs: PROCESS ( y, A(0) )
	BEGIN
	EA <= '0' ; LB <= '0' ; EB <= '0' ; Done <= '0' ;
	CASE y IS
		WHEN S1 =>
			LB <= '1';
		WHEN S2 =>
			EA <= '1' ;
			IF A(0) = '1' THEN EB <= '1' ;
		END IF ;
		WHEN S3 =>
			Done <= '1' ;
	END CASE ;
	END PROCESS ;

	-- The datapath circuit is described below
	upcount: PROCESS ( Resetn, Clock )
	BEGIN
	IF Resetn = '0' THEN
			B <= (OTHERS => '0') ;
	ELSIF (Clock'EVENT AND Clock = '1') THEN
		IF LB = '1' THEN
			B <= (OTHERS => '0') ;
		ELSIF EB = '1' THEN
			B <= B + 1 ;
		END IF ;
	END IF;
	END PROCESS;
	low <= '0' ;
	ShiftA: shiftrne GENERIC MAP ( K => 8 ) PORT MAP ( Data, LA, EA, low, Clock, A ) ;
	z <= '1' WHEN A = "00000000" ELSE '0' ;

END Behavior;


LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY shiftrne IS -- left-to-right shift register with async reset
	GENERIC ( K : INTEGER := 4 ) ;
	PORT (	Q 			: IN 	STD_LOGIC_VECTOR(K-1 DOWNTO 0);
	LA,EA, w,Clock 	: IN	STD_LOGIC; 
		A : BUFFER 	STD_LOGIC_VECTOR(K-1 DOWNTO 0)) ;
END shiftrne ;

ARCHITECTURE Behavior OF shiftrne IS
BEGIN
	PROCESS ( LA,Clock )
	BEGIN
		IF LA = '1' THEN
			A <= Q;
		ELSIF Clock'EVENT AND Clock = '1' THEN
			IF EA = '1' THEN
				Genbits: FOR i IN K-1 DOWNTO 1 LOOP
					A(i-1) <= A(i) ;
				END LOOP ;
				A(K-1) <= w;
			END IF;
		END IF ;
	END PROCESS ;
END Behavior ;

