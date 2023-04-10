library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity res_out_3 is
end entity res_out_3;

architecture testbench of res_out_3 is

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
    SEL_ROUTE <= "0001"; -- Buffer_B <= B                 1

    wait for 10 ns;
    A <= "0101";
    SEL_ROUTE <= "0000"; -- Buffer_A <= A                 2

    wait for 10 ns;
    SEL_FCT <= "1010"; -- S <= RightShift(Buffer_B)       3

    wait for 20 ns;
    SEL_ROUTE <= "1110"; -- Buffer_B <= S                4

    wait for 10 ns;
    SEL_FCT <= "0101"; -- S <= Buffer_A and RightShift(Buffer_B)  5

    wait for 20 ns;
    SEL_ROUTE <= "0110"; -- MEM_Cache_1 <= S           6

    wait for 10 ns;
    SEL_FCT <= "1000"; -- S <= RightShift(Buffer_A)   7

    wait for 20 ns;
    SEL_ROUTE <= "1100"; -- Buffer_A <= S             8

    wait for 10 ns;
    SEL_ROUTE <= "0001"; -- Buffer_B <= B            9

    wait for 10 ns;
    SEL_FCT <= "0101"; -- S <= Buffer_B and RightShift(Buffer_A)  10

    wait for 20 ns;
    SEL_ROUTE <= "1110"; -- Buffer_B <= S            11

    wait for 10 ns;
    SEL_ROUTE <= "0010"; -- Buffer_A <= MEM_Cache_1 12

    wait for 10 ns;
    SEL_FCT <= "0110"; -- S <= Buffer_A or Buffer_B 13

    wait for 20 ns;
    SEL_ROUTE <= "1110"; -- Buffer_B <= S           14

    wait for 10 ns;
    A <= "0001";
    SEL_ROUTE <= "0000"; -- Buffer_A <= A          15

    wait for 10 ns;
    SEL_FCT <= "0101"; -- S <= 0001 and Buffer_B => get only the first bit  16

    wait for 20 ns;
    SEL_OUT <= "11"; -- RES_OUT <= S          17

    wait for 100 ns;
    report "simulation finished successfully" severity FAILURE;
  end process;
end testbench;