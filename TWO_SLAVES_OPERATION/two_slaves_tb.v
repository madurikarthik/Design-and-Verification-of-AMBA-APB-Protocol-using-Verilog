module apb_psel_tb; 
    reg PCLK; 
    reg PRESETn; 
    reg [7:0] PADDR; 
    reg [7:0] PWDATA; 
    reg PWRITE; 
    reg PSEL0, PSEL1; 
    reg PENABLE; 
    wire [7:0] PRDATA0, PRDATA1; 
    wire PREADY0, PREADY1; 
    wire PSLVERR0, PSLVERR1; 
 
    // Instantiate DUT 
    apb_top dut ( 
        .PCLK(PCLK), .PRESETn(PRESETn), 
        .PADDR(PADDR), .PWDATA(PWDATA), .PWRITE(PWRITE), 
        .PSEL0(PSEL0), .PSEL1(PSEL1), .PENABLE(PENABLE), 
        .PRDATA0(PRDATA0), .PRDATA1(PRDATA1), 
        .PREADY0(PREADY0), .PREADY1(PREADY1), 
        .PSLVERR0(PSLVERR0), .PSLVERR1(PSLVERR1) 
    ); 
 
    // Clock generation 
    initial begin 
        PCLK = 0; 
        forever #5 PCLK = ~PCLK; 
    end 
 
    // Stimulus 
    initial begin 
        PRESETn = 0; PSEL0 = 0; PSEL1 = 0; PENABLE = 0; 
        PWRITE = 0; PADDR = 0; PWDATA = 0; 
        #12 PRESETn = 1; 
 
        // Write to Slave0 reg0 
        #10 PADDR=8'h00; PWDATA=8'hAA; PWRITE=1; PSEL0=1; PENABLE=0; 
        #10 PENABLE=1; 
        #10 PSEL0=0; PENABLE=0; 
 
        // Read from Slave0 reg0 
        #10 PADDR=8'h00; PWRITE=0; PSEL0=1; PENABLE=0; 
        #10 PENABLE=1; 
        #10 PSEL0=0; PENABLE=0; 
 
        // Write to Slave1 reg0 
        #10 PADDR=8'h10; PWDATA=8'h55; PWRITE=1; PSEL1=1; PENABLE=0; 
        #10 PENABLE=1; 
        #10 PSEL1=0; PENABLE=0; 
 
        // Read from Slave1 reg0 
        #10 PADDR=8'h10; PWRITE=0; PSEL1=1; PENABLE=0; 
        #10 PENABLE=1; 
        #10 PSEL1=0; PENABLE=0; 
 
        #20 $finish; 
    end 
 
    // Monitor outputs 
    initial begin 
        $monitor("T=%0t | PADDR=%h | PWDATA=%h | PRDATA0=%h | PRDATA1=%h | PSLVERR0=%b 
|         PSLVERR1=%b", 
                  $time, PADDR, PWDATA, PRDATA0, PRDATA1, PSLVERR0, PSLVERR1); 
    end 
endmodule 
