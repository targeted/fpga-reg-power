library ieee;
use ieee.std_logic_1164.all;
use work.reg;

entity reg_chain is
    generic
    (
        REG_COUNT : positive
    );
    port
    (
        clk    : in  std_ulogic;
        rst    : in  std_ulogic;
        output : out std_ulogic
    );
end reg_chain;

architecture reg_chain of reg_chain is

    type reg_wire_t is array (0 to REG_COUNT - 2) of std_ulogic;
    signal reg_wire : reg_wire_t;

    signal pulse : std_ulogic;

begin

    pulse_generator:
    process (clk, rst) is
    begin
        if rst = '1' then
            pulse <= '0';
        elsif rising_edge(clk) then
            pulse <= not pulse;
        end if;
    end process;

    gen_reg_chain:
    for i in 0 to REG_COUNT - 1 generate

        reg_first:
        if i = 0 generate
            reg_first_inst: entity reg
            port map (
                clk    => clk,
                rst    => rst,
                input  => pulse,
                output => reg_wire(0)
            );
        end generate;

        reg_others:
        if (i > 0) and (i < REG_COUNT - 1) generate
            reg_others_inst: entity reg
            port map (
                clk    => clk,
                rst    => rst,
                input  => reg_wire(i - 1),
                output => reg_wire(i)
            );
        end generate;

        reg_last:
        if i = REG_COUNT - 1 generate
            reg_last_inst: entity reg
            port map (
                clk    => clk,
                rst    => rst,
                input  => reg_wire(REG_COUNT - 2),
                output => output
            );
        end generate;

    end generate;

end reg_chain;
