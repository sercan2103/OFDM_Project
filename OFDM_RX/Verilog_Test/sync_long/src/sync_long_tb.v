`timescale 1ns / 1ps

module sync_long_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // 100 MHz clock
    
    // Inputs
    reg clock;
    reg reset;
    reg enable;
    reg reset_dot11;
    reg [31:0] sample_in;
    reg sample_in_strobe;
    reg short_gi;
    reg [3:0] fft_win_shift;
    reg [15:0] phase_out;
    reg phase_out_stb;
    reg [31:0] rot_data;
    reg phase_offset_override_en;
    reg signed [15:0] phase_offset_override_val;
    
    // Outputs
    wire [7:0] rot_addr;
    wire [31:0] metric;
    wire metric_stb;
    wire long_preamble_detected;
    wire [31:0] phase_in_i;
    wire [31:0] phase_in_q;
    wire phase_in_stb;
    wire [31:0] sample_out;
    wire sample_out_strobe;
    wire [15:0] num_ofdm_symbol;
    wire signed [15:0] phase_offset_taken;
    wire signed [15:0] ltf_phase_offset;
    wire [2:0] state;
    
    // Instantiate the Unit Under Test (UUT)
    sync_long uut (
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .reset_dot11(reset_dot11),
        .sample_in(sample_in),
        .sample_in_strobe(sample_in_strobe),
        .short_gi(short_gi),
        .fft_win_shift(fft_win_shift),
        .phase_out(phase_out),
        .phase_out_stb(phase_out_stb),
        .rot_addr(rot_addr),
        .rot_data(rot_data),
        .metric(metric),
        .metric_stb(metric_stb),
        .long_preamble_detected(long_preamble_detected),
        .phase_in_i(phase_in_i),
        .phase_in_q(phase_in_q),
        .phase_in_stb(phase_in_stb),
        .sample_out(sample_out),
        .sample_out_strobe(sample_out_strobe),
        .num_ofdm_symbol(num_ofdm_symbol),
        .phase_offset_override_en(phase_offset_override_en),
        .phase_offset_override_val(phase_offset_override_val),
        .phase_offset_taken(phase_offset_taken),
        .ltf_phase_offset(ltf_phase_offset),
        .state(state)
    );
    
    // Clock generation
    initial begin
        clock = 0;
        forever #(CLK_PERIOD/2) clock = ~clock;
    end
    
    // Rotation LUT simulation (simplified)
    always @(rot_addr) begin
        case(rot_addr)
            8'h00: rot_data = {16'h7FFF, 16'h0000}; // cos(0), sin(0)
            8'h01: rot_data = {16'h7F62, 16'h0648}; // cos(pi/32), sin(pi/32)
            8'h02: rot_data = {16'h7D8A, 16'h0C8C}; // cos(pi/16), sin(pi/16)
            default: rot_data = {16'h7FFF, 16'h0000};
        endcase
    end
    
    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        enable = 1;
        reset_dot11 = 1;
        sample_in = 0;
        sample_in_strobe = 0;
        short_gi = 0;
        fft_win_shift = 0;
        phase_out = 0;
        phase_out_stb = 0;
        phase_offset_override_en = 0;
        phase_offset_override_val = 0;
        
        // Wait for global reset
        #100;
        reset = 0;
        reset_dot11 = 0;
        
        // Wait some time
        #200;
        
        // Send some test samples (simulating short preamble tail + long preamble)
        repeat(200) begin
            @(posedge clock);
            sample_in_strobe <= 1;
            // Generate simple sinusoidal test pattern
            sample_in <= {$random, $random};
        end
        
        @(posedge clock);
        sample_in_strobe <= 0;
        
        // Wait for processing
        #10000;
        
        // Monitor outputs
        if (long_preamble_detected) begin
            $display("Long preamble detected at time %t", $time);
        end
        
        $display("Test completed at time %t", $time);
        $finish;
    end
    
    // Monitor key signals
    always @(posedge clock) begin
        if (long_preamble_detected) begin
            $display("Time %t: Long preamble detected! State=%d", $time, state);
        end
        if (sample_out_strobe) begin
            $display("Time %t: FFT output sample=%h, symbol_num=%d", $time, sample_out, num_ofdm_symbol);
        end
    end

endmodule
