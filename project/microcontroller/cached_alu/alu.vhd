library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
  port (
    SEL_FCT : in std_logic_vector(3 downto 0);
    SR_IN : in std_logic_vector(1 downto 0);
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    RESET : in std_logic;
    CLK : in std_logic;

    SR_OUT : out std_logic_vector(1 downto 0) := (others => '0');
    S : out std_logic_vector (7 downto 0) := (others => '0')
  );
end alu;

architecture alu_arch of alu is
begin
  alu_process : process (CLK, RESET)
    variable A_8BITS : std_logic_vector (7 downto 0) := (others => '0');
    variable B_8BITS : std_logic_vector (7 downto 0) := (others => '0');
    variable CARRY_8BITS : std_logic_vector (7 downto 0) := (others => '0');
    variable S_OUT : std_logic_vector (7 downto 0) := (others => '0');

  begin
    if (RESET = '1') then
      S <= (others => '0');
      S_OUT := (others => '0');
      SR_OUT <= "00";
      A_8BITS := (others => '0');
      B_8BITS := (others => '0');
      CARRY_8BITS := (others => '0');
    elsif rising_edge(CLK) then
      case SEL_FCT is
        when "0000" => -- all zeros
          S_OUT := (others => '0');
          SR_OUT <= "00";

        when "0001" => -- S_OUT = A
          S_OUT := "0000" & A;
          SR_OUT <= "00";

        when "0010" => -- S_OUT = B
          S_OUT := "0000" & B;
          SR_OUT <= "00";

        when "0011" => -- S_OUT = not A
          S_OUT := "0000" & not A;
          SR_OUT <= "00";

        when "0100" => -- S_OUT = not B
          S_OUT := "0000" & not B;
          SR_OUT <= "00";

        when "0101" => -- S_OUT = A and B
          S_OUT := "0000" & (A and B);
          SR_OUT <= "00";

        when "0110" => -- S_OUT = A or B
          S_OUT := "0000" & (A or B);
          SR_OUT <= "00";

        when "0111" => -- S_OUT = A xor B
          S_OUT := "0000" & (A xor B);
          SR_OUT <= "00";

        when "1000" => -- S_OUT = A right shift
          S_OUT := "0000" & SR_IN(1) & A(3 downto 1);
          SR_OUT <= '0' & A(0);

        when "1001" => -- S_OUT = A left shift
          S_OUT := "0000" & A(2 downto 0) & SR_IN(0);
          SR_OUT <= A(3) & '0';

        when "1010" => -- S_OUT = B right shift
          S_OUT := "0000" & SR_IN(1) & B(3 downto 1);
          SR_OUT <= '0' & B(0);

        when "1011" => -- S_OUT = B left shift
          S_OUT := "0000" & B(2 downto 0) & SR_IN(0);
          SR_OUT <= B(3) & '0';

        when "1100" => -- S_OUT = A * B
          S_OUT := std_logic_vector(unsigned(A) * unsigned(B));
          SR_OUT <= "00";

        when "1101" => -- S_OUT = A + B + SR_IN_R
          A_8BITS := "0000" & A;
          B_8BITS := "0000" & B;
          CARRY_8BITS := "0000000" & SR_IN(0);
          S_OUT := std_logic_vector(unsigned(A_8BITS) + unsigned(B_8BITS) + unsigned(CARRY_8BITS));
          SR_OUT <= "00";

        when "1110" => -- S_OUT = A + B
          A_8BITS := "0000" & A;
          B_8BITS := "0000" & B;
          S_OUT := std_logic_vector(unsigned(A_8BITS) + unsigned(B_8BITS));
          SR_OUT <= "00";

        when others => -- S_OUT = A - B
          A_8BITS := "0000" & A;
          B_8BITS := "0000" & B;
          S_OUT := std_logic_vector(unsigned(A_8BITS) - unsigned(B_8BITS));
          SR_OUT <= "00";
      end case;
    elsif falling_edge(CLK) then
      S <= S_OUT;
    end if;
  end process;
end alu_arch;