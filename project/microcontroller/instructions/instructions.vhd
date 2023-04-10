library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructions is
  port (
    clk : in std_logic;
    reset : in std_logic;

    sel_fct : out std_logic_vector(3 downto 0);
    sel_route : out std_logic_vector(3 downto 0);
    sel_out : out std_logic_vector(1 downto 0)
  );
end entity;

architecture arch of instructions is
  signal instruction : std_logic_vector(9 downto 0);

  component memory_instructions is
    port (
      clk : in std_logic;
      reset : in std_logic;
      instruction : out std_logic_vector(9 downto 0)
    );
  end component;

  component buffer_memory is
    generic (
      size : integer
    );
    port (
      clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(size - 1 downto 0);
      output : out std_logic_vector(size - 1 downto 0)
    );
  end component;

begin
  mem_instructions : memory_instructions
  port map(
    clk => clk,
    reset => reset,
    instruction => instruction
  );

  mem_sel_fct : buffer_memory
  generic map(
    size => 4
  )
  port map(
    clk => clk,
    reset => reset,
    input => instruction(9 downto 6),
    output => sel_fct
  );

  sel_route <= instruction(5 downto 2);

  mem_sel_out : buffer_memory
  generic map(
    size => 2
  )
  port map(
    clk => clk,
    reset => reset,
    input => instruction(1 downto 0),
    output => sel_out
  );

end arch;