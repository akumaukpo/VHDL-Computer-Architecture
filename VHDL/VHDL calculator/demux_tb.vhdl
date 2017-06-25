library ieee;
use ieee.std_logic_1164.all;
use work.special.all;

entity demuxTest is
generic ( x : integer := 4;
	   			y : integer := 2);
end demuxTest;

architecture behavioral of demuxTest is
	component deMux is

	  port(	EN: 	in std_logic;
	        INP: 	in std_logic_vector(x-1 downto 0);
	  	    SEL: 	in std_logic_vector(y-1 downto 0);
	  	    OUTP: out twod_arr((2**y)-1 downto 0 , x-1 downto 0)
	        );
		end component;

signal OUTP : twod_arr(2**y - 1 downto 0, x-1 downto 0);
signal INP : std_logic_vector(x-1 downto 0);
signal EN : std_logic;
signal SEL : std_logic_vector(y-1 downto 0);

begin
deMux_1: deMux port map (EN, INP, SEL, OUTP);
process
begin

INP <= "0101";
SEL <= "00";
EN <= '1';
wait for 1 ns;
assert(OUTP(0,0) = '1' and
			 OUTP(0,1) = '0' and
			 OUTP(0,2) = '1' and
			 OUTP(0,3) = '0' and

			 OUTP(1,0) = '0' and
			 OUTP(1,1) = '0' and
			 OUTP(1,2) = '0' and
			 OUTP(1,3) = '0' and

			 OUTP(2,0) = '0' and
			 OUTP(2,1) = '0' and
			 OUTP(2,2) = '0' and
			 OUTP(2,3) = '0' and

			 OUTP(3,0) = '0' and
			 OUTP(3,1) = '0' and
			 OUTP(3,2) = '0' and
			 OUTP(3,3) = '0')
			 report "Test1 : FAILURE";

INP <= "1010";
SEL <= "01";
EN <= '1';
wait for 1 ns;
assert(OUTP(1,0) = '0' and
			 OUTP(1,1) = '1' and
			 OUTP(1,2) = '0' and
			 OUTP(1,3) = '1' and

			 OUTP(0,0) = '0' and
			 OUTP(0,1) = '0' and
			 OUTP(0,2) = '0' and
			 OUTP(0,3) = '0' and

			 OUTP(2,0) = '0' and
			 OUTP(2,1) = '0' and
			 OUTP(2,2) = '0' and
			 OUTP(2,3) = '0' and

			 OUTP(3,0) = '0' and
			 OUTP(3,1) = '0' and
			 OUTP(3,2) = '0' and
			 OUTP(3,3) = '0')
			 report "Test2 : FAILURE";

INP <= "1111";
SEL <= "10";
EN <= '1';
wait for 1 ns;
assert(OUTP(2,0) = '1' and
			 OUTP(2,1) = '1' and
			 OUTP(2,2) = '1' and
			 OUTP(2,3) = '1' and

			 OUTP(1,0) = '0' and
			 OUTP(1,1) = '0' and
			 OUTP(1,2) = '0' and
			 OUTP(1,3) = '0' and

			 OUTP(0,0) = '0' and
			 OUTP(0,1) = '0' and
			 OUTP(0,2) = '0' and
			 OUTP(0,3) = '0' and

			 OUTP(3,0) = '0' and
			 OUTP(3,1) = '0' and
			 OUTP(3,2) = '0' and
			 OUTP(3,3) = '0')
			 report "Test3 : FAILURE";

INP <= "1100";
SEL <= "11";
EN <= '1';
wait for 1 ns;
assert(OUTP(3,0) = '0' and
			 OUTP(3,1) = '0' and
			 OUTP(3,2) = '1' and
			 OUTP(3,3) = '1' and

			 OUTP(1,0) = '0' and
			 OUTP(1,1) = '0' and
			 OUTP(1,2) = '0' and
			 OUTP(1,3) = '0' and

			 OUTP(2,0) = '0' and
			 OUTP(2,1) = '0' and
			 OUTP(2,2) = '0' and
			 OUTP(2,3) = '0' and

			 OUTP(0,0) = '0' and
			 OUTP(0,1) = '0' and
			 OUTP(0,2) = '0' and
			 OUTP(0,3) = '0')
			 report "Test4 : FAILURE";

INP <= "1010";
SEL <= "01";
EN <= '0';
wait for 1 ns;
assert(OUTP(1,0) = '0' and
			 OUTP(1,1) = '0' and
			 OUTP(1,2) = '0' and
			 OUTP(1,3) = '0' and

			 OUTP(0,0) = '0' and
			 OUTP(0,1) = '0' and
			 OUTP(0,2) = '0' and
			 OUTP(0,3) = '0' and

			 OUTP(2,0) = '0' and
			 OUTP(2,1) = '0' and
			 OUTP(2,2) = '0' and
			 OUTP(2,3) = '0')
			 report "ENABLE test: FAILURE";

wait for 1 ns;
report "YOU MADE IT BOSS!";
wait;

end process;
end architecture;
