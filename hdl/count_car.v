module count_car (
	input            clk        ,    
	input            reset_n    ,  
	input            sensor1    ,
	input            sensor2    ,
	input            sensor3    ,
	output reg [1:0] car1       ,
	output reg [1:0] car2       ,
	output reg [1:0] car3       
);

reg [1:0] next_state_c1, current_state_c1;
reg [1:0] next_state_c2, current_state_c2;
reg [1:0] next_state_c3, current_state_c3;
reg inc1;
reg inc2;
reg inc3;


localparam HOLD       = 2'b00,
           INC        = 2'b01;

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state_c1 <= 0;
	end else begin
		current_state_c1 <= next_state_c1;
	end
end

always @(*) begin
	inc1 = 1'b0;
	next_state_c1 = current_state_c1;
	case (current_state_c1)
		HOLD: begin 
			if (sensor1) begin
				inc1 = 1'b1;
				next_state_c1 = INC;
			end
		end
		INC: begin 
			if (!sensor1) begin
				next_state_c1 = HOLD;
			end
		end
	endcase
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state_c2 <= 0;
	end else begin
		current_state_c2 <= next_state_c2;
	end
end

always @(*) begin
	inc2 = 1'b0;
	next_state_c2 = current_state_c2;
	case (current_state_c2)
		HOLD: begin 
			if (sensor2) begin
				inc2 = 1'b1;
				next_state_c2 = INC;
			end
		end
		INC: begin 
			if (!sensor2) begin
				next_state_c2 = HOLD;
			end
		end
	endcase
end


always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state_c3 <= HOLD;
	end else begin
		current_state_c3 <= next_state_c3;
	end
end

always @(*) begin
	inc3 = 1'b0;
	next_state_c3 = current_state_c3;
	case (current_state_c3)
		HOLD: begin 
			if (sensor3) begin
				inc3 = 1'b1;
				next_state_c3 = INC;
			end
		end
		INC: begin 
			if (!sensor3) begin
				next_state_c3 = HOLD;
			end
		end
	endcase
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		car1 <= 0;
	end else if (inc1) begin
		car1 <= car1+1;
	end
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		car2 <= 0;
	end else if (inc2) begin
		car2 <= car2+1;
	end
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		car3 <= 0;
	end else if (inc3) begin
		car3 <= car3+1;
	end
end

endmodule