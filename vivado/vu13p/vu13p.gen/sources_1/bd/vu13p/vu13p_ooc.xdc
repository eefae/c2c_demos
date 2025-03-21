################################################################################

# This XDC is used only for OOC mode of synthesis, implementation
# This constraints file contains default clock frequencies to be used during
# out-of-context flows such as OOC Synthesis and Hierarchical Designs.
# This constraints file is not used in normal top-down synthesis (default flow
# of Vivado)
################################################################################
create_clock -name aurora_refclk_clk_p -period 6.400 [get_ports aurora_refclk_clk_p]
create_clock -name sysclk_clk_p -period 10 [get_ports sysclk_clk_p]

################################################################################