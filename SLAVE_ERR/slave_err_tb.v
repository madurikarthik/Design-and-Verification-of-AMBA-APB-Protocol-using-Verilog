`timescale 1ns / 1ps 
module apb_slverr_tb; 
    reg        PCLK; 
    reg        PRESETn; 
    reg        PSEL; 
    reg        PENABLE; 
    reg        PWRITE; 
    reg  [7:0] PADDR; 
    reg  [7:0] PWDATA; 
    wire [7:0] PRDATA; 
    wire       PREADY; 
    wire       PSLVERR; 
 
    // Instantiate DUT 
    apb_slverr uut ( 
        .PCLK(PCLK), 
        .PRESETn(PRESETn), 
        .PSEL(PSEL), 
        .PENABLE(PENABLE), 
        .PWRITE(PWRITE), 
        .PADDR(PADDR), 
        .PWDATA(PWDATA), 
        .PRDATA(PRDATA),  
        .PREADY(PREADY), 
        .PSLVERR(PSLVERR) 
    ); 
 
    // Clock generation 
    initial begin 
        PCLK = 0; 
        forever #5 PCLK = ~PCLK; // 10ns period 
    end 
 
    // Stimulus 
    initial begin 
        // Initial 
        PRESETn = 0; PSEL = 0; PENABLE = 0; PWRITE = 0;  
        PADDR = 8'h00; PWDATA = 8'h00; 
 
        // Release reset 
        #12 PRESETn = 1; 
 
        // VALID WRITE to reg0 (addr 0x00) 
        #10 PSEL=1; PWRITE=1; PENABLE=0; PADDR=8'h00; PWDATA=8'hAA; 
        #10 PENABLE=1; 
        #10 PSEL=0; PENABLE=0; 
 
        // VALID READ from reg0 
        #10 PSEL=1; PWRITE=0; PENABLE=0; PADDR=8'h00; 
        #10 PENABLE=1; 
        #10 PSEL=0; PENABLE=0; 
 
        // INVALID WRITE to addr 0x08 ? expect PSLVERR=1 
        #10 PSEL=1; PWRITE=1; PENABLE=0; PADDR=8'h08; PWDATA=8'h55; 
        #10 PENABLE=1; 
        #10 PSEL=0; PENABLE=0; 
 
        // INVALID READ from addr 0x0C ? expect PSLVERR=1 
        #10 PSEL=1; PWRITE=0; PENABLE=0; PADDR=8'h0C; 
        #10 PENABLE=1; 
        #10 PSEL=0; PENABLE=0; 
 
        #20 $finish; 
    end 
 
    // Monitor 
    initial begin 
        $monitor("T=%0t | PADDR=%h | PWRITE=%b | PWDATA=%h | PRDATA=%h | PSLVERR=%b | 
PREADY=%b", 
                 $time, PADDR, PWRITE, PWDATA, PRDATA, PSLVERR, PREADY); 
    end 
endmodule
