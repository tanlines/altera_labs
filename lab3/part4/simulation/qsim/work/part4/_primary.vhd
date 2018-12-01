library verilog;
use verilog.vl_types.all;
entity part4 is
    port(
        D               : in     vl_logic;
        Clk             : in     vl_logic;
        Q_a             : out    vl_logic;
        Q_b             : out    vl_logic;
        Q_c             : out    vl_logic
    );
end part4;
