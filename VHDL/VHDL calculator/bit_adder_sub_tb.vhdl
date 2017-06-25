library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder_sub_tb is
end four_bit_adder_sub_tb;

architecture behavioral of four_bit_adder_sub_tb is
component four_bit_adder_sub
port( INP1, INP2: 	in std_logic_vector(3 downto 0);
			OUTP: out std_logic_vector(3 downto 0);
			OVERFLOW, UNDERFLOW: out std_logic;
			SUB: in std_logic
			);

end component four_bit_adder_sub;

signal INP1, INP2, OUTP : std_logic_vector(3 downto 0);
signal SUB, OVERFLOW, UNDERFLOW: std_logic;

begin
four_bit_adder_sub_1: four_bit_adder_sub port map(INP1, INP2, OUTP, OVERFLOW,
																									UNDERFLOW, SUB);
process
begin

INP1 <= "0000";
INP2 <= "0001";
SUB  <= '0';
wait for 1 ns;
assert(OUTP = "0001" and
			 OVERFLOW = '0' and
			 UNDERFLOW = '0')
			 report "Test 1 failed!!!";

 INP1 <= "0000";
 INP2 <= "0000";
 SUB  <= '0';
 wait for 1 ns;
 assert(OUTP = "0000" and
 			  OVERFLOW = '0' and
 			  UNDERFLOW = '0')
 			  report "Test 1 failed!!!";

INP1 <= "0001";
INP2 <= "0001";
SUB  <= '1';
wait for 1 ns;
assert(OUTP = "0000" and
			 OVERFLOW = '0' and
			 UNDERFLOW = '0')
			 report "Test 1 failed!!!";

INP1 <= "0100";
INP2 <= "1000";
SUB  <= '1';
wait for 1 ns;
assert(OUTP = "1100" and
			 OVERFLOW = '1' and
			 UNDERFLOW = '0')
			 report "Test 1 failed!!!";

INP1 <= "1011";
INP2 <= "1100";
SUB  <= '0';
wait for 1 ns;
assert(OUTP = "0111" and
			 OVERFLOW = '0' and
			 UNDERFLOW = '1')
			 report "Test 1 failed!!!";


wait for 1 ns;
report "YOU MADE IT BOSS!";
wait;

end process;
end architecture;
