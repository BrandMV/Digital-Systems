-- ===================================================== --
-- ==============     FLIP FLOPS     =================== --
-- ===================================================== --

library IEEE;
use IEEE.std_logic_1164.all;

entity ff is
    port(
        pre, clr, clk, d, t, s, r, j, k: in std_logic;
		sel: in std_logic_vector(1 downto 0);
        flip: out std_logic_vector(1 downto 0)
    );
end ff;

architecture a_ff of ff is
    SIGNAL srQ, jkQ, dQ, tQ: STD_LOGIC_VECTOR(1 DOWNTO 0);

    begin

        -- ~~~FLIP-FLOP SR~~~ --

        flipFlopSR: Process(clr, pre, clk)
        begin
            if(clr = '0') then 
                srQ(1) <= '0';
                srQ(0) <= '1';
            elsif(clk'event and clk = '1') then
                if(pre = '1') then
                    srQ(1) <= '1';
                    srQ(0) <= '0';
                else
                    srQ(1) <= s OR ((NOT r) AND srQ(1));  
                    srQ(0) <= not srQ(1);
                end if;
            end if;
        end process flipFlopSR;

         -- ~~~FLIP-FLOP JK~~~ --

         flipFlopJK: process(clr, pre, clk)
         begin
            if(clr = '0') then
                jkQ(1) <= '0';
                jkQ(0) <= '1';
            elsif (clk'event and clk = '1') then
                if(pre = '1') then
                    jkQ(1) <= '1';
                    jkQ(0) <= '0';
                else
                    jkQ(1) <= ((not k) and jkQ(1)) or (j and (not jkQ(1)));
                    jkQ(0) <= not jkQ(1);
                end if;
            end if;
        end process flipFlopJK;

         -- ~~~FLIP-FLOP D~~~ --

         flipFlopD: process(clr, pre, clk)
         begin
            if(clr = '0') then
                dQ(1) <= '0';
                dQ(0) <= '1';
            elsif(clk'event and clk = '1') then
                if(pre = '1') then
                    dQ(1) <= '1';
                    dQ(0) <= '0';
                else
                    dQ(1) <= d;
                    dQ(0) <= not dQ(1);
                end if;
            end if;
        end process flipFlopD;

         -- ~~~FLIP-FLOP T~~~ --

         flipFlopT: process(clr, pre, clk)
         begin
            if(clr = '0') then
                tQ(1) <= '0';
                tQ(0) <= '1';
            elsif(clk'event and clk = '1') then
                if(pre = '1') then
                    tQ(1) <= '1';
                    tQ(0) <= '0';
                else
					tQ(1) <= t xor tQ(1);
					tQ(0) <= not tQ(1);
                end if;
            end if;
        end process flipFlopT;

         -- ~~~MUX~~~ --
        flip <= dQ when sel = "00" else
				srQ when sel = "01" else
				jkQ when sel = "10" else
				tQ;
      
end a_ff; -- arch