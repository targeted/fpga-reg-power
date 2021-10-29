library ieee;
use ieee.std_logic_1164.all;

entity reg is
    port
    (
        clk    : in  std_ulogic;
        rst    : in  std_ulogic;
        input  : in  std_ulogic;
        output : out std_ulogic
    );
end reg;

architecture reg of reg is
begin

    process (clk, rst) is
    begin
        if rst = '1' then
            output <= '0';
        elsif rising_edge(clk) then
            output <= input;
        end if;
    end process;

end reg;
