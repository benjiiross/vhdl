-- Code your design here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY addNbits IS
  GENERIC (
    N : INTEGER := 4
  );
  PORT (
    e1 : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
    e2 : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
    c_in : IN STD_LOGIC;

    s1 : OUT STD_LOGIC_VECTOR (N * 2 - 1 DOWNTO 0);
    c_out : OUT STD_LOGIC
  );
END addNbits;

ARCHITECTURE addNbits_DataFlow OF addNbits IS
  SIGNAL My_e1 : STD_LOGIC_VECTOR (N DOWNTO 0);
  SIGNAL My_e2 : STD_LOGIC_VECTOR (N DOWNTO 0);
  SIGNAL My_c_in : STD_LOGIC_VECTOR (N DOWNTO 0);
  SIGNAL My_s1 : STD_LOGIC_VECTOR (N * 2 DOWNTO 0);

BEGIN
  My_e1 <= '0' & e1;
  My_e2 <= '0' & e2;
  My_c_in(N DOWNTO 1) <= (OTHERS => '0');
  My_c_in(0) <= c_in;

  s1 <= My_s1(N * 2 - 1 DOWNTO 0);
  c_out <= My_s1(N * 2);
  My_s1 <= STD_LOGIC_VECTOR(unsigned(My_e1) * unsigned(My_e2) + unsigned(My_c_in));

END addNbits_DataFlow;