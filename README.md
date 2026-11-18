The Advanced Microcontroller Bus Architecture – Advanced Peripheral Bus (AMBA-APB) 
protocol is a part of ARM’s AMBA family designed for connecting low-bandwidth and low- power 
peripheral devices in System-on-Chip (SoC) environments. APB offers a simple, non- pipelined, and 
cost-effective interface ideal for register-based communication with peripherals such as timers, UARTs, 
and GPIO controllers. This project focuses on the design and verification of the AMBA-APB protocol 
using Verilog. The implementation includes a fully functional APB slave module that supports both read 
and write transactions in accordance with the APB3 specification. The design employs a finite state 
machine to manage the setup and enable phases of data transfer, ensuring correct timing and protocol 
compliance. 
A Verilog-based testbench is developed to verify functional correctness, simulating a series of valid 
APB transactions. The simulation results are analyzed using waveform viewers, demonstrating that the 
design correctly handles address decoding, data transfer, and ready signaling. The project provides a 
practical understanding of peripheral interfacing in SoC design and showcases the role of bus protocols 
in low-latency, high- efficiency communication between processors and peripherals. The Advanced 
Peripheral Bus (APB) protocol is a fundamental communication standard in the world of SoC design. Its 
simplicity, power efficiency, and scalability make it an essential choice for connecting low-speed 
peripherals to microcontrollers and microprocessors. While it may not be suitable for high-speed data 
transfers, its significance lies in its ability to provide a reliable and standardized interface for a wide range 
of peripheral devices. As technology continues to advance, APB will likely remain a vital part of SoC 
design for years.


The main objectives of this project are: 
. To design the AMBA-APB protocol using Verilog HDL with accurate timing and signal 
specifications. 
. To understand the functionality and handshaking mechanism between master and slave modules. 
. To perform functional verification using simulation tools (such as Model Sim or Xilinx Vivado) 
and validate correct data transfer. 
. To ensure low-power operation, simplified communication, and error-free signal transmission 
between peripheral devices and the main processor. 
. To analyse the read and write transactions in APB and verify its compliance with standard AMBA 
specifications.
