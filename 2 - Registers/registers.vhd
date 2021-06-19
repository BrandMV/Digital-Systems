-- ===================================================== --
-- ==============      Registers     =================== --
-- ===================================================== --
library ieee;
use ieee.std_logic_1164.all;

entity reg is
    port(
            clk, clr, ecd, eci: in std_logic;
            c: in std_logic_vector (1 downto 0);
            dato: in std_logic_vector (7 downto 0);
            q:inout std_logic_vector (7 downto 0)
    );
end reg;

architecture A_reg of reg is
    signal aux: std_logic_vector (7 downto 0);
    begin

        -- ~~~MUX PROCESS~~~ --

        MUX: process(c, clk, clr)
            begin
				if( clr = '0' ) then
					aux <= "00000000";
				elsif( clk'event and clk='1' ) then
	                case c is  
	                    when "00" => aux <= dato;
	                    when "01" =>
							aux(7) <= ecd;
	                        for i in 0 to 6 loop
	                            aux(i) <= aux(i+1);
	                        end loop;
	                    when "10" =>
	                        for i in 7 downto 1 loop
	                            aux(i) <= aux(i-1);
	                        end loop;
							aux(0) <= eci;
	                    when others => 
							aux <= q;
	                end case;
				end if;
            end process MUX;
		

	q <= aux;
end A_reg; 
                
                            