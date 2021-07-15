library verilog;
use verilog.vl_types.all;
entity divider is
    generic(
        T               : vl_logic_vector(0 to 16) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0)
    );
    port(
        i_clk           : in     vl_logic;
        i_rst_n         : in     vl_logic;
        clk_1ms         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T : constant is 1;
end divider;
