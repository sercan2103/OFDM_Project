# OFDM Decoder Module - Standalone Vivado Project

## Overview
This is a standalone Vivado project for the `ofdm_decoder` module extracted from OpenWiFi's `openofdm_rx` IP core. The OFDM decoder performs the complete decoding pipeline for 802.11 OFDM packets, converting frequency-domain samples to decoded data bytes.

## Module Description

### Functionality
The ofdm_decoder module implements the complete 802.11 OFDM decoding chain:
1. **Demodulation** - Maps complex constellation points to bits (BPSK/QPSK/16-QAM/64-QAM)
2. **Deinterleaving** - Reverses the bit interleaving applied during encoding
3. **Viterbi Decoding** - Performs convolutional decoding with forward error correction
4. **Descrambling** - Removes the scrambling applied to the data
5. **Bit-to-Byte Conversion** - Groups decoded bits into bytes

### Key Features
- Support for multiple modulation schemes (BPSK, QPSK, 16-QAM, 64-QAM)
- Soft-decision Viterbi decoding for improved error correction
- Adaptive rate selection based on 802.11 RATE field
- CSI (Channel State Information) and noise variance input for LLR calculation
- Support for both legacy 802.11a/g and 802.11n (HT) modes

## Files Included

### Source Files (src/)
- **ofdm_decoder.v** - Main decoder module (318 lines)
- **demodulate.v** - Constellation demapper (BPSK/QPSK/QAM)
- **deinterleave.v** - Bit deinterleaver
- **descramble.v** - Data descrambler
- **bits_to_bytes.v** - Bit-to-byte converter
- **complex_to_mag_sq.v** - Complex magnitude squared calculator
- **dpram.v** - Dual-port RAM
- **common_params.v** - Common parameter definitions
- **common_defs.v** - Common macro definitions
- **openofdm_rx_pre_def.v** - Pre-processor definitions
- **ofdm_decoder_tb.v** - Testbench for simulation

### IP Cores (src/ip_cores/)
- **viterbi_v7_0/** - Xilinx Viterbi Decoder v7.0 IP core (convolutional decoder)

## Module Interface

### Inputs
- `clock` - System clock (typically 100 MHz)
- `enable` - Module enable signal
- `reset` - Synchronous reset
- `reset_dot11` - 802.11 protocol reset
- `state[4:0]` - Current decoder state
- `old_state[4:0]` - Previous decoder state
- `sample_in[31:0]` - Equalized FFT output {I[15:0], Q[15:0]}
- `sample_in_strobe` - Input sample valid strobe
- `soft_decoding` - Enable soft-decision decoding
- `soft_bits_method` - Soft bits calculation method
- `rate[7:0]` - Modulation and coding rate
- `do_descramble` - Enable descrambling (for DATA, not SIGNAL)
- `num_bits_to_decode[19:0]` - Number of bits to decode
- `csi[31:0]` - Channel State Information
- `csi_valid` - CSI valid strobe
- `noise_var[31:0]` - Noise variance estimate
- `noise_var_valid` - Noise variance valid strobe

### Outputs
- `bit_in` - Bit input to byte converter
- `bit_in_stb` - Bit input strobe
- `demod_out[5:0]` - Demodulated bits (max 6 bits for 64-QAM)
- `demod_soft_bits[17:0]` - Soft bits for LLR calculation
- `demod_out_strobe` - Demodulator output strobe
- `deinterleave_erase_out[7:0]` - Deinterleaved bits with erase flags
- `deinterleave_erase_out_strobe` - Deinterleaver output strobe
- `conv_decoder_out` - Viterbi decoder output bit
- `conv_decoder_out_stb` - Viterbi decoder output strobe
- `descramble_out` - Descrambled output bit
- `descramble_out_strobe` - Descrambler output strobe
- `byte_out[7:0]` - Decoded byte output
- `byte_out_strobe` - Byte output strobe

## Decoding Pipeline

```
FFT Output → Demodulate → Deinterleave → Viterbi Decode → Descramble → Bits-to-Bytes → MAC Layer
  (I/Q)        (bits)       (reordered)    (FEC decoded)   (unscrambled)    (bytes)
```

### Rate Field Encoding
The `rate[7:0]` field encodes the modulation and coding scheme:
- `rate[7]` - HT flag (1 = 802.11n, 0 = legacy)
- `rate[6:0]` - Rate/MCS value
  - Legacy: 0x0C=6M, 0x12=9M, 0x18=12M, 0x24=18M, 0x30=24M, 0x48=36M, 0x60=48M, 0x6C=54M
  - HT: MCS 0-7 for single spatial stream

## Building the Project

### Prerequisites
- Xilinx Vivado 2022.2 or later
- Xilinx Installation directory (e.g., `/tools/Xilinx`)

### Build Steps

1. **Navigate to the ofdm_decoder directory:**
   ```bash
   cd /path/to/openwifi-hw/ip/ofdm_decoder
   ```

2. **Run the build script:**
   ```bash
   ./create_vivado_proj.sh /tools/Xilinx ofdm_decoder.tcl zed_fmcs2 100
   ```

   Parameters:
   - `/tools/Xilinx` - Xilinx installation directory
   - `ofdm_decoder.tcl` - TCL script filename
   - `zed_fmcs2` - Board name
   - `100` - Clock frequency in MHz

3. **The script will:**
   - Create a new Vivado project: `ofdm_decoder/ofdm_decoder.xpr`
   - Add all source files
   - Add Viterbi decoder IP core
   - Configure simulation settings

### Opening the Project

```bash
vivado ./ofdm_decoder/ofdm_decoder.xpr
```

## First Time Setup

⚠️ **IMPORTANT**: When opening the project for the first time, the Viterbi decoder IP needs to be upgraded and generated:

1. **Open the project** in Vivado
2. **Report IP Status**: In Flow Navigator, click "Report IP Status"
3. **Upgrade IP**: If Viterbi decoder shows as needing upgrade, click "Upgrade Selected"
4. **Generate Output Products**: 
   - In the Sources window, expand "Design Sources"
   - Right-click on "viterbi_v7_0"
   - Select "Generate Output Products"
   - Choose "Out of context per IP" and click "Generate"

## Running Simulation

### Using Vivado GUI

1. **Open the project** in Vivado
2. **Run Behavioral Simulation**:
   - In Flow Navigator, click "Run Simulation" → "Run Behavioral Simulation"
3. **View Waveforms**:
   - Add signals to waveform window
   - Key signals to monitor:
     - `sample_in` - Input FFT samples
     - `demod_out` - Demodulated bits
     - `deinterleave_erase_out` - Deinterleaved bits
     - `conv_decoder_out` - Viterbi decoder output
     - `descramble_out` - Descrambled bits
     - `byte_out` - Final decoded bytes

### Testbench Behavior

The testbench (`ofdm_decoder_tb.v`):
1. Initializes all inputs
2. Provides CSI and noise variance estimates
3. Sends BPSK-modulated test samples (SIGNAL field)
4. Switches to scrambled data mode
5. Sends more test samples with various modulations
6. Monitors all pipeline stages

## Technical Details

### Viterbi Decoder Configuration
- **Type**: Convolutional decoder (constraint length 7)
- **Code rate**: 1/2, 2/3, 3/4 (depending on rate field)
- **Interface**: AXI-Stream
- **Soft decision**: 3-bit soft inputs for improved performance
- **Traceback**: 48 states

### Demodulation
- **BPSK**: 1 bit per carrier
- **QPSK**: 2 bits per carrier
- **16-QAM**: 4 bits per carrier
- **64-QAM**: 6 bits per carrier
- **Soft bits**: LLR (Log-Likelihood Ratio) calculation using CSI and noise variance

### Deinterleaving
- Block size depends on rate:
  - 48 bits for BPSK (legacy)
  - 52 bits for HT modes
- Two-stage permutation as per 802.11 standard

### Descrambling
- Polynomial: x^7 + x^4 + 1
- Initial state from first 7 bits of DATA field (not SIGNAL)
- Only applied to DATA, not to SIGNAL or HT-SIGNAL fields

## Dependencies

This project depends on:
1. **Xilinx IP Cores**:
   - Viterbi Decoder v7.0 (convolutional decoding)

2. **Custom Modules**:
   - demodulate - Constellation demapping with soft-decision support
   - deinterleave - Bit reordering per 802.11 spec
   - descramble - LFSR-based descrambling
   - bits_to_bytes - Serial-to-parallel conversion
   - complex_to_mag_sq - Magnitude squared for CSI calculation
   - dpram - Storage for CSI/noise variance

## Troubleshooting

### IP Core Version Mismatch
If you see warnings about IP versions:
1. Click "Report IP Status"
2. Select the Viterbi decoder and click "Upgrade Selected"
3. Regenerate output products

### Elaboration Errors
If simulation fails to elaborate:
1. Check that Viterbi decoder has generated output products
2. Verify IP Status shows "Up-to-date"
3. Clean and regenerate simulation files

### Decoder Not Producing Output
Common issues:
- `enable` signal not asserted
- `num_bits_to_decode` set to 0
- Missing CSI/noise variance (causes soft-decision failures)
- Incorrect `rate` field value

### Viterbi Decoder Freezing
If decoder stops responding:
- Ensure `vit_ce` is set to `1'b1` (already done in code)
- Check that input strobes are properly timed
- Verify reset sequence

## Reference

This module is part of the OpenWiFi project:
- **OpenWiFi GitHub**: https://github.com/open-sdr/openwifi
- **openofdm_rx Documentation**: https://github.com/jhshi/openofdm

For detailed information about the OFDM decoding algorithm, refer to:
- 802.11-2012 Standard, Section 18 (OFDM PHY)
- openofdm_rx documentation: docs/source/decode.rst

## License
This code is part of the OpenWiFi project and follows its licensing terms.
