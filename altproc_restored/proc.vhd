LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all ;
USE work.subccts.all ;

ENTITY proc IS
  GENERIC(L: INTEGER := 8);
  PORT (  Data      : IN    STD_LOGIC_VECTOR(L-1 DOWNTO 0) ;
    Reset, w    : IN    STD_LOGIC ;
    Clock     : IN    STD_LOGIC ;
    F, Rx, Ry   : IN    STD_LOGIC_VECTOR(1 DOWNTO 0) ;
    Done      : BUFFER  STD_LOGIC ;
    BusWires  : BUFFER STD_LOGIC_VECTOR(L-1 DOWNTO 0) ) ;
END proc ;

ARCHITECTURE Behavior OF proc IS
  SIGNAL X, Y, Rin, Rout : STD_LOGIC_VECTOR(0 TO 3) ;
  SIGNAL Clear, High, AddSub : STD_LOGIC ;
  SIGNAL Extern, Ain, Gin, Gout, FRin : STD_LOGIC ;
  SIGNAL Count, T, I : STD_LOGIC_VECTOR(1 DOWNTO 0) ;
  SIGNAL R0, R1, R2, R3 : STD_LOGIC_VECTOR(L-1 DOWNTO 0) ;
  SIGNAL A, Sum, G : STD_LOGIC_VECTOR(L-1 DOWNTO 0) ;
  SIGNAL Func, FuncReg, Sel : STD_LOGIC_VECTOR(1 TO 6) ;
BEGIN
  High <= '1' ;
  Clear <= Reset OR Done OR (NOT w AND NOT T(1) AND NOT T(0)) ;
  counter: upcount PORT MAP ( Clear, Clock, Count ) ;
  T <= Count ;
  Func <= F & Rx & Ry ;
  FRin <= w AND NOT T(1) AND NOT T(0) ;
  functionreg: regn GENERIC MAP ( N => 6 ) 
          PORT MAP ( Func, FRin, Clock, FuncReg ) ;
  I <= FuncReg(1 TO 2) ;
  decX: dec2to4 PORT MAP ( FuncReg(3 TO 4), High, X ) ;
  decY: dec2to4 PORT MAP ( FuncReg(5 TO 6), High, Y ) ;
  
  controlsignals: PROCESS ( T, I, X, Y )
  BEGIN
    Extern <= '0' ; Done <= '0' ; Ain <= '0' ; Gin <= '0' ;
    Gout <= '0' ; AddSub <= '0' ; Rin <= "0000" ; Rout <= "0000" ;
    CASE T IS WHEN "00" => -- no signals asserted in time step T0
    WHEN "01" => -- define signals asserted in time step T1
      CASE I IS
        WHEN "00" => -- Load
            Extern <= '1' ; Rin <= X ; Done <= '1' ;
        WHEN "01" => -- Move
            Rout <= Y ; Rin <= X ; Done <= '1' ;
        WHEN OTHERS => -- Add, Sub
            Rout <= X ; Ain <= '1' ;
      END CASE ;
    WHEN "10" => -- define signals asserted in time step T2
      CASE I IS
          WHEN "10" => -- Add
              Rout <= Y ; Gin <= '1' ;
          WHEN "11" => -- Sub
              Rout <= Y ; AddSub <= '1' ; Gin <= '1' ;
          WHEN OTHERS => -- Load, Move
      END CASE ;
    WHEN OTHERS => -- define signals asserted in time step T3
      CASE I IS
          WHEN "00" => -- Load
          WHEN "01" => -- Move
          WHEN OTHERS => -- Add, Sub
            Gout <= '1' ; Rin <= X ; Done <= '1' ;
      END CASE ;
    END CASE ;
  END PROCESS ;
  reg0: regn GENERIC MAP (N => L) PORT MAP ( BusWires, Rin(0), Clock, R0 ) ;
  reg1: regn GENERIC MAP (N => L) PORT MAP ( BusWires, Rin(1), Clock, R1 ) ;
  reg2: regn GENERIC MAP (N => L) PORT MAP ( BusWires, Rin(2), Clock, R2 ) ;
  reg3: regn GENERIC MAP (N => L) PORT MAP ( BusWires, Rin(3), Clock, R3 ) ;
  regA: regn GENERIC MAP (N => L) PORT MAP ( BusWires, Ain, Clock, A ) ;
  alu: WITH AddSub SELECT
    Sum <= A + BusWires WHEN '0',
        A - BusWires WHEN OTHERS ;
  regG: regn GENERIC MAP (N => L) PORT MAP ( Sum, Gin, Clock, G ) ;
  Sel <= Rout & Gout & Extern ;
  WITH Sel SELECT
    BusWires <= R0 WHEN "100000",
            R1 WHEN "010000",
            R2 WHEN "001000",
            R3 WHEN "000100",
            G WHEN "000010",
            Data WHEN OTHERS ;
END Behavior ;