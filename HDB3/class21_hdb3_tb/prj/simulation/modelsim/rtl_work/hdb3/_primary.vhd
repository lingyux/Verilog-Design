library verilog;
use verilog.vl_types.all;
entity hdb3 is
    port(
        i_clk           : in     vl_logic;
        i_rst_n         : in     vl_logic;
        hdb3_decode     : out    vl_logic;
        hdb3_code       : out    vl_logic_vector(1 downto 0);
        r_data          : out    vl_logic
    );
end hdb3;
