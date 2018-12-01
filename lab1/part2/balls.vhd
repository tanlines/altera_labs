LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part2 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(9 downto 0);
LEDG : OUT STD_LOGIC_VECTOR(8 downto 0));

END part2;

ARCHITECTURE Behavior OF part2 IS
  signal s : std_logic;
  signal x : STD_LOGIC_VECTOR(3 downto 0);
  signal y : STD_LOGIC_VECTOR(3 downto 0);
  signal m : STD_LOGIC_VECTOR(3 downto 0);

BEGIN
  s <= SW(9);
  x <= SW(3 DOWNTO 0);
  y <= SW(7 DOWNTO 4);
  LEDG(3 DOWNTO 0) <= m;

  m(0) <= (NOT (s) AND x(0)) OR (s AND y(0));
  m(1) <= (NOT (s) AND x(1)) OR (s AND y(1));
  m(2) <= (NOT (s) AND x(2)) OR (s AND y(2));
  m(3) <= (NOT (s) AND x(3)) OR (s AND y(3));

END Behavior;