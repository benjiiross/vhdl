library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructions_tb is
end instructions_tb;

architecture rtl of instructions_tb is
  signal CLK : std_logic := '0';
  signal RESET : std_logic := '0';
  signal sel_fct : std_logic_vector(3 downto 0) := "0000";
  signal sel_route : std_logic_vector(3 downto 0) := "0000";
  signal sel_out : std_logic_vector(1 downto 0) := "00";
begin
  CLK <= not CLK after 5 ns;

  instr_tb : entity work.instructions
    port map(
      CLK => CLK,
      RESET => RESET,
      sel_fct => sel_fct,
      sel_route => sel_route,
      sel_out => sel_out
    );
end architecture;