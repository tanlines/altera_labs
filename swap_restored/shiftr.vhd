LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY shiftr IS -- left-to-right shift register with async reset
	GENERIC ( K : INTEGER := 4 ) ;
	PORT (	Resetn, Clock, w 	: IN	 		STD_LOGIC ;
			Q 			: BUFFER 	STD_LOGIC_VECTOR(1 TO K) ) ;
END shiftr ;

ARCHITECTURE Behavior OF shiftr IS	
BEGIN
	PROCESS ( Resetn, Clock )
	BEGIN
		IF Resetn = '0' THEN
				Q <= (OTHERS => '0') ;
		ELSIF Clock'EVENT AND Clock = '1' THEN
			Genbits: FOR i IN K DOWNTO 2 LOOP
				Q(i) <= Q(i-1) ;
			END LOOP ;
			Q(1) <= w ;
		END IF ;
	END PROCESS ;
END Behavior ;

