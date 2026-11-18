`timescale 1ns / 1ps 
 module apb_reset( 
    input  wire       PCLK, 
    input  wire       PRESETn, 
    input  wire       PSEL, 
    input  wire       PENABLE, 
    input  wire       PWRITE, 
    input  wire [7:0] PADDR, 
    input  wire [7:0] PWDATA, 
    output reg  [7:0] PRDATA, 
    output reg        PREADY 
); 
 
    reg [7:0] reg0; 
 
    always @(posedge PCLK or negedge PRESETn) begin 
        if (!PRESETn) begin  
            // RESET STATE 
            reg0   <= 8'd0; 
            PRDATA <= 8'd0; 
            PREADY <= 1'b0; 
        end 
        else begin 
            PREADY <= 1'b1; // Always ready after reset 
 
            if (PSEL && PENABLE) begin 
                if (PWRITE) begin 
                    case (PADDR) 
                        8'h00: reg0 <= PWDATA; 
                    endcase 
                end 
                else begin 
                    case (PADDR) 
                        8'h00: PRDATA <= reg0; 
                        default: PRDATA <= 8'd0; 
                    endcase 
                end 
            end 
        end 
    end 
endmodule
