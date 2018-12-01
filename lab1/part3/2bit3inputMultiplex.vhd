LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part3 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(9 downto 0);
LEDG : OUT STD_LOGIC_VECTOR(8 downto 0);
LEDR : OUT STD_LOGIC_VECTOR(9 downto 0));

END part3;

ARCHITECTURE Behavior OF part3 IS
  signal s : STD_LOGIC_VECTOR(1 downto 0);
  signal x : STD_LOGIC_VECTOR(1 downto 0);
  signal y : STD_LOGIC_VECTOR(1 downto 0);
  signal z : STD_LOGIC_VECTOR(1 downto 0);
  signal m : STD_LOGIC_VECTOR(1 downto 0);

BEGIN
  s <= SW(9 DOWNTO 8);
  x <= SW(5 DOWNTO 4);
  y <= SW(3 DOWNTO 2);
  z <= SW(1 DOWNTO 0);
  LEDG(1 DOWNTO 0) <= m;
  LEDR <= SW;

  m(0) <= (NOT (s(0)) AND NOT (s(1)) AND x(0)) OR
				((s(0)) AND NOT (s(1)) AND y(0)) OR
				(NOT (s(0)) AND (s(1)) AND z(0)) OR
				((s(0)) AND (s(1)) AND z(0));
  m(1) <= (NOT (s(0)) AND NOT (s(1)) AND x(1)) OR
				((s(0)) AND NOT (s(1)) AND y(1)) OR
				(NOT (s(0)) AND (s(1)) AND z(1)) OR
				((s(0)) AND (s(1)) AND z(1));

END Behavior;