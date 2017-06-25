library ieee;
use ieee.std_logic_1164.all;

entity shift_reg8 is
    port(I : in std_logic_vector (7 downto 0);
    	SHIFT_VAL : in std_logic; -- 
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic; -- positive level triggering in problem 3
    	enable : in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
    	O : out std_logic_vector(7 downto 0)
    );
end shift_reg8;

architecture structural of shift_reg8 is
component shift_reg is
port(	I:	in std_logic_vector (3 downto 0);
		SHIFT_VAL : in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0)
);
end component;

signal carry1_shft, carry2_shft : std_logic;
signal input : std_logic_vector(7 downto 0) := "00000000";
begin
    shift_reg0: shift_reg port map(I(3 downto 0), carry1_shft, sel, clock, enable, input(3 downto 0));
    shift_reg1: shift_reg port map(I(7 downto 4), carry2_shft, sel, clock, enable, input(7 downto 4));

    with sel select carry1_shft <=
        input(4) when "10", --carry val
		SHIFT_VAL when "01",
        '0' when others; 

    with sel select carry2_shft <=
        input(3) when "01", --carry val
        SHIFT_VAL when "10", 
        '0' when others; 

    O <= input;

end structural;