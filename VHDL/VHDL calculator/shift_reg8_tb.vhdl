library ieee;
use ieee.std_logic_1164.all;

entity shift_reg8_tb is
end shift_reg8_tb;

architecture behav of shift_reg8_tb is
component shift_reg8
    port(I : in std_logic_vector (7 downto 0);
    	SHIFT_VAL: in std_logic;
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic;
    	enable : in std_logic;
    	O : out std_logic_vector(7 downto 0)
    );
end component;

signal i, o : std_logic_vector(7 downto 0);
signal shift_val, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

begin
shift_reg0: shift_reg8 port map (i, shift_val, sel, clk, enable, o);

process
    type pattern_type is record
        i: std_logic_vector (7 downto 0);
        shift_val, clock, enable: std_logic;
        sel: std_logic_vector(1 downto 0);
        outcome: std_logic_vector (7 downto 0);
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
	
	--tests 
	
	(("10100011", '0', '0', '1', "11", "00000000"),--L
    ("10100011", '0', '0', '1', "10", "00000000"),--SR
    ("10100011", '0', '0', '1', "01", "00000000"),--SL
    ("10100011", '0', '0', '1', "00", "00000000"),--H
    ("01101101", '0', '0', '1', "11", "00000000"),--L
    ("01101101", '0', '0', '1', "10", "00000000"),--SL
    ("01101101", '0', '0', '1', "01", "00000000"),--SL
    ("01101101", '0', '0', '1', "00", "00000000"),--H
	
	("10100011", '0', '1', '1', "11", "10100011"),--l
    ("10100011", '0', '1', '1', "10", "01010001"),--SR
    ("10100011", '0', '1', '1', "01", "10100010"),--SL
    ("10100011", '0', '1', '1', "00", "10100010"),--H
    ("01101101", '0', '1', '1', "11", "01101101"),--l
    ("01101101", '0', '1', '1', "10", "00110110"),--SR
    ("01101101", '0', '1', '1', "01", "01101100"),--SL
    ("01101101", '0', '1', '1', "00", "01101100"),--H
	
	("10100011", '1', '0', '0', "11", "00000000"),--l
    ("10100011", '1', '0', '0', "10", "00000000"),--SR
    ("10100011", '1', '0', '0', "01", "00000000"),--SL
    ("10100011", '1', '0', '0', "00", "00000000"),--H
	
    ("01101101", '1', '0', '0', "11", "00000000"),--L
    ("01101101", '1', '0', '0', "10", "00000000"),--SR
    ("01101101", '1', '0', '0', "01", "00000000"),--SL
    ("01101101", '1', '0', '0', "00", "00000000"),--H
	
	("10100011", '0', '0', '1', "11", "00000000"),--L
    ("10100011", '0', '0', '1', "10", "00000000"),--SR
    ("10100011", '0', '0', '1', "01", "00000000"),--SL
    ("10100011", '0', '0', '1', "00", "00000000"),--H
    ("01101101", '0', '0', '1', "11", "00000000"),--L
    ("01101101", '0', '0', '1', "10", "00000000"),--SL
    ("01101101", '0', '0', '1', "01", "00000000"),--SL
    ("01101101", '0', '0', '1', "00", "00000000"),--H
	
	("10100011", '0', '0', '1', "11", "00000000"),--L
    ("10100011", '0', '0', '1', "10", "00000000"),--SR
    ("10100011", '0', '0', '1', "01", "00000000"),--SL
    ("10100011", '0', '0', '1', "00", "00000000"),--H
    ("01101101", '0', '0', '1', "11", "00000000"),--L
    ("01101101", '0', '0', '1', "10", "00000000"),--SL
    ("01101101", '0', '0', '1', "01", "00000000"),--SL
    ("01101101", '0', '0', '1', "00", "00000000")--H
	
	);
	
	begin
    for n in patterns'range loop
        i <= patterns(n).i;
        shift_val <= patterns(n).shift_val;
        sel <= patterns(n).sel;
        enable <= patterns(n).enable;
        clk <= '0';
        wait for 1 ns;

        clk <= patterns(n).clock; --Create rising edge if there should be one.
        wait for 1 ns;

        assert o = patterns(n).outcome report "BAD OUPUT VALUE" severity error;
        wait for 1 ns;
    end loop;
    report "TEST COMPLETE" severity note;
    wait;
end process;
end behav;
	
	
	