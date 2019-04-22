module kogg_stone (
	input[15:0] data1, data2,
	output[15:0] res	
);

wire [15:0] init_g, init_p;
wire [33:0] black_cell_input_g_i_to_k, black_cell_input_p_i_to_k, black_cell_input_p_k_to_j, black_cell_input_g_k_to_j;
wire [33:0] black_cell_output_g_i_to_k, black_cell_output_p_i_to_k;

wire [14:0] gray_cell_input_g_i_to_k, gray_cell_input_p_i_to_k, gray_cell_output_g, gray_cell_input_g_k_to_j;

wire [7:0] bufferd_output;
wire [15:0] output_g;

assign init_p = (data1 ^ data2);
assign init_g = (data1 & data2);


assign {black_cell_input_g_i_to_k[13:0], black_cell_input_p_i_to_k[13:0]} = {init_g[15:2], init_p[15:2]};
assign {black_cell_input_g_k_to_j[13:0], black_cell_input_p_k_to_j[13:0]} = {init_g[14:1], init_p[14:1]};

assign black_cell_input_g_i_to_k[25:14] = black_cell_output_g_i_to_k[13:2];
assign black_cell_input_p_i_to_k[25:14] = black_cell_output_p_i_to_k[13:2];
assign black_cell_input_g_i_to_k[33:26] = black_cell_output_g_i_to_k[25:18];
assign black_cell_input_p_i_to_k[33:26] = black_cell_output_p_i_to_k[25:18];

assign black_cell_input_p_k_to_j[25:14] = black_cell_output_g_i_to_k[11:0];
assign black_cell_input_p_k_to_j[25:14] = black_cell_output_p_i_to_k[11:0];
assign black_cell_input_g_k_to_j[33:26] = black_cell_output_g_i_to_k[21:14];
assign black_cell_input_p_k_to_j[33:26] = black_cell_output_p_i_to_k[21:14];

assign gray_cell_input_g_i_to_k[14:7] = black_cell_output_g_i_to_k[33:26];
assign gray_cell_input_p_i_to_k[14:7] = black_cell_output_p_i_to_k[33:26];

assign gray_cell_input_g_i_to_k[6:3] = black_cell_output_g_i_to_k[17:14];
assign gray_cell_input_p_i_to_k[6:3] = black_cell_output_p_i_to_k[17:14];

assign gray_cell_input_g_i_to_k[2:1] = black_cell_output_g_i_to_k[1:0];
assign gray_cell_input_p_i_to_k[2:1] = black_cell_output_p_i_to_k[1:0];

assign gray_cell_input_g_i_to_k[0] = init_g[1];
assign gray_cell_input_p_i_to_k[0] = init_p[1];

assign gray_cell_input_g_k_to_j[14:11] = gray_cell_output_g[6:3];
assign gray_cell_input_g_k_to_j[10:7] = bufferd_output[3:0];
assign gray_cell_input_g_k_to_j[6:5] = gray_cell_output_g[2:1];
assign gray_cell_input_g_k_to_j[4:3] = bufferd_output[1:0];
assign gray_cell_input_g_k_to_j[2:1] = {gray_cell_output_g[0], bufferd_output[0]};
assign gray_cell_input_g_k_to_j[0] = init_g[0];

assign output_g = {black_cell_output_g_i_to_k[33:26], bufferd_output};

//buffer
buffer #(.size(8)) buffers(
					{gray_cell_output_g[6:3], gray_cell_output_g[2:1], gray_cell_output_g[0], init_g[0]},	
					bufferd_output);

genvar i;
generate
	for (i = 0; i <34 ; i=i+1) begin
		black_cell B_C(
			black_cell_input_g_i_to_k[i], 
			black_cell_input_p_i_to_k[i], 
			black_cell_input_g_k_to_j[i],
			black_cell_input_p_k_to_j[i],

			black_cell_output_g_i_to_k[i], 
			black_cell_output_p_i_to_k[i]
		);
	end
endgenerate
generate
	for (i = 0; i < 15; i=i+1) begin
		gray_cell G_C(
			gray_cell_input_g_i_to_k[i],
			gray_cell_input_p_i_to_k[i],
			gray_cell_input_g_k_to_j[i],

			gray_cell_output_g[i]
		);
	end
endgenerate

assign res = {1'b0, init_p} ^ {output_g, 1'b0};
endmodule