library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity memory_instr_tb is
end memory_instr_tb;

architecture testbench of memory_instr_tb is
  signal CLK : std_logic := '0';
  signal RESET : std_logic := '0';
  signal SEL_FCT : std_logic_vector(3 downto 0);
  signal SEL_ROUTE : std_logic_vector(3 downto 0);
  signal SEL_OUT : std_logic_vector(1 downto 0);

begin
  memory_instr_tb : entity work.memory_instr
    port map(
      CLK => CLK,
      RESET => RESET,
      SEL_FCT => SEL_FCT,
      SEL_ROUTE => SEL_ROUTE,
      SEL_OUT => SEL_OUT
    );
  process
  begin
    CLK <= '0';
    wait for 10 ns;
    CLK <= '1';
    wait for 10 ns;
  end process;

  process
  begin
    for i in 0 to 4096 loop
      -- if i = 240 then
      --   RESET <= '1';
      -- else
      --   RESET <= '0';
      -- end if;
      wait for 10 ns;
    end loop;
    report "simulation finished successfully" severity FAILURE;
  end process;
end testbench;