library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microcontroller is
  port (
    clk : in std_logic;
    reset : in std_logic;
    a_in : in std_logic_vector(3 downto 0);
    b_in : in std_logic_vector(3 downto 0);
    sr_in : in std_logic_vector(1 downto 0);

    res_out : out std_logic_vector(7 downto 0) := (others => '0');
    sr_out : out std_logic_vector(1 downto 0) := "00"
  );
end microcontroller;

architecture rtl of microcontroller is

  component cached_alu is
    port (
      SR_IN : in std_logic_vector(1 downto 0);
      A_IN : in std_logic_vector(3 downto 0);
      B_IN : in std_logic_vector(3 downto 0);
      RESET : in std_logic;
      CLK : in std_logic;

      SEL_FCT : in std_logic_vector(3 downto 0);
      SEL_ROUTE : in std_logic_vector(3 downto 0);
      SEL_OUT : in std_logic_vector(1 downto 0);

      RES_OUT : out std_logic_vector(7 downto 0) := (others => '0');
      SR_OUT : out std_logic_vector(1 downto 0) := "00"
    );
  end component;

  component instructions is
    port (
      clk : in std_logic;
      reset : in std_logic;

      sel_fct : out std_logic_vector(3 downto 0);
      sel_route : out std_logic_vector(3 downto 0);
      sel_out : out std_logic_vector(1 downto 0)
    );
  end component;

  signal sel_fct : std_logic_vector(3 downto 0);
  signal sel_route : std_logic_vector(3 downto 0);
  signal sel_out : std_logic_vector(1 downto 0);
begin

  inst : instructions port map(
    clk => clk,
    reset => reset,

    sel_fct => sel_fct,
    sel_route => sel_route,
    sel_out => sel_out
  );

  alu : cached_alu port map(
    SR_IN => sr_in,
    A_IN => a_in,
    B_IN => b_in,
    RESET => reset,
    CLK => clk,

    SEL_FCT => sel_fct,
    SEL_ROUTE => sel_route,
    SEL_OUT => sel_out,

    RES_OUT => res_out,
    SR_OUT => sr_out
  );

end rtl;