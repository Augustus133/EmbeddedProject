`timescale 1ns/1ns

module top_tb #(
	parameter WIDTH_TIK   = 16,
	parameter WIDTH_MS    =  9,
	parameter WIDTH_SPEED = 14
)();

reg                    clk           ;
reg                    reset_n       ;
reg                    sensor1       ;
reg                    sensor2       ;
reg                    sensor3       ;
reg     [1:0]          valid_Epass   ;
reg                    enable        ;
// wire [WIDTH_SPEED-1:0] speed      ;
// wire                   done       ;
wire                   barrier       ;
wire                   serial_data_out    ;

top  
#(
	.SYS_FREQ(10000000)
) DUT (
	.clk        (clk        ),
	.reset_n    (reset_n    ),
	.sensor1    (sensor1    ),
	.sensor2    (sensor2    ),
	.sensor3    (sensor3    ),
	.valid_Epass(valid_Epass),
	.enable     (enable     ),
	.barrier    (barrier    ),
	.serial_data_out(serial_data_out)
);

always #50 clk = ~clk;

initial begin
	//testcase1
	//---------------------------------------------------------------------------
	fork// sensor 1
		begin 
			// Luot thu 1
			clk = 0;
			reset_n = 0;
			sensor1 =0;
			enable = 0;
			@(negedge clk);
			reset_n = 1;
			#10000;
			sensor1 = 1;
			#144000000;	// Thoi gian oto di qua 1 sensor
			sensor1 = 0;

			// Luot thu 2
			#1200000000;
			#1000000000;
			sensor1 = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor1 = 0;
		end

		// sensor 2
		begin 
			// Luot thu 1
			sensor2 = 0;
			valid_Epass = 2'b00;
			@(negedge clk);
			#10000;
			#(480000000-50000000); // Thoi gian oto di tu sensor 1 den sensor 2
			sensor2 = 1;
			#50000000;
			valid_Epass = 2'b10;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor2 = 0;
			valid_Epass = 2'b00;

			// Luot thu 2
			#(720000000-50000000);
			#1000000000;
			#300000000
			#240000000;  // Thoi gian oto di tu sensor 1 den sensor 2
			sensor2 = 1;
			#50000000;
			valid_Epass = 2'b10;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor2 = 0;
			valid_Epass = 2'b00;
		end

		// sensor 3
		begin 
			// Luot thu 1
			sensor3 = 0;
			#10000;
			#1200000000; // Thoi gian oto di tu sensor 1 den sensor 3
			sensor3 = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor3 = 0;

			// Luot thu 2
			#1000000000;
			#200000000
			#600000000; // Thoi gian oto di tu sensor 1 den sensor 3
			sensor3 = 1;
			#144000000; // Thoi gian oto di qua 1 sensor
			sensor3 = 0;
		end
	join
	#300000000;
	//-----------------------------------------------------------
	//testcase2
	//-----------------------------------------------------------
	sensor1 = 1;
	#144000000;	// Thoi gian oto di qua 1 sensor
	sensor1 = 0;
	#340000000
	sensor2 = 1;
	#50000000;
	valid_Epass = 2'b11;
	#94000000; // Thoi gian oto di qua 1 sensor
	sensor2 = 0;
	valid_Epass = 2'b00;
	#200000000;
	enable = 1;
	#150000000
	sensor3 = 1;
	#50000000;
	sensor1 = 1;
	#90000000;
	sensor3 = 0;
	enable = 0;
	#60000000;
	sensor1 = 0;
	#320000000;
	sensor2 = 1;
	#50000000;
	valid_Epass = 2'b10;
	#94000000; // Thoi gian oto di qua 1 sensor
	sensor2 = 0;
	valid_Epass = 2'b00;
	#400000000;
	sensor3 = 1;
	#144000000;
	sensor3 = 0;
	#300000000;
	//-----------------------------------------------------------------
	//testcase3
	//-----------------------------------------------------------------
	sensor1 = 1;
	#144000000;	// Thoi gian oto di qua 1 sensor
	sensor1 = 0;
	#340000000
	sensor2 = 1;
	#50000000;
	valid_Epass = 2'b10;
	#94000000; // Thoi gian oto di qua 1 sensor
	sensor2 = 0;
	valid_Epass = 2'b00;
	#200000000;
	#150000000;
	sensor3 = 1;
	#10000000;
	sensor1 = 1;
	#130000000;
	sensor3 = 0;
	#60000000;
	sensor1 = 0;
	#320000000;
	sensor2 = 1;
	#50000000;
	valid_Epass = 2'b10;
	#94000000; // Thoi gian oto di qua 1 sensor
	sensor2 = 0;
	valid_Epass = 2'b00;
	#400000000;
	sensor3 = 1;
	#144000000;
	sensor3 = 0;
	#300000000;
	//----------------------------------------------------------------
	//testcase4
	//----------------------------------------------------------------
		sensor1 = 1;
	#144000000;	// Thoi gian oto di qua 1 sensor
	sensor1 = 0;
	#340000000
	sensor2 = 1;
	#50000000;
	valid_Epass = 2'b10;
	#94000000; // Thoi gian oto di qua 1 sensor
	sensor2 = 0;
	valid_Epass = 2'b00;
	#200000000;
	#150000000;
	sensor3 = 1;
	#10000000;
	sensor1 = 1;
	#130000000;
	sensor3 = 0;
	#60000000;
	sensor1 = 0;
	#320000000;
	sensor2 = 1;
	#50000000;
	valid_Epass = 2'b11;
	#94000000; // Thoi gian oto di qua 1 sensor
	sensor2 = 0;
	valid_Epass = 2'b00;
	#400000000;
	enable = 1;
	#144000000
	sensor3 = 1;
	#144000000;
	sensor3 = 0;
	enable = 0;
	#300000000;

end
endmodule
