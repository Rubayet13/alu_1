`timescale 1ns/10ps
module  memory_controller_top_tb; 
	reg clk = 0; 
	reg rst; 
	reg cs; 
	reg wr_enb; 
	reg rd_enb; 
	reg [3:0] wr_data; 
	reg [1:0] addr; 
	reg op_start;
	wire [3:0] rd_data; 

	initial forever begin 
		#5 clk =~ clk; 
	end 

	memory_controller_top DUT (
		.clk (clk),
		.rst (rst),
		.cs (cs), 
		.wr_enb (wr_enb), 
		.rd_enb (rd_enb),
		.wr_data (wr_data),
		.addr (addr),
		.op_start (op_start),
		.rd_data (rd_data)
	);

	initial begin 
		//value a write start
		rst	<= 0; 
		cs	<= 0;
		@(negedge clk); 
		rst <= 1; 
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b01;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b01;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 1;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 0; 
		addr		<= 2'b01;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		repeat (2) begin 
		@(negedge clk);
		end
		//value a write end
	
		//value b write start
		rst	<= 0; 
		cs	<= 0;
		@(negedge clk); 
		rst <= 1; 
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b10;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b10;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 1;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 0; 
		addr		<= 2'b10;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		repeat (2) begin 
		@(negedge clk);
		end
		//value b write end

		//opcode write start
		rst	<= 0; 
		cs	<= 0;
		@(negedge clk); 
		rst <= 1; 
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b11;
		wr_data 	<= 4'b0011;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b11;
		wr_data 	<= 4'b0011;
		wr_enb 		<= 1;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 0; 
		addr		<= 2'b11;
		wr_data 	<= 4'b0011;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		repeat (2) begin 
		@(negedge clk);
		end
		//opcode write end

		//result write start 
		rst	<= 0; 
		cs	<= 0;
		@(negedge clk); 
		rst <= 1; 
		@(negedge clk);
		cs			<= 0; 
		//addr		<= 2'b00;
		//wr_data 	<= 4'b0000;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 1;
		/*@(negedge clk);
		cs			<= 0; 
		addr		<= 2'b11;
		wr_data 	<= 4'b1110;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 1;
		@(negedge clk);
		cs			<= 0; 
		addr		<= 2'b11;
		wr_data 	<= 4'b1010;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		repeat (2) begin 
		@(negedge clk);
		end
		*/
		@(negedge clk);
		//read start 
		rst	<= 0; 
		cs	<= 0;
		@(negedge clk); 
		rst <= 1; 
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b00;
		wr_data 	<= 4'b0000;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		@(negedge clk);
		cs			<= 1; 
		addr		<= 2'b00;
		wr_data 	<= 4'b0000;
		wr_enb 		<= 0;
		rd_enb 		<= 1;
		op_start 	<= 0;
		repeat (2) begin 
		@(negedge clk);
		cs			<= 0; 
		addr		<= 2'b00;
		wr_data 	<= 4'b0000;
		wr_enb 		<= 0;
		rd_enb 		<= 0;
		op_start 	<= 0;
		end
		//read end 
		$finish (); 
	end 
endmodule 