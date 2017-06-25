library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity shift_reg_tb is
end shift_reg_tb;

architecture behav of shift_reg_tb is
--  Declaration of the component that will be instantiated.
component shift_reg
port (	I:	in std_logic_vector (3 downto 0);
		SHIFT_VAL: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; 
		enable:		in std_logic;
		O:	out std_logic_vector(3 downto 0)
);
end component;
--  Specifies which entity is bound with the component.
-- for shift_reg_0: shift_reg use entity work.shift_reg(rtl);
signal i, o : std_logic_vector(3 downto 0);
signal shift_val, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);
begin

shift_reg0: shift_reg port map (I => i, SHIFT_VAL => shift_val, sel => sel, clock => clk, enable => enable, O => o); --inst 


process
type pattern_type is record
--  The inputs 
i: std_logic_vector (3 downto 0);
shift_val, clock, enable: std_logic;
sel: std_logic_vector(1 downto 0);

o: std_logic_vector (3 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0001",'1','0', '0', "11", "0000"),
("0110", '1', '1', '1', "11", "0110"), 
("1111", '1', '0', '1', "01", "0110"), 
("1111", '1', '1', '1', "01", "1101"), 
("1111", '0', '0', '1', "10", "1101"), 
("1111", '0', '1', '1', "10", "0110"), 
("1111", '0', '0', '1', "00", "0110"), 
("1111", '0', '1', '1', "00", "0110"), 
("1111", '1', '0', '1', "00", "0110"), 
("1111", '1', '1', '0', "00", "0110"), 
("1111", '1', '0', '1', "11", "0110"), 
("0010", '1', '1', '1', "11", "0010"), 
("1111", '1', '0', '1', "01", "0010"), 
("1111", '1', '1', '1', "01", "0101"), 
("1111", '0', '0', '1', "10", "0101"), 
("1111", '0', '1', '1', "10", "0010"), 
("1111", '0', '0', '1', "00", "0010"), 
("1111", '0', '1', '1', "00", "0010"), 
("1111", '1', '0', '1', "00", "0010"),
("0001", '0', '1', '0', "00", "0001"));
begin
--  Check
for n in patterns'range loop

i <= patterns(n).i;
shift_val <= patterns(n).shift_val;
sel <= patterns(n).sel;
clk <= patterns(n).clock;
enable <= patterns(n).enable;

wait for 1 ns;

assert o = patterns(n).o
report "bad output value" severity error;
end loop;
assert false report "end of test" severity note;

wait;
end process;
end behav;
