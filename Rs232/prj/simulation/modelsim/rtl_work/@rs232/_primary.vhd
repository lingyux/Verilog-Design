library verilog;
use verilog.vl_types.all;
entity Rs232 is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        rx              : in     vl_logic;
        tx              : out    vl_logic
    );
end Rs232;
