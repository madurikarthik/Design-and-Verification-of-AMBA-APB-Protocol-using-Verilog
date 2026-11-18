`timescale 1ns / 1ps 
Module 
apb1_slave(PCLK,PRESETn,PSEL,PENABLE,PADDR,PWDATA,PRDATA,PREADY,PSLVERR,PWRITE,reg0_out,reg1_out); 
    input PCLK; 
    input        PRESETn; 
    input        PSEL; 
    input        PENABLE; 
    input        PWRITE; 
    input  [7:0] PADDR; 
    input  [7:0] PWDATA;  
    output reg [7:0] PRDATA; 
    output       PREADY; 
    output       PSLVERR; 
    output       reg0_out; 
    output       reg1_out; 
 
    reg [7:0] reg0; 
    reg [7:0] reg1; 
     
    assign reg0_out=reg0; 
    assign reg1_out=reg1; 
    assign PREADY = 1'b1;      // Always ready 
    assign PSLVERR = 1'b0;     // No error 
 
    always @(posedge PCLK or negedge PRESETn) begin 
        if (!PRESETn) begin 
            reg0 <= 8'd0; 
            reg1 <= 8'd0; 
            PRDATA <= 8'd0; 
        end else begin 
            if (PSEL && PENABLE) begin 
                if (PWRITE) begin 
                    case (PADDR) 
                        8'h00: reg0 <= PWDATA; 
                        8'h01: reg1 <= PWDATA; 
                    endcase 
                end else begin 
                    case (PADDR) 
                        8'h00: PRDATA <= reg0; 
                        8'h01: PRDATA <= reg1; 
                        default: PRDATA <= 8'd0; 
                    endcase 
                end 
            end 
        end 
    end 
endmodule
