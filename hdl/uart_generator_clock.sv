module uart_generator_clock 
#(
  parameter SYS_FREQ  = 10000000,
  parameter BAUD_RATE = 9600,
  parameter SAMPLE    = 16
  ) (
  input         clk       , // Clock
  input         reset_n   , // Asynchronous reset active low
  output logic  clock     , // clk
  output logic  sample_clk  // sample_clk
);
  parameter CLOCK     = SYS_FREQ/(BAUD_RATE*2);
  // parameter CLOCK     = SYS_FREQ/BAUD_RATE;
  parameter BAUD_DVSR = SYS_FREQ/(SAMPLE*BAUD_RATE);
  
  logic [$clog2(CLOCK    ) - 1 : 0] count_clk;
  logic [$clog2(BAUD_DVSR) - 1 : 0] count_sample_clk;

  always_ff @(posedge clk or negedge reset_n) begin : proc_count_clk
    if(~reset_n) begin
      count_clk <= 0;
    end else begin
      count_clk <= (count_clk == (CLOCK - 1) ? 0 : (count_clk + 1));;
    end
  end

  always_ff @(posedge clk or negedge reset_n) begin : proc_count_sample_clk
    if(~reset_n) begin
      count_sample_clk <= 0;
    end else begin
      count_sample_clk <= (count_sample_clk == (BAUD_DVSR - 1) ? 0 : (count_sample_clk + 1));
    end
  end

  always_ff @(posedge clk or negedge reset_n) begin : proc_clock
    if(~reset_n) begin
      clock <= 0;
    end 
    else if (count_clk == (CLOCK - 1)) begin
      clock <= ~clock;
    end
    else begin
      clock = clock;
    end
  end

  always_ff @(posedge clk or negedge reset_n) begin : proc_sample_clk
    if(~reset_n) begin
      sample_clk <= 0;
    end 
    else if (count_sample_clk == (BAUD_DVSR - 1)) begin
      sample_clk <= ~sample_clk;
    end
    else begin
      sample_clk = sample_clk;
    end
  end

endmodule : uart_generator_clock
