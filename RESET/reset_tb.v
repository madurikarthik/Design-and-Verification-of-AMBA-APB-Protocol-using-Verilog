`timescale 1ns / 1ps 
 module apb_reset_tb; 
    reg        PCLK; 
    reg        PRESETn; 
    reg        PSEL; 
    reg        PENABLE; 
    reg        PWRITE; 
    reg  [7:0] PADDR; 
    reg  [7:0] PWDATA; 
    wire [7:0] PRDATA; 
    wire       PREADY; 
 
    // Instantiate DUT 
    apb_reset uut ( 
        .PCLK(PCLK), 
        .PRESETn(PRESETn), 
        .PSEL(PSEL), 
        .PENABLE(PENABLE), 
        .PWRITE(PWRITE), 
        .PADDR(PADDR), 
        .PWDATA(PWDATA), 
        .PRDATA(PRDATA), 
        .PREADY(PREADY) 
    ); 
   
    // Clock generation 
    initial begin 
        PCLK = 0; 
        forever #5 PCLK = ~PCLK; // 10ns period 
    end 
 
    initial begin 
        // Initial values 
        PRESETn = 0; PSEL = 0; PENABLE = 0; PWRITE = 0;  
        PADDR = 8'h00; PWDATA = 8'h00; 
         
        // Apply reset 
        #15 PRESETn = 1; // Release reset 
         
        // Write to reg0 
        #10 PSEL = 1; PWRITE = 1; PENABLE = 0; PADDR = 8'h00; PWDATA = 8'h55; // Setup 
        #10 PENABLE = 1; // Enable phase 
        #10 PSEL = 0; PENABLE = 0; 
 
        // Read back from reg0 
        #10 PSEL = 1; PWRITE = 0; PENABLE = 0; PADDR = 8'h00; 
        #10 PENABLE = 1; 
        #10 PSEL = 0; PENABLE = 0; 
        // Apply reset again 
        #10 PRESETn = 0; // All outputs should reset 
        #10 PRESETn = 1; // Release reset 
        #20 $finish; 
    end 
    // Monitor 
    initial begin 
        $monitor("T=%0t | PRESETn=%b | PSEL=%b | PENABLE=%b | PWRITE=%b | PADDR=%h | 
PWDATA=%h | PRDATA=%h | PREADY=%b | reg0=%h", 
                  $time, PRESETn, PSEL, PENABLE, PWRITE, PADDR, PWDATA, PRDATA, PREADY, 
uut.reg0); 
    end 
endmodule
