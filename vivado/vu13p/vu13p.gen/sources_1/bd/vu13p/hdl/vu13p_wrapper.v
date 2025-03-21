//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Fri Mar 21 17:20:02 2025
//Host        : eda2 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target vu13p_wrapper.bd
//Design      : vu13p_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module vu13p_wrapper
   (aurora_refclk_clk_n,
    aurora_refclk_clk_p,
    aurora_rx_slave_rxn,
    aurora_rx_slave_rxp,
    aurora_tx_slave_txn,
    aurora_tx_slave_txp,
    sysclk_clk_n,
    sysclk_clk_p);
  input aurora_refclk_clk_n;
  input aurora_refclk_clk_p;
  input [0:1]aurora_rx_slave_rxn;
  input [0:1]aurora_rx_slave_rxp;
  output [0:1]aurora_tx_slave_txn;
  output [0:1]aurora_tx_slave_txp;
  input sysclk_clk_n;
  input sysclk_clk_p;

  wire aurora_refclk_clk_n;
  wire aurora_refclk_clk_p;
  wire [0:1]aurora_rx_slave_rxn;
  wire [0:1]aurora_rx_slave_rxp;
  wire [0:1]aurora_tx_slave_txn;
  wire [0:1]aurora_tx_slave_txp;
  wire sysclk_clk_n;
  wire sysclk_clk_p;

  vu13p vu13p_i
       (.aurora_refclk_clk_n(aurora_refclk_clk_n),
        .aurora_refclk_clk_p(aurora_refclk_clk_p),
        .aurora_rx_slave_rxn(aurora_rx_slave_rxn),
        .aurora_rx_slave_rxp(aurora_rx_slave_rxp),
        .aurora_tx_slave_txn(aurora_tx_slave_txn),
        .aurora_tx_slave_txp(aurora_tx_slave_txp),
        .sysclk_clk_n(sysclk_clk_n),
        .sysclk_clk_p(sysclk_clk_p));
endmodule
