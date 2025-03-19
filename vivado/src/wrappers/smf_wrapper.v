`timescale 1 ps / 1 ps

module smf_c2c_master_wrapper
   (aurora_refclk_clk_n,
    aurora_refclk_clk_p,
    aurora_rx_master_rxn,
    aurora_rx_master_rxp,
    aurora_tx_master_txn,
    aurora_tx_master_txp,
    led_out,
    sysclk_clk_n,
    sysclk_clk_p);
  input aurora_refclk_clk_n;
  input aurora_refclk_clk_p;
  input [0:1]aurora_rx_master_rxn;
  input [0:1]aurora_rx_master_rxp;
  output [0:1]aurora_tx_master_txn;
  output [0:1]aurora_tx_master_txp;
  output [3:0]led_out;
  input [0:0]sysclk_clk_n;
  input [0:0]sysclk_clk_p;

  wire aurora_refclk_clk_n;
  wire aurora_refclk_clk_p;
  wire [0:1]aurora_rx_master_rxn;
  wire [0:1]aurora_rx_master_rxp;
  wire [0:1]aurora_tx_master_txn;
  wire [0:1]aurora_tx_master_txp;
  wire [3:0]led_out;
  wire [0:0]sysclk_clk_n;
  wire [0:0]sysclk_clk_p;

  smf_c2c_master smf_c2c_master_i
       (.aurora_refclk_clk_n(aurora_refclk_clk_n),
        .aurora_refclk_clk_p(aurora_refclk_clk_p),
        .aurora_rx_master_rxn(aurora_rx_master_rxn),
        .aurora_rx_master_rxp(aurora_rx_master_rxp),
        .aurora_tx_master_txn(aurora_tx_master_txn),
        .aurora_tx_master_txp(aurora_tx_master_txp),
        .led_out(led_out),
        .sysclk_clk_n(sysclk_clk_n),
        .sysclk_clk_p(sysclk_clk_p));
endmodule
