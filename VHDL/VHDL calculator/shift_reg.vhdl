library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
port(	I:	in std_logic_vector (3 downto 0);
		SHIFT_VAL: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0)
);
end shift_reg;

architecture behav of shift_reg is

	signal A: std_logic_vector (3 downto 0); --4 bit signal
	


begin

	process (clock, enable) is 
	begin 
	
	 if clock' event and clock = '1' and enable = '1' then 
		if (sel = "01") then  --if sel 01 then shift left
			A(0) <= SHIFT_VAL;
			A(1) <= A(0);
			A(2) <= A(1);
			A(3) <= A(2);
			
			elsif(sel = "10") then -- if sel 10 shift right
			A(0) <= A(1);
			A(1) <= A(2);
			A(2) <= A(3);
			A(3) <= SHIFT_VAL;
	 
			elsif(sel ="11") then --if sel 11 load 
			A <= I;
			
			end if;
			
			elsif enable = '0' then -- 0000
			A <= "0000";
			
			end if; 
			
			end process;
			
			O <= A; --output
			
	 
-- Wrong! You must replace it with your implementation.
end behav;

