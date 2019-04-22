module Bent_tb ();
	reg[15:0]  data_1, data_2;
	wire [15:0] res;
	kogg_stone K_S(data_1, data_2, res);
	initial begin
		# 30
		data_1 = 15'd0;
		data_2 = 15'd0;
		# 30;
		data_1 = 15'd0;
		data_2 = 15'd1;
		# 30;
		data_1 = 15'd2;
		data_2 = 15'd5;
		# 30;
		data_1 = 15'd14;
		data_2 = 15'd1;
		# 30;
		data_1 = 15'd15;
		data_2 = 15'd1;
		# 30;
		data_1 = 15'd16;
		data_2 = 15'd1;
		# 30;
		data_1 = 15'd17;
		data_2 = 15'd5;
		# 30;
		data_1 = 15'd15;
		data_2 = 15'd0;
		# 30;
		data_1 = 15'd16;
		data_2 = 15'd0;
		# 30;
	end
endmodule