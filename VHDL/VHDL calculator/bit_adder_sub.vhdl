
--bit adder ----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity bit_adder is
  port (A_in,B_in, Car_in: in std_logic;
        Car_out,sum_out : out std_logic);
end bit_adder;

architecture behavioral of bit_adder is
  signal a_xor_b : std_logic;
  signal a_and_b : std_logic;
  signal axorb_and_cin : std_logic;
  begin
    a_xor_b <= A_in xor B_in;
    sum_out <= a_xor_b xor Car_in;
    a_and_b <= A_in and B_in;
    axorb_and_cin <= a_xor_b and Car_in;
    Car_out <= axorb_and_cin or a_and_b;
  end architecture behavioral;

-- 4 bit adder -------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity four_bit_adder is
  port( INP1, INP2: 	in std_logic_vector(3 downto 0);
  	    OUTP: out std_logic_vector(3 downto 0);
        OVERFLOW, UNDERFLOW: out std_logic
        );
end entity four_bit_adder;

architecture structural of four_bit_adder is
  component bit_adder is
    port (A_in,B_in, Car_in: in std_logic;
          Car_out,sum_out : out std_logic);
      end component bit_adder;

  signal car1_2: std_logic;
  signal car2_3: std_logic;
  signal car3_4: std_logic;
  signal carryout_adder: std_logic;
  signal somme : std_logic_vector(3 downto 0);
  begin
  bit_adder_1: bit_adder port map ( A_in => INP1(0), B_in => INP2(0), Car_in => '0', Car_out => car1_2, sum_out => somme(0));
  bit_adder_2: bit_adder port map ( A_in => INP1(1), B_in => INP2(1), Car_in => car1_2, Car_out => car2_3, sum_out => somme(1));
  bit_adder_3: bit_adder port map ( A_in => INP1(2), B_in => INP2(2), Car_in => car2_3, Car_out => car3_4, sum_out => somme(2));
  bit_adder_4: bit_adder port map ( A_in => INP1(3), B_in => INP2(3), Car_in => car3_4, Car_out => carryout_adder, sum_out => somme(3));
    OUTP <= somme;
    OVERFLOW <= not INP1(3) and not INP2(3) and  somme(3);
    UNDERFLOW <= INP1(3) and INP2(3) and not somme(3);
  end structural;

  -- 4 bit adder subtractor ------------------------------------------------
  library ieee;
  use ieee.std_logic_1164.all;

  entity four_bit_adder_sub is
    port( INP1, INP2: 	in std_logic_vector(3 downto 0);
    	    OUTP: out std_logic_vector(3 downto 0);
          OVERFLOW, UNDERFLOW: out std_logic;
          SUB: in std_logic
          );
  end four_bit_adder_sub;

  architecture behavioral of four_bit_adder is
    component four_bit_adder is
      port( INP1, INP2: 	in std_logic_vector(3 downto 0);
      	    OUTP: out std_logic_vector(3 downto 0);
            OVERFLOW, UNDERFLOW: out std_logic
            );
    end component four_bit_adder;
    signal inpSelector,twosCompliment, negINP2: std_logic_vector(3 downto 0);
    signal twosComplimentOverflow, adderOverflow: std_logic;

    begin
      four_bit_adder1 : four_bit_adder port map (INP1 =>INP1, INP2 =>inpSelector, OUTP=>OUTP, OVERFLOW =>adderOverflow, UNDERFLOW =>UNDERFLOW);
      four_bit_adder2 : four_bit_adder port map (INP1 =>negINP2, INP2 => "0001", OUTP=> twosCompliment, OVERFLOW=> twosComplimentOverflow, UNDERFLOW => open);
      OVERFLOW <= twosComplimentOverflow or adderOverflow;
      negINP2 <= not INP2;
      inpSelector <= twosCompliment when (SUB = '1') else
                     INP2 when (SUB = '0');
    end behavioral;
