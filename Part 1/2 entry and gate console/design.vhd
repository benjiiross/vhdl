-- Code your design here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ET2 IS
    PORT (
        e1 : IN STD_LOGIC;
        e2 : IN STD_LOGIC;
        s1 : OUT STD_LOGIC
    );
END ET2;

ARCHITECTURE ET2_DataFlow OF ET2 IS
BEGIN

    MyET2ProcessFlag : PROCESS (e1, e2)
    BEGIN
        s1 <= e1 AND e2;
    END PROCESS;

END ET2_DataFlow;