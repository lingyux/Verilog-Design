library verilog;
use verilog.vl_types.all;
entity led_ctrl is
    generic(
        CNT_MAX         : vl_logic_vector(0 to 22) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        repeat_en       : in     vl_logic;
        led             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CNT_MAX : constant is 1;
end led_ctrl;
