# Zero_Risc

Zero Risc is a securuty driven hardware module writen in Verilog. This module implemntes a CFI .........

This project emerged from a college proposed project topic, wich itself came from the *RISC-V Soft CPU Security Contest by Thales and Microchip Technology*
https://github.com/ThalesGroup/RISC-V-IoT-Contest

## Problem Statement


## Design

### Table - CFG
Zero_Risc Control flow graph is represent using a table that stores information about the *jump* intructions and the adress to wjere that *jump* can branch.

![CFG table](pics/table.png  "CFG table")


### Decoder
The decoder submodule is responssible for

![Zero_Risc_decoder](pics/Zero_Risc_decoder.png)

### Zero_Risc module

![Zero_Risc_module](pics/Zero_Risc.png)



### Tipical system overview

![overview](pics/overview.png)



## Usage

Currently, Zero Risc works as a proof of concept. This means that for it to work you need to hardcode the table before deploying it to the FPGA.

This module can be used simply by adding it to your project a submodule. Then you need just to connect:
  * **i_clk** to provide a clock 
  * **i_rst** as reset (synchornous positive reset)
  * **i_instr_addr**  to the Instruction Address (PC) register
  * **o_signal** to an IRQ of your system, and write your interrupt responce routine


## The Repository is organized as follows:

  [Verilog](verilog) - HDL for the Zero Risc module

  [Sim](sim) - HDL for the Zero Risc module simulation

  [Ibex](ibex) - Link to the Ibex repository  


### To do
* Loader module to load the CFG table. This is currently being done by hardcoding in the *Verilog* code  
l
