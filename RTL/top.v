module top(
    input           clk       ,   //VGA驱动时钟
    input           rstn      ,   //复位信号
    input           key_up    ,
    input           key_down  ,
    input           key_right ,
    input           key_left  ,
    output          vga_hs    ,   //行同步信号
    output          vga_vs    ,   //场同步信号
    output  [15:0]  vga_rgb       //红绿蓝三原色输出
);
wire          up   ;
wire          down ;
wire          right;
wire          left ;
wire  [15:0]  pixel_data;
wire          data_req  ;
wire  [10:0]  pixel_xpos;
wire  [10:0]  pixel_ypos;
shake shake1(
    .clk    (clk      ),  //input      clk   ,
    .rstn   (rstn     ),  //input      rstn  ,
    .key    (key_up   ),  //input      key   ,
    .shape  (up       )   //output reg shape  
);
shake shake2(
    .clk    (clk      ),  //input      clk   ,
    .rstn   (rstn     ),  //input      rstn  ,
    .key    (key_down ),  //input      key   ,
    .shape  (down     )   //output reg shape  
);
shake shake3(
    .clk    (clk      ),  //input      clk   ,
    .rstn   (rstn     ),  //input      rstn  ,
    .key    (key_right),  //input      key   ,
    .shape  (right    )   //output reg shape  
);
shake shake4(
    .clk    (clk     ),  //input      clk   ,
    .rstn   (rstn    ),  //input      rstn  ,
    .key    (key_left),  //input      key   ,
    .shape  (left    )   //output reg shape  
);
control control(
    .clk         (clk       ),  //input             clk       ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input             rstn      ,   //复位信号
    .up          (up        ),  //input             up        ,
    .down        (down      ),  //input             down      ,
    .right       (right     ),  //input             right     ,
    .left        (left      ),  //input             left      ,
    .pixel_xpos  (pixel_xpos),  //input      [10:0] pixel_xpos,
    .pixel_ypos  (pixel_ypos),  //input      [10:0] pixel_ypos,
    .pixel_data  (pixel_data)   //output reg [15:0] pixel_data 
);
vga_driver vga_driver(
    .clk         (clk       ),  //input           clk       ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input           rstn      ,   //复位信号
    .vga_hs      (vga_hs    ),  //output          vga_hs    ,   //行同步信号
    .vga_vs      (vga_vs    ),  //output          vga_vs    ,   //场同步信号
    .vga_rgb     (vga_rgb   ),  //output  [15:0]  vga_rgb   ,   //红绿蓝三原色输出
    .pixel_data  (pixel_data),  //input   [15:0]  pixel_data,   //像素点数据
    .data_req    (data_req  ),  //output          data_req  ,   //请求像素点颜色数据输入 
    .pixel_xpos  (pixel_xpos),  //output  [10:0]  pixel_xpos,   //像素点横坐标
    .pixel_ypos  (pixel_ypos)   //output  [10:0]  pixel_ypos    //像素点纵坐标    
);   

endmodule
