library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

-- Generates clock and initial reset signals to be used in testbenches.
-- Clock is 50% duty rising at time zero.
-- Initial reset pulse is async assert/sync deassert.

entity clock_reset_generator is
    generic
    (
        CLK_RATE : positive
    );
    port
    (
        clk_o : out std_logic;   -- system clock
        rst_o : out std_logic    -- async assert/sync deassert
    );
end clock_reset_generator;

architecture clock_reset_generator of clock_reset_generator is

    constant CLK_PERIOD: time := (1_000_000_000.0 / real(CLK_RATE)) * 1 ns;

    signal clk: std_logic;

begin

    clk_o <= clk;

    clock_generator: process is
    begin
        loop
            clk <= '1';
            wait for CLK_PERIOD / 2;
            clk <= '0';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- async assert/sync deassert, more than a whole tick spent in reset

    reset_generator: process is
    begin
        rst_o <= '0';
        wait for (CLK_PERIOD * 2 / 3);
        rst_o <= '1';
        wait for CLK_PERIOD;
        wait until rising_edge(clk);
        rst_o <= '0';
        wait;
    end process;

end clock_reset_generator;
