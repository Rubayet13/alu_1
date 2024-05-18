module memory_controller (
	input wire clk,
	input wire rst,
	input wire cs,
	input wire wr_enb,
	input wire rd_enb,
	output reg write_enb,
	output reg read_enb
);
	reg [2:0] pstate , nstate;

	parameter	IDLE			= 3'b000,
		  		WRITE_ACTIVE	= 3'b001,
				WRITE			= 3'b010,
				READ			= 3'b011

	;
	always@(*)begin:NSLOL
		begin:NSL
			case(pstate)
				IDLE	:	begin 
								nstate = (cs && !wr_enb && !rd_enb)? WRITE_ACTIVE : IDLE;
							end
										
		WRITE_ACTIVE	:	begin 
								nstate = ( cs && wr_enb)? WRITE : (cs && rd_enb)? READ : IDLE; 
							end		
		 	
				WRITE	: 	begin 
								nstate = IDLE;
							end
				READ	:
							begin 								
								nstate = IDLE;
							end
	
				default	:   nstate = 2'bxx;
			endcase 
		end:NSL

		begin:OL
			case(pstate)
				IDLE	:	begin 
								write_enb	= 0;
								read_enb	= 0;
							end
		WRITE_ACTIVE	:	begin 
								write_enb	= 0;
								read_enb	= 0;
							end		
				WRITE	:	begin 
							 	write_enb	= 1;
								read_enb	= 0;
							end
				READ	:	begin 
							 	write_enb	= 0;
								read_enb	= 1;
							end
				default	:	begin 
							 	write_enb	= 1'bx;
								read_enb	= 1'bx;
							end
			endcase 
		end:OL
	end:NSLOL
	
	always@(posedge clk or negedge rst)begin:PSR 
		if(!rst)begin 
			pstate <= IDLE; 
		end
		else begin 
			pstate <= nstate; 
		end
	end:PSR 

endmodule 