module buffer #(parameter size = 2) (
	input[size-1:0] data,
	output[size-1:0] out_data	
);
genvar i;
generate
	for (i = 0; i < size; i=i+1) begin
		buf(out_data[i], data[i]);
	end
endgenerate
endmodule