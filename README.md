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