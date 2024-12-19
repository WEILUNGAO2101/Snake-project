module snake_game(
    input             clk       ,   //VGA驱动时钟
    input             rstn      ,   //复位信号
    input             up        ,
    input             down      ,
    input             right     ,
    input             left      ,
    input             start     ,
    input      [10:0] pixel_xpos,
    input      [10:0] pixel_ypos,
    output reg        die       ,
    output reg        win       ,
    output reg [15:0] pixel_game 
);

reg [25:0] cnt1s;
parameter  num1s = 49999999;
reg [9:0]  second;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            cnt1s <= 0;
        end else if(cnt1s >= num1s)begin
            cnt1s <= 0;
        end else if(start)begin
            cnt1s <= cnt1s+1;
        end else begin
            cnt1s <= 0;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            second <= 0;
        end else if(start)begin
            if(cnt1s >= num1s)begin
                second <= second+1;
            end else begin
                second <= second;
            end
        end else begin
            second <= 0;
        end
    end


reg [25:0] move;
parameter  move_num = 10000000;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            move <= 0;
        end else if(move >= move_num)begin
            move <= 0;
        end else if(start)begin
            move <= move+1;
        end else begin
            move <= 0;
        end
    end
reg [1:0] direction;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            direction <= 2;
        end else if(!start)begin
            direction <= 2;
        end else if(up && direction!=1)begin
            direction <= 0;
        end else if(down && direction!=0)begin
            direction <= 1;
        end else if(right && direction!=3)begin
            direction <= 2;
        end else if(left && direction!=2)begin
            direction <= 3;
        end else begin
            direction <= direction;
        end
    end
reg [10:0] head_x;
reg [10:0] head_y;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            head_x <= 20;
            head_y <= 20;
        end else if(start)begin
            case(direction)
                0:begin
                    if(move >= move_num)begin
                        head_x <= head_x;
                        head_y <= head_y-1;
                    end else begin  
                        head_x <= head_x;
                        head_y <= head_y;
                    end
                end
                1:begin
                    if(move >= move_num)begin
                        head_x <= head_x;
                        head_y <= head_y+1;
                    end else begin  
                        head_x <= head_x;
                        head_y <= head_y;
                    end
                end
                2:begin
                    if(move >= move_num)begin
                        head_x <= head_x+1;
                        head_y <= head_y;
                    end else begin  
                        head_x <= head_x;
                        head_y <= head_y;
                    end
                end
                3:begin
                    if(move >= move_num)begin
                        head_x <= head_x-1;
                        head_y <= head_y;
                    end else begin  
                        head_x <= head_x;
                        head_y <= head_y;
                    end
                end
            endcase
        end else begin
            head_x <= 20;
            head_y <= 20;
        end
    end
reg [10:0] body_x[19:0];
reg [10:0] body_y[19:0];
reg [4:0]  i;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            for(i=0;i<20;i=i+1)begin
                body_x [i] <= 0;
                body_y [i] <= 0;
            end
        end else if(start)begin
            if(move >= move_num)begin
                body_x[0] <= head_x;
                body_y[0] <= head_y;
                for(i=1;i<20;i=i+1)begin
                    body_x[i] <= body_x[i-1];
                    body_y[i] <= body_y[i-1];
                end
            end else begin
                for(i=0;i<20;i=i+1)begin
                    body_x[i] <= body_x[i];
                    body_y[i] <= body_y[i];
                end
            end
        end else begin
            for(i=0;i<20;i=i+1)begin
                body_x[i] <= 0;
                body_y[i] <= 0;
            end
        end
    end
reg [15:0] random_x;
reg [15:0] random_y;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            random_x <= 16'h0f0f;
        end else begin
            random_x[0]  <= random_x[15];
            random_x[1]  <= random_x[0] ;
            random_x[2]  <= random_x[1] ;
            random_x[3]  <= random_x[2] ;
            random_x[4]  <= random_x[3] ;
            random_x[5]  <= random_x[4] ;
            random_x[6]  <= random_x[5] ;
            random_x[7]  <= random_x[6] ;
            random_x[8]  <= random_x[7] ;
            random_x[9]  <= random_x[8] ;
            random_x[10] <= random_x[9] ;
            random_x[11] <= random_x[10]^random_x[15];
            random_x[12] <= random_x[11]^random_x[15];
            random_x[13] <= random_x[12]^random_x[15];
            random_x[14] <= random_x[13]^random_x[15];
            random_x[15] <= random_x[14];
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            random_y <= 16'h5555;
        end else begin
            random_y[0]  <= random_y[15];
            random_y[1]  <= random_y[0] ;
            random_y[2]  <= random_y[1] ;
            random_y[3]  <= random_y[2] ;
            random_y[4]  <= random_y[3] ;
            random_y[5]  <= random_y[4] ;
            random_y[6]  <= random_y[5] ;
            random_y[7]  <= random_y[6] ;
            random_y[8]  <= random_y[7] ;
            random_y[9]  <= random_y[8] ;
            random_y[10] <= random_y[9] ;
            random_y[11] <= random_y[10]^random_y[15];
            random_y[12] <= random_y[11]^random_y[15];
            random_y[13] <= random_y[12]^random_y[15];
            random_y[14] <= random_y[13]^random_y[15];
            random_y[15] <= random_y[14];
        end
    end
reg eated;
reg [15:0] color_apple;
reg [10:0] apple_x;
reg [10:0] apple_y;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            apple_x     <= 0;
            apple_y     <= 0;
            color_apple <= 0;
        end else if(eated || (!start && right))begin
            apple_x     <= random_x%69+1;
            apple_y     <= random_y%59+1;
            color_apple <= {random_y[15:14],3'b111,random_y[10:8],3'b111,random_y[4:3],3'b111};
        end else if((xpos>=0 && xpos<72 && ypos>=0 && ypos<64) && wall[((64-ypos)*72 - xpos%72)-1])begin
            if(apple_x==xpos && apple_y==ypos)begin
                apple_x     <= random_x%69+1;
                apple_y     <= random_y%59+1;
                color_apple <= {random_y[15:14],3'b111,random_y[10:8],3'b111,random_y[4:3],3'b111};
            end else begin
                apple_x     <= apple_x;
                apple_y     <= apple_y;
                color_apple <= color_apple;
            end
        end else begin
            apple_x     <= apple_x;
            apple_y     <= apple_y;
            color_apple <= color_apple;
        end
    end
reg flag;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            flag <= 0;
        end else if(move >= move_num)begin
            flag <= 1;
        end else begin
            flag <= 0;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            eated <= 0;
        end else if(apple_x==head_x && apple_y==head_y && flag)begin
            eated <= 1;
        end else begin
            eated <= 0;
        end
    end
reg [15:0] color_body[19:0];
reg [4:0]  j;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            for(j=0;j<20;j=j+1)begin
                color_body[j] <= 16'h0780;
            end
        end else if(start)begin
            if(eated)begin
                color_body[0] <= color_apple;
                for(j=1;j<20;j=j+1)begin
                    color_body[j] <= color_body[j-1];
                end
            end else begin
                for(j=0;j<20;j=j+1)begin
                    color_body[j] <= color_body[j];
                end
            end
        end else begin
            for(j=0;j<20;j=j+1)begin
                color_body[j] <= 16'h0780;
            end
        end
    end
reg [10:0] length;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            length <= 0;
        end else if(start)begin
            if(eated)begin
                length <= length+1;
            end else begin
                length <= length;
            end
        end else begin
            length <= 0;
        end
    end
reg [5:0] addr;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            addr <= 0;
        end else if(addr >= 50)begin
            addr <= 0;
        end else begin
            addr <= addr+1;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            die <= 0;
        end else if((xpos>=0 && xpos<72 && ypos>=0 && ypos<64) && wall[((64-ypos)*72 - xpos%72)-1])begin
            if(head_x==xpos && head_y==ypos)begin
                die <= 1;
            end else begin
                die <= 0;
            end
        end else if(head_x==body_x[addr] && head_y==body_y[addr] && addr<=length+5)begin
            die <= 1;
        end else begin
            die <= 0;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            win <= 0;
        end else if(length >= 15)begin
            win <= 1;
        end else begin
            win <= 0;
        end
    end
wire [4607:0] wall;
assign wall[4607:4096] = 512'hFFFFFFFFFFFFFFFFFC80000000000000000480000000000000000480000000000000000480000000000000000480000000000000000481FFFFE0000FFFFE0481;
assign wall[4095:3584] = 512'h00000000000002048100000000000002048100000000000002048100000000000002048100000000000002048100000000000002048100000000000002048100;
assign wall[3583:3072] = 512'h003FFFF8000204810000000000000204810000000000000204810000000000000204810000000000000204810000000000000204800000000000000004800040;
assign wall[3071:2560] = 512'h00000008000480004000000008000480004000000008000480004000000008000480004000000008000480004000000008000480004000000008000480004000;
assign wall[2559:2048] = 512'h00000800048000400000000800048000400000000800048000400000000800048000400000000800048000400000000800048000400000000800048000400000;
assign wall[2047:1536] = 512'h00080004800040000000080004800040000000080004800040000000080004800000000000000004810000000000000204810000000000000204810000000000;
assign wall[1535:1024] = 512'h0002048100000000000002048100000000000002048100003FFFF800020481000000000000020481000000000000020481000000000000020481000000000000;
assign wall[1023:512]  = 512'h020481000000000000020481000000000000020481000000000000020481FFFFE0000FFFFE048000000000000000048000000000000000048000000000000000;
assign wall[511:0]     = 512'h04800000000000000004800000000000000004FFFFFFFFFFFFFFFFFC000000000000000000000000000000000000000000000000000000000000000000000000;

wire [127:0] digital[9:0];
assign digital[0] = 128'h00000018244242424242424224180000;//0
assign digital[1] = 128'h000000083808080808080808083E0000;//1
assign digital[2] = 128'h0000003C4242420204081020427E0000;//2
assign digital[3] = 128'h0000003C4242020418040242423C0000;//3
assign digital[4] = 128'h000000040C0C142424447F04041F0000;//4
assign digital[5] = 128'h0000007E404040784402024244380000;//5
assign digital[6] = 128'h000000182440405C62424242221C0000;//6
assign digital[7] = 128'h0000007E420404080810101010100000;//7
assign digital[8] = 128'h0000003C4242422418244242423C0000;//8
assign digital[9] = 128'h0000003844424242463A020224180000;//9

reg [3:0] data1;
reg [3:0] data2;
reg [3:0] data3;
reg [3:0] data4;
reg [3:0] data5;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            data1 <= 0;
            data2 <= 0;
            data3 <= 0;
            data4 <= 0;
            data5 <= 0;
        end else begin
            data1 <= second/100%10;
            data2 <= second/10%10;
            data3 <= second%10;
            data4 <= length/10;
            data5 <= length%10;
        end
    end
wire [10:0] xpos;
wire [10:0] ypos;
assign xpos = pixel_xpos[10:3];
assign ypos = pixel_ypos[10:3];
parameter color_head  = 16'hF800;
parameter colcor_wall = 16'h00ff;

parameter x1 = 285;
parameter y1 = 15;
parameter x2 = 285;
parameter y2 = 35;
wire [10:0] xpos2;
wire [10:0] ypos2;
assign xpos2 = pixel_xpos[10:1];
assign ypos2 = pixel_ypos[10:1];
parameter color_words = 16'hffff;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_game <= 0;
        end else if((xpos>=0 && xpos<72 && ypos>=0 && ypos<64) && wall[((64-ypos)*72 - xpos%72)-1])begin
            pixel_game <= colcor_wall;
        end else if(xpos==apple_x && ypos==apple_y)begin
            pixel_game <= color_apple;
        end else if(xpos==head_x && ypos==head_y)begin
            pixel_game <= color_head;
        end else if(xpos==body_x[0] && ypos==body_y[0] && length>=0)begin
            pixel_game <= color_body[0];
        end else if(xpos==body_x[1] && ypos==body_y[1] && length>=0)begin
            pixel_game <= color_body[1];
        end else if(xpos==body_x[2] && ypos==body_y[2] && length>=0)begin
            pixel_game <= color_body[2];
        end else if(xpos==body_x[3] && ypos==body_y[3] && length>=0)begin
            pixel_game <= color_body[3];
        end else if(xpos==body_x[4] && ypos==body_y[4] && length>=0)begin
            pixel_game <= color_body[4];
        end else if(xpos==body_x[5] && ypos==body_y[5] && length>=1)begin
            pixel_game <= color_body[5];
        end else if(xpos==body_x[6] && ypos==body_y[6] && length>=2)begin
            pixel_game <= color_body[6];
        end else if(xpos==body_x[7] && ypos==body_y[7] && length>=3)begin
            pixel_game <= color_body[7];
        end else if(xpos==body_x[8] && ypos==body_y[8] && length>=4)begin
            pixel_game <= color_body[8];
        end else if(xpos==body_x[9] && ypos==body_y[9] && length>=5)begin
            pixel_game <= color_body[9];
        end else if(xpos==body_x[10] && ypos==body_y[10] && length>=6)begin
            pixel_game <= color_body[10];
        end else if(xpos==body_x[11] && ypos==body_y[11] && length>=7)begin
            pixel_game <= color_body[11];
        end else if(xpos==body_x[12] && ypos==body_y[12] && length>=8)begin
            pixel_game <= color_body[12];
        end else if(xpos==body_x[13] && ypos==body_y[13] && length>=9)begin
            pixel_game <= color_body[13];
        end else if(xpos==body_x[14] && ypos==body_y[14] && length>=10)begin
            pixel_game <= color_body[14];
        end else if(xpos==body_x[15] && ypos==body_y[15] && length>=11)begin
            pixel_game <= color_body[15];
        end else if(xpos==body_x[16] && ypos==body_y[16] && length>=12)begin
            pixel_game <= color_body[16];
        end else if(xpos==body_x[17] && ypos==body_y[17] && length>=13)begin
            pixel_game <= color_body[17];
        end else if(xpos==body_x[18] && ypos==body_y[18] && length>=14)begin
            pixel_game <= color_body[18];
        end else if(xpos==body_x[19] && ypos==body_y[19] && length>=15)begin
            pixel_game <= color_body[19];
        
        end else if(xpos2>=x1 && xpos2<x1+8 && ypos2>y1 && ypos2<y1+16)begin
            pixel_game <= (digital[data1][(16+y1-ypos2)*8 - ((xpos2-x1)%8)-1]) ? color_words : 0;
        end else if(xpos2>=x1+8 && xpos2<x1+16 && ypos2>y1 && ypos2<y1+16)begin
            pixel_game <= (digital[data2][(16+y1-ypos2)*8 - ((xpos2-x1-8)%8)-1]) ? color_words : 0;
        end else if(xpos2>=x1+16 && xpos2<x1+24 && ypos2>y1 && ypos2<y1+16)begin
            pixel_game <= (digital[data3][(16+y1-ypos2)*8 - ((xpos2-x1-16)%8)-1]) ? color_words : 0;
        
        end else if(xpos2>=x2 && xpos2<x2+8 && ypos2>y2 && ypos2<y2+16)begin
            pixel_game <= (digital[data4][(16+y2-ypos2)*8 - ((xpos2-x2)%8)-1]) ? color_words : 0;
        end else if(xpos2>=x2+8 && xpos2<x2+16 && ypos2>y2 && ypos2<y2+16)begin
            pixel_game <= (digital[data5][(16+y2-ypos2)*8 - ((xpos2-x2-8)%8)-1]) ? color_words : 0;
        end else begin
            pixel_game <= 0;
        end
    end
endmodule
