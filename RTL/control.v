module control(
    input             clk       ,   //VGA驱动时钟
    input             rstn      ,   //复位信号
    input             up        ,
    input             down      ,
    input             right     ,
    input             left      ,
    input      [10:0] pixel_xpos,
    input      [10:0] pixel_ypos,
    output reg [15:0] pixel_data 
);

reg  start;
wire die;
wire win;
reg  die_state;
reg  win_state;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            start <= 0;
        end else if(right && !die_state && !win_state)begin
            start <= 1;
        end else if(die || win)begin
            start <= 0;
        end else begin
            start <= start;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            die_state <= 0;
        end else if(die)begin
            die_state <= 1;
        end else if(right)begin
            die_state <= 0;
        end else begin
            die_state <= die_state;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            win_state <= 0;
        end else if(win)begin
            win_state <= 1;
        end else if(right)begin
            win_state <= 0;
        end else begin
            win_state <= win_state;
        end
    end
wire [15:0] pixel_start;
wire [15:0] pixel_game;
wire [15:0] pixel_win;
wire [15:0] pixel_fail;
snake_start snake_start(
    .clk          (clk        ),  //input             clk        ,   //VGA驱动时钟
    .rstn         (rstn       ),  //input             rstn       ,   //复位信号
    .pixel_xpos   (pixel_xpos ),  //input      [10:0] pixel_xpos ,
    .pixel_ypos   (pixel_ypos ),  //input      [10:0] pixel_ypos ,
    .pixel_start  (pixel_start)   //output reg [15:0] pixel_start 
);
snake_game snake_game(
    .clk         (clk       ),  //input             clk       ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input             rstn      ,   //复位信号
    .up          (up        ),  //input             up        ,
    .down        (down      ),  //input             down      ,
    .right       (right     ),  //input             right     ,
    .left        (left      ),  //input             left      ,
    .start       (start     ),  //input             start     ,
    .pixel_xpos  (pixel_xpos),  //input      [10:0] pixel_xpos,
    .pixel_ypos  (pixel_ypos),  //input      [10:0] pixel_ypos,
    .die         (die       ),  //output reg        die       ,
    .win         (win       ),  //output reg        win       ,
    .pixel_game  (pixel_game)   //output reg [15:0] pixel_game 
);
snake_win snake_win(
    .clk         (clk       ),  //input             clk        ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input             rstn       ,   //复位信号
    .pixel_xpos  (pixel_xpos),  //input      [10:0] pixel_xpos ,
    .pixel_ypos  (pixel_ypos),  //input      [10:0] pixel_ypos ,
    .pixel_win   (pixel_win )   //output reg [15:0] pixel_win   
);
snake_fail snake_fail(
    .clk         (clk       ),  //input             clk        ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input             rstn       ,   //复位信号
    .pixel_xpos  (pixel_xpos),  //input      [10:0] pixel_xpos ,
    .pixel_ypos  (pixel_ypos),  //input      [10:0] pixel_ypos ,
    .pixel_fail  (pixel_fail)   //output reg [15:0] pixel_fail   
);
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_data <= 0;
        end else if(win_state)begin
            pixel_data <= pixel_win;
        end else if(die_state)begin
            pixel_data <= pixel_fail;
        end else if(!start)begin
            pixel_data <= pixel_start;
        end else begin
            pixel_data <= pixel_game;
        end
    end

endmodule
