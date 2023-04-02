library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity instructions is
  port (
    CLK : in std_logic;
    RESET : in std_logic;

    SEL_FCT : out std_logic_vector(3 downto 0);
    SEL_ROUTE : out std_logic_vector(3 downto 0);
    SEL_OUT : out std_logic_vector(1 downto 0)
  );
end instructions;

architecture instructions_arch of instructions is

begin
  intructions_process : process (CLK)
    variable INSTRUCTION : std_logic_vector(9 downto 0) := (others => '1');
  begin
    if rising_edge(CLK) then
      if INSTRUCTION = "1111111111" then
        INSTRUCTION := (others => '0');
      else
        INSTRUCTION := std_logic_vector(unsigned(INSTRUCTION) + "0000000001");
      end if;
      SEL_FCT <= INSTRUCTION(3 downto 0);
      SEL_ROUTE <= INSTRUCTION(7 downto 4);
      SEL_OUT <= INSTRUCTION(9 downto 8);
    end if;
    if RESET = '1' then
      INSTRUCTION := (others => '0');
    end if;
  end process;

end instructions_arch;