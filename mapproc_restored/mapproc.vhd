library ieee;
use ieee.std_logic_1164.all;
use work.subccts.all;
use work.proc_pkg.all;

entity mapproc is
	port (sw: in std_logic_vector(9 downto 0);
		  key: in std_logic_vector(3 downto 0);
		  ledg: out std_logic_vector(7 downto 0);
		  ledr: out std_logic_vector(9 downto 0);
		  hex0: out std_logic_vector(0 to 6);
		  hex1: out std_logic_vector(0 to 6);
		  hex2: out std_logic_vector(0 to 6);
		  hex3: out std_logic_vector(0 to 6)
		 );
end mapproc;

architecture structural of mapproc is
	signal done, reset, w, clock: std_logic;
	signal buswires: std_logic_vector(3 downto 0);
	signal r0, r1, r2, r3: std_logic_vector(3 downto 0);
begin
	reset <= not key(1);
	w <= not key(3);
	clock <= not key(0);
	ledg(7) <= done;
	ledr(3 downto 0) <= buswires;
	
	proc0: proc	generic map (L => 4)
				port map(Data => sw(3 downto 0),
						Reset => reset,
						w => w,
						Clock => clock,
						F => sw(9 downto 8),
						RX => sw(7 downto 6),
						RY => sw(5 downto 4),
						Done => done,
						BusWires => buswires,
						R0 => r0,
						R1 => r1,
						R2 => r2,
						R3 => r3);
						
	dig0: seg7 PORT map (  r0, hex0);
	dig1: seg7 PORT map (  r1, hex1);
	dig2: seg7 PORT map (  r2, hex2);
	dig3: seg7 PORT map (  r3, hex3);
	
end structural;
	