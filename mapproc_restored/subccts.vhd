LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

PACKAGE subccts IS
	COMPONENT regn -- register
		GENERIC ( N : INTEGER := 8 ) ;
		PORT  ( 	R 			: IN 		STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			Rin, Clock 	: IN 		STD_LOGIC ;
			Q 			: OUT 	STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
	END COMPONENT ;

	COMPONENT trin -- tri-state buffers
		GENERIC ( N : INTEGER := 8 ) ;
		PORT  ( 	X	 : IN 	STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			E  : IN 	STD_LOGIC ;
			F 	 : OUT 	STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
	END COMPONENT ;

	COMPONENT dec2to4 IS
		PORT (  w : IN  STD_LOGIC_VECTOR(1 DOWNTO 0) ;
				En  : IN  STD_LOGIC ;
				y   : OUT   STD_LOGIC_VECTOR(0 TO 3) ) ;
	END COMPONENT;

	COMPONENT upcount IS
		PORT (  Clear, Clock  : IN    STD_LOGIC ;
				Q       : BUFFER  STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
	END COMPONENT ;

	COMPONENT seg7 IS
		PORT (  bin4  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0) ;
				leds  : OUT   STD_LOGIC_VECTOR(1 TO 7) ) ;
	END COMPONENT ;
END subccts ;

