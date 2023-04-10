library ieee;
use ieee.std_logic_1164.all;

entity memory_cache is
  port (
    CLK : in std_logic;
    reset : in std_logic;
    INPUT : in std_logic_vector(7 downto 0);
    SET : in std_logic;

    OUTPUT : out std_logic_vector(7 downto 0) := (others => '0')
  );
end entity memory_cache;

architecture rtl of memory_cache is
begin

  process (CLK, reset)
  begin
    if reset = '1' then
      OUTPUT <= (others => '0');
    elsif (falling_edge(CLK) and SET = '1') then
      OUTPUT <= INPUT;
    end if;
  end process;
end architecture rtl;