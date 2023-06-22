module datapath 
#(
	parameter WIDTH_TIK   = 16      ,
	parameter WIDTH_MS    = 14      ,
	parameter WIDTH_SPEED = 14      ,
	parameter SYS_FREQ    = 10000000
)
(
	input                        clk        ,    
	input                        reset_n    ,
	input                        init       ,
	input                        count      ,
	input                        cal        ,
	input                        up         ,
	input                        down       ,
	input                        en         ,
	input                        dis        ,
	// output reg [1:0]             num_veh    ,
	output     [WIDTH_SPEED-1:0] speed      ,
	output                       done       ,
	output reg                   en_barrier 
);

reg [WIDTH_TIK-1:0] time_tik;	// depending on 
reg [WIDTH_MS-1:0]  time_ms;


/**============================================
 * 	          Update value for time_tik
 *=============================================*/
always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		time_tik <= 0;
	end 
	else if (time_tik == (SYS_FREQ/1000 - 1)) begin // 50M/1000 - 1
		time_tik <= 0;
	end
	else begin
		if (init) begin
			time_tik <= 0;
		end
		else if (count) begin
			time_tik <= time_tik + 1;
		end
	end
end


/**============================================
 * 	          Update value for time_ms
 *=============================================*/
always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		time_ms <= 0;
	end else begin
		if (init) begin
			time_ms <= 0;
		end
		else if (time_tik == (SYS_FREQ/1000 - 1)) begin
			time_ms <= time_ms + 1;
		end
	end
end


/**============================================
 * 	     Instance div, calculate speed
 *=============================================*/
div 
#( 
	.N(WIDTH_SPEED)
) div_DUT (
	.clk     (clk                ),
	.reset_n (reset_n            ),
	.dividend(14'b11100001000000 ),	// 14400
	.divisor (time_ms            ),
	.sen1    (init               ),
	.sen2    (cal                ),
	.Q       (speed              ),
	.done    (done               )
);


/**============================================
 * 	          Update value for en_barrier
 *=============================================*/
always @(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		en_barrier <= 0;
	end else begin
		if (up | en) begin
			en_barrier <= 1;
		end
		else if (dis | down) begin
			en_barrier <= 0;
		end
	end
end


/**============================================
 * 	          Update value for num_veh
 *=============================================*/
// always @(posedge clk or negedge reset_n) begin
// 	if(~reset_n) begin
// 		num_veh <= 0;
// 	end else begin
// 		case ({up, down})
// 			2'b10: begin 
// 				num_veh <= num_veh + 1;
// 			end
// 			2'b01: begin 
// 				if (num_veh == 0) begin
// 					num_veh <= 0;
// 				end
// 				else begin
// 					num_veh <= num_veh - 1 ;
// 				end
// 			end
// 			default : num_veh <= num_veh;
// 		endcase
// 	end
// end

endmodule
