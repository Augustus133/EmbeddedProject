module push_data
#(
	parameter WIDTH_SPEED     = 14                ,
	parameter DATA_SIZE       = 8                 
)
(
	input                        clk     ,    // Clock
	input                        reset_n ,  // Asynchronous reset active low
	input                        done    ,
	input      [WIDTH_SPEED-1:0] speed   ,
	output reg                   write   ,
	output reg [DATA_SIZE-1:0]   data    
);

localparam STATE0 = 2'b00,
           STATE1 = 2'b01,
           STATE2 = 2'b10,
           STATE3 = 2'b11;

reg [WIDTH_SPEED-1:0] data_cp;
reg [1:0] current_state, next_state;

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		data_cp <= {(WIDTH_SPEED){1'b0}};
	end else if (done) begin
		data_cp <= speed;
	end
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state <= STATE0;
	end else begin
		current_state <= next_state;
	end
end

always @(*) begin
	case (current_state)
		STATE0: begin
			next_state = STATE0;
			write = 0;
			data = {(DATA_SIZE){1'b0}};
			if (done) begin
				next_state = STATE1;
			end
		end
		STATE1: begin
			next_state = STATE2;
			write = 1;
			data = data_cp[DATA_SIZE-1:0];
		end

		STATE2: begin
			next_state = STATE3;
			write = 0;
		end

		STATE3: begin
			next_state = STATE0;
			write = 1;
			data = data_cp[WIDTH_SPEED-1:DATA_SIZE];
		end
	endcase
end


endmodule 