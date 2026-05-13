`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when powered
    input  wire       clk,      // clock
    input  wire       rst_n     // active low reset
);

    reg [3:0] count;

    // 4-bit down counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b1111;
        else
            count <= count - 1'b1;
    end

    // Output count on lower 4 bits
    assign uo_out = {4'b0000, count};

    // Unused bidirectional IOs
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent unused signal warnings
    wire _unused = &{ui_in, uio_in, ena, 1'b0};

endmodule

`default_nettype wire
