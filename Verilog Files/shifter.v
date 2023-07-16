`timescale 1ns / 1ps

module shifter(
    input [31:0] data,
    input [5:0] shift,
    input [1:0] select,
    output reg [31:0] out
    );
reg [31:0] w1, w2, w3,w4, w5;	 
always @(*)
begin 
if(select[1]==0)
begin
	if(shift[0]==1)
	w1 = data<<1;
	else
	w1 = data;
	if(shift[1]==1)
	w2 = w1<<2;
	else
	w2 <= w1;
	if(shift[2]==1)
	w3 = w2<<4;
	else
	w3 = w2;
	if(shift[3]==1)
	w4 = w3<<8;
	else
	w4 = w3;
	if(shift[4]==1)
	w5 = w4<<16;
	else
	w5 = w4;
	if(shift[5]==1)
	out = w5<<32;
	else
	out = w5;
end
else if(select[1]==1 && select[0]==0)
begin
	if(shift[0]==1)
	w1 = data>>1;
	else
	w1 = data;
	if(shift[1]==1)
	w2 = w1>>2;
	else
	w2 = w1;
	if(shift[2]==1)
	w3 = w2>>4;
	else
	w3 = w2;
	if(shift[3]==1)
	w4 = w3>>8;
	else
	w4 = w3;
	if(shift[4]==1)
	w5 = w4>>16;
	else
	w5 = w4;
	if(shift[5]==1)
	out = w5>>32;
	else
	out = w5;
end
else
begin
	if(shift[0]==1)
	begin
	w1 = data>>1;
	w1[31]= data[31];
	end
	else
	w1 = data;
	if(shift[1]==1)
	begin
	w2 = w1>>2;
	w2[31:30]={w1[31],w1[31]};
	end
	else
	w2 = w1;
	if(shift[2]==1)
	begin
	w3 = w2>>4;
	w3[31:28]={w2[31],w2[31],w2[31],w2[31]};
	end
	else
	w3 = w2;
	if(shift[3]==1)
	begin
	w4 = w3>>8;
	w4[31:24]={w3[31],w3[31],w3[31],w3[31],w3[31],w3[31],w3[31],w3[31]};
	end
	else
	w4 = w3;
	if(shift[4]==1)
	begin
	w5 = w4>>16;
	w5[31:16]={w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31],w4[31]};
	end
	else
	w5 = w4;
	if(shift[5]==1)
	begin
	out = w5>>32;
	out = {w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31],w5[31]};
	end
	else
	out <= w5;
end
end
endmodule

