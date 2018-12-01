LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part5 IS
	PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
			LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END part5;

ARCHITECTURE Behavior OF part5 IS
COMPONENT part3
	PORT (s,x,y,z : IN STD_LOGIC_VECTOR(1 downto 0);
	m : OUT STD_LOGIC_VECTOR(1 downto 0));
END COMPONENT;
	
COMPONENT part4
	PORT (SW : IN STD_LOGIC_VECTOR(1 downto 0);
	HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
	
SIGNAL OUT1 : STD_LOGIC_VECTOR(1 DOWNTO 0); 
SIGNAL OUT2 : STD_LOGIC_VECTOR(1 DOWNTO 0); 
SIGNAL OUT3 : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
	LEDR <= SW;
	stage1: part3 PORT MAP (SW(9 DOWNTO 8),SW(5 DOWNTO 4),SW(3 DOWNTO 2),SW(1 DOWNTO 0), OUT1);
	stage2: part3 PORT MAP (SW(9 DOWNTO 8),SW(3 DOWNTO 2),SW(1 DOWNTO 0),SW(5 DOWNTO 4), OUT2);
	stage3: part3 PORT MAP (SW(9 DOWNTO 8),SW(1 DOWNTO 0),SW(5 DOWNTO 4),SW(3 DOWNTO 2), OUT3);
	stage4: part4 PORT MAP (OUT1, HEX0); 
	stage5: part4 PORT MAP (OUT2, HEX1); 
	stage6: part4 PORT MAP (OUT3, HEX2); 
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part3 IS
PORT ( 
s,x,y,z : IN STD_LOGIC_VECTOR(1 downto 0);
m : OUT STD_LOGIC_VECTOR(1 downto 0));

END part3;

ARCHITECTURE Behavior OF part3 IS
BEGIN
  m(0) <= (NOT (s(0)) AND NOT (s(1)) AND x(0)) OR
				((s(0)) AND NOT (s(1)) AND y(0)) OR
				(NOT (s(0)) AND (s(1)) AND z(0)) OR
				((s(0)) AND (s(1)) AND z(0));
  m(1) <= (NOT (s(0)) AND NOT (s(1)) AND x(1)) OR
				((s(0)) AND NOT (s(1)) AND y(1)) OR
				(NOT (s(0)) AND (s(1)) AND z(1)) OR
				((s(0)) AND (s(1)) AND z(1));
END Behavior;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part4 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(1 downto 0);
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