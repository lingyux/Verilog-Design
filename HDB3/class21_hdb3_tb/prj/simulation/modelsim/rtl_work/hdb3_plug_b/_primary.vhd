library verilog;
use verilog.vl_types.all;
entity hdb3_plug_b is
    port(
        i_rst_n         : in     vl_logic;
        i_clk           : in     vl_logic;
        i_plug_v_code   : in     vl_logic_vector(1 downto 0);
        o_plug_b_code   : out    vl_logic_vector(1 downto 0)
    );
end hdb3_plug_b;
