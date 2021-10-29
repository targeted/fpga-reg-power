library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use work.clock_reset_generator;
use work.power;

entity power_test is
end power_test;

architecture power_test of power_test is

    constant CLK_RATE  : positive := 10_000_000;
    constant REG_COUNT : positive := 10;

    signal clk              : std_logic;
    signal rst              : std_logic;
    signal reg_chain_output : std_logic;

begin

    clock_reset_generator_inst : entity clock_reset_generator
    generic map
    (
        CLK_RATE => CLK_RATE
    )
    port map
    (
        clk_o => clk,
        rst_o => rst
    );

    power_inst : entity power
    generic map
    (
        REG_COUNT => REG_COUNT
    )
    port map
    (
        clk              => clk,
        rst              => rst,
        reg_chain_output => reg_chain_output
    );

end power_test;