library verilog;
use verilog.vl_types.all;
entity countertest_vlg_check_tst is
    port(
        T               : in     vl_logic_vector(0 to 3);
        sampler_rx      : in     vl_logic
    );
end countertest_vlg_check_tst;
