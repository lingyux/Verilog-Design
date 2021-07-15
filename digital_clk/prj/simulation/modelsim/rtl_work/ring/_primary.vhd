library verilog;
use verilog.vl_types.all;
entity ring is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        load            : in     vl_logic;
        data_in_load    : in     vl_logic_vector(15 downto 0);
        data_in_cmp     : in     vl_logic_vector(15 downto 0);
        data_ring       : out    vl_logic_vector(15 downto 0);
        ring            : out    vl_logic
    );
end ring;
