library verilog;
use verilog.vl_types.all;
entity tft_colorbar is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        tft_rgb         : out    vl_logic_vector(15 downto 0);
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        tft_de          : out    vl_logic;
        tft_clk         : out    vl_logic;
        tft_bl          : out    vl_logic
    );
end tft_colorbar;
