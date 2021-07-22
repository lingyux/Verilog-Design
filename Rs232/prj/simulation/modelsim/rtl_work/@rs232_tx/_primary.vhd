library verilog;
use verilog.vl_types.all;
entity Rs232_tx is
    generic(
        UART_BPS        : integer := 9600;
        CLK_FREQ        : integer := 50000000
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        pi_data         : in     vl_logic_vector(7 downto 0);
        pi_flag         : in     vl_logic;
        tx              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of UART_BPS : constant is 1;
    attribute mti_svvh_generic_type of CLK_FREQ : constant is 1;
end Rs232_tx;
