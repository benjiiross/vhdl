library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity memory is
  generic (
    SIZE : integer
  );
  port (
    INPUT : in std_logic_vector(SIZE - 1 downto 0);
    OUTPUT : out std_logic_vector(SIZE - 1 downto 0) := (others => '0');
    CLK : in std_logic;
    RESET : in std_logic
  );
end memory;

architecture memory_arch of memory is
begin
  memory_process : process (CLK, RESET) is
    variable MEM : std_logic_vector(SIZE - 1 downto 0) := (others => '0');
  begin
    if (RESET = '1') then
      MEM := (others => '0');
      OUTPUT <= (others => '0');
    elsif rising_edge(CLK) then
      OUTPUT <= MEM;
      MEM := INPUT;
    end if;
  end process;

end memory_arch;