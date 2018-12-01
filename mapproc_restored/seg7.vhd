LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY seg7 IS
  PORT (  bin4  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0) ;
		  leds  : OUT   STD_LOGIC_VECTOR(1 TO 7) ) ;
END seg7 ;
ARCHITECTURE Behavior OF seg7 IS  
BEGIN
  PROCESS ( bin4 )
  BEGIN
    CASE bin4 IS             --    abcdefg
      WHEN "0000"   => leds   <=  "0000001" ;
      WHEN "0001"   => leds   <=  "1001111" ;
      WHEN "0010"   => leds   <=  "0010010" ;
      WHEN "0011"   => leds   <=  "0000110" ;
      WHEN "0100"   => leds   <=  "1001100" ;
      WHEN "0101"   => leds   <=  "0100100" ;
      WHEN "0110"   => leds   <=  "0100000" ;
      WHEN "0111"   => leds   <=  "0001111" ;
      WHEN "1000"   => leds   <=  "0000000" ;
      WHEN "1001"   => leds   <=  "0000100" ;
	  WHEN "1010"   => leds   <=  "0001000" ;
	  WHEN "1011"   => leds   <=  "1100000" ;
	  WHEN "1100"   => leds   <=  "0110001" ;
	  WHEN "1101"   => leds   <=  "1000010" ;
	  WHEN "1110"   => leds   <=  "0110000" ;
	  WHEN "1111"   => leds   <=  "0111000" ;
      WHEN OTHERS   => leds   <=  "-------" ;
    END CASE ;
  END PROCESS ;
END Behavior ;

