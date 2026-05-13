`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Generate waveform dump
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
  end

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate DUT
  tt_um_example user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin

    // Initialize signals
    ena = 1'b1;
    rst_n = 1'b0;
    ui_in = 8'b0;
    uio_in = 8'b0;

    // Hold reset
    #20;

    // Release reset
    rst_n = 1'b1;

    // Run counter
    #200;

    $finish;
  end

  // Monitor counter output
  initial begin
    $monitor("Time=%0t | Reset=%b | Count=%b",
              $time, rst_n, uo_out[3:0]);
  end

endmodule

`default_nettype wire
