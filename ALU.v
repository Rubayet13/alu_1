module ALU( 
	input wire [3:0] value_a,
	input wire [3:0] value_b, 
	input wire [3:0] opcode,
	output reg [3:0] result
);	
	//reg [3:0] operation;
	parameter	no_operation =4'b0000,
				NotA		 =4'b0001,
				NotB		 =4'b0010,
				AorB		 =4'b0011,
				AandB		 =4'b0100,
				AxorB		 =4'b0101
	;

	always@(*)begin 
			case (opcode)  
				no_operation: 	result = 4'b0000;
				NotA		:	result = ~value_a;
				NotB		:	result = ~value_b;	
				AorB		:	result = value_a | value_b;
				AandB		:	result = value_a & value_b;
				AxorB		:	result = value_a ^ value_b;
				default		:	result = 4'bxxxx;
			endcase 
	end
endmodule 