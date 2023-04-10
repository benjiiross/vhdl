library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_instructions_tb is
end memory_instructions_tb;

architecture testbench of memory_instructions_tb is
  signal CLK : std_logic := '0';
  signal RESET : std_logic := '0';
  signal instruction : std_logic_vector(9 downto 0) := (others => '0');
begin
  CLK <= not CLK after 5 ns;

  memory_instr_tb : entity work.memory_instructions
    port map(
      clk => clk,
      reset => reset,
      instruction => instruction
    );
end testbench;