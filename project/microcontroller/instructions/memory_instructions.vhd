library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity memory_instructions is
  port (
    clk : in std_logic;
    reset : in std_logic;
    instruction : out std_logic_vector(9 downto 0)
  );
end memory_instructions;

architecture behavioral of memory_instructions is
  type my_array is array (0 to 127) of std_logic_vector(9 downto 0); -- 128 instructions
  signal instructions : my_array := (others => (others => '0')); -- initialize all to 0
  signal isStartup : boolean := true;
  signal instructions_size : integer := 0; -- size of instructions array
begin
  process (isStartup)
    file F : text open read_mode is "instructions.txt";
    variable L : line;
    variable i : integer := 0; -- index for instructions array
    variable instruction_line : bit_vector(9 downto 0);
  begin
    if (isStartup = true) then
      while not endfile(F) loop
        readline(F, L);
        read(L, instruction_line);
        instructions(i) <= to_stdlogicvector(instruction_line);
        i := i + 1;
      end loop;
      instructions_size <= i;
      file_close(F);
    end if;
    isStartup <= false;
  end process;

  process (clk, reset)
    variable i : integer := 0; -- index for instructions array

  begin
    if (reset = '1') then
      i := 0;
    elsif (clk'event and clk = '1') then
      if (i < instructions_size) then
        instruction <= instructions(i);
        i := i + 1;
      end if;
    end if;
  end process;

end behavioral;