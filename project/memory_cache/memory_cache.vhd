library ieee;
use ieee.std_logic_1164.all;

entity memory_cache is
  generic (
    SIZE : integer
  );
  port (
    clk : in std_logic;
    reset : in std_logic;
    INPUT : in std_logic_vector(SIZE - 1 downto 0);
    SET : in std_logic;

    OUTPUT : out std_logic_vector(SIZE - 1 downto 0) := (others => '0')
  );
end entity memory_cache;

architecture rtl of memory_cache is
begin

  process (clk, reset)
  begin
    if reset = '1' then
      OUTPUT <= (others => '0');
    elsif falling_edge(clk) then
      OUTPUT <= INPUT;
    end if;
  end process;
end architecture rtl;