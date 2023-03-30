library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buffered_alu_tb is
end buffered_alu_tb;

architecture testbench of buffered_alu_tb is

  signal A, B, SEL_FCT : std_logic_vector (3 downto 0) := "0000";
  signal SR_IN : std_logic_vector (1 downto 0) := "00";
  signal SR_OUT : std_logic_vector (1 downto 0) := "00";
  signal S : std_logic_vector (7 downto 0) := "00000000";
  signal CLK, RESET : std_logic := '0';

begin
  clock : CLK <= not CLK after 5 ns;
  buffered_alu_tb : entity work.buffered_alu
    port map(
      A => A,
      B => B,
      SEL_FCT => SEL_FCT,
      SR_IN => SR_IN,
      SR_OUT => SR_OUT,
      S => S,
      CLK => CLK,
      RESET => RESET
    );

  testbench : process
  begin
    -- create a testbench
    A <= "0001";
    B <= "0001";
    SEL_FCT <= "1110";
    SR_IN <= "01";
    wait for 50 ns;
    report "simulation finished" severity failure;
  end process;

end testbench;