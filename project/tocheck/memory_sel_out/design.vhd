library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity memory_sel_out is
  port (
    SEL_IN : in std_logic_vector (1 downto 0));

end memory_sel_out;

architecture Behavioral of memory_sel_out is
begin
  process (SEL_OUT, S, MEM_CACHE_1, MEM_CACHE_2)
  begin
    case SEL_OUT is
      when "00" => RES_OUT <= MEM_CACHE_1;
      when "01" => RES_OUT <= MEM_CACHE_2;
      when "10" => RES_OUT <= S;
      when "11" => RES_OUT <= "00000000";
    end case;
  end process;
end Behavioral;