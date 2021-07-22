library verilog;
use verilog.vl_types.all;
entity vga_pic is
    generic(
        H_VALID         : vl_logic_vector(0 to 9) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        V_VALID         : vl_logic_vector(0 to 9) := (Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        RED             : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        ORANGE          : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        YELLOW          : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        GREEN           : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        CYAN            : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        BLUE            : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        PURPPLE         : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        BLACK           : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        WHITE           : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        GRAY            : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0)
    );
    port(
        vga_clk         : in     vl_logic;
        rst_n           : in     vl_logic;
        pix_x           : in     vl_logic_vector(9 downto 0);
        pix_y           : in     vl_logic_vector(9 downto 0);
        pix_data        : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of H_VALID : constant is 1;
    attribute mti_svvh_generic_type of V_VALID : constant is 1;
    attribute mti_svvh_generic_type of RED : constant is 1;
    attribute mti_svvh_generic_type of ORANGE : constant is 1;
    attribute mti_svvh_generic_type of YELLOW : constant is 1;
    attribute mti_svvh_generic_type of GREEN : constant is 1;
    attribute mti_svvh_generic_type of CYAN : constant is 1;
    attribute mti_svvh_generic_type of BLUE : constant is 1;
    attribute mti_svvh_generic_type of PURPPLE : constant is 1;
    attribute mti_svvh_generic_type of BLACK : constant is 1;
    attribute mti_svvh_generic_type of WHITE : constant is 1;
    attribute mti_svvh_generic_type of GRAY : constant is 1;
end vga_pic;
