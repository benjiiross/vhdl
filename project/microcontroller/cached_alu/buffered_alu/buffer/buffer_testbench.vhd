library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buffer_tb is
end buffer_tb;

architecture testbench of buffer_tb is

  signal CLK : std_logic := '0';
  signal RESET : std_logic := '0';
  signal INPUT : std_logic_vector(3 downto 0) := (others => '0');
  signal OUTPUT : std_logic_vector(3 downto 0) := (others => '0');

begin
  alu_tb : entity work.buffer_memory
    generic map(
      SIZE => 4
    )
    port map(
      RESET => RESET,
      CLK => CLK,
      INPUT => INPUT,
      OUTPUT => OUTPUT
    );

  CLK <= not CLK after 5 ns;

  testbench : process
  begin
    wait for 97 ns;
    wait for 3 ns;
    INPUT <= "0000";
    wait for 1 ns;
    INPUT <= "0010";
    wait for 1 ns;
    INPUT <= "0011";
    wait for 1 ns;
    INPUT <= "0100";
    wait for 10 ns;
    INPUT <= "0001";
    wait for 50 ns;
    report "simulation finished successfully" severity FAILURE;
  end process;

end testbench;