library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity memory_tb is
end memory_tb;

architecture testbench of memory_tb is

  signal INPUT, OUTPUT : std_logic_vector(7 downto 0) := (others => '0');
  signal CLK, SET, RESET : std_logic := '0';

begin
  clock : CLK <= not CLK after 5 ns;
  memory : entity work.memory
    generic map(
      SIZE => 8
    )
    port map(
      INPUT => INPUT,
      OUTPUT => OUTPUT,
      CLK => CLK,
      RESET => RESET
    );

  testbench : process
  begin
    for i in 0 to 255 loop
      if i = 120 then
        RESET <= '1';
      elsif i = 130 then
        RESET <= '0';
      end if;
      INPUT <= std_logic_vector(to_unsigned(i, 8));
      wait for 10 ns;
    end loop;
    report "Simulation successful" severity FAILURE;
  end process;
end testbench;