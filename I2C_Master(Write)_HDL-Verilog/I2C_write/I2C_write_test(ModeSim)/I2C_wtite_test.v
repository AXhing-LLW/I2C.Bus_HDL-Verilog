`timescale 1ns/1ns

module I2C_write_test;
	reg CLK;
	reg GO;
	reg reset;
	reg [26:0] regdata;
	wire SCLK;
	wire SDIN;
	wire ACK,ACK1,ACK2,ACK3,ldnACK1,ldnACK2,ldnACK3;
	wire rstACK;

//Master I2C 寫入 Control
I2C_write I2C_write_0
(CLK,SCLK,SDIN,regdata,GO,ACK,reset,rstACK,ACK1,ACK2,ACK3,ldnACK1,ldnACK2,ldnACK3);

//設定I2C寫入之DATA
initial
begin
	regdata=27'b101010101101010101101010101;
end

//產生10MHZ的CLK
initial
begin
	CLK=0;
end
always #50 CLK=~CLK;

//設定非同重置,100ns後結束
initial
begin
	reset=1;
	while(1)
		#100 reset=0;
end

//開始模擬100ns後觸發I2C動作
initial
begin
	GO=0;
	#100 GO=1;
	#100 GO=0;
end

endmodule