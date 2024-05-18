module mux2(	
	input wire [3:0] a, 
	input wire [3:0] b,
	input wire sel, 
	output reg [3:0] y
);

	always@(a,b,sel)begin
		if(sel==1)begin 
			y = b; 
		end 
		else begin 
			y = a; 
		end 
	end
endmodule 