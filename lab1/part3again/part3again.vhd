LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part3again IS
PORT ( 
s,x,y,z : IN STD_LOGIC_VECTOR(1 downto 0);
m : OUT STD_LOGIC_VECTOR(1 downto 0));

END part3again;

ARCHITECTURE Behavior OF part3again IS
  signal SW : STD_LOGIC_VECTOR(9 downto 0);
  signal LEDG : STD_LOGIC_VECTOR(7 downto 0);
  signal LEDR : STD_LOGIC_VECTOR(9 downto 0);

BEGIN
  SW(9 DOWNTO 8) <= s;
  SW(5 DOWNTO 4) <= x;
  SW(3 DOWNTO 2) <= y;
  SW(1 DOWNTO 0) <= z;
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