`timescale 1ns / 1ps 
module apb_slverr( 
    input  wire       PCLK, 
    input  wire       PRESETn, 
    input  wire       PSEL, 
    input  wire       PENABLE, 
    input  wire       PWRITE, 
    input  wire [7:0] PADDR, 
    input  wire [7:0] PWDATA, 
    output reg  [7:0] PRDATA, 
    output reg        PREADY, 
    output reg        PSLVERR); 
 
    reg [7:0] reg0, reg1; 
 
    always @(posedge PCLK or negedge PRESETn) begin 
        if (!PRESETn) begin 
            reg0    <= 8'd0; 
            reg1    <= 8'd0; 
            PRDATA  <= 8'd0; 
            PREADY  <= 1'b0; 
            PSLVERR <= 1'b0; 
        end 
 
        else begin 
            PREADY  <= 1'b1; // Always ready for simplicity 
            PSLVERR <= 1'b0; // Default no error 
 
            if (PSEL && PENABLE) begin 
                if (PWRITE) begin 
                    case (PADDR) 
                        8'h00: reg0 <= PWDATA; 
                        8'h04: reg1 <= PWDATA; 
                        default: PSLVERR <= 1'b1; // Invalid address write 
                    endcase 
                end 
                else begin 
                    case (PADDR) 
                        8'h00: PRDATA <= reg0; 
                        8'h04: PRDATA <= reg1; 
                        default: begin 
                            PRDATA  <= 8'd0; 
                            PSLVERR <= 1'b1; // Invalid address read 
                        end 
                    endcase 
                end 
            end 
        end 
    end 
endmodule 
