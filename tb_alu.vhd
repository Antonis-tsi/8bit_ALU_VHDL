library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.alu_utils_pkg.ALL;

entity tb_alu is
end tb_alu;

architecture test of tb_alu is
    -- Σήματα
    signal X_tb, Y_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal S_tb       : STD_LOGIC_VECTOR(2 downto 0);
    signal F_tb       : STD_LOGIC_VECTOR(7 downto 0);
    signal C_tb       : STD_LOGIC;

    -- Τα σήματα για τα HEX
    signal HEX0_tb : STD_LOGIC_VECTOR(6 downto 0); -- Τα χαμηλά 4 bits
    signal HEX1_tb : STD_LOGIC_VECTOR(6 downto 0); -- Τα υψηλά 4 bits

begin

    -- 1. Σύνδεση με την ALU 
    UUT: entity work.alu_8bit
    port map (
        X => X_tb, Y => Y_tb, S => S_tb, F => F_tb, C => C_tb
    );

    -- 2. Σύνδεση (HEX0 - Χαμηλά bits) Παίρνει τα bits 3 έως 0 του αποτελέσματος F
    HEX_Display_Low: entity work.my_hex_display
    port map (
        A => F_tb(3 downto 0), 
        B   => HEX0_tb
    );

    -- 3. Σύνδεση (HEX1 - Υψηλά bits) Παίρνει τα bits 7 έως 4 του αποτελέσματος F
    HEX_Display_High: entity work.my_hex_display
    port map (
        A => F_tb(7 downto 4), 
        B   => HEX1_tb           
    );

    -- Διαδικασία δοκιμής 
    stim_proc: process
    begin
        -- ΠΕΡΙΠΤΩΣΗ 1: X=47, Y=33
        X_tb <= "00101111"; -- 47
        Y_tb <= "00100001"; -- 33
        
        S_tb <= "000"; wait for 20 ns;
        S_tb <= "001"; wait for 20 ns; -- Add
        S_tb <= "010"; wait for 20 ns; -- Sub X-Y
        S_tb <= "011"; wait for 20 ns; -- Sub Y-X
        S_tb <= "100"; wait for 20 ns; -- Inc
        S_tb <= "101"; wait for 20 ns; -- Dec
        S_tb <= "110"; wait for 20 ns; -- OR
        S_tb <= "111"; wait for 20 ns; -- AND
        
        wait for 50 ns; 

        -- ΠΕΡΙΠΤΩΣΗ 2: X=131, Y=140
        X_tb <= "10000011"; -- 131
        Y_tb <= "10001100"; -- 140
        
        S_tb <= "000"; wait for 20 ns;
        S_tb <= "001"; wait for 20 ns;
        S_tb <= "010"; wait for 20 ns;
        S_tb <= "011"; wait for 20 ns;
        S_tb <= "100"; wait for 20 ns;
        S_tb <= "101"; wait for 20 ns;
        S_tb <= "110"; wait for 20 ns;
        S_tb <= "111"; wait for 20 ns;

        wait;
    end process;
end test;