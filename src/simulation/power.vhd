library ieee;
use ieee.std_logic_1164.all;
use work.reg_chain;

entity power is
    generic
    (
        REG_COUNT : positive
    );
    port
    (
        clk              : in  std_logic;
        rst              : in  std_logic;
        reg_chain_output : out std_logic
    );
end power;

architecture test of power is
begin

    reg_chain_inst : entity reg_chain
    generic map
    (
        REG_COUNT => REG_COUNT
    )
    port map
    (
        clk    => clk,
        rst    => rst,
        output => reg_chain_output
    );

end test;
