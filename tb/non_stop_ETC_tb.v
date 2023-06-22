`timescale 1ns/1ns

module non_stop_ETC_tb #(
	parameter WIDTH_TIK   = 16,
	parameter WIDTH_MS    =  9,
	parameter WIDTH_SPEED = 14
)();

reg                    clk        ;
reg                    reset_n    ;
reg                    sensor1    ;
reg                    sensor2    ;
reg                    sensor3    ;
reg     [1:0]          valid_Epass;
reg                    enable     ;
wire [WIDTH_SPEED-1:0] speed      ;
wire                   done       ;
wire                   barrier    ;

top DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.sensor1    (sensor1    ),
	.sensor2    (sensor2    ),
	.sensor3    (sensor3    ),
	.valid_Epass(valid_Epass),
	.enable     (enable     ),
	.speed      (speed      ),
	.done       (done       ),
	.barrier    (barrier    )
);

always #5 clk = ~clk;

		initial begin
			clk = 0;
			reset_n = 0;
			sensor1 =0;
			sensor2 =0;
			sensor3 = 0;
			valid_Epass = 0;
			enable = 0;
			@(negedge clk);
			@(negedge clk);
			@(negedge clk);
			reset_n = 1;
			#1000;
			sensor1 = 1;
			#150;	// Thoi gian oto di qua 1 sensor
			sensor1 = 0;
			// #300
			// sensor1 = 1;
			#1000;
			sensor2 = 1;
			valid_Epass = 2'b10;
			#150;
			// sensor1 = 0;			
			// #15
			sensor2 = 0;
			#1500;
			// sensor2 = 1;
			sensor3 =1;
			#150;
			sensor3 =0;
			#1500;
		end
endmodule

