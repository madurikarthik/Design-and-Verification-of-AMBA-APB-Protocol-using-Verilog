module apb_top ( 
    input wire PCLK, 
    input wire PRESETn, 
    input wire [7:0] PADDR, 
    input wire [7:0] PWDATA, 
    input wire PWRITE, 
    input wire PSEL0, 
    input wire PSEL1, 
    input wire PENABLE, 
    output wire [7:0] PRDATA0, 
    output wire [7:0] PRDATA1, 
    output wire PREADY0, 
    output wire PREADY1, 
    output wire PSLVERR0, 
    output wire PSLVERR1 
); 
 
    apb_psel #(.ADDR_BASE(8'h00)) slave0 ( 
        .PCLK(PCLK), .PRESETn(PRESETn), .PSEL(PSEL0), .PENABLE(PENABLE), 
        .PWRITE(PWRITE), .PADDR(PADDR), .PWDATA(PWDATA), 
        .PRDATA(PRDATA0), .PREADY(PREADY0), .PSLVERR(PSLVERR0) 
    ); 
 
    apb_psel #(.ADDR_BASE(8'h10)) slave1 ( 
        .PCLK(PCLK), .PRESETn(PRESETn), .PSEL(PSEL1), .PENABLE(PENABLE), 
        .PWRITE(PWRITE), .PADDR(PADDR), .PWDATA(PWDATA), 
        .PRDATA(PRDATA1), .PREADY(PREADY1), .PSLVERR(PSLVERR1) 
    ); 
 
endmodule
