`timescale 1ns / 1ps 
module apb_enable( 
input        PCLK, 
input        PRESETn,
input        PSEL,
input        PENABLE,
input        PWRITE,
input  [7:0] PADDR, 
input  [7:0] PWDATA, 
output reg [7:0] PRDATA, 
output
       PREADY, 
output
       PSLVERR); 
reg [7:0] reg0; 
reg [7:0] reg1; 
// Always ready, no errors 
assign PREADY  = 1'b1; 
assign PSLVERR = 1'b0; 
always @(posedge PCLK or negedge PRESETn) begin 
if (!PRESETn) begin 
reg0   <= 8'd0; 
reg1   <= 8'd0; 
PRDATA <= 8'd0; 
end  
else if (PSEL && PENABLE && PREADY) begin 
if (PWRITE) begin 
// WRITE operation 
                case (PADDR) 
                    8'h00: reg0 <= PWDATA; 
                    8'h01: reg1 <= PWDATA; 
                    default: ; // Ignore invalid addresses 
                endcase 
            end 
            else begin 
                // READ operation 
                case (PADDR) 
                    8'h00: PRDATA <= reg0; 
                    8'h01: PRDATA <= reg1; 
                    default: PRDATA <= 8'd0; 
                endcase 
            end 
        end 
    end 
endmodule 
