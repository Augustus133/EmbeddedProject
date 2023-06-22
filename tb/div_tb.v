`timescale 1ns/1ns

module div_tb #(parameter N   = 20,
                parameter DEC = 4 )();

    
reg          clk     ;
reg          reset_n ;
reg  [N-1:0] dividend;
reg  [N-1:0] divisor ;
reg          sen1    ;
reg          sen2    ;
wire [N-1:0] Q       ;
wire         done    ;

div  
#(
        .N  (N),
        .DEC(DEC)
) DUT (
        .clk     (clk     ),
        .reset_n (reset_n ),
        .dividend(dividend),
        .divisor (divisor ),
        .sen1    (sen1    ),
        .sen2    (sen2    ),
        .Q       (Q       ),
        .done    (done    )
);

    always #5 clk = ~clk;


    initial begin
        clk = 0;
        reset_n = 0;
        dividend = 14400 ;
        divisor = 1000;
        sen1 = 0;
        sen2 = 0;

        @(negedge clk);
        reset_n = 1;
        sen1 = 1;
        @(negedge clk);
        sen2 = 1;

        wait(done);
        sen1 = 0;
        sen2 = 0;
        @(negedge clk);
        #1000

        @(negedge clk);
        divisor = 480;
        dividend = 4000*3.6;
        sen1 = 1;
        @(negedge clk);
        sen2 = 1;
        @(negedge clk);

        wait(done);
        //#(50*N);
        sen1 = 0;
        sen2 = 0;   
        #10000; 
        // $stop;
    end
endmodule


