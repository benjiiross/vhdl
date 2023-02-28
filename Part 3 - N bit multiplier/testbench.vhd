-- Code your testbench here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- Déclaration d'une entité pour la simulation sans ports d'entrés et de sorties
ENTITY myAddNbitstestbench IS
END myAddNbitstestbench;

ARCHITECTURE myAddNbitstestbench_Arch OF myAddNbitstestbench IS
  -- Déclaration de la constante pour le paramètre générique (non obligatoire)
  CONSTANT N : INTEGER := 4;

  -- Déclaration du composant à tester --> renvoie vers l'entité ET2 !
  COMPONENT addNbits IS
    GENERIC (
      N : INTEGER
    );
    PORT (
      e1 : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
      e2 : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
      c_in : IN STD_LOGIC;
      s1 : OUT STD_LOGIC_VECTOR (N * 2 - 1 DOWNTO 0);
      c_out : OUT STD_LOGIC
    );
  END COMPONENT;

  -- Déclaration des signaux internes à l'arhitecture pour relier les simulations
  SIGNAL e1_sim, e2_sim : STD_LOGIC_VECTOR(N - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL s1_sim : STD_LOGIC_VECTOR(N * 2 - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL c_in_sim, c_out_sim : STD_LOGIC := '0';

BEGIN
  -- Instanciation du composant à tester
  MyComponentAddNbitsunderTest : addNbits
  -- raccordement des ports du composant aux signaux dans l'architecture
  GENERIC MAP(
    N => N
  )
  PORT MAP(
    e1 => e1_sim,
    e2 => e2_sim,
    c_in => c_in_sim,
    s1 => s1_sim,
    c_out => c_out_sim
  );
  -- Déclaration du process permettant de faire évoluer les signaux d'entrée du composant à tester
  MyStimulus_Proc2 : PROCESS -- pas de liste de sensibilité
  BEGIN

    FOR i IN 0 TO (2 ** N) - 1 LOOP
      FOR j IN 0 TO (2 ** N) - 1 LOOP
        FOR k IN 0 TO 1 LOOP
          c_in_sim <= to_unsigned(k, 1)(0);
          e1_sim <= STD_LOGIC_VECTOR(to_unsigned(i, N));
          e2_sim <= STD_LOGIC_VECTOR(to_unsigned(j, N));
          WAIT FOR 100 us;

          REPORT "c_in=" & INTEGER 'image(k) &
          " | e1=" & INTEGER'image(i) &
          "| e2=" & INTEGER'image(j) &
          " || s1 = " & INTEGER'image(to_integer(unsigned(s1_sim))) &
          " | c_out=" & STD_LOGIC'image(c_out_sim);

          ASSERT s1_sim = STD_LOGIC_VECTOR(unsigned(e1_sim) *
          unsigned(e2_sim) * unsigned'('0' & c_in_sim)) REPORT "Failure" SEVERITY failure;
        END LOOP;
      END LOOP;
    END LOOP;

    REPORT "Test ok (no assert...)";
    WAIT;
  END PROCESS;
END myAddNbitstestbench_Arch;