library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
  port (
    A, B, SEL_FCT : in std_logic_vector(3 downto 0);
    SR_IN : in std_logic_vector(1 downto 0);
    CLK, RESET : in std_logic;

    SR_OUT : out std_logic_vector(1 downto 0) := "00";
    S : out std_logic_vector (7 downto 0) := (others => '0')
  );
end alu;

architecture alu_arch of alu is
begin
  alu_process : process (CLK, RESET)
    variable A_8BITS, B_8BITS, CARRY_8BITS : std_logic_vector (7 downto 0) := (others => '0');
  begin
    if (RESET = '1') then
      S <= (others => '0');
      SR_OUT <= "00";
      A_8BITS := (others => '0');
      B_8BITS := (others => '0');
      CARRY_8BITS := (others => '0');
    elsif rising_edge(CLK) then
      case SEL_FCT is
        when "0000" => -- all zeros
          S <= (others => '0');
          SR_OUT <= "00";

        when "0001" => -- S = A
          S <= "0000" & A;
          SR_OUT <= "00";

        when "0010" => -- S = B
          S <= "0000" & B;
          SR_OUT <= "00";

        when "0011" => -- S = not A
          S <= "0000" & not A;
          SR_OUT <= "00";

        when "0100" => -- S = not B
          S <= "0000" & not B;
          SR_OUT <= "00";

        when "0101" => -- S = A and B
          S <= "0000" & (A and B);
          SR_OUT <= "00";

        when "0110" => -- S = A or B
          S <= "0000" & (A or B);
          SR_OUT <= "00";

        when "0111" => -- S = A xor B
          S <= "0000" & (A xor B);
          SR_OUT <= "00";

        when "1000" => -- S = A right shift
          S <= "0000" & SR_IN(1) & A(3 downto 1);
          SR_OUT <= '0' & A(0);

        when "1001" => -- S = A left shift
          S <= "0000" & A(2 downto 0) & SR_IN(0);
          SR_OUT <= A(3) & '0';

        when "1010" => -- S = B right shift
          S <= "0000" & SR_IN(1) & B(3 downto 1);
          SR_OUT <= '0' & B(0);

        when "1011" => -- S = B left shift
          S <= "0000" & B(2 downto 0) & SR_IN(0);
          SR_OUT <= B(3) & '0';

        when "1100" => -- S = A * B
          S <= std_logic_vector(unsigned(A) * unsigned(B));
          SR_OUT <= "00";

        when "1101" => -- S = A + B + SR_IN_R
          A_8BITS := "0000" & A;
          B_8BITS := "0000" & B;
          CARRY_8BITS := "0000000" & SR_IN(0);
          S <= std_logic_vector(unsigned(A_8BITS) + unsigned(B_8BITS) + unsigned(CARRY_8BITS));
          SR_OUT <= "00";

        when "1110" => -- S = A + B
          A_8BITS := "0000" & A;
          B_8BITS := "0000" & B;
          S <= std_logic_vector(unsigned(A_8BITS) + unsigned(B_8BITS));
          SR_OUT <= "00";

        when others => -- S = A - B
          A_8BITS := "0000" & A;
          B_8BITS := "0000" & B;
          S <= std_logic_vector(unsigned(A_8BITS) - unsigned(B_8BITS));
          SR_OUT <= "00";
      end case;
    end if;
  end process;
end alu_arch;