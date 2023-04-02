library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity res_out_2 is
end entity res_out_2;

architecture testbench of res_out_2 is

  signal SR_IN : std_logic_vector (1 downto 0) := (others => '0');
  signal A : std_logic_vector (3 downto 0) := (others => '0');
  signal B : std_logic_vector (3 downto 0) := (others => '0');
  signal RESET : std_logic := '0';
  signal CLK : std_logic := '0';

  signal SEL_FCT : std_logic_vector (3 downto 0) := (others => '0');
  signal SEL_ROUTE : std_logic_vector(3 downto 0) := (others => '0');
  signal SEL_OUT : std_logic_vector(1 downto 0) := (others => '0');

  signal S : std_logic_vector (7 downto 0) := (others => '0');
  signal SR_OUT : std_logic_vector (1 downto 0) := (others => '0');
begin
  clock : CLK <= not CLK after 5 ns;

  alu_tb : entity work.cached_alu
    port map(
      SR_IN => SR_IN,
      A_IN => A,
      B_IN => B,
      RESET => RESET,
      CLK => CLK,
      SEL_FCT => SEL_FCT,
      SEL_ROUTE => SEL_ROUTE,
      SEL_OUT => SEL_OUT,
      RES_OUT => S,
      SR_OUT => SR_OUT
    );

  testbench : process
  begin
    -- RES_OUT_2
    wait for 5 ns;
    B <= "1111";
    SEL_ROUTE <= "0001"; -- Buffer_B <= B

    wait for 10 ns;
    A <= "0100";
    SEL_ROUTE <= "0000"; -- Buffer_A <= A

    wait for 10 ns;
    SEL_FCT <= "1110"; -- S <= Buffer_A + Buffer_B

    wait for 20 ns;
    SEL_ROUTE <= "1110"; -- Buffer_B <= S

    wait for 10 ns;
    SEL_FCT <= "0111"; -- S <= Buffer_A xor Buffer_B

    wait for 20 ns;
    SEL_ROUTE <= "1100"; -- Buffer_A <= S

    wait for 10 ns;
    SEL_FCT <= "0011"; -- S <= NOT Buffer_A

    wait for 10 ns;
    SEL_OUT <= "11"; -- RES_OUT <= S

    wait for 50 ns;
    report "simulation finished successfully" severity FAILURE;
  end process;
end testbench;