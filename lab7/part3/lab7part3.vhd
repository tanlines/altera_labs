LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY lab7part3 IS
	PORT ( 
		SW: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END lab7part3;
ARCHITECTURE Structural OF lab7part3 IS
	COMPONENT shiftr IS -- left-to-right shift register with async reset
		GENERIC ( K : INTEGER := 4 ) ;
		PORT (	Resetn, Clock, w 	: IN	 		STD_LOGIC ;
				Q 			: BUFFER 	STD_LOGIC_VECTOR(1 TO K) ) ;
	END COMPONENT ;
	SIGNAL q0, q1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL w, z, clk, reset0,reset1 : STD_LOGIC;

BEGIN
	w <= SW(1);
	clk <= KEY(0);
	reset0 <= SW(0) AND NOT SW(1);
	reset1 <= SW(0) AND SW(1);
	LEDG(0) <= z;
	LEDR(3 DOWNTO 0) <= q0;
	LEDR(7 DOWNTO 4) <= q1;
	z <= '1' WHEN (q0(0) = '1' OR q1(0) = '1') ELSE '0';
	shift0 : shiftr PORT MAP(reset0,clk,NOT(w),q0);
	shift1 : shiftr PORT MAP(reset1,clk,w,q1);
	
END Structural;