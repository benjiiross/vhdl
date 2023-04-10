library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity res_out_1 is
end entity res_out_1;

architecture testbench of res_out_1 is

  signal SR_IN : std_logic_vector (1 downto 0) := (others => '0');
  signal A : std_logic_vector (3 downto 0) := (others => '0');
  signal B : std_logic_vector (3 downto 0) := (others => '0');
  signal RESET : std_logic := '0';
  signal CLK : std_logic := '0';

  signal S : std_logic_vector (7 downto 0) := (others => '0');
  signal SR_OUT : std_logic_vector (1 downto 0) := (others => '0');
begin
  clock : CLK <= not CLK after 5 ns;

  microcontroller_tb : entity work.microcontroller
    port map(
      SR_IN => SR_IN,
      A_IN => A,
      B_IN => B,
      RESET => RESET,
      CLK => CLK,
      RES_OUT => S,
      SR_OUT => SR_OUT
    );

  testbench : process
  begin
    A <= "0100";
    B <= "1111";
    wait for 500 ns;

    report "simulation finished successfully" severity FAILURE;
  end process;
end testbench;