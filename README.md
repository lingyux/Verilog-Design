# Verilog-Design

## HDB3
实现HDB3编码和解码, 并实现硬件调试, 并配有实验报告

## 数字时钟

### 开发板
正点原子的新起点开发板, 时钟为50MHz. 仿真平台采用ModelSim. 
### 输入
共有四个按键输入, 分别的作用为
 1. key_in_m: 选择时钟当前模式, 分别为始终模式选择, 调整始终, 显示闹铃时间, 确认
2. key_in_p: 调整时间按钮, 每次按下加一, 到九归零, 每次只调整一位, 需要配和key_in_n可以调整分和时
3. key_in_n: 选择调整时间的位置
4. key_in_e: 确认, 将当前的输入传送至各个模块

### 输出
1. led[3:0]显示当前时钟模式, 四个全亮的时候代表当前为闹铃时间
2. 六段数码管, 显示当前时间, 闹铃时间等


## Rs232串口
### 开发板
正点原子的新起点开发板, 时钟为50MHz. 仿真平台采用ModelSim. 
### 实现目标
通过电脑向FPGA串口发送数据, FPGA接收后, 将数据发送给电脑, 完成一次数据回环
### 输入信号
- clk: 时钟输入, 提供时钟信号
- rst_n: 复位信号
- rx: 接收电脑发送的串口数据
### 输出信号
- tx: 讲数据发送给电脑, 完成数据回环

## VGA驱动
### 开发板
正点原子的新起点开发板, 时钟为50MHz. 仿真平台采用ModelSim. 
### 实现目标
- 在VGA显示屏上实现彩带显示`vga`
- 显示字符`vga_char`
### 输入信号
- clk	: 时钟信号
- rst_n	: 复位信号
### 输出信号
- hsync	: 行同步信号
- vsync	: 场同步信号
- vga_rgb : 显示的数据

## 红外协议
### 开发板
正点原子的新起点开发板, 时钟为50MHz. 仿真平台采用ModelSim. 
### 实现目标
- 解析接收到的红外遥控器发送的数据, 并将相应的数据显示在数码管上
### 输入信号
- sys_clk	系统时钟信号
- sys_rst_n	系统复位新仓
- inf_in	红外接收头接收到的红外信号
### 输出信号
- led	当长时间按下同一个按键时, led闪烁
- seg	数码管段选信号
- sel	数码管位选信号
### NEC红外传输协议
- 参考链接[NEC协议](https://www.cnblogs.com/mylinux/p/5084264.html)
#### 数据帧的定义
NEC协议采用的是PPM(脉冲位置调试)进行编码. 当我们按下一次按键的时候, 会发送一帧的数据. 数据有引导码, 地址码, 地址反码, 数据码, 数据反码以及一位的结束位组成.
![一帧数据](https://i.loli.net/2021/07/31/EwoMQgirqITHFlD.png)
		如上图所示: 9ms的高电平脉冲个4.5ms的低电平组成了引导码. 紧接着是地址码和地址反码, 低位在前, 高位在后. 最后是560us的高电平脉冲表示结束位. 
#### 0和1的定义
![0和1的定义](https://i.loli.net/2021/07/31/idzL2pNIV6ou5BD.png)
		由上图可知, 逻辑0和逻辑1是由脉冲之间的时间间隔来区分的, 逻辑1由560us的高脉冲加上1.69ms 的低电平组成, 逻辑0由560us的高电平脉冲加加上560us的低电平组成. 在实际操作的时候可以适当放宽一定的时间来避免传输中的数据错误

#### 重复码的定义
![重复码的定义](https://i.loli.net/2021/07/31/6WLJdY5pje3EXmO.png)
		当长时间按住某一个键位的时候, 每隔110ms就会发送一个重复码, 重复码由9ms的高电平和2.25ms 的低电平以及560us的高电平(结束位)组成.

#### FPGA接收到的波形
使用一体化接收头接收到的信号输入到FPGA的波形刚好与发送的波形相反. 发送高电平, 接收后输出就为低电平, 发送低电平, 接收后输出就为高电平. FGPA接收到的波形如下图所示
![引导码接收的波形](https://i.loli.net/2021/07/31/AfIycdl9B1eJV7o.png)
![逻辑1和逻辑0接收到的波形](https://i.loli.net/2021/07/31/mYO8Ic5yWsZAJuK.png)
![重复码接收到的波形](https://i.loli.net/2021/07/31/Dt2JakZceF4fyqb.png)

## hdmi驱动
### 开发板
正点原子的新起点开发板, 时钟为50MHz. 仿真平台采用ModelSim. 

### 实现目标
- 在hdmi显示屏上实现彩带显示

### 输入信号
- clk	: 时钟信号
- rst_n	: 复位信号

### 输出信号
输出的信号为四对差分信号，和两个I2C控制信号
- ddc_scl		I2C串行时钟,
- ddc_sda		I2C串行数据,
- red_p			红色分量的差分传输信号,
- red_n			,
- green_p		绿色分量的差分传输信号,
- green_n		,
- blue_p		蓝色分量的差分传输信号,
- blue_n		,
- clk_p			差分时钟信号,
- clk_n			 	

### 传输编码方式
- hdmi采用TMDS编码方式进行传输，编码原则如下
![tmds编码](https://i.loli.net/2021/08/17/sbLnx87IpUfTkG1.png)

### 参考文档
[DVI 1.0.pdf](https://github.com/lingyux/Verilog-Design/blob/main/hdmi/doc/DVI%20V1.0.pdf)
[HDMI Specification 13a.pdf](https://github.com/lingyux/Verilog-Design/blob/main/hdmi/doc/HDMI%20Specification%2013a.pdf)

## tft液晶驱动
### 开发板
正点原子的新起点开发板, 时钟为50MHz. 仿真平台采用ModelSim. 

### 实现目标
- 在tft液晶显示屏上实现彩带显示等宽10色彩条

### 输入信号
- clk	: 时钟信号
- sys_rst_n	: 复位信号

### 输出信号
- hsync	: 行同步信号
- vsync	: 场同步信号
- tft_rgb : 显示的数据
- tft_de  : 图像使能信号
- tft_clk  : 时钟信号
- tft_bl   : 背光使能信号

### 液晶显示原理
1. HV同步模式
HV同步模式下，图像的实现需要行场同步信号来确定显示的时序。此时RGB接口的是TFT-LCD时序和VGA时序类似。
![TFT液晶显示HV同步模式行时序图](https://i.loli.net/2021/08/17/SALRcB96MYbTVwf.png)
![TFT液晶显示HV同步模式场时序图](https://i.loli.net/2021/08/17/tVaoiH39xr4vlU6.png)
![TFT液晶显示HV同步模式时序图](https://i.loli.net/2021/08/17/YyTI8lChR4q7e2i.png)
2. DE同步模式
DE同步模式下，图像的显示只需要接收数据使能信号来确定显示时序，不需要行场同步信号。
![DE同步模式TFT图像显示时序图](https://i.loli.net/2021/08/17/67yLOxaAkFlSDQ1.png)
3. 常见的分辨率的显示屏时序参数
![TFT-LCD显示屏的时序参数](https://i.loli.net/2021/08/17/9vjLC7WFanh8NGI.png)

