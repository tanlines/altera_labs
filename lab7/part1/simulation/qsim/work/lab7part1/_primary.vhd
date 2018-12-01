library verilog;
use verilog.vl_types.all;
entity lab7part1 is
    port(
        SW              : in     vl_logic_vector(3 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0);
        LEDG            : out    vl_logic_vector(7 downto 0)
    );
end lab7part1;
