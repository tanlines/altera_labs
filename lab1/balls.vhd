LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY balls IS
PORT ( SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END balls;
ARCHITECTURE Behavior OF balls IS
BEGIN
LEDR <= SW;
END Behavior;