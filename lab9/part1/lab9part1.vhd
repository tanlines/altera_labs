LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all ;
USE work.subccts.all ;

ENTITY lab9part1 IS
	PORT ( DIN : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	Resetn, Clock, Run : IN STD_LOGIC;
	Done : BUFFER STD_LOGIC;
	Timing : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	Instruction : OUT STD_LOGIC_VECTOR(0 TO 8);
	BusWires : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0));
END lab9part1 ;
ARCHITECTURE Behavior OF lab9part1 IS
COMPONENT dec3to8
	PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	En : IN STD_LOGIC;
	Y : OUT STD_LOGIC_VECTOR(0 TO 7));
END COMPONENT;
COMPONENT regn
	GENERIC (n : INTEGER := 9);
	PORT ( R : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	Rin, Clock : IN STD_LOGIC;
	Q : BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT;
-- Operation register, holds instruction, source and dest registers
SIGNAL IR : STD_LOGIC_VECTOR(1 TO 9) := (OTHERS => '0');
SIGNAL IRin : STD_LOGIC := '0';
-- Instruction register, first 3 bits of IR
SIGNAL I : STD_LOGIC_VECTOR(0 TO 7) := (OTHERS => '0');
-- X(source) Y(dest) register, bits 4-6 and 7-9 of IR
SIGNAL Xreg, Yreg : STD_LOGIC_VECTOR(0 TO 7) := (OTHERS => '0');

-- Control signals for the 8 9-bit registers
SIGNAL Rin, Rout : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
-- Registers
SIGNAL R0,R1,R2,R3,R4,R5,R6,R7 : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');

-- Clear-? High-? AddSub- 0 to add, 1 to subtract
SIGNAL Clear, High, AddSub : STD_LOGIC := '0';
-- Extern-? Ain, Gin, Gout used in AddSub, FRin-?
SIGNAL Extern, Ain, Gin, Gout, FRin : STD_LOGIC := '0';
SIGNAL A,G,Sum : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
-- Timing state
SIGNAL T : STD_LOGIC_VECTOR(0 TO 3) := (OTHERS => '0');
-- Counter for timer
SIGNAL Count : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	Timing <= T;
	Instruction <= IR;
	High <= '1';
	Clear <= Resetn OR Done OR (NOT Run AND T(0));
	decI: dec3to8 PORT MAP (IR(1 TO 3), High, I);
	-- decode 3 bit to determine source/dest register
	decX: dec3to8 PORT MAP (IR(4 TO 6), High, Xreg);
	decY: dec3to8 PORT MAP (IR(7 TO 9), High, Yreg);
	-- decode to get current timing state
	decT : dec2to4 PORT MAP ( Count, High, T );
	-- Increment Count on clock event
	counter: upcount PORT MAP ( Clear, Clock, Count ) ;
	-- Only allow loading new function when Run and timestate 0
	func_reg: regn PORT MAP (DIN, IRin, Clock, IR);
	din_tri: trin GENERIC MAP (N => 9) PORT MAP (DIN, IRin,BusWires);
	IRin <= Run AND T(0);
	
	-- Control in/out flags for each register
	RegCntl : FOR k IN 0 TO 7 GENERATE
		Rin(k) <= ((I(0) OR I(1)) AND T(1) AND Xreg(k)) OR
		((I(2) OR I(3)) AND T(3) AND Xreg(k)) ;
		Rout(k) <= (I(1) AND T(1) AND Yreg(k)) OR
		((I(2) OR I(3)) AND ((T(1) AND Xreg(k)) OR (T(2) AND Yreg(k)))) ;
	END GENERATE RegCntl;
	-- Refer to function table
	Done <= ((I(0) OR I(1)) AND T(1)) OR ((I(2) OR I(3)) AND T(3));
	Ain <= (I(2) OR I(3)) AND T(1) ;
	Gin <= (I(2) OR I(3)) AND T(2) ;
	Gout <= (I(2) OR I(3)) AND T(3) ;
	AddSub <= I(3) ;
	
	-- Place external data onto bus
	tri_extern : trin GENERIC MAP ( N => 9 ) PORT MAP ( DIN, Extern, BusWires ) ;
	-- Choose which register allows input from bus
	reg_0: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(0), Clock, R0);
	reg_1: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(1), Clock, R1);
	reg_2: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(2), Clock, R2);
	reg_3: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(3), Clock, R3);
	reg_4: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(4), Clock, R4);
	reg_5: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(5), Clock, R5);
	reg_6: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(6), Clock, R6);
	reg_7: regn GENERIC MAP (N => 9) PORT MAP (BusWires, Rin(7), Clock, R7);
	-- Choose which register places data onto bus
	tri_0: trin GENERIC MAP (N => 9) PORT MAP (R0, Rout(0),BusWires);
	tri_1: trin GENERIC MAP (N => 9) PORT MAP (R1, Rout(1),BusWires);
	tri_2: trin GENERIC MAP (N => 9) PORT MAP (R2, Rout(2),BusWires);
	tri_3: trin GENERIC MAP (N => 9) PORT MAP (R3, Rout(3),BusWires);
	tri_4: trin GENERIC MAP (N => 9) PORT MAP (R4, Rout(4),BusWires);
	tri_5: trin GENERIC MAP (N => 9) PORT MAP (R5, Rout(5),BusWires);
	tri_6: trin GENERIC MAP (N => 9) PORT MAP (R6, Rout(6),BusWires);
	tri_7: trin GENERIC MAP (N => 9) PORT MAP (R7, Rout(7),BusWires);
	
	-- Adder circuit
	-- When Ain, loads bus data into temp storage A
	regA : regn GENERIC MAP (N => 9) PORT MAP ( BusWires , Ain , Clock, A ) ;
	alu : WITH AddSub SELECT
		Sum <= A + BusWires WHEN '0', A - BusWires WHEN OTHERS ;
	-- When Gin, loads sum into temp storage G
	regG : regn GENERIC MAP (N => 9) PORT MAP ( Sum, Gin, Clock, G ) ;
	-- When Gout, places Sum onto bus
	triG : trin GENERIC MAP (N => 9) PORT MAP ( G, Gout, BusWires ) ;
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY dec3to8 IS
	PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	En : IN STD_LOGIC;
	Y : OUT STD_LOGIC_VECTOR(0 TO 7));
END dec3to8;
ARCHITECTURE Behavior OF dec3to8 IS
BEGIN
	PROCESS (W, En)
	BEGIN
	IF En = '1' THEN
		CASE W IS
		WHEN "000" => Y <= "10000000";
		WHEN "001" => Y <= "01000000";
		WHEN "010" => Y <= "00100000";
		WHEN "011" => Y <= "00010000";
		WHEN "100" => Y <= "00001000";
		WHEN "101" => Y <= "00000100";
		WHEN "110" => Y <= "00000010";
		WHEN "111" => Y <= "00000001";
	END CASE;
	ELSE
	Y <= "00000000";
	END IF;
	END PROCESS;
	END Behavior;
