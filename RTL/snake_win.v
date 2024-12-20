module snake_win(
    input             clk        ,   //VGA驱动时钟
    input             rstn       ,   //复位信号
    input      [10:0] pixel_xpos ,
    input      [10:0] pixel_ypos ,
    output reg [15:0] pixel_win   
);
wire [127:0] data[14:0];
assign data[0]  = 128'h000000D654545454546C282828280000;//W0
assign data[1]  = 128'h000000303000007010101010107C0000;//i1
assign data[2]  = 128'h00000000000000DC6242424242E70000;//n2
assign data[3]  = 128'h00000010101010101010000010100000;//!3
assign data[4]  = 128'h000000FC4242427C4848444442E30000;//R4
assign data[5]  = 128'h000000000000003C42427E40423C0000;//e5
assign data[6]  = 128'h000000000000003E42403C02427C0000;//s6
assign data[7]  = 128'h000000000010107C10101010120C0000;//t7
assign data[8]  = 128'h0000000000000038440C34444C360000;//a8
assign data[9]  = 128'h00000000000000EE3220202020F80000;//r9
assign data[10] = 128'h00000000C04040586442424264580000;//b10
assign data[11] = 128'h000000000000001C22404040221C0000;//c11
assign data[12] = 128'h00000000C040404E4850704844EE0000;//k12
assign data[13] = 128'h000000000000003C42424242423C0000;//o13
assign data[14] = 128'h000000000000003E444438403C42423C;//g14

wire [10:0] xpos;
wire [10:0] ypos;
assign xpos = pixel_xpos[10:3];
assign ypos = pixel_ypos[10:3];
wire [10:0] xpos2;
wire [10:0] ypos2;
assign xpos2 = pixel_xpos[10:2];
assign ypos2 = pixel_ypos[10:2];
parameter x1 = 28;
parameter y1 = 8;
parameter x2 = 12;
parameter y2 = 24;
parameter x3 = 24;
parameter y3 = 80;

parameter color_back   = 16'h0000;
parameter color_words1 = 16'h5555;
parameter color_words2 = 16'hF00F;
parameter color_words3 = 16'hF0FF;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_win <= color_back;
        end else if(xpos>=x1 && xpos<x1+8 && ypos>=y1 && ypos<y1+16)begin//W
            pixel_win <= (data[0][(16+y1-ypos)*8 - ((xpos-x1)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+8 && xpos<x1+16 && ypos>=y1 && ypos<y1+16)begin//i
            pixel_win <= (data[1][(16+y1-ypos)*8 - ((xpos-x1-8)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+16 && xpos<x1+24 && ypos>=y1 && ypos<y1+16)begin//n
            pixel_win <= (data[2][(16+y1-ypos)*8 - ((xpos-x1-16)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+24 && xpos<x1+32 && ypos>=y1 && ypos<y1+16)begin//!
            pixel_win <= (data[3][(16+y1-ypos)*8 - ((xpos-x1-24)%8)-1]) ? color_words1 : color_back;

        end else if(xpos>=x2 && xpos<x2+8 && ypos>=y2 && ypos<y2+16)begin//R
            pixel_win <= (data[4][(16+y2-ypos)*8 - ((xpos-x2)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+8 && xpos<x2+16 && ypos>=y2 && ypos<y2+16)begin//e
            pixel_win <= (data[5][(16+y2-ypos)*8 - ((xpos-x2-8)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+16 && xpos<x2+24 && ypos>=y2 && ypos<y2+16)begin//s
            pixel_win <= (data[6][(16+y2-ypos)*8 - ((xpos-x2-16)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+24 && xpos<x2+32 && ypos>=y2 && ypos<y2+16)begin//t
            pixel_win <= (data[7][(16+y2-ypos)*8 - ((xpos-x2-24)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+32 && xpos<x2+40 && ypos>=y2 && ypos<y2+16)begin//a
            pixel_win <= (data[8][(16+y2-ypos)*8 - ((xpos-x2-32)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+40 && xpos<x2+48 && ypos>=y2 && ypos<y2+16)begin//r
            pixel_win <= (data[9][(16+y2-ypos)*8 - ((xpos-x2-40)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+48 && xpos<x2+56 && ypos>=y2 && ypos<y2+16)begin//t
            pixel_win <= (data[7][(16+y2-ypos)*8 - ((xpos-x2-48)%8)-1]) ? color_words2 : color_back;

        end else if(xpos2>=x3 && xpos2<x3+8 && ypos2>=y3 && ypos2<y3+16)begin//b
            pixel_win <= (data[10][(16+y3-ypos2)*8 - ((xpos2-x3)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+8 && xpos2<x3+16 && ypos2>=y3 && ypos2<y3+16)begin//a
            pixel_win <= (data[8][(16+y3-ypos2)*8 - ((xpos2-x3-8)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+16 && xpos2<x3+24 && ypos2>=y3 && ypos2<y3+16)begin//c
            pixel_win <= (data[11][(16+y3-ypos2)*8 - ((xpos2-x3-16)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+24 && xpos2<x3+32 && ypos2>=y3 && ypos2<y3+16)begin//k
            pixel_win <= (data[12][(16+y3-ypos2)*8 - ((xpos2-x3-24)%8)-1]) ? color_words3 : color_back;

        end else if(xpos2>=x3+40 && xpos2<x3+48 && ypos2>=y3 && ypos2<y3+16)begin//t
            pixel_win <= (data[7][(16+y3-ypos2)*8 - ((xpos2-x3-40)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+48 && xpos2<x3+56 && ypos2>=y3 && ypos2<y3+16)begin//0
            pixel_win <= (data[13][(16+y3-ypos2)*8 - ((xpos2-x3-48)%8)-1]) ? color_words3 : color_back;

        end else if(xpos2>=x3+64 && xpos2<x3+72 && ypos2>=y3 && ypos2<y3+16)begin//o
            pixel_win <= (data[13][(16+y3-ypos2)*8 - ((xpos2-x3-64)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+72 && xpos2<x3+80 && ypos2>=y3 && ypos2<y3+16)begin//r
            pixel_win <= (data[9][(16+y3-ypos2)*8 - ((xpos2-x3-72)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+80 && xpos2<x3+88 && ypos2>=y3 && ypos2<y3+16)begin//i
            pixel_win <= (data[1][(16+y3-ypos2)*8 - ((xpos2-x3-80)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+88 && xpos2<x3+96 && ypos2>=y3 && ypos2<y3+16)begin//g
            pixel_win <= (data[14][(16+y3-ypos2)*8 - ((xpos2-x3-88)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+96 && xpos2<x3+104 && ypos2>=y3 && ypos2<y3+16)begin//i
            pixel_win <= (data[1][(16+y3-ypos2)*8 - ((xpos2-x3-96)%8)-1]) ? color_words3 : color_back;
        end else if(xpos2>=x3+104 && xpos2<x3+112 && ypos2>=y3 && ypos2<y3+16)begin//n
            pixel_win <= (data[2][(16+y3-ypos2)*8 - ((xpos2-x3-104)%8)-1]) ? color_words3 : color_back;

        end else begin
            pixel_win <= color_back;
        end
    end
endmodule 

