library verilog;
use verilog.vl_types.all;
entity lab11part1_vlg_check_tst is
    port(
        AA              : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        Done            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end lab11part1_vlg_check_tst;
