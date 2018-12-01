library verilog;
use verilog.vl_types.all;
entity part2_vlg_check_tst is
    port(
        M               : in     vl_logic_vector(3 downto 0);
        z               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end part2_vlg_check_tst;
