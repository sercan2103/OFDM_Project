# Project Timeline

## January - 20th February 2026

### Mehmet

- I took the example from the MATLAB Simulink project given for Packet Detection, removed it from the WLAN toolbox, rewrote it as floating point, and tested it with the test data.
- I took the example from the MATLAB Simulink project given for Coarse CFO Estimator, removed it from the WLAN toolbox, rewrote it as floating point, and tested it with the test data.
- I took the example from the MATLAB Simulink project given for Coarse CFO Correction, removed it from the WLAN toolbox, rewrote it as floating point, and tested it with the test data. 

### Kemal & Fatih Şenal

- Developed MATLAB simulations for Symbol Timing Estimator with both floating-point and fixed-point implementations.
- Developed MATLAB simulations for Fine CFO Estimator with both floating-point and fixed-point implementations.
- Developed MATLAB simulations for Fine CFO Correction with both floating-point and fixed-point implementations.
- Developed MATLAB simulations for Channel Estimator with both floating-point and fixed-point implementations.
- Developed MATLAB simulations for Noise Power Estimator with both floating-point and fixed-point implementations.
- Created comprehensive documentation and test modules for all estimators.
- Performed verification against Verilog implementations.

### Fatih Durak

## 20th February - 27th February 2026

### Mehmet

### Kemal & Fatih Şenal
- Developed MATLAB simulations for HT-DATA Recover with fixed-point implementations.
- Taken results for previously developed MATLAB simulations (Symbol Timing Estimator, Fine CFO Estimator , Fine CFO Correction, Channel Estimator , Noise Power Estimator) uploaded in results folder.
### Fatih Durak

## 27th February - 06th March 2026

### Mehmet
- I created fixed-point models in MATLAB for the `power_trigger` and `sync_short` submodules in the RX section of the existing Verilog code.
- I tested the power_trigger and sync_short modules, for which I created the Matlab model.
- Next week I will compare these fixed-point MATLAB modules with the modules in Verilog to find the exact correct solution.

### Kemal & Fatih Şenal
- Developed necessary MATLAB models for OpenOFDM's submodules for equalizer, sync_long and OFDM_decoder such as phase, rotate, divider, complex multiplier, complex to magnitude est.
- Developed MATLAB models for OpenOFDM equalizer, sync_long and OFDM_decoder modules.

### Fatih Durak

## 06th March - 13th March 2026

### Mehmet


### Kemal & Fatih Şenal
-Developed 802.11n Reciver MATLAB model using previusly developed  MATLAB Models.

-Sepereted necessary HDL modules from 802.11n openofdm_rx for testing and verifying the MATLAB models by comperasion. Seperated Modules are: Equalizer , OFDM Decoder , Sync_long

### Fatih Durak

## 13th March - 27th March 2026

-Created BPSK modulator and BPSK Demodulator as HDL IP.
-Tested the BPSK modulator and BPSK Demodulator IPs.
-Integrated IPs in AD9361 Referance Project.
