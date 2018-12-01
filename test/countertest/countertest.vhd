LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY countertest IS
	PORT (
	Resetn, Clock : IN STD_LOGIC;
	T : OUT STD_LOGIC_VECTOR(0 TO 3)
	);
END countertest ;
ARCHITECTURE Behavior OF countertest IS
	COMPONENT dec2to4 IS
		PORT (  w : IN  STD_LOGIC_VECTOR(1 DOWNTO 0) ;
				En  : IN  STD_LOGIC ;
				y   : OUT   STD_LOGIC_VECTOR(0 TO 3) ) ;
	END COMPONENT;
		COMPONENT upcount IS
		PORT (  Clear, Clock  : IN    STD_LOGIC ;
				Q       : BUFFER  STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
	END COMPONENT ;
-- Timing state
-- Counter for timer
SIGNAL Count : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
BEGIN
	-- decode to get current timing state
	decT : dec2to4 PORT MAP ( Count, '1', T );
	-- Increment Count on clock event
	counter: upcount PORT MAP ( Resetn, Clock, Count ) ;
END Behavior;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY dec2to4 IS
  PORT (  w : IN  STD_LOGIC_VECTOR(1 DOWNTO 0) ;
    En  : IN  STD_LOGIC ;
    y   : OUT   STD_LOGIC_VECTOR(0 TO 3) ) ;
END dec2to4 ;

ARCHITECTURE Behavior OF dec2to4 IS
  SIGNAL Enw : STD_LOGIC_VECTOR(2 DOWNTO 0) ;
BEGIN
  Enw <= En & w ;
  WITH Enw SELECT
    y <= "1000" WHEN "100",
      "0100" WHEN "101",
      "0010" WHEN "110",
      "0001" WHEN "111",
      "0000" WHEN OTHERS ;
END Behavior ;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY upcount IS
  PORT (  Clear, Clock  : IN    STD_LOGIC ;
      Q       : BUFFER  STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
END upcount ;

ARCHITECTURE Behavior OF upcount IS
BEGIN
  upcount: PROCESS ( Clock )
  BEGIN
    IF (Clock'EVENT AND Clock = '1') THEN
        IF Clear = '1' THEN
            Q <= "00" ;
        ELSE
            Q <= Q + '1' ;
      END IF ;
    END IF;
  END PROCESS;
END Behavior ;

