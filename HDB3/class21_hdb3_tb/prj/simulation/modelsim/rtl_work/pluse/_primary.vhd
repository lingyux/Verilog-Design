library verilog;
use verilog.vl_types.all;
entity pluse is
    generic(
        plu             : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0)
    );
    port(
        i_clk           : in     vl_logic;
        i_rst_n         : in     vl_logic;
        o_pluse         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of plu : constant is 1;
end pluse;
