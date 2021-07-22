library verilog;
use verilog.vl_types.all;
entity vga_pic is
    generic(
        CHAR_B_H        : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        CHAR_B_V        : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        CHAR_W          : vl_logic_vector(0 to 9) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        CHAR_H          : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        BLACK           : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        GOLDEN          : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        vga_clk         : in     vl_logic;
        rst_n           : in     vl_logic;
        pix_x           : in     vl_logic_vector(9 downto 0);
        pix_y           : in     vl_logic_vector(9 downto 0);
        pix_data        : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CHAR_B_H : constant is 1;
    attribute mti_svvh_generic_type of CHAR_B_V : constant is 1;
    attribute mti_svvh_generic_type of CHAR_W : constant is 1;
    attribute mti_svvh_generic_type of CHAR_H : constant is 1;
    attribute mti_svvh_generic_type of BLACK : constant is 1;
    attribute mti_svvh_generic_type of GOLDEN : constant is 1;
end vga_pic;
