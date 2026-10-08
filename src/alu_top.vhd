library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.alu_utils_pkg.ALL; 

entity alu_top is
    Port (
        -- ΕΙΣΟΔΟΙ
        SW   : in  STD_LOGIC_VECTOR(17 downto 0); 
        KEY  : in  STD_LOGIC_VECTOR(3 downto 0);  

        -- ΕΞΟΔΟΙ
        LEDR : out STD_LOGIC_VECTOR(17 downto 0); 
        LEDG : out STD_LOGIC_VECTOR(8 downto 0); 
        HEX0 : out STD_LOGIC_VECTOR(6 downto 0); --(a, b, c, d, e, f, g)  
        HEX1 : out STD_LOGIC_VECTOR(6 downto 0)   
    );
end alu_top;

architecture Behavioral of alu_top is

    -- Σήματα
    signal X_in, Y_in : STD_LOGIC_VECTOR(7 downto 0);
    signal S_in       : STD_LOGIC_VECTOR(2 downto 0);
    signal F_out      : STD_LOGIC_VECTOR(7 downto 0);
    signal C_out      : STD_LOGIC;

begin

    -- 1. ΣΥΝΔΕΣΗ ΕΙΣΟΔΩΝ
    X_in <= SW(7 downto 0);
    Y_in <= SW(15 downto 8);
    S_in <= not KEY(2 downto 0); -- επιλογής λειτουργίας ?? S_in <= not KEY(2 downto 0); ??

    -- 2. ALU
    U0_ALU: entity work.alu_8bit
    port map (
        X => X_in,
        Y => Y_in,
        S => S_in,
        F => F_out,
        C => C_out
    );
	 
    -- 3. ΣΥΝΔΕΣΗ LED
    LEDR(7 downto 0) <= F_out;            -- Αποτέλεσμα στα LED
    LEDR(17 downto 8) <= (others => '0'); -- Τα υπόλοιπα σβηστά

    LEDG(0) <= C_out;                     -- Κρατούμενο στο πράσινο LED
    LEDG(8 downto 1) <= (others => '0');  -- Τα υπόλοιπα σβηστά

    -- 4. ΣΥΝΔΕΣΗ 7-SEGMENT DISPLAYS
    -- Είσοδος = A, Έξοδος = B

    -- Display HEX0: Χαμηλά 4 bits (F3-F0)
    HEX_DISP_0: entity work.my_hex_display
    port map (
        A => F_out(3 downto 0), -- Είσοδος A
        B => HEX0               -- Έξοδος B στο HEX0
    );

    -- Display HEX1: Υψηλά 4 bits (F7-F4)
    HEX_DISP_1: entity work.my_hex_display
    port map (
        A => F_out(7 downto 4), -- Είσοδος A
        B => HEX1               -- Έξοδος B στο  HEX1
    );

end Behavioral;