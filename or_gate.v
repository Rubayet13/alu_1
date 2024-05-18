module or_gate(
	input wire a, 
	input wire b, 
	output reg y
); 

	always@(a,b) begin 
		y = a | b; 
	end 
endmodule 