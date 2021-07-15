library verilog;
use verilog.vl_types.all;
entity hdb3_decode is
    port(
        i_rst_n         : in     vl_logic;
        i_clk           : in     vl_logic;
        i_hdb3_code     : in     vl_logic_vector(1 downto 0);
        o_data          : out    vl_logic
    );
end hdb3_decode;
