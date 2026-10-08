library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- πράξεις με std_logic_vector

package alu_utils_pkg is
    -- Γ) Σταθερές
    constant DATA_WIDTH : integer := 8; -- Μήκος εισόδων/εξόδων
    constant SEL_WIDTH  : integer := 3; -- Γραμμές επιλογής

    -- Α) Procedures 
    -- Πρόσθεση: Επιστρέφει αποτέλεσμα και κρατούμενο
    procedure add(
        signal x, y : in std_logic_vector(DATA_WIDTH-1 downto 0);
        signal res  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        signal cout : out std_logic
    );

    -- Αφαίρεση: Επιστρέφει αποτέλεσμα (το κρατούμενο ζητείται από τη procedure αλλά στην ALU θα αγνοηθεί βάσει πίνακα)
    procedure sub(
        signal x, y : in std_logic_vector(DATA_WIDTH-1 downto 0);
        signal res  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        signal cout : out std_logic
    );

    -- Β) Functions 
    function inc(val : std_logic_vector) return std_logic_vector;
    function dec(val : std_logic_vector) return std_logic_vector;

end alu_utils_pkg;

package body alu_utils_pkg is

    -- Υλοποίηση Procedure ADD
    procedure add(
        signal x, y : in std_logic_vector(DATA_WIDTH-1 downto 0); -- 8 bits
        signal res  : out std_logic_vector(DATA_WIDTH-1 downto 0); -- 8 bits
        signal cout : out std_logic
    ) is
        variable temp_sum : std_logic_vector(DATA_WIDTH downto 0); -- 9 bits για το κρατούμενο
    begin
        temp_sum := ('0' & x) + ('0' & y);
        res <= temp_sum(DATA_WIDTH-1 downto 0);
        cout <= temp_sum(DATA_WIDTH);
    end add;

    -- Υλοποίηση Procedure SUB
    procedure sub(
        signal x, y : in std_logic_vector(DATA_WIDTH-1 downto 0); -- 8 bits
        signal res  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        signal cout : out std_logic
    ) is
        variable temp_diff : std_logic_vector(DATA_WIDTH downto 0); -- 9 bits για το κρατούμενο
    begin
        temp_diff := ('0' & x) - ('0' & y);
        res <= temp_diff(DATA_WIDTH-1 downto 0);
        cout <= temp_diff(DATA_WIDTH); -- Συνήθως Borrow, αλλά θα το διαχειριστούμε στην ALU
    end sub;

    -- Υλοποίηση Function INC
    function inc(val : std_logic_vector) return std_logic_vector is
    begin
        return val + 1;
    end inc;

    -- Υλοποίηση Function DEC
    function dec(val : std_logic_vector) return std_logic_vector is
    begin
        return val - 1;
    end dec;

end alu_utils_pkg;