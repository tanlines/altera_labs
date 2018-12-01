library verilog;
use verilog.vl_types.all;
entity lab9part1 is
    port(
        DIN             : in     vl_logic_vector(8 downto 0);
        Resetn          : in     vl_logic;
        Clock           : in     vl_logic;
        Run             : in     vl_logic;
        Done            : out    vl_logic;
        Timing          : out    vl_logic_vector(3 downto 0);
        Instruction     : out    vl_logic_vector(0 to 8);
        BusWires        : out    vl_logic_vector(8 downto 0)
    );
end lab9part1;
