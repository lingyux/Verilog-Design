library verilog;
use verilog.vl_types.all;
entity hdb3_code is
    port(
        i_rst_n         : in     vl_logic;
        i_clk           : in     vl_logic;
        i_data          : in     vl_logic;
        o_hdb3_code     : out    vl_logic_vector(1 downto 0)
    );
end hdb3_code;
