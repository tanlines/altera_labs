LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY part1;
ENTITY part2 IS
PORT ( 
SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6));

END part2;

ARCHITECTURE Behavior OF part2 IS
COMPONENT display
PORT ( 
x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
y : OUT STD_LOGIC_VECTOR(0 TO 6));

END COMPONENT;
COMPONENT circuitA
PORT ( 
a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
b : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));

END COMPONENT;

COMPONENT comparator
PORT ( 
a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
b : OUT STD_LOGIC);

END COMPONENT;

SIGNAL RESULTA : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL M : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL V : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL z : STD_LOGIC;
BEGIN
	V <= SW;
	com: comparator PORT MAP (V(3 DOWNTO 0), z);
	cA: circuitA PORT MAP (V(2 DOWNTO 0),RESULTA);
	M(0) <= (V(0) AND NOT z) OR (RESULTA(0) AND z);
	M(1) <= (V(1) AND NOT z) OR (RESULTA(1) AND z);
	M(2) <= (V(2) AND NOT z) OR (RESULTA(2) AND z);
	M(3) <= (V(3) AND NOT z);
	digit0 : display PORT MAP (M,HEX0);
	digit1 : display PORT MAP ((2 DOWNTO 0 => '0') & z,HEX1);
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY comparator IS
PORT ( 
a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
b : OUT STD_LOGIC);
END comparator;

ARCHITECTURE Behavior OF comparator IS
BEGIN
	b <= a(3) AND (a(2) OR a(1));
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY circuitA IS
PORT ( 
a : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
b : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));

END circuitA;

ARCHITECTURE Behavior OF circuitA IS
BEGIN
	b(0) <= a(0);
	b(1) <= a(2) AND NOT a(1);
	b(2) <= a(2) AND a(1);
END Behavior;