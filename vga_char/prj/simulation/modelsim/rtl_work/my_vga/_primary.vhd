library verilog;
use verilog.vl_types.all;
entity my_vga is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        vga_rgb         : out    vl_logic_vector(15 downto 0)
    );
end my_vga;
