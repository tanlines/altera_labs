LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY lab7part2 IS
	PORT ( 
		SW: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END lab7part2;
ARCHITECTURE Structural OF lab7part2 IS
	TYPE State_type IS (A,B,C,D,E,F,G,H,I);
	attribute syn_encoding : string;
	attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";
	SIGNAL y : State_type;
	SIGNAL y_next : State_type;
	SIGNAL w, z, clk, reset : STD_LOGIC;
BEGIN
	w <= SW(1);
	clk <= KEY(0);
	reset <= SW(0);
	LEDG(0) <= z;
	LEDR(3 DOWNTO 0) <= "1010";
	z <= '1' WHEN (y = I OR y = E) ELSE '0';
	PROCESS (w, y)
	BEGIN
		CASE y IS
			WHEN A =>
				IF w = '0' THEN
					y_next <= B;
				ELSE
					y_next <= F;
				END IF;
			WHEN B =>
				IF w = '0' THEN
					y_next <= C;
				ELSE
					y_next <= F;
				END IF;
			WHEN C =>
				IF w = '0' THEN
					y_next <= D;
				ELSE
					y_next <= F;
			END IF;
			WHEN D =>
				IF w = '0' THEN
					y_next <= E;
				ELSE
					y_next <= F;
			END IF;
			WHEN E =>
				IF w = '0' THEN
					y_next <= E;
				ELSE
					y_next <= F;
			END IF;
			WHEN F =>
				IF w = '0' THEN
					y_next <= B;
				ELSE
					y_next <= G;
			END IF;
			WHEN G =>
				IF w = '0' THEN
					y_next <= B;
				ELSE
					y_next <= H;
			END IF;
			WHEN H =>
				IF w = '0' THEN
					y_next <= B;
				ELSE
					y_next <= I;
			END IF;
			WHEN I =>
				IF w = '0' THEN
					y_next <= B;
				ELSE
					y_next <= I;
			END IF;
			WHEN OTHERS =>
				y_next <= A;
		END CASE;
	END PROCESS;
	
	PROCESS (clk)
	BEGIN
		IF reset='0' THEN
			y <= A;
		ELSIF clk'EVENT AND clk='1' THEN
			y <= y_next;
		END IF;
	END PROCESS;
END Structural;