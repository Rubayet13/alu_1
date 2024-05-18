module memory_controller_top (
	input wire clk,
	input wire rst,
	input wire cs,
	input wire wr_enb,
	input wire rd_enb,
	input wire [3:0] wr_data,
	input wire [1:0] addr,
	input wire op_start,
	output wire [3:0] rd_data
);
	wire [3:0] wr_data_int;
	wire [1:0] addr_int;
	wire wr_enb_int;
	wire [3:0] value_a_int; 
	wire [3:0] value_b_int; 
	wire [3:0] opcode_int;	 
	wire [3:0] result_int;
	wire write_enb_fsm2or;
	wire read_enb2mem;

	memory_controller fsm (
		.clk 		(clk), 
		.rst 		(rst), 
		.cs			(cs), 
		.wr_enb		(wr_enb), 
		.rd_enb 	(rd_enb), 
		.write_enb 	(write_enb_fsm2or),
		.read_enb 	(read_enb2mem) 
	);
	
	memory mem (
		.clk (clk), 
		.wr_enb (wr_enb_int),
		.rd_enb (read_enb2mem),
		.addr 	(addr_int), 
		.wr_data(wr_data_int),
		.rd_data(rd_data),
		.value_a(value_a_int),
		.value_b(value_b_int),
		.opcode (opcode_int)
	);

	ALU alu (
		.value_a(value_a_int),
		.value_b(value_b_int),
		.opcode	(opcode_int),
		.result (result_int)
	);

	or_gate op_start_pass (
		.a (write_enb_fsm2or),
		.b (op_start),
		.y (wr_enb_int)
	);

	mux2 result_pass (
		.a	(wr_data),
		.b 	(result_int),
		.sel(op_start),
		.y	(wr_data_int)
	);
	
	mux result_addr (
		.a	(addr),
		.b 	(2'b00),
		.sel(op_start),
		.y	(addr_int)
	); 

	/*always@(*)begin 
		wr_data_int = op_start? result : wr_data; 
	end 

	always@(*)begin 
		addr_int = op_start? 2'b00 : addr; 
	end 

	always@(*)begin 
		wr_enb_int = wr_enb | op_start;
	end 
	*/

endmodule 