module single_port_ram 
#( parameter DATA_WIDTH=16, parameter ADDR_WIDTH=5 )
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] rdaddr,
	input [(ADDR_WIDTH-1):0] wraddr,
	input we, clk,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] rdaddr_reg;

	always @ (posedge clk)
	begin
		// Write
		if (we)
		begin
			ram[wraddr] <= data;
		end
		rdaddr_reg <= rdaddr;
		q <= ram[rdaddr_reg];
	end	

endmodule
