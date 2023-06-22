module div
#(
	parameter N   = 14,
	parameter DEC =  4
)
(
	input              clk     ,    
	input              reset_n , 
	input      [N-1:0] dividend,
	input      [N-1:0] divisor ,
	input              sen1    ,
	input              sen2    ,
	output reg [N-1:0] Q       ,
	output reg         done    
);

reg [N-1:0] Y;



localparam IDLE  = 3'b000,
		   ENA   = 3'b001,
		   SHIFT = 3'b010,
		   CALC  = 3'b011;
reg [2:0] current_state, next_state;


    reg [N-1:0] quo, quo_next;  // intermediate quotient
    reg [N:0] acc, acc_next;    // accumulator (1 bit wider)
    reg [$clog2(N)-1:0] i;      // iteration counter

    // division algorithm iteration
    always @(*) begin
        if (acc >= {1'b0, Y}) begin
            acc_next = acc - Y;
            {acc_next, quo_next} = {acc_next[N-1:0], quo, 1'b1};
        end else begin
            {acc_next, quo_next} = {acc, quo} << 1;
        end
    end

always @(*) begin
	case (current_state)
		IDLE: begin
			if (sen1) begin
				next_state = ENA;
			end
			else begin
				next_state = current_state;
			end
		end
		
		ENA: begin
			if (sen2) begin
				next_state = CALC;
			end
			else begin
				next_state = current_state;
			end
		end

		CALC: begin																																																																																
			if (i == N-1) begin
				next_state = IDLE;
			end
			else begin 
				next_state = CALC;
			end
		end
	
		default : next_state = current_state;
	endcase
end

always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		current_state <= IDLE;
	end else begin
		current_state <= next_state;
	end
end


always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		i <= 0;
		Q     <= {N{1'b0}};
		done  <= 1'b0;
		Y     <= {N{1'b0}};
	end else begin
		case (current_state)
			IDLE: begin
				done <= 1'b0;
			end
			ENA: begin
				i <= 0;
				{acc, quo} <= {{N{1'b0}}, dividend, 1'b0};
				Y <= divisor;
				done <= 1'b0;
			end
			CALC: begin
				if (i == N-1) begin  // we're done
        		  done <= 1;
        		  Q <= quo_next;
        		end else begin  // next iteration
        		  i <= i + 1;
        		  acc <= acc_next;
        		  quo <= quo_next;
        		end
			end				
		endcase
	end
end

endmodule