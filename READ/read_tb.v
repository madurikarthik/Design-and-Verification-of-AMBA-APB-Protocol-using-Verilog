`timescale 1ns / 1ps 
module apb_read_tb; 
    reg        PCLK; 
    reg        PRESETn; 
    reg        PSEL; 
    reg        PENABLE; 
    reg        PWRITE; 
    reg  [7:0] PADDR; 
    wire [7:0] PRDATA; 
    wire       PREADY; 
 
    // Instantiate the APB slave 
    apb_read uut ( 
        .PCLK(PCLK), 
        .PRESETn(PRESETn), 
        .PSEL(PSEL), 
        .PENABLE(PENABLE), 
        .PWRITE(PWRITE), 
        .PADDR(PADDR), 
        .PRDATA(PRDATA), 
        .PREADY(PREADY) 
    ); 
 
    // Clock generation 
    initial begin 
        PCLK = 0; 
        forever #5 PCLK = ~PCLK; 
    end 
 
    // Stimulus 
 
    initial begin 
        // Initialize signals 
        PRESETn = 0; PSEL = 0; PENABLE = 0; PWRITE = 0; PADDR = 8'h00; 
        #10 PRESETn = 1; // Release reset 
 
        // ---- APB Read Transfer ---- 
        // Setup phase 
        #10 PSEL = 1; PADDR = 8'h00; PWRITE = 0; PENABLE = 0; 
 
        // Enable phase 
        #10 PENABLE = 1; 
 
        // Idle phase 
        #10 PSEL = 0; PENABLE = 0; 
 
        #20 $finish; 
    end 
 
    // Monitor outputs 
    initial begin 
        $monitor("Time=%0t | PSEL=%b PENABLE=%b PWRITE=%b PADDR=%h PRDATA=%h", 
                 $time, PSEL, PENABLE, PWRITE, PADDR, PRDATA); 
    end 
endmodule
