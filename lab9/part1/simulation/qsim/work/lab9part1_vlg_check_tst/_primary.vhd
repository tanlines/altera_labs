library verilog;
use verilog.vl_types.all;
entity lab9part1_vlg_check_tst is
    port(
        BusWires        : in     vl_logic_vector(8 downto 0);
        Done            : in     vl_logic;
        Instruction     : in     vl_logic_vector(0 to 8);
        Timing          : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end lab9part1_vlg_check_tst;
