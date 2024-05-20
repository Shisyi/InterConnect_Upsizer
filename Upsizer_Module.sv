`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2024 04:45:59
// Design Name: 
// Module Name: Upsizer_Module
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


module Upsizer_Module#(
	parameter  T_DATA_WIDTH = 4,
	parameter  T_DATA_RATIO = 2
)(
	input logic 					clk,
	input logic						rst_n,
	input logic  [T_DATA_WIDTH-1:0]	s_data_i,
	input logic						s_last_i,
	input logic						s_valid_i,
	output logic					s_ready_o,
	output logic [T_DATA_WIDTH-1:0] m_data_0 [T_DATA_RATIO-1:0],
	output logic [T_DATA_RATIO-1:0] m_keep_o,
	output logic 					m_last_o,
    output logic					m_valid_o,
	input logic						m_ready_i
);	
	localparam M = T_DATA_RATIO-2;
	reg [T_DATA_RATIO-2:0] counter = '0;
	reg [T_DATA_WIDTH-1:0] buffer = '0;

	always @(posedge clk) begin

		m_valid_o <= '0;

		if (s_valid_i & m_ready_i) begin
			buffer <= s_data_i;
			
				if (counter == '1) begin
					m_data_0[T_DATA_RATIO-2] <= buffer;
					m_data_0[T_DATA_RATIO-1] <= s_data_i;
					//buffer      <= s_data_i;
					m_keep_o    <= 2'b11;
					if (s_last_i)
						m_last_o <= '1;
				    

					counter      <= '0;
					m_valid_o    <= '1;

				end 
				else begin


					counter     <= counter + 1;
					m_valid_o   <= '0;
					m_last_o    <= '0;

					if (s_last_i) begin
						m_last_o <= '1;
						m_data_0[T_DATA_RATIO-2] <= s_data_i;
						m_keep_o    <= 2'b10;
						buffer		<= '0;
						counter		<= '0;
					end

				end
		end
		else
			m_last_o <= '0;

		if (counter == '1 | s_last_i)
			s_ready_o <= '1;
		else
			s_ready_o <= '0;
	end


endmodule
