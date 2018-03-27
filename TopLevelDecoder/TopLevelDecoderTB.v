
// TBench for first simulation of unrolled LUT based LDPC decoder

`timescale 1ns/1ps
module WakeUp1bit_ItrDecTb_256 ();

//--some parameter initializations	
	parameter N = 1024;
	parameter Q = 3;



//--clock generation
	reg Clk, Rst;
	parameter ClkPer = 10;                         //100 MHz
	
	parameter ClkHalf = ClkPer/2;
	parameter Propag = ClkPer/10;
	
	initial
		Clk = 1;

		
	always
		#ClkHalf  Clk = ~Clk;

		
	initial begin
		Rst = 0;
		#(2*ClkPer+1) Rst = 1;
	end

	
		
//--read input
        integer ChLLRxDI [0:N-1];//[Q-1:0];
        
        always @ (*)
                for (i=0; i<N; i=i+1)
                        ChLLRxDI = 0;//{Q{1'b0}};
                        

//-- Output

//--instantiation
        TopLevelDecoder DUT(
            .ChLLRxDI(ChLLRxDI),
            .ClkxCI(Clk),
            .RstxRBI(Rst),
            .DecodedBitsxDO()
	);

endmodule

