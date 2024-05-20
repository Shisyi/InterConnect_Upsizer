`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2024 01:07:39
// Design Name: 
// Module Name: TB_upsize
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_upsize();

	parameter  T_DATA_WIDTH = 4;
	parameter  T_DATA_RATIO = 2;
	localparam CLK_PERIOD = 10ns;
	
	logic 						clk = 0;
	logic						rst_n;
	logic [T_DATA_WIDTH-1:0]	s_data_i;
	logic						s_last_i;
	logic						s_valid_i = 1;
	logic						s_ready_o;
	logic [T_DATA_WIDTH-1:0] 	m_data_0 [T_DATA_RATIO-1:0];
	logic [T_DATA_RATIO-1:0]	m_keep_o;
	logic 						m_last_o;
    logic						m_valid_o;
	logic						m_ready_i;
     

	Upsizer_Module #(
		.T_DATA_WIDTH(T_DATA_WIDTH),
		.T_DATA_RATIO(T_DATA_RATIO)

	) inst_Upsizer_Module (
		.clk                (clk),
		.rst_n      		(rst_n),
		.s_data_i      		(s_data_i),
		.s_last_i    		(s_last_i),
		.s_valid_i 			(s_valid_i),
		.s_ready_o  		(s_ready_o),
		.m_data_0           (m_data_0),
		.m_keep_o           (m_keep_o),
		.m_last_o           (m_last_o),
		.m_valid_o          (m_valid_o),
		.m_ready_i          (m_ready_i)
	);    

	
    initial begin
        forever begin
            clk <= !clk;
            #(CLK_PERIOD/2);
        end
    end   		

    task wait_clk(int num_clk);
        #(num_clk * CLK_PERIOD);
    endtask : wait_clk

    initial begin
    rst_n			      <= '0;
    s_data_i      	      <= '0;
    s_last_i 			  <= '0;
    s_valid_i  		      <= '0;
    m_ready_i             <= '1;
    	
	end

	always @(posedge clk) begin
		#(2);
		s_data_i <= s_data_i + 1;
		if (s_data_i == 4'b0101 | 4'b1101)
			#(10);
	end

	always @(posedge clk) begin
		if (s_valid_i == '0) begin
		#(2);
		wait_clk(1);
		s_valid_i <= !s_valid_i;
		wait_clk(5);
	    end
	    else
	    s_valid_i <= !s_valid_i;
	end

	always @(posedge clk) begin
		if (s_last_i == '0) begin
		#(2);
	    wait_clk(3);
    	s_last_i <= !s_last_i;
    	#(10);
    	s_last_i <= !s_last_i;
    	wait_clk(2);
    	s_last_i <= !s_last_i;
    	#(10);
    	s_last_i <= !s_last_i;
	    end
	end





endmodule
