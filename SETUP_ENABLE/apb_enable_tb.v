`timescale 1ns / 1ps 
module apb_enable_tb; 
    reg        PCLK; 
    reg        PRESETn; 
    reg        PSEL; 
    reg        PENABLE; 
    reg        PWRITE; 
    reg [7:0]  PADDR; 
    reg [7:0]  PWDATA; 
     reg        PREADY;   // TB-controlled ready signal 
    wire [7:0] PRDATA; 
    wire       PSLVERR; 
 
    // Instantiate DUT 
    apb_enable dut ( 
        .PCLK(PCLK),  
        .PRESETn(PRESETn), 
        .PSEL(PSEL), 
        .PENABLE(PENABLE), 
        .PWRITE(PWRITE), 
        .PADDR(PADDR), 
        .PWDATA(PWDATA), 
        .PRDATA(PRDATA), 
        .PSLVERR(PSLVERR) 
    ); 
 
    // Clock generation 
    initial begin 
        PCLK = 0; 
        forever #5 PCLK = ~PCLK; // 100 MHz clock 
    end 
 
    initial begin 
        // Initialize 
        PRESETn = 0; 
        PSEL = 0; 
        PENABLE = 0; 
        PWRITE = 0; 
        PADDR = 0; 
        PWDATA = 0; 
        PREADY = 1;  // Initially ready 
        #12 PRESETn = 1; 
 
        // Write transaction with wait state 
        $display("=== WRITE with wait state ==="); 
        PADDR = 8'h00; PWDATA = 8'h55; PWRITE = 1; PSEL = 1; PENABLE = 0; 
        #10 PENABLE = 1; PREADY = 0; // Wait state inserted 
        #20 PREADY = 1; // Now ready, write completes 
        #10 PSEL = 0; PENABLE = 0; 
 
        // Read transaction with wait state 
        $display("=== READ with wait state ==="); 
        PADDR = 8'h00; PWRITE = 0; PSEL = 1; PENABLE = 0; 
        #10 PENABLE = 1; PREADY = 0; // Wait state inserted 
        #20 PREADY = 1; // Now ready, read completes 
        #10 PSEL = 0; PENABLE = 0; 
 
        // Display result 
        $display("Read data: %h", PRDATA); 
        #20 $finish; 
    end 
endmodule 
