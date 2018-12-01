library verilog;
use verilog.vl_types.all;
entity countertest is
    port(
        Resetn          : in     vl_logic;
        Clock           : in     vl_logic;
        T               : out    vl_logic_vector(0 to 3)
    );
end countertest;
