library verilog;
use verilog.vl_types.all;
entity hdb3_plug_v is
    port(
        i_rst_n         : in     vl_logic;
        i_clk           : in     vl_logic;
        i_data          : in     vl_logic;
        o_plug_v_code   : out    vl_logic_vector(1 downto 0)
    );
end hdb3_plug_v;
