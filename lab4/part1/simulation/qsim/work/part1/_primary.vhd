library verilog;
use verilog.vl_types.all;
entity part1 is
    port(
        T               : in     vl_logic;
        Clk             : in     vl_logic;
        Clear           : in     vl_logic;
        Q               : inout  vl_logic_vector(7 downto 0)
    );
end part1;
