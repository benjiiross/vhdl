library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buffered_alu is
  port (
    SEL_FCT : in std_logic_vector(3 downto 0);
    SR_IN : in std_logic_vector(1 downto 0);
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    RESET : in std_logic;
    CLK : in std_logic;

    SR_OUT : out std_logic_vector(1 downto 0) := "00";
    S : out std_logic_vector (7 downto 0) := (others => '0')
  );
end entity buffered_alu;

architecture buffered_alu_arch of buffered_alu is
  signal A_buf, B_buf : std_logic_vector(3 downto 0) := (others => '0');
  signal SR_IN_buf : std_logic_vector(1 downto 0) := (others => '0');

  component alu is
    port (
      SEL_FCT : in std_logic_vector(3 downto 0);
      SR_IN : in std_logic_vector(1 downto 0);
      A : in std_logic_vector(3 downto 0);
      B : in std_logic_vector(3 downto 0);
      RESET : in std_logic;
      CLK : in std_logic;

      SR_OUT : out std_logic_vector(1 downto 0);
      S : out std_logic_vector (7 downto 0)
    );
  end component alu;

  component buffer_memory is
    generic (
      SIZE : integer
    );
    port (
      INPUT : in std_logic_vector(SIZE - 1 downto 0);
      OUTPUT : out std_logic_vector(SIZE - 1 downto 0);
      CLK : in std_logic;
      RESET : in std_logic
    );
  end component buffer_memory;

begin
  buffer_A : buffer_memory
  generic map(SIZE => 4)
  port map(
    INPUT => A,
    OUTPUT => A_buf,
    CLK => CLK,
    RESET => RESET
  );

  buffer_B : buffer_memory
  generic map(SIZE => 4)
  port map(
    INPUT => B,
    OUTPUT => B_buf,
    CLK => CLK,
    RESET => RESET
  );

  buffer_SR_IN : buffer_memory
  generic map(SIZE => 2)
  port map(
    INPUT => SR_IN,
    OUTPUT => SR_IN_buf,
    CLK => CLK,
    RESET => RESET
  );

  alu1 : alu
  port map(
    A => A_buf,
    B => B_buf,
    SEL_FCT => SEL_FCT,
    SR_IN => SR_IN_buf,
    RESET => RESET,
    SR_OUT => SR_OUT,
    S => S,
    CLK => CLK
  );
end architecture buffered_alu_arch;