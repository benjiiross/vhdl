library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity buffered_alu is
  port (
    A, B, SEL_FCT : in std_logic_vector(3 downto 0);
    SR_IN : in std_logic_vector(1 downto 0);
    CLK, RESET : in std_logic;

    SR_OUT : out std_logic_vector(1 downto 0) := "00";
    S : out std_logic_vector (7 downto 0) := (others => '0')
  );
end entity buffered_alu;

architecture buffered_alu_arch of buffered_alu is
  component alu is
    port (
      A, B, SEL_FCT : in std_logic_vector(3 downto 0);
      SR_IN : in std_logic_vector(1 downto 0);
      CLK, RESET : in std_logic;

      SR_OUT : out std_logic_vector(1 downto 0) := "00";
      S : out std_logic_vector (7 downto 0) := (others => '0')
    );
  end component alu;

  component memory is
    generic (
      SIZE : integer
    );
    port (
      INPUT : in std_logic_vector(SIZE - 1 downto 0);
      OUTPUT : out std_logic_vector(SIZE - 1 downto 0) := (others => '0');
      CLK, RESET : in std_logic
    );
  end component memory;

  signal A_buf, B_buf : std_logic_vector(3 downto 0) := (others => '0');
  signal SR_IN_buf : std_logic_vector(1 downto 0) := (others => '0');
begin
  alu1 : alu
  port map(
    A => A_buf,
    B => B_buf,
    SEL_FCT => SEL_FCT,
    SR_IN => SR_IN_buf,
    CLK => CLK,
    RESET => RESET,
    SR_OUT => SR_OUT,
    S => S
  );

  Buffer_A : memory
  generic map(SIZE => 4)
  port map(
    INPUT => A,
    OUTPUT => A_buf,
    CLK => CLK,
    RESET => RESET
  );

  Buffer_B : memory
  generic map(SIZE => 4)
  port map(
    INPUT => B,
    OUTPUT => B_buf,
    CLK => CLK,
    RESET => RESET
  );

  Buffer_SR_IN : memory
  generic map(SIZE => 2)
  port map(
    INPUT => SR_IN,
    OUTPUT => SR_IN_buf,
    CLK => CLK,
    RESET => RESET
  );

end architecture buffered_alu_arch;