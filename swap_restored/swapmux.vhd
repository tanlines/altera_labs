LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE work.components.all ;

ENTITY swapmux IS
	PORT ( 	Data 		: IN 	STD_LOGIC_VECTOR(7 DOWNTO 0) ;
				Resetn, w 	: IN 	STD_LOGIC ;
				Clock 		: IN 	STD_LOGIC ;
				RinExt	 	: IN 	STD_LOGIC_VECTOR(1 TO 3) ;
				BusWires 	: BUFFER	STD_LOGIC_VECTOR(7 DOWNTO 0) ) ;
END swapmux ;

ARCHITECTURE Behavior OF swapmux IS
	SIGNAL Rin, Q : STD_LOGIC_VECTOR(1 TO 3) ;
	SIGNAL S : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
	SIGNAL R1, R2, R3 : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
BEGIN
	control: shiftr GENERIC MAP ( K => 3 )
				PORT MAP ( Resetn, Clock, w, Q ) ;
	Rin(1) <= RinExt(1) OR Q(3) ;
	Rin(2) <= RinExt(2) OR Q(2) ;
	Rin(3) <= RinExt(3) OR Q(1) ;
	reg1: regn PORT MAP ( BusWires, Rin(1), Clock, R1 ) ;
	reg2: regn PORT MAP ( BusWires, Rin(2), Clock, R2 ) ;
	reg3: regn PORT MAP ( BusWires, Rin(3), Clock, R3 ) ;
	encoder:
	WITH Q SELECT
		S <=	"00" WHEN "000",
				"10" WHEN "100",
				"01" WHEN "010",
				"11" WHEN OTHERS ;
	muxes: --eight 4-to-1 multiplexers
	WITH S SELECT
		BusWires <=Data WHEN "00",
						R1 WHEN "01",
						R2 WHEN "10",
						R3 WHEN OTHERS ;
END Behavior ;

