library verilog;
use verilog.vl_types.all;
entity countertest_vlg_sample_tst is
    port(
        Clock           : in     vl_logic;
        Resetn          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end countertest_vlg_sample_tst;
