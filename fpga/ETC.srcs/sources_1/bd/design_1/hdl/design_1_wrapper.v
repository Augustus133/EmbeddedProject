//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Fri Jun 16 08:19:01 2023
//Host        : LAPTOP-6FJG57FJ running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
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
  output clock;
  input enable;
  output led1;
  output led2;
  output led3;
  output led4;
  output led5;
  output led6;
  input reset_n;
  input sensor1;
  input sensor2;
  input sensor3;
  output serial_data_out;
  input sys_clock;
  input [1:0]valid_Epass;

  wire barrier;
  wire clock;
  wire enable;
  wire led1;
  wire led2;
  wire led3;
  wire led4;
  wire led5;
  wire led6;
  wire reset_n;
  wire sensor1;
  wire sensor2;
  wire sensor3;
  wire serial_data_out;
  wire sys_clock;
  wire [1:0]valid_Epass;

  design_1 design_1_i
       (.barrier(barrier),
        .clock(clock),
        .enable(enable),
        .led1(led1),
        .led2(led2),
        .led3(led3),
        .led4(led4),
        .led5(led5),
        .led6(led6),
        .reset_n(reset_n),
        .sensor1(sensor1),
        .sensor2(sensor2),
        .sensor3(sensor3),
        .serial_data_out(serial_data_out),
        .sys_clock(sys_clock),
        .valid_Epass(valid_Epass));
endmodule
