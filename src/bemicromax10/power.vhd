library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity power is
    port
    (
        sys_clk : in  std_logic;
        pb_n    : in  std_logic_vector (1 to 4);
        gpio    : out std_logic_vector (1 to 12)
    );
end power;

architecture bemicromax10 of power is

    constant REG_COUNT : positive := 8060;

    signal sys_rst : std_ulogic;

    signal clk_10mhz  : std_ulogic;
    signal clk_25mhz  : std_ulogic;
    signal clk_100mhz : std_ulogic;

    signal clk : std_ulogic;
    signal rst : std_ulogic;

    signal pll_areset : std_ulogic;
    signal pll_inclk0 : std_ulogic;
    signal pll_c0     : std_ulogic;
    signal pll_c1     : std_ulogic;
    signal pll_c2     : std_ulogic;
    signal pll_locked : std_ulogic;

    signal reg_chain_output : std_ulogic;

begin

    sys_rst <= not pb_n(1);

    -- ------------------------------------------------------------------------

    pll_areset <= sys_rst;
    pll_inclk0 <= sys_clk;

    pll_inst : entity pll
    port map (
        areset => pll_areset,
        inclk0 => pll_inclk0,
        c0     => pll_c0,
        c1     => pll_c1,
        c2     => pll_c2,
        locked => pll_locked
    );

    clk_10mhz  <= pll_c0;
    clk_25mhz  <= pll_c1;
    clk_100mhz <= pll_c2;

    clk <= clk_10mhz;
    rst <= sys_rst or (not pll_locked);

    -- ------------------------------------------------------------------------

    reg_chain_inst : entity reg_chain
    generic map (
        REG_COUNT => REG_COUNT
    )
    port map (
        clk    => clk,
        rst    => rst,
        output => reg_chain_output
    );

    gpio <= (1 => reg_chain_output, others => '0');

    -- ------------------------------------------------------------------------

end bemicromax10;

