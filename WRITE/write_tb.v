`timescale 1ns / 1ps 
module apb1_master; 
    reg        PCLK; 
    reg        PRESETn; 
    reg        PSEL; 
    reg        PENABLE; 
    reg        PWRITE; 
    reg [7:0]  PADDR; 
    reg [7:0]  PWDATA; 
    wire [7:0] PRDATA;  
    wire       PREADY; 
    wire       PSLVERR; 
 
    apb1_slave 
uut(PCLK,PRESETn,PSEL,PENABLE,PADDR,PWDATA,PRDATA,PREADY,PSLVERR,PWRITE,reg0_out,reg1_out); 
 
    initial begin 
        PCLK = 0; 
        forever #5 PCLK = ~PCLK; 
    end 
 
    initial begin 
        PRESETn = 0; PSEL = 0; PENABLE = 0; PWRITE = 0; 
        PADDR = 8'd0; PWDATA = 8'd0; 
        #10 PRESETn = 1; 
 
        // Write 55 to address 00 
        #10 PADDR = 8'h00; PWDATA = 8'h55; PWRITE = 1; PSEL = 1; PENABLE = 0; 
        #10 PENABLE = 1; 
        #10 $display("reg0_out=%h,reg1_out=%h",reg0_out,reg1_out); 
        #10 PSEL = 0; PENABLE = 0; 
 
        // Read from address 00 
        #10 PADDR = 8'h00; PWRITE = 0; PSEL = 1; PENABLE = 0; 
        #10 PENABLE = 1; 
        #10 $display("reg0_out=%h,reg1_out=%h",reg0_out,reg1_out); 
        #10 PSEL = 0; PENABLE = 0; 
 
        // End simulation 
        #20 $finish; 
    end 
endmodule
