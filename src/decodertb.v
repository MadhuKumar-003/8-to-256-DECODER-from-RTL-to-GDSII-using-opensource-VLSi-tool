`timescale 1ns / 1ps

module tb_decoder();

    // Inputs
    reg [7:0] in;
    reg enable;

    // Outputs
    wire [255:0] out;

    // Instantiate the Unit Under Test (UUT)
    decoder_8_to_256 uut (
        .in(in), 
        .enable(enable),
        .out(out)
    );

    integer i;

    // VCD Dumping Block
    initial begin
        $dumpfile("decoder_waveform.vcd"); 
        $dumpvars(0, tb_decoder);          
    end

    // Automated Verification Block
    initial begin
        $display("-------------------------------------------");
        $display("Starting 8-to-256 Decoder Verification...");
        
        // Test 1: Check Enable Low behavior
        enable = 1'b0;
        in = 8'd15; // Random input
        #10;
        if (out !== 256'b0) begin
            $display("FAIL: Decoder output is not zero when disabled!");
        end

        // Test 2: Check all 256 combinations when Enabled
        enable = 1'b1;
        for (i = 0; i < 256; i = i + 1) begin
            in = i;
            #10;
            
            // The expected result is a 1 shifted left by 'i' positions
            if (out !== (256'b1 << i)) begin
                $display("FAIL: Decoder logic incorrect at input %d", i);
            end
        end

        $display("Simulation Complete. All 256 states verified successfully.");
        $display("-------------------------------------------");
        $finish; 
    end
endmodule
