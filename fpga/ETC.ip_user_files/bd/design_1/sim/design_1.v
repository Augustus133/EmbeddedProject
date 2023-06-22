//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Sat Jun 25 10:46:04 2022
//Host        : quangnd12 running 64-bit Ubuntu 20.04.4 LTS
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,da_clkrst_cnt=1,synth_mode=Global}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (barrier,
    clock,
    enable,
    led1,
    led2,
    led3,
    led4,
    led5,
    led6,
    reset_n,
    sensor1,
    sensor2,
    sensor3,
    serial_data_out,
    sys_clock,
    valid_Epass);
  output barrier;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLOCK, CLK_DOMAIN design_1_top_0_0_clock, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) output clock;
  input enable;
  output led1;
  output led2;
  output led3;
  output led4;
  output led5;
  output led6;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_n;
  input sensor1;
  input sensor2;
  input sensor3;
  output serial_data_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLOCK, CLK_DOMAIN design_1_clk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input sys_clock;
  input [1:0]valid_Epass;

  wire clk_in1_0_1;
  wire clk_wiz_0_clk_out1;
  wire enable_1;
  wire reset_n_1;
  wire sensor1_1;
  wire sensor2_1;
  wire sensor3_1;
  wire top_0_barrier;
  wire top_0_clock;
  wire top_0_led1;
  wire top_0_led2;
  wire top_0_led3;
  wire top_0_led4;
  wire top_0_led5;
  wire top_0_led6;
  wire top_0_serial_data_out;
  wire [1:0]valid_Epass_1;

  assign barrier = top_0_barrier;
  assign clk_in1_0_1 = sys_clock;
  assign clock = top_0_clock;
  assign enable_1 = enable;
  assign led1 = top_0_led1;
  assign led2 = top_0_led2;
  assign led3 = top_0_led3;
  assign led4 = top_0_led4;
  assign led5 = top_0_led5;
  assign led6 = top_0_led6;
  assign reset_n_1 = reset_n;
  assign sensor1_1 = sensor1;
  assign sensor2_1 = sensor2;
  assign sensor3_1 = sensor3;
  assign serial_data_out = top_0_serial_data_out;
  assign valid_Epass_1 = valid_Epass[1:0];
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_in1_0_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .resetn(reset_n_1));
  design_1_top_0_0 top_0
       (.barrier(top_0_barrier),
        .clk(clk_wiz_0_clk_out1),
        .clock(top_0_clock),
        .enable(enable_1),
        .led1(top_0_led1),
        .led2(top_0_led2),
        .led3(top_0_led3),
        .led4(top_0_led4),
        .led5(top_0_led5),
        .led6(top_0_led6),
        .reset_n(reset_n_1),
        .sensor1(sensor1_1),
        .sensor2(sensor2_1),
        .sensor3(sensor3_1),
        .serial_data_out(top_0_serial_data_out),
        .valid_Epass(valid_Epass_1));
endmodule
