library verilog;
use verilog.vl_types.all;
entity lab11part1 is
    port(
        Clock           : in     vl_logic;
        Resetn          : in     vl_logic;
        LA              : in     vl_logic;
        s               : in     vl_logic;
        Data            : in     vl_logic_vector(7 downto 0);
        B               : out    vl_logic_vector(3 downto 0);
        AA              : out    vl_logic_vector(7 downto 0);
        Done            : out    vl_logic
    );
end lab11part1;
