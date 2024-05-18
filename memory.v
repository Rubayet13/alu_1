module memory (
	input wire clk,
	input wire wr_enb,
	input wire rd_enb,
	input wire [1:0] addr,
	input wire [3:0] wr_data,
	output reg [3:0] rd_data,
	output reg [3:0] value_a,
	output reg [3:0] value_b,
	output reg [3:0] opcode
);  
	reg [3:0] mem [3:0];
	always@(posedge clk) begin 
		if (wr_enb)begin 
			mem[addr] <= wr_data;
		end
		else begin 
			mem[addr] <= mem[addr];
		end
	end 

	always@(*) begin 
		if (rd_enb) begin 
			rd_data = mem [addr];
		end
		else begin 
			rd_data = 4'b0000;
		end
	end 
	always@(*) begin 	
		value_a = mem [1];
		value_b = mem [2];
		opcode  = mem [3];
	end
endmodule 
  