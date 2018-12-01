library verilog;
use verilog.vl_types.all;
entity part1_vlg_sample_tst is
    port(
        Clear           : in     vl_logic;
        Clk             : in     vl_logic;
        Q               : in     vl_logic_vector(7 downto 0);
        T               : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end part1_vlg_sample_tst;
