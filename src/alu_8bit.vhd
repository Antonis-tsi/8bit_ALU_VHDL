library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.alu_utils_pkg.ALL; -- εισαγωγή του πακέτου

entity alu_8bit is
    Port (
        X, Y : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0); -- Είσοδοι
        S    : in  STD_LOGIC_VECTOR(SEL_WIDTH-1 downto 0);  -- Επιλογή (S2, S1, S0)
        F    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0); -- Έξοδος F
        C    : out STD_LOGIC                                -- Έξοδος C (Carry)
    );
end alu_8bit;

architecture Behavioral of alu_8bit is
    signal res_temp : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal c_temp   : STD_LOGIC;
    -- Βοηθητικά σήματα για procedures 
    signal dummy_c  : STD_LOGIC; 
begin

    process(X, Y, S)
    begin
        -- (default values)
        res_temp <= (others => '0');
        c_temp <= '0';
        
        case S is
            when "000" => -- 0
                res_temp <= (others => '0');
                c_temp <= '0';
                
            when "001" => -- X + Y 
                add(X, Y, res_temp, c_temp); -- procedure add 
                
            when "010" => -- X - Y
                sub(X, Y, res_temp, dummy_c); -- procedure sub
                c_temp <= '0';  
                
            when "011" => -- Y - X
                sub(Y, X, res_temp, dummy_c); 
                c_temp <= '0';
                
            when "100" => -- X + 1
                res_temp <= inc(X); -- function inc 
                c_temp <= '0';
                
            when "101" => -- X - 1
                res_temp <= dec(X); -- function dec 
                c_temp <= '0';
                
            when "110" => -- X OR Y
                res_temp <= X or Y;
                c_temp <= '0';
                
            when "111" => -- X AND Y
                res_temp <= X and Y;
                c_temp <= '0';
                
            when others =>
                res_temp <= (others => '0');
                c_temp <= '0';
        end case;
    end process;

    F <= res_temp;
    C <= c_temp;

end Behavioral;