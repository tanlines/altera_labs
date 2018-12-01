LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY part4 IS
	PORT ( D, Clk : IN STD_LOGIC ;
	Q_a, Q_b, Q_c : OUT STD_LOGIC) ;
END part4 ;

ARCHITECTURE Behavior OF part4 IS
	COMPONENT myDLatch
		PORT ( D, Clk : IN STD_LOGIC ;
			Q : OUT STD_LOGIC) ;
	END COMPONENT;
	COMPONENT PEFF
		PORT ( D, Clk : IN STD_LOGIC ;
			Q : OUT STD_LOGIC) ;
	END COMPONENT;
BEGIN
	latch1: myDLatch PORT MAP(D,Clk,Q_a);
	latch2: PEFF PORT MAP(D,Clk, Q_b);
	latch3: PEFF PORT MAP(D,NOT Clk, Q_c);
END Behavior ;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY myDLatch IS
	PORT ( D, Clk : IN STD_LOGIC ;
	Q : OUT STD_LOGIC) ;
END myDLatch ;

ARCHITECTURE Behavior OF myDLatch IS
	BEGIN
		PROCESS ( D, Clk )
			BEGIN
				IF Clk = '1' THEN
				Q <= D ;
				END IF ;
		END PROCESS ;
END Behavior ;

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY PEFF IS
	PORT ( D, Clk : IN STD_LOGIC ;
	Q : OUT STD_LOGIC) ;
END PEFF ;

ARCHITECTURE Behavior OF PEFF IS
	BEGIN
		PROCESS ( D, Clk )
			BEGIN
				IF Clk'EVENT AND Clk = '1' THEN
				Q <= D ;
				END IF ;
		END PROCESS ;
END Behavior ;