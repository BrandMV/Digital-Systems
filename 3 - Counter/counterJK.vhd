-- ====================================================================== --
-- ==============      3 Bits Counter using JK ff     =================== --
-- ====================================================================== --

library IEEE;
use IEEE.std_logic_1164.all;

entity cjk is
    port(
        clk, clr, c: in std_logic;
        q: inout std_logic_vector(2 downto 0)
    );
end cjk;

architecture A_cjk of cjk is

	signal aux: std_logic_vector (2 downto 0);

    begin

        process(clr, clk, c)
            begin
                if( clr = '0') then
                    aux <= "000";
                elsif ( clk'event and clk = '1') then
                    case c is
                        when '0' =>
                            aux(2) <= ( (not ((not c) and q(1) and q(0))) and q(2)) or (((not c) and q(1) and q(0)) and (not q(2)));
                            aux(1) <= ( (not ((not c) and q(0))) and q(1)) or (((not c) and q(0)) and (not q(1)));
                            aux(0) <= ( not (not c) and q(0)) or ((not c) and (not q(0)));
                        when others =>
                            aux <= q;
                    end case;
                end if;
            end process;
			q <= aux;

    end A_cjk;