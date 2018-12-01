library verilog;
use verilog.vl_types.all;
entity part2_vlg_sample_tst is
    port(
        V               : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end part2_vlg_sample_tst;
