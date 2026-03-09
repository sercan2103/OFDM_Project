`timescale 1ns / 1ps

module ofdm_decoder_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // 100 MHz clock
    
    // Inputs
    reg clock;
    reg enable;
    reg reset;
    reg reset_dot11;
    reg [4:0] state;
    reg [4:0] old_state;
    reg [31:0] sample_in;
    reg sample_in_strobe;
    reg soft_decoding;
    reg soft_bits_method;
    reg [7:0] rate;
    reg do_descramble;
    reg [19:0] num_bits_to_decode;
    reg [31:0] csi;
    reg csi_valid;
    reg [31:0] noise_var;
    reg noise_var_valid;
    
    // Outputs
    wire bit_in;
    wire bit_in_stb;
    wire [5:0] demod_out;
    wire [17:0] demod_soft_bits;
    wire demod_out_strobe;
    wire [7:0] deinterleave_erase_out;
    wire deinterleave_erase_out_strobe;
    wire conv_decoder_out;
    wire conv_decoder_out_stb;
    wire descramble_out;
    wire descramble_out_strobe;
    wire [7:0] byte_out;
    wire byte_out_strobe;
    
    // Instantiate the Unit Under Test (UUT)
    ofdm_decoder uut (
        .clock(clock),
        .enable(enable),
        .reset(reset),
        .reset_dot11(reset_dot11),
        .state(state),
        .old_state(old_state),
        .sample_in(sample_in),
        .sample_in_strobe(sample_in_strobe),
        .soft_decoding(soft_decoding),
        .soft_bits_method(soft_bits_method),
        .rate(rate),
        .do_descramble(do_descramble),
        .num_bits_to_decode(num_bits_to_decode),
        .csi(csi),
        .csi_valid(csi_valid),
        .noise_var(noise_var),
        .noise_var_valid(noise_var_valid),
        .bit_in(bit_in),
        .bit_in_stb(bit_in_stb),
        .demod_out(demod_out),
        .demod_soft_bits(demod_soft_bits),
        .demod_out_strobe(demod_out_strobe),
        .deinterleave_erase_out(deinterleave_erase_out),
        .deinterleave_erase_out_strobe(deinterleave_erase_out_strobe),
        .conv_decoder_out(conv_decoder_out),
        .conv_decoder_out_stb(conv_decoder_out_stb),
        .descramble_out(descramble_out),
        .descramble_out_strobe(descramble_out_strobe),
        .byte_out(byte_out),
        .byte_out_strobe(byte_out_strobe)
    );
    
    // Clock generation
    initial begin
        clock = 0;
        forever #(CLK_PERIOD/2) clock = ~clock;
    end
    
    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        enable = 1;
        reset_dot11 = 1;
        state = 0;
        old_state = 0;
        sample_in = 0;
        sample_in_strobe = 0;
        soft_decoding = 1;  // Enable soft decoding
        soft_bits_method = 0;
        rate = 8'h0C;  // 6 Mbps rate (legacy BPSK 1/2)
        do_descramble = 0;
        num_bits_to_decode = 48;  // One OFDM symbol (SIGNAL field)
        csi = 32'h1000;  // Some CSI value
        csi_valid = 0;
        noise_var = 32'h100;  // Noise variance
        noise_var_valid = 0;
        
        // Wait for global reset
        #100;
        reset = 0;
        reset_dot11 = 0;
        
        // Wait some time
        #200;
        
        // Provide CSI and noise variance
        @(posedge clock);
        csi_valid <= 1;
        noise_var_valid <= 1;
        
        @(posedge clock);
        csi_valid <= 0;
        noise_var_valid <= 0;
        
        #100;
        
        // Send some test samples (simulating BPSK modulated data)
        repeat(48) begin  // One OFDM symbol
            @(posedge clock);
            sample_in_strobe <= 1;
            // Generate BPSK-like samples (around +/- 1024)
            sample_in <= ($random % 2) ? {16'h0400, 16'h0000} : {16'hFC00, 16'h0000};
        end
        
        @(posedge clock);
        sample_in_strobe <= 0;
        
        // Enable descrambling for data
        #1000;
        do_descramble <= 1;
        num_bits_to_decode <= 1000;  // More bits for data
        rate <= 8'h0C;  // 6 Mbps
        
        // Send more test samples
        repeat(200) begin
            @(posedge clock);
            sample_in_strobe <= 1;
            sample_in <= $random;
        end
        
        @(posedge clock);
        sample_in_strobe <= 0;
        
        // Wait for processing
        #20000;
        
        $display("Test completed at time %t", $time);
        $finish;
    end
    
    // Monitor key signals
    always @(posedge clock) begin
        if (demod_out_strobe) begin
            $display("Time %t: Demod output=%b, soft_bits=%h", $time, demod_out, demod_soft_bits);
        end
        if (deinterleave_erase_out_strobe) begin
            $display("Time %t: Deinterleave output=%b", $time, deinterleave_erase_out);
        end
        if (conv_decoder_out_stb) begin
            $display("Time %t: Viterbi decoder output=%b", $time, conv_decoder_out);
        end
        if (descramble_out_strobe) begin
            $display("Time %t: Descrambler output=%b", $time, descramble_out);
        end
        if (byte_out_strobe) begin
            $display("Time %t: Byte output=%h", $time, byte_out);
        end
    end

endmodule
