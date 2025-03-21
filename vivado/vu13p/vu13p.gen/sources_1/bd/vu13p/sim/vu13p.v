//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Fri Mar 21 17:20:02 2025
//Host        : eda2 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target vu13p.bd
//Design      : vu13p
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bram_imp_1VGN97F
   (S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid,
    s_axi_aclk,
    s_axi_aresetn);
  input [13:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [13:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [63:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [63:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [7:0]S_AXI_wstrb;
  input S_AXI_wvalid;
  input s_axi_aclk;
  input s_axi_aresetn;

  wire [13:0]axi_bram_ctrl_0_BRAM_PORTA_ADDR;
  wire axi_bram_ctrl_0_BRAM_PORTA_CLK;
  wire [63:0]axi_bram_ctrl_0_BRAM_PORTA_DIN;
  wire [63:0]axi_bram_ctrl_0_BRAM_PORTA_DOUT;
  wire axi_bram_ctrl_0_BRAM_PORTA_EN;
  wire axi_bram_ctrl_0_BRAM_PORTA_RST;
  wire [7:0]axi_bram_ctrl_0_BRAM_PORTA_WE;
  wire clk_wiz_0_clk_200;
  wire proc_sys_reset_0_peripheral_aresetn;
  wire [13:0]smartconnect_0_M00_AXI_ARADDR;
  wire [1:0]smartconnect_0_M00_AXI_ARBURST;
  wire [3:0]smartconnect_0_M00_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M00_AXI_ARLEN;
  wire [0:0]smartconnect_0_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire [2:0]smartconnect_0_M00_AXI_ARSIZE;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [13:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M00_AXI_AWLEN;
  wire [0:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [63:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RLAST;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [63:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [7:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;

  assign S_AXI_arready = smartconnect_0_M00_AXI_ARREADY;
  assign S_AXI_awready = smartconnect_0_M00_AXI_AWREADY;
  assign S_AXI_bresp[1:0] = smartconnect_0_M00_AXI_BRESP;
  assign S_AXI_bvalid = smartconnect_0_M00_AXI_BVALID;
  assign S_AXI_rdata[63:0] = smartconnect_0_M00_AXI_RDATA;
  assign S_AXI_rlast = smartconnect_0_M00_AXI_RLAST;
  assign S_AXI_rresp[1:0] = smartconnect_0_M00_AXI_RRESP;
  assign S_AXI_rvalid = smartconnect_0_M00_AXI_RVALID;
  assign S_AXI_wready = smartconnect_0_M00_AXI_WREADY;
  assign clk_wiz_0_clk_200 = s_axi_aclk;
  assign proc_sys_reset_0_peripheral_aresetn = s_axi_aresetn;
  assign smartconnect_0_M00_AXI_ARADDR = S_AXI_araddr[13:0];
  assign smartconnect_0_M00_AXI_ARBURST = S_AXI_arburst[1:0];
  assign smartconnect_0_M00_AXI_ARCACHE = S_AXI_arcache[3:0];
  assign smartconnect_0_M00_AXI_ARLEN = S_AXI_arlen[7:0];
  assign smartconnect_0_M00_AXI_ARLOCK = S_AXI_arlock[0];
  assign smartconnect_0_M00_AXI_ARPROT = S_AXI_arprot[2:0];
  assign smartconnect_0_M00_AXI_ARSIZE = S_AXI_arsize[2:0];
  assign smartconnect_0_M00_AXI_ARVALID = S_AXI_arvalid;
  assign smartconnect_0_M00_AXI_AWADDR = S_AXI_awaddr[13:0];
  assign smartconnect_0_M00_AXI_AWBURST = S_AXI_awburst[1:0];
  assign smartconnect_0_M00_AXI_AWCACHE = S_AXI_awcache[3:0];
  assign smartconnect_0_M00_AXI_AWLEN = S_AXI_awlen[7:0];
  assign smartconnect_0_M00_AXI_AWLOCK = S_AXI_awlock[0];
  assign smartconnect_0_M00_AXI_AWPROT = S_AXI_awprot[2:0];
  assign smartconnect_0_M00_AXI_AWSIZE = S_AXI_awsize[2:0];
  assign smartconnect_0_M00_AXI_AWVALID = S_AXI_awvalid;
  assign smartconnect_0_M00_AXI_BREADY = S_AXI_bready;
  assign smartconnect_0_M00_AXI_RREADY = S_AXI_rready;
  assign smartconnect_0_M00_AXI_WDATA = S_AXI_wdata[63:0];
  assign smartconnect_0_M00_AXI_WLAST = S_AXI_wlast;
  assign smartconnect_0_M00_AXI_WSTRB = S_AXI_wstrb[7:0];
  assign smartconnect_0_M00_AXI_WVALID = S_AXI_wvalid;
  vu13p_axi_bram_ctrl_0_0 axi_bram_ctrl_0
       (.bram_addr_a(axi_bram_ctrl_0_BRAM_PORTA_ADDR),
        .bram_clk_a(axi_bram_ctrl_0_BRAM_PORTA_CLK),
        .bram_en_a(axi_bram_ctrl_0_BRAM_PORTA_EN),
        .bram_rddata_a(axi_bram_ctrl_0_BRAM_PORTA_DOUT),
        .bram_rst_a(axi_bram_ctrl_0_BRAM_PORTA_RST),
        .bram_we_a(axi_bram_ctrl_0_BRAM_PORTA_WE),
        .bram_wrdata_a(axi_bram_ctrl_0_BRAM_PORTA_DIN),
        .s_axi_aclk(clk_wiz_0_clk_200),
        .s_axi_araddr(smartconnect_0_M00_AXI_ARADDR),
        .s_axi_arburst(smartconnect_0_M00_AXI_ARBURST),
        .s_axi_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .s_axi_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .s_axi_arlen(smartconnect_0_M00_AXI_ARLEN),
        .s_axi_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .s_axi_arprot(smartconnect_0_M00_AXI_ARPROT),
        .s_axi_arready(smartconnect_0_M00_AXI_ARREADY),
        .s_axi_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .s_axi_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .s_axi_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .s_axi_awburst(smartconnect_0_M00_AXI_AWBURST),
        .s_axi_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .s_axi_awlen(smartconnect_0_M00_AXI_AWLEN),
        .s_axi_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .s_axi_awprot(smartconnect_0_M00_AXI_AWPROT),
        .s_axi_awready(smartconnect_0_M00_AXI_AWREADY),
        .s_axi_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .s_axi_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .s_axi_bready(smartconnect_0_M00_AXI_BREADY),
        .s_axi_bresp(smartconnect_0_M00_AXI_BRESP),
        .s_axi_bvalid(smartconnect_0_M00_AXI_BVALID),
        .s_axi_rdata(smartconnect_0_M00_AXI_RDATA),
        .s_axi_rlast(smartconnect_0_M00_AXI_RLAST),
        .s_axi_rready(smartconnect_0_M00_AXI_RREADY),
        .s_axi_rresp(smartconnect_0_M00_AXI_RRESP),
        .s_axi_rvalid(smartconnect_0_M00_AXI_RVALID),
        .s_axi_wdata(smartconnect_0_M00_AXI_WDATA),
        .s_axi_wlast(smartconnect_0_M00_AXI_WLAST),
        .s_axi_wready(smartconnect_0_M00_AXI_WREADY),
        .s_axi_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .s_axi_wvalid(smartconnect_0_M00_AXI_WVALID));
  vu13p_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,axi_bram_ctrl_0_BRAM_PORTA_ADDR}),
        .clka(axi_bram_ctrl_0_BRAM_PORTA_CLK),
        .dina(axi_bram_ctrl_0_BRAM_PORTA_DIN),
        .douta(axi_bram_ctrl_0_BRAM_PORTA_DOUT),
        .ena(axi_bram_ctrl_0_BRAM_PORTA_EN),
        .rsta(axi_bram_ctrl_0_BRAM_PORTA_RST),
        .wea(axi_bram_ctrl_0_BRAM_PORTA_WE));
endmodule

module c2c_imp_1YRO02P
   (aurora_pma_init_in,
    aurora_refclk_clk_n,
    aurora_refclk_clk_p,
    aurora_rx_slave_rxn,
    aurora_rx_slave_rxp,
    aurora_tx_slave_txn,
    aurora_tx_slave_txp,
    axi_c2c_link_status_out,
    channel_up,
    gt_pll_lock,
    init_clk,
    lane0,
    lane1,
    m_aclk,
    m_aresetn,
    m_axi_araddr,
    m_axi_arburst,
    m_axi_arlen,
    m_axi_arready,
    m_axi_arsize,
    m_axi_arvalid,
    m_axi_awaddr,
    m_axi_awburst,
    m_axi_awlen,
    m_axi_awready,
    m_axi_awsize,
    m_axi_awvalid,
    m_axi_bready,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_rdata,
    m_axi_rlast,
    m_axi_rready,
    m_axi_rresp,
    m_axi_rvalid,
    m_axi_wdata,
    m_axi_wlast,
    m_axi_wready,
    m_axi_wstrb,
    m_axi_wvalid);
  input aurora_pma_init_in;
  input aurora_refclk_clk_n;
  input aurora_refclk_clk_p;
  input [0:1]aurora_rx_slave_rxn;
  input [0:1]aurora_rx_slave_rxp;
  output [0:1]aurora_tx_slave_txn;
  output [0:1]aurora_tx_slave_txp;
  output axi_c2c_link_status_out;
  output channel_up;
  output gt_pll_lock;
  input init_clk;
  output [0:0]lane0;
  output [0:0]lane1;
  input m_aclk;
  input m_aresetn;
  output [39:0]m_axi_araddr;
  output [1:0]m_axi_arburst;
  output [7:0]m_axi_arlen;
  input m_axi_arready;
  output [2:0]m_axi_arsize;
  output m_axi_arvalid;
  output [39:0]m_axi_awaddr;
  output [1:0]m_axi_awburst;
  output [7:0]m_axi_awlen;
  input m_axi_awready;
  output [2:0]m_axi_awsize;
  output m_axi_awvalid;
  output m_axi_bready;
  input [1:0]m_axi_bresp;
  input m_axi_bvalid;
  input [63:0]m_axi_rdata;
  input m_axi_rlast;
  output m_axi_rready;
  input [1:0]m_axi_rresp;
  input m_axi_rvalid;
  output [63:0]m_axi_wdata;
  output m_axi_wlast;
  input m_axi_wready;
  output [7:0]m_axi_wstrb;
  output m_axi_wvalid;

  wire GT_DIFF_REFCLK1_0_1_CLK_N;
  wire GT_DIFF_REFCLK1_0_1_CLK_P;
  wire [0:1]GT_SERIAL_RX_0_1_RXN;
  wire [0:1]GT_SERIAL_RX_0_1_RXP;
  wire [0:1]aurora_64b66b_0_GT_SERIAL_TX_TXN;
  wire [0:1]aurora_64b66b_0_GT_SERIAL_TX_TXP;
  wire [127:0]aurora_64b66b_0_USER_DATA_M_AXIS_RX_TDATA;
  wire aurora_64b66b_0_USER_DATA_M_AXIS_RX_TVALID;
  wire aurora_64b66b_0_channel_up;
  wire aurora_64b66b_0_gt_pll_lock;
  wire [0:1]aurora_64b66b_0_lane_up;
  wire aurora_64b66b_0_mmcm_not_locked_out;
  wire aurora_64b66b_0_user_clk_out;
  wire [127:0]axi_chip2chip_0_AXIS_TX_TDATA;
  wire axi_chip2chip_0_AXIS_TX_TREADY;
  wire axi_chip2chip_0_AXIS_TX_TVALID;
  wire axi_chip2chip_0_aurora_pma_init_out;
  wire axi_chip2chip_0_aurora_reset_pb;
  wire axi_chip2chip_0_axi_c2c_link_status_out;
  wire [39:0]axi_chip2chip_0_m_axi_ARADDR;
  wire [1:0]axi_chip2chip_0_m_axi_ARBURST;
  wire [7:0]axi_chip2chip_0_m_axi_ARLEN;
  wire axi_chip2chip_0_m_axi_ARREADY;
  wire [2:0]axi_chip2chip_0_m_axi_ARSIZE;
  wire axi_chip2chip_0_m_axi_ARVALID;
  wire [39:0]axi_chip2chip_0_m_axi_AWADDR;
  wire [1:0]axi_chip2chip_0_m_axi_AWBURST;
  wire [7:0]axi_chip2chip_0_m_axi_AWLEN;
  wire axi_chip2chip_0_m_axi_AWREADY;
  wire [2:0]axi_chip2chip_0_m_axi_AWSIZE;
  wire axi_chip2chip_0_m_axi_AWVALID;
  wire axi_chip2chip_0_m_axi_BREADY;
  wire [1:0]axi_chip2chip_0_m_axi_BRESP;
  wire axi_chip2chip_0_m_axi_BVALID;
  wire [63:0]axi_chip2chip_0_m_axi_RDATA;
  wire axi_chip2chip_0_m_axi_RLAST;
  wire axi_chip2chip_0_m_axi_RREADY;
  wire [1:0]axi_chip2chip_0_m_axi_RRESP;
  wire axi_chip2chip_0_m_axi_RVALID;
  wire [63:0]axi_chip2chip_0_m_axi_WDATA;
  wire axi_chip2chip_0_m_axi_WLAST;
  wire axi_chip2chip_0_m_axi_WREADY;
  wire [7:0]axi_chip2chip_0_m_axi_WSTRB;
  wire axi_chip2chip_0_m_axi_WVALID;
  wire clk_wiz_0_clk_156_25;
  wire clk_wiz_0_clk_200;
  wire proc_sys_reset_0_peripheral_aresetn;
  wire vio_0_probe_out1;
  wire [0:0]xlslice_0_Dout;
  wire [0:0]xlslice_1_Dout;

  assign GT_DIFF_REFCLK1_0_1_CLK_N = aurora_refclk_clk_n;
  assign GT_DIFF_REFCLK1_0_1_CLK_P = aurora_refclk_clk_p;
  assign GT_SERIAL_RX_0_1_RXN = aurora_rx_slave_rxn[0:1];
  assign GT_SERIAL_RX_0_1_RXP = aurora_rx_slave_rxp[0:1];
  assign aurora_tx_slave_txn[0:1] = aurora_64b66b_0_GT_SERIAL_TX_TXN;
  assign aurora_tx_slave_txp[0:1] = aurora_64b66b_0_GT_SERIAL_TX_TXP;
  assign axi_c2c_link_status_out = axi_chip2chip_0_axi_c2c_link_status_out;
  assign axi_chip2chip_0_m_axi_ARREADY = m_axi_arready;
  assign axi_chip2chip_0_m_axi_AWREADY = m_axi_awready;
  assign axi_chip2chip_0_m_axi_BRESP = m_axi_bresp[1:0];
  assign axi_chip2chip_0_m_axi_BVALID = m_axi_bvalid;
  assign axi_chip2chip_0_m_axi_RDATA = m_axi_rdata[63:0];
  assign axi_chip2chip_0_m_axi_RLAST = m_axi_rlast;
  assign axi_chip2chip_0_m_axi_RRESP = m_axi_rresp[1:0];
  assign axi_chip2chip_0_m_axi_RVALID = m_axi_rvalid;
  assign axi_chip2chip_0_m_axi_WREADY = m_axi_wready;
  assign channel_up = aurora_64b66b_0_channel_up;
  assign clk_wiz_0_clk_156_25 = init_clk;
  assign clk_wiz_0_clk_200 = m_aclk;
  assign gt_pll_lock = aurora_64b66b_0_gt_pll_lock;
  assign lane0[0] = xlslice_1_Dout;
  assign lane1[0] = xlslice_0_Dout;
  assign m_axi_araddr[39:0] = axi_chip2chip_0_m_axi_ARADDR;
  assign m_axi_arburst[1:0] = axi_chip2chip_0_m_axi_ARBURST;
  assign m_axi_arlen[7:0] = axi_chip2chip_0_m_axi_ARLEN;
  assign m_axi_arsize[2:0] = axi_chip2chip_0_m_axi_ARSIZE;
  assign m_axi_arvalid = axi_chip2chip_0_m_axi_ARVALID;
  assign m_axi_awaddr[39:0] = axi_chip2chip_0_m_axi_AWADDR;
  assign m_axi_awburst[1:0] = axi_chip2chip_0_m_axi_AWBURST;
  assign m_axi_awlen[7:0] = axi_chip2chip_0_m_axi_AWLEN;
  assign m_axi_awsize[2:0] = axi_chip2chip_0_m_axi_AWSIZE;
  assign m_axi_awvalid = axi_chip2chip_0_m_axi_AWVALID;
  assign m_axi_bready = axi_chip2chip_0_m_axi_BREADY;
  assign m_axi_rready = axi_chip2chip_0_m_axi_RREADY;
  assign m_axi_wdata[63:0] = axi_chip2chip_0_m_axi_WDATA;
  assign m_axi_wlast = axi_chip2chip_0_m_axi_WLAST;
  assign m_axi_wstrb[7:0] = axi_chip2chip_0_m_axi_WSTRB;
  assign m_axi_wvalid = axi_chip2chip_0_m_axi_WVALID;
  assign proc_sys_reset_0_peripheral_aresetn = m_aresetn;
  assign vio_0_probe_out1 = aurora_pma_init_in;
  vu13p_aurora_64b66b_0_0 aurora_64b66b_0
       (.channel_up(aurora_64b66b_0_channel_up),
        .gt_pll_lock(aurora_64b66b_0_gt_pll_lock),
        .gt_refclk1_n(GT_DIFF_REFCLK1_0_1_CLK_N),
        .gt_refclk1_p(GT_DIFF_REFCLK1_0_1_CLK_P),
        .gt_rxcdrovrden_in(1'b0),
        .init_clk(clk_wiz_0_clk_156_25),
        .lane_up(aurora_64b66b_0_lane_up),
        .loopback({1'b0,1'b0,1'b0}),
        .m_axi_rx_tdata(aurora_64b66b_0_USER_DATA_M_AXIS_RX_TDATA),
        .m_axi_rx_tvalid(aurora_64b66b_0_USER_DATA_M_AXIS_RX_TVALID),
        .mmcm_not_locked_out(aurora_64b66b_0_mmcm_not_locked_out),
        .pma_init(axi_chip2chip_0_aurora_pma_init_out),
        .power_down(1'b0),
        .reset_pb(axi_chip2chip_0_aurora_reset_pb),
        .rxn(GT_SERIAL_RX_0_1_RXN),
        .rxp(GT_SERIAL_RX_0_1_RXP),
        .s_axi_tx_tdata(axi_chip2chip_0_AXIS_TX_TDATA),
        .s_axi_tx_tready(axi_chip2chip_0_AXIS_TX_TREADY),
        .s_axi_tx_tvalid(axi_chip2chip_0_AXIS_TX_TVALID),
        .txn(aurora_64b66b_0_GT_SERIAL_TX_TXN),
        .txp(aurora_64b66b_0_GT_SERIAL_TX_TXP),
        .user_clk_out(aurora_64b66b_0_user_clk_out));
  vu13p_axi_chip2chip_0_0 axi_chip2chip_0
       (.aurora_init_clk(clk_wiz_0_clk_156_25),
        .aurora_mmcm_not_locked(aurora_64b66b_0_mmcm_not_locked_out),
        .aurora_pma_init_in(vio_0_probe_out1),
        .aurora_pma_init_out(axi_chip2chip_0_aurora_pma_init_out),
        .aurora_reset_pb(axi_chip2chip_0_aurora_reset_pb),
        .axi_c2c_aurora_channel_up(aurora_64b66b_0_channel_up),
        .axi_c2c_aurora_rx_tdata(aurora_64b66b_0_USER_DATA_M_AXIS_RX_TDATA),
        .axi_c2c_aurora_rx_tvalid(aurora_64b66b_0_USER_DATA_M_AXIS_RX_TVALID),
        .axi_c2c_aurora_tx_tdata(axi_chip2chip_0_AXIS_TX_TDATA),
        .axi_c2c_aurora_tx_tready(axi_chip2chip_0_AXIS_TX_TREADY),
        .axi_c2c_aurora_tx_tvalid(axi_chip2chip_0_AXIS_TX_TVALID),
        .axi_c2c_link_status_out(axi_chip2chip_0_axi_c2c_link_status_out),
        .axi_c2c_phy_clk(aurora_64b66b_0_user_clk_out),
        .axi_c2c_s2m_intr_in({1'b0,1'b0,1'b0,1'b0}),
        .m_aclk(clk_wiz_0_clk_200),
        .m_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .m_axi_araddr(axi_chip2chip_0_m_axi_ARADDR),
        .m_axi_arburst(axi_chip2chip_0_m_axi_ARBURST),
        .m_axi_arlen(axi_chip2chip_0_m_axi_ARLEN),
        .m_axi_arready(axi_chip2chip_0_m_axi_ARREADY),
        .m_axi_arsize(axi_chip2chip_0_m_axi_ARSIZE),
        .m_axi_arvalid(axi_chip2chip_0_m_axi_ARVALID),
        .m_axi_awaddr(axi_chip2chip_0_m_axi_AWADDR),
        .m_axi_awburst(axi_chip2chip_0_m_axi_AWBURST),
        .m_axi_awlen(axi_chip2chip_0_m_axi_AWLEN),
        .m_axi_awready(axi_chip2chip_0_m_axi_AWREADY),
        .m_axi_awsize(axi_chip2chip_0_m_axi_AWSIZE),
        .m_axi_awvalid(axi_chip2chip_0_m_axi_AWVALID),
        .m_axi_bready(axi_chip2chip_0_m_axi_BREADY),
        .m_axi_bresp(axi_chip2chip_0_m_axi_BRESP),
        .m_axi_bvalid(axi_chip2chip_0_m_axi_BVALID),
        .m_axi_rdata(axi_chip2chip_0_m_axi_RDATA),
        .m_axi_rlast(axi_chip2chip_0_m_axi_RLAST),
        .m_axi_rready(axi_chip2chip_0_m_axi_RREADY),
        .m_axi_rresp(axi_chip2chip_0_m_axi_RRESP),
        .m_axi_rvalid(axi_chip2chip_0_m_axi_RVALID),
        .m_axi_wdata(axi_chip2chip_0_m_axi_WDATA),
        .m_axi_wlast(axi_chip2chip_0_m_axi_WLAST),
        .m_axi_wready(axi_chip2chip_0_m_axi_WREADY),
        .m_axi_wstrb(axi_chip2chip_0_m_axi_WSTRB),
        .m_axi_wvalid(axi_chip2chip_0_m_axi_WVALID));
  vu13p_xlslice_0_0 xlslice_0
       (.Din({aurora_64b66b_0_lane_up[0],aurora_64b66b_0_lane_up[1]}),
        .Dout(xlslice_0_Dout));
  vu13p_xlslice_1_0 xlslice_1
       (.Din({aurora_64b66b_0_lane_up[0],aurora_64b66b_0_lane_up[1]}),
        .Dout(xlslice_1_Dout));
endmodule

(* CORE_GENERATION_INFO = "vu13p,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=vu13p,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=12,numReposBlks=10,numNonXlnxBlks=0,numHierBlks=2,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "vu13p.hwdef" *) 
module vu13p
   (aurora_refclk_clk_n,
    aurora_refclk_clk_p,
    aurora_rx_slave_rxn,
    aurora_rx_slave_rxp,
    aurora_tx_slave_txn,
    aurora_tx_slave_txp,
    sysclk_clk_n,
    sysclk_clk_p);
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 aurora_refclk CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aurora_refclk, CAN_DEBUG false, FREQ_HZ 156250000" *) input aurora_refclk_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 aurora_refclk CLK_P" *) input aurora_refclk_clk_p;
  (* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX:1.0 aurora_rx_slave RXN" *) input [0:1]aurora_rx_slave_rxn;
  (* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX:1.0 aurora_rx_slave RXP" *) input [0:1]aurora_rx_slave_rxp;
  (* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX:1.0 aurora_tx_slave TXN" *) output [0:1]aurora_tx_slave_txn;
  (* X_INTERFACE_INFO = "xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX:1.0 aurora_tx_slave TXP" *) output [0:1]aurora_tx_slave_txp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 sysclk CLK_N" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME sysclk, CAN_DEBUG false, FREQ_HZ 100000000" *) input sysclk_clk_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_clock:1.0 sysclk CLK_P" *) input sysclk_clk_p;

  wire CLK_IN1_D_0_1_CLK_N;
  wire CLK_IN1_D_0_1_CLK_P;
  wire GT_DIFF_REFCLK1_0_1_CLK_N;
  wire GT_DIFF_REFCLK1_0_1_CLK_P;
  wire [0:1]GT_SERIAL_RX_0_1_RXN;
  wire [0:1]GT_SERIAL_RX_0_1_RXP;
  wire [0:1]aurora_64b66b_0_GT_SERIAL_TX_TXN;
  wire [0:1]aurora_64b66b_0_GT_SERIAL_TX_TXP;
  wire aurora_64b66b_0_channel_up;
  wire aurora_64b66b_0_gt_pll_lock;
  wire axi_chip2chip_0_axi_c2c_link_status_out;
  wire [39:0]axi_chip2chip_0_m_axi_ARADDR;
  wire [1:0]axi_chip2chip_0_m_axi_ARBURST;
  wire [7:0]axi_chip2chip_0_m_axi_ARLEN;
  wire axi_chip2chip_0_m_axi_ARREADY;
  wire [2:0]axi_chip2chip_0_m_axi_ARSIZE;
  wire axi_chip2chip_0_m_axi_ARVALID;
  wire [39:0]axi_chip2chip_0_m_axi_AWADDR;
  wire [1:0]axi_chip2chip_0_m_axi_AWBURST;
  wire [7:0]axi_chip2chip_0_m_axi_AWLEN;
  wire axi_chip2chip_0_m_axi_AWREADY;
  wire [2:0]axi_chip2chip_0_m_axi_AWSIZE;
  wire axi_chip2chip_0_m_axi_AWVALID;
  wire axi_chip2chip_0_m_axi_BREADY;
  wire [1:0]axi_chip2chip_0_m_axi_BRESP;
  wire axi_chip2chip_0_m_axi_BVALID;
  wire [63:0]axi_chip2chip_0_m_axi_RDATA;
  wire axi_chip2chip_0_m_axi_RLAST;
  wire axi_chip2chip_0_m_axi_RREADY;
  wire [1:0]axi_chip2chip_0_m_axi_RRESP;
  wire axi_chip2chip_0_m_axi_RVALID;
  wire [63:0]axi_chip2chip_0_m_axi_WDATA;
  wire axi_chip2chip_0_m_axi_WLAST;
  wire axi_chip2chip_0_m_axi_WREADY;
  wire [7:0]axi_chip2chip_0_m_axi_WSTRB;
  wire axi_chip2chip_0_m_axi_WVALID;
  wire [0:0]c2c_Dout;
  wire [0:0]c2c_Dout1;
  wire clk_wiz_0_clk_156_25;
  wire clk_wiz_0_clk_200;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire [13:0]smartconnect_0_M00_AXI_ARADDR;
  wire [1:0]smartconnect_0_M00_AXI_ARBURST;
  wire [3:0]smartconnect_0_M00_AXI_ARCACHE;
  wire [7:0]smartconnect_0_M00_AXI_ARLEN;
  wire [0:0]smartconnect_0_M00_AXI_ARLOCK;
  wire [2:0]smartconnect_0_M00_AXI_ARPROT;
  wire smartconnect_0_M00_AXI_ARREADY;
  wire [2:0]smartconnect_0_M00_AXI_ARSIZE;
  wire smartconnect_0_M00_AXI_ARVALID;
  wire [13:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [7:0]smartconnect_0_M00_AXI_AWLEN;
  wire [0:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [63:0]smartconnect_0_M00_AXI_RDATA;
  wire smartconnect_0_M00_AXI_RLAST;
  wire smartconnect_0_M00_AXI_RREADY;
  wire [1:0]smartconnect_0_M00_AXI_RRESP;
  wire smartconnect_0_M00_AXI_RVALID;
  wire [63:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [7:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [0:0]vio_0_probe_out0;
  wire [0:0]vio_0_probe_out1;

  assign CLK_IN1_D_0_1_CLK_N = sysclk_clk_n;
  assign CLK_IN1_D_0_1_CLK_P = sysclk_clk_p;
  assign GT_DIFF_REFCLK1_0_1_CLK_N = aurora_refclk_clk_n;
  assign GT_DIFF_REFCLK1_0_1_CLK_P = aurora_refclk_clk_p;
  assign GT_SERIAL_RX_0_1_RXN = aurora_rx_slave_rxn[0:1];
  assign GT_SERIAL_RX_0_1_RXP = aurora_rx_slave_rxp[0:1];
  assign aurora_tx_slave_txn[0:1] = aurora_64b66b_0_GT_SERIAL_TX_TXN;
  assign aurora_tx_slave_txp[0:1] = aurora_64b66b_0_GT_SERIAL_TX_TXP;
  bram_imp_1VGN97F bram
       (.S_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .S_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .S_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .S_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .S_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .S_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .S_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .S_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .S_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .S_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .S_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .S_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .S_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .S_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .S_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .S_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .S_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .S_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .S_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .S_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .S_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .S_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .S_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .S_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .S_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .S_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .S_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .S_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .S_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .S_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .S_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .s_axi_aclk(clk_wiz_0_clk_200),
        .s_axi_aresetn(proc_sys_reset_0_peripheral_aresetn));
  c2c_imp_1YRO02P c2c
       (.aurora_pma_init_in(vio_0_probe_out1),
        .aurora_refclk_clk_n(GT_DIFF_REFCLK1_0_1_CLK_N),
        .aurora_refclk_clk_p(GT_DIFF_REFCLK1_0_1_CLK_P),
        .aurora_rx_slave_rxn(GT_SERIAL_RX_0_1_RXN),
        .aurora_rx_slave_rxp(GT_SERIAL_RX_0_1_RXP),
        .aurora_tx_slave_txn(aurora_64b66b_0_GT_SERIAL_TX_TXN),
        .aurora_tx_slave_txp(aurora_64b66b_0_GT_SERIAL_TX_TXP),
        .axi_c2c_link_status_out(axi_chip2chip_0_axi_c2c_link_status_out),
        .channel_up(aurora_64b66b_0_channel_up),
        .gt_pll_lock(aurora_64b66b_0_gt_pll_lock),
        .init_clk(clk_wiz_0_clk_156_25),
        .lane0(c2c_Dout),
        .lane1(c2c_Dout1),
        .m_aclk(clk_wiz_0_clk_200),
        .m_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .m_axi_araddr(axi_chip2chip_0_m_axi_ARADDR),
        .m_axi_arburst(axi_chip2chip_0_m_axi_ARBURST),
        .m_axi_arlen(axi_chip2chip_0_m_axi_ARLEN),
        .m_axi_arready(axi_chip2chip_0_m_axi_ARREADY),
        .m_axi_arsize(axi_chip2chip_0_m_axi_ARSIZE),
        .m_axi_arvalid(axi_chip2chip_0_m_axi_ARVALID),
        .m_axi_awaddr(axi_chip2chip_0_m_axi_AWADDR),
        .m_axi_awburst(axi_chip2chip_0_m_axi_AWBURST),
        .m_axi_awlen(axi_chip2chip_0_m_axi_AWLEN),
        .m_axi_awready(axi_chip2chip_0_m_axi_AWREADY),
        .m_axi_awsize(axi_chip2chip_0_m_axi_AWSIZE),
        .m_axi_awvalid(axi_chip2chip_0_m_axi_AWVALID),
        .m_axi_bready(axi_chip2chip_0_m_axi_BREADY),
        .m_axi_bresp(axi_chip2chip_0_m_axi_BRESP),
        .m_axi_bvalid(axi_chip2chip_0_m_axi_BVALID),
        .m_axi_rdata(axi_chip2chip_0_m_axi_RDATA),
        .m_axi_rlast(axi_chip2chip_0_m_axi_RLAST),
        .m_axi_rready(axi_chip2chip_0_m_axi_RREADY),
        .m_axi_rresp(axi_chip2chip_0_m_axi_RRESP),
        .m_axi_rvalid(axi_chip2chip_0_m_axi_RVALID),
        .m_axi_wdata(axi_chip2chip_0_m_axi_WDATA),
        .m_axi_wlast(axi_chip2chip_0_m_axi_WLAST),
        .m_axi_wready(axi_chip2chip_0_m_axi_WREADY),
        .m_axi_wstrb(axi_chip2chip_0_m_axi_WSTRB),
        .m_axi_wvalid(axi_chip2chip_0_m_axi_WVALID));
  vu13p_clk_wiz_0_0 clk_wiz_0
       (.clk_200(clk_wiz_0_clk_200),
        .clk_75(clk_wiz_0_clk_156_25),
        .clk_in1_n(CLK_IN1_D_0_1_CLK_N),
        .clk_in1_p(CLK_IN1_D_0_1_CLK_P));
  vu13p_proc_sys_reset_0_0 proc_sys_reset_0
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(vio_0_probe_out0),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(clk_wiz_0_clk_200));
  vu13p_smartconnect_0_0 smartconnect_0
       (.M00_AXI_araddr(smartconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arburst(smartconnect_0_M00_AXI_ARBURST),
        .M00_AXI_arcache(smartconnect_0_M00_AXI_ARCACHE),
        .M00_AXI_arlen(smartconnect_0_M00_AXI_ARLEN),
        .M00_AXI_arlock(smartconnect_0_M00_AXI_ARLOCK),
        .M00_AXI_arprot(smartconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arready(smartconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arsize(smartconnect_0_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(smartconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(smartconnect_0_M00_AXI_RDATA),
        .M00_AXI_rlast(smartconnect_0_M00_AXI_RLAST),
        .M00_AXI_rready(smartconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(smartconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(smartconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .S00_AXI_araddr(axi_chip2chip_0_m_axi_ARADDR),
        .S00_AXI_arburst(axi_chip2chip_0_m_axi_ARBURST),
        .S00_AXI_arcache({1'b0,1'b0,1'b1,1'b1}),
        .S00_AXI_arlen(axi_chip2chip_0_m_axi_ARLEN),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot({1'b0,1'b0,1'b0}),
        .S00_AXI_arqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_arready(axi_chip2chip_0_m_axi_ARREADY),
        .S00_AXI_arsize(axi_chip2chip_0_m_axi_ARSIZE),
        .S00_AXI_arvalid(axi_chip2chip_0_m_axi_ARVALID),
        .S00_AXI_awaddr(axi_chip2chip_0_m_axi_AWADDR),
        .S00_AXI_awburst(axi_chip2chip_0_m_axi_AWBURST),
        .S00_AXI_awcache({1'b0,1'b0,1'b1,1'b1}),
        .S00_AXI_awlen(axi_chip2chip_0_m_axi_AWLEN),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot({1'b0,1'b0,1'b0}),
        .S00_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_awready(axi_chip2chip_0_m_axi_AWREADY),
        .S00_AXI_awsize(axi_chip2chip_0_m_axi_AWSIZE),
        .S00_AXI_awvalid(axi_chip2chip_0_m_axi_AWVALID),
        .S00_AXI_bready(axi_chip2chip_0_m_axi_BREADY),
        .S00_AXI_bresp(axi_chip2chip_0_m_axi_BRESP),
        .S00_AXI_bvalid(axi_chip2chip_0_m_axi_BVALID),
        .S00_AXI_rdata(axi_chip2chip_0_m_axi_RDATA),
        .S00_AXI_rlast(axi_chip2chip_0_m_axi_RLAST),
        .S00_AXI_rready(axi_chip2chip_0_m_axi_RREADY),
        .S00_AXI_rresp(axi_chip2chip_0_m_axi_RRESP),
        .S00_AXI_rvalid(axi_chip2chip_0_m_axi_RVALID),
        .S00_AXI_wdata(axi_chip2chip_0_m_axi_WDATA),
        .S00_AXI_wlast(axi_chip2chip_0_m_axi_WLAST),
        .S00_AXI_wready(axi_chip2chip_0_m_axi_WREADY),
        .S00_AXI_wstrb(axi_chip2chip_0_m_axi_WSTRB),
        .S00_AXI_wvalid(axi_chip2chip_0_m_axi_WVALID),
        .aclk(clk_wiz_0_clk_200),
        .aresetn(proc_sys_reset_0_peripheral_aresetn));
  vu13p_vio_0_0 vio_0
       (.clk(clk_wiz_0_clk_200),
        .probe_in0(aurora_64b66b_0_gt_pll_lock),
        .probe_in1(c2c_Dout1),
        .probe_in2(c2c_Dout),
        .probe_in3(aurora_64b66b_0_channel_up),
        .probe_in4(axi_chip2chip_0_axi_c2c_link_status_out),
        .probe_out0(vio_0_probe_out0),
        .probe_out1(vio_0_probe_out1));
endmodule
