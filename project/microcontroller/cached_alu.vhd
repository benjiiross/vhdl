library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cached_alu is
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
end entity cached_alu;

architecture rtl of cached_alu is
  signal MEM_CACHE_1_IN : std_logic_vector(7 downto 0) := (others => '0');
  signal MEM_CACHE_1_OUT : std_logic_vector(7 downto 0) := (others => '0');
  signal MEM_CACHE_1_SET : std_logic := '0';
  signal MEM_CACHE_2_IN : std_logic_vector(7 downto 0) := (others => '0');
  signal MEM_CACHE_2_OUT : std_logic_vector(7 downto 0) := (others => '0');
  signal MEM_CACHE_2_SET : std_logic := '0';
  signal ALU_A : std_logic_vector(3 downto 0) := (others => '0');
  signal ALU_B : std_logic_vector(3 downto 0) := (others => '0');
  signal ALU_S : std_logic_vector(7 downto 0) := (others => '0');

  component buffered_alu is
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
  end component buffered_alu;

  component memory_cache is
    port (
      CLK : in std_logic;
      RESET : in std_logic;
      INPUT : in std_logic_vector(7 downto 0);
      SET : in std_logic;

      OUTPUT : out std_logic_vector(7 downto 0) := (others => '0')
    );
  end component memory_cache;
begin
  MEM_CACHE_1 : memory_cache
  port map(
    CLK => CLK,
    RESET => RESET,
    INPUT => MEM_CACHE_1_IN,
    SET => MEM_CACHE_1_SET,
    OUTPUT => MEM_CACHE_1_OUT
  );

  MEM_CACHE_2 : memory_cache
  port map(
    CLK => CLK,
    RESET => RESET,
    INPUT => MEM_CACHE_2_IN,
    SET => MEM_CACHE_2_SET,
    OUTPUT => MEM_CACHE_2_OUT
  );

  b_alu : buffered_alu
  port map(
    SR_IN => SR_IN,
    SEL_FCT => SEL_FCT,
    SR_OUT => SR_OUT,
    CLK => CLK,
    RESET => RESET,
    A => ALU_A,
    B => ALU_B,
    S => ALU_S
  );

  process (SEL_ROUTE)
  begin
    MEM_CACHE_1_SET <= '0';
    MEM_CACHE_2_SET <= '0';
    case SEL_ROUTE is
      when "0000" => -- Buffer_A <= A_IN
        ALU_A <= A_IN;
      when "0001" => -- Buffer_B <= B_IN
        ALU_B <= B_IN;
      when "0010" => -- Buffer_A <= MEM_CACHE_1 (4 LSB)
        ALU_A <= MEM_CACHE_1_OUT(3 downto 0);
      when "0011" => -- Buffer_A <= MEM_CACHE_1 (4 MSB)
        ALU_A <= MEM_CACHE_1_OUT(7 downto 4);
      when "0100" => -- Buffer_B <= MEM_CACHE_1 (4 LSB)
        ALU_B <= MEM_CACHE_1_OUT(3 downto 0);
      when "0101" => -- Buffer_B <= MEM_CACHE_1 (4 MSB)
        ALU_B <= MEM_CACHE_1_OUT(7 downto 4);
      when "0110" => -- MEM_CACHE_1 <= S
        MEM_CACHE_1_SET <= '1';
        MEM_CACHE_1_IN <= ALU_S;
      when "0111" => -- Buffer_A <= MEM_CACHE_1 (4 LSB)
        ALU_A <= MEM_CACHE_2_OUT(3 downto 0);
      when "1000" => -- Buffer_A <= MEM_CACHE_1 (4 MSB)
        ALU_A <= MEM_CACHE_2_OUT(7 downto 4);
      when "1001" => -- Buffer_B <= MEM_CACHE_1 (4 LSB)
        ALU_B <= MEM_CACHE_2_OUT(3 downto 0);
      when "1010" => -- Buffer_B <= MEM_CACHE_1 (4 MSB)
        ALU_B <= MEM_CACHE_2_OUT(7 downto 4);
      when "1011" => -- MEM_CACHE_2 <= S
        MEM_CACHE_2_SET <= '1';
        MEM_CACHE_2_IN <= ALU_S;
      when "1100" => -- Buffer_A <= S (4 LSB)
        ALU_A <= ALU_S(3 downto 0);
      when "1101" => -- Buffer_A <= S (4 MSB)
        ALU_A <= ALU_S(7 downto 4);
      when "1110" => -- Buffer_B <= S (4 LSB)
        ALU_B <= ALU_S(3 downto 0);
      when others => -- Buffer_B <= S (4 MSB)
        ALU_B <= ALU_S(7 downto 4);
    end case;
  end process;

  process (CLK)
  begin
    if rising_edge(CLK) then
      case SEL_OUT is
        when "00" => -- No output
          RES_OUT <= (others => '0');
        when "01" => -- RES_OUT <= MEM_CACHE_1
          RES_OUT <= MEM_CACHE_1_OUT;
        when "10" => -- RES_OUT <= MEM_CACHE_2
          RES_OUT <= MEM_CACHE_2_OUT;
        when others => -- RES_OUT <= S
          RES_OUT <= ALU_S;
      end case;
    end if;
  end process;

end architecture;