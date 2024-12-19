module snake_start(
    input             clk        ,   //VGA驱动时钟
    input             rstn       ,   //复位信号
    input      [10:0] pixel_xpos ,
    input      [10:0] pixel_ypos ,
    output reg [15:0] pixel_start 
);
wire [127:0] data[7:0];
assign data[0] = 128'h0000003E4242402018040242427C0000;//S0
assign data[1] = 128'h00000000000000DC6242424242E70000;//n1
assign data[2] = 128'h0000000000000038440C34444C360000;//a2
assign data[3] = 128'h00000000C040404E4850704844EE0000;//k3
assign data[4] = 128'h000000000000003C42427E40423C0000;//e4
assign data[5] = 128'h000000000000003E42403C02427C0000;//s5
assign data[6] = 128'h000000000010107C10101010120C0000;//t6
assign data[7] = 128'h00000000000000EE3220202020F80000;//r7

wire [10:0] xpos;
wire [10:0] ypos;
assign xpos = pixel_xpos[10:3];
assign ypos = pixel_ypos[10:3];
parameter x1 = 10;
parameter y1 = 10;
parameter x2 = 25;
parameter y2 = 26;

parameter color_back   = 16'h0000;
parameter color_words1 = 16'h5555;
parameter color_words2 = 16'hF00F;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_start <= color_back;
        end else if(xpos>=x1 && xpos<x1+8 && ypos>=y1 && ypos<y1+16)begin//S
            pixel_start <= (data[0][(16+y1-ypos)*8 - ((xpos-x1)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+8 && xpos<x1+16 && ypos>=y1 && ypos<y1+16)begin//n
            pixel_start <= (data[1][(16+y1-ypos)*8 - ((xpos-x1-8)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+16 && xpos<x1+24 && ypos>=y1 && ypos<y1+16)begin//a
            pixel_start <= (data[2][(16+y1-ypos)*8 - ((xpos-x1-16)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+24 && xpos<x1+32 && ypos>=y1 && ypos<y1+16)begin//k
            pixel_start <= (data[3][(16+y1-ypos)*8 - ((xpos-x1-24)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+32 && xpos<x1+40 && ypos>=y1 && ypos<y1+16)begin//e
            pixel_start <= (data[4][(16+y1-ypos)*8 - ((xpos-x1-32)%8)-1]) ? color_words1 : color_back;

        end else if(xpos>=x2 && xpos<x2+8 && ypos>=y2 && ypos<y2+16)begin//S
            pixel_start <= (data[0][(16+y2-ypos)*8 - ((xpos-x2)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+8 && xpos<x2+16 && ypos>=y2 && ypos<y2+16)begin//t
            pixel_start <= (data[6][(16+y2-ypos)*8 - ((xpos-x2-8)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+16 && xpos<x2+24 && ypos>=y2 && ypos<y2+16)begin//a
            pixel_start <= (data[2][(16+y2-ypos)*8 - ((xpos-x2-16)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+24 && xpos<x2+32 && ypos>=y2 && ypos<y2+16)begin//r
            pixel_start <= (data[7][(16+y2-ypos)*8 - ((xpos-x2-24)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+32 && xpos<x2+40 && ypos>=y2 && ypos<y2+16)begin//t
            pixel_start <= (data[6][(16+y2-ypos)*8 - ((xpos-x2-32)%8)-1]) ? color_words2 : color_back;
        end else begin
            pixel_start <= color_back;
        end
    end
endmodule 

