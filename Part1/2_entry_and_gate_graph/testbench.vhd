-- Code your testbench here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY myET2testbench IS
END myET2testbench;

ARCHITECTURE myET2testbench_Arch OF myET2testbench IS
    COMPONENT ET2
        PORT (
            e1 : IN STD_LOGIC;
            e2 : IN STD_LOGIC;
            s1 : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL e1_sim, e2_sim : STD_LOGIC := '0';
    SIGNAL s1_sim : STD_LOGIC := '0';

BEGIN
    MyComponentET2underTest : ET2

    PORT MAP(
        e1 => e1_sim,
        e2 => e2_sim,
        s1 => s1_sim
    );

    MyStimulus_e1_sim_e2_sim_Proc : PROCESS
    BEGIN
        e1_sim <= '0';
        e2_sim <= '0';
        WAIT FOR 100 us;

        e1_sim <= '0';
        e2_sim <= '1';
        WAIT FOR 100 us;

        e1_sim <= '1';
        e2_sim <= '0';
        WAIT FOR 100 us;

        e1_sim <= '1';
        e2_sim <= '1';
        WAIT FOR 700 us;
    END PROCESS;
END myET2testbench_Arch;