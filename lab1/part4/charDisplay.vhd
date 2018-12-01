LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part4 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(9 downto 0);
HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6));

END part4;

ARCHITECTURE Behavior OF part4 IS
  signal c : STD_LOGIC_VECTOR(1 downto 0);
  signal m : STD_LOGIC_VECTOR(0 TO 6);

BEGIN
  c <= SW(1 DOWNTO 0);
  HEX0 <= NOT m;

  m(0) <= 
				(NOT c(1) AND c(0));
  m(1) <= 
				((NOT c(1) AND NOT c(0)) OR
				(c(1) AND NOT c(0)));
  m(2) <= 
				((NOT c(1) AND NOT c(0)) OR
				(c(1) AND NOT c(0)));
  m(3) <= 
				((NOT c(1) AND c(0)) OR
				(NOT c(1) AND NOT c(0)));
  m(4) <= 
				((NOT c(1) AND c(0)) OR
				(NOT c(1) AND NOT c(0)));
  m(5) <= 
				(NOT c(1) AND c(0));
  m(6) <= 
				((NOT c(1) AND c(0)) OR
				(NOT c(1) AND NOT c(0)));

END Behavior;