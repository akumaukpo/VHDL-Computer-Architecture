library ieee;
use ieee.std_logic_1164.all;
use work.special.all;

entity deMux is
  generic(x : integer := 4;
          y : integer := 2);
  port(	EN: 	in std_logic;
        INP: 	in std_logic_vector(x-1 downto 0);
  	    SEL: 	in std_logic_vector(y-1 downto 0);
  	    OUTP: out twod_arr((2**y)-1 downto 0 , x-1 downto 0)
        );
end deMux;

architecture behavioral of deMux is
begin
    process(EN, INP, SEL) is
      variable SEL_VAL : integer := 0;
      variable ONE : integer := 0;
      constant POWERy : integer := 2**y;
    begin
    if EN = '1' then
      for z in y-1 downto 0 loop
        if (SEL(z) = '1') then
          ONE := 1;
        else
          ONE := 0;
        end if;
        SEL_VAL := SEL_VAL + ONE*(2**z);
      end loop;
      for i in POWERy-1 downto 0 loop
        if SEL_VAL = i then
          for j in 0 to x-1 loop
            OUTP(i , j) <= INP(j);
          end loop;
        else
          for j in 0 to x-1 loop
            OUTP(i , j) <= '0';
          end loop;
        end if;
      end loop;
      SEL_VAL := 0;
    end if;
    end process;
end behavioral;
