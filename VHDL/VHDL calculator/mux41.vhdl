library ieee;
use ieee.std_logic_1164.all;
entity mux4 is
    generic (len : positive);
    port (in1, in2, in3, in4 : in std_logic_vector(len-1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(len-1 downto 0));
end entity mux4;

architecture behavioral of mux4 is
begin
    with sel select output <=
        in1 when "00",
        in2 when "01",
        in3 when "10",
        in4 when others; 

end architecture behavioral;