library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is

  signal A, B, SEL_FCT : std_logic_vector (3 downto 0);
  signal SR_IN : std_logic_vector (1 downto 0);
  signal SR_OUT : std_logic_vector (1 downto 0);
  signal S : std_logic_vector (7 downto 0);
  signal RESET : std_logic := '0';
  signal CLK : std_logic := '0';

begin
  alu_tb : entity work.alu
    port map(
      A => A,
      B => B,
      SEL_FCT => SEL_FCT,
      SR_IN => SR_IN,
      SR_OUT => SR_OUT,
      S => S,
      RESET => RESET,
      CLK => CLK
    );

  CLK <= not CLK after 5 ns;

  testbench : process
  begin
    for i in 0 to 15 loop
      SEL_FCT <= std_logic_vector(to_unsigned(i, SEL_FCT'length));

      for j in 0 to 15 loop
        A <= std_logic_vector(to_unsigned(j, A'length));

        for k in 0 to 15 loop
          B <= std_logic_vector(to_unsigned(k, B'length));

          for l in std_logic range '0' to '1' loop
            SR_IN(1) <= l;

            for m in std_logic range '0' to '1' loop
              SR_IN(0) <= m;
              wait for 10 ns;
            end loop;
          end loop;
        end loop;
      end loop;
    end loop;
    report "simulation finished successfully" severity FAILURE;
  end process;

end testbench;