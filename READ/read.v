`timescale 1ns / 1ps 
module apb_read( 
 
    input  wire       PCLK, 
    input  wire       PRESETn, 
    input  wire       PSEL, 
    input  wire       PENABLE, 
    input  wire       PWRITE, 
    input  wire [7:0] PADDR, 
    output reg  [7:0] PRDATA, 
    output wire       PREADY 
); 
 
    reg [7:0] reg0; 
  
    assign PREADY = 1'b1; // Always ready (no wait states) 
 
    always @(posedge PCLK or negedge PRESETn) begin 
        if (!PRESETn) begin 
            reg0 <= 8'hAA; // Example data stored in register 
            PRDATA <= 8'd0; 
        end 
        else begin 
            if (PSEL && PENABLE && !PWRITE) begin // Read Enable phase 
                case (PADDR) 
                    8'h00: PRDATA <= reg0; 
                    default: PRDATA <= 8'h00; 
                endcase 
            end 
        end 
    end 
 
endmodule
