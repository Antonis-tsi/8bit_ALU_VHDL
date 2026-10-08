library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity my_hex_display is
    port (
        A : in  std_logic_vector(3 downto 0); 
        B : out std_logic_vector(6 downto 0) -- Αλλαγή από "0 to 6" σε "6 downto 0"
    );
end my_hex_display;

architecture behavioral of my_hex_display is
begin
    process (A) 
    begin
        -- Οι τιμές έχουν αντιστραφεί για να ταιριάζουν στη μορφή (g, f, e, d, c, b, a)
        -- Υποθέτουμε Active Low (0 = ON, 1 = OFF)
        case A is 
            when "0000" => B <= "1000000"; -- 0
            when "0001" => B <= "1111001"; -- 1
            when "0010" => B <= "0100100"; -- 2
            when "0011" => B <= "0110000"; -- 3
            when "0100" => B <= "0011001"; -- 4
            when "0101" => B <= "0010010"; -- 5
            when "0110" => B <= "0000010"; -- 6
            when "0111" => B <= "1111000"; -- 7
            when "1000" => B <= "0000000"; -- 8
            when "1001" => B <= "0010000"; -- 9
            when "1010" => B <= "0001000"; -- A
            when "1011" => B <= "0000011"; -- b
            when "1100" => B <= "1000110"; -- C
            when "1101" => B <= "0100001"; -- d
            when "1110" => B <= "0000110"; -- E
            when "1111" => B <= "0001110"; -- F
            when others => B <= "0111111"; -- OFF/Error
        end case;
    end process;
end architecture;