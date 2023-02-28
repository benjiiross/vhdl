-- Code your testbench here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- Déclaration d'une entité pour la simulation sans ports d'entrées et de sorties
ENTITY myET2testbench IS
END myET2testbench;

ARCHITECTURE myET2testbench_Arch OF myET2testbench IS
    --Déclaration du composant à tester -> renvoie vers l'entité ET2 !
    COMPONENT ET2
        PORT (
            e1 : IN STD_LOGIC;
            e2 : IN STD_LOGIC;
            s1 : OUT STD_LOGIC
        );
    END COMPONENT;

    --Déclaration des signaux internes à l'architecture pour relier les simulations
    SIGNAL e1_sim, e2_sim : STD_LOGIC := '0'; --valeur par défaut : '0'
    SIGNAL s1_sim : STD_LOGIC := '0';

BEGIN
    --Instanciation du composant à tester
    MyComponentET2underTest : ET2
    --raccordement des ports du composant aux signaux dans l'architecture
    PORT MAP(
        e1 => e1_sim,
        e2 => e2_sim,
        s1 => s1_sim
    );

    -- Définition du process permettant de faire évoluer les signaux d'entrée du composant a tester
    MyStimulus_ele2Input_Proc2 : PROCESS -- pas de liste de sensibilité
    BEGIN
        FOR i IN 0 TO 1 LOOP
            FOR j IN 0 TO 1 LOOP
                e1_sim <= to_unsigned(i, 1)(0);
                e2_sim <= to_unsigned(j, 1)(0);
                WAIT FOR 100 us;

                -- ASSERT s1_sim = (e1_sim AND e2_sim)
                REPORT "e1_sim = " & STD_LOGIC'image(e1_sim) &
                    " | e2_sim = " & STD_LOGIC'image(e2_sim) &
                    " | s1_sim = " & STD_LOGIC'image(s1_sim)
                    SEVERITY NOTE;
            END LOOP;
        END LOOP;

        REPORT "Test ok (no assert..)";
        WAIT;
    END PROCESS;

END MyET2testbench_Arch;