library ieee;
use ieee.std_logic_1164.all;

entity mux4_tb is
end mux4_tb;

architecture behavioral of mux4_tb is
component mux4 is
    generic (len : natural);
    port (in1, in2, in3, in4 : in std_logic_vector(len-1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(len-1 downto 0));
end component mux4;

signal in1 : std_logic_vector(7 downto 0) := "01000000";
signal in2 : std_logic_vector(7 downto 0) := "00100000";
signal in3 : std_logic_vector(7 downto 0) := "00010000";
signal in4 : std_logic_vector(7 downto 0) := "00001000";
signal sel : std_logic_vector(1 downto 0);
signal output : std_logic_vector(7 downto 0);
begin
    mux4temp: mux4 generic map(8) port map(in1 => in1, in2 => in2, in3 => in3, in4 => in4, sel => sel, output => output);
    process
    begin
        sel <= "00";
        wait for 10 ns;

        sel <= "01";
        wait for 10 ns;
        

        sel <= "10";
        wait for 10 ns;
        

        sel <= "11";
        wait for 10 ns;
        
        report "done testing" severity note;
        wait;
    end process;
end architecture behavioral;