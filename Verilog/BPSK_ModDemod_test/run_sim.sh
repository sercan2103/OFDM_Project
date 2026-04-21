#!/bin/bash
set -e
cd /home/kemal/Desktop/FMCOMM2andos/BPSK_ModDemod_test

xvlog \
  ../BPSK_Modulator/src/bpsk_core.v \
  ../BPSK_Demodulator/src/bpsk_demod_nco.v \
  ../BPSK_Demodulator/src/bpsk_demod_agc.v \
  ../BPSK_Demodulator/src/bpsk_demod_core.v \
  src/lfsr.v \
  tb/moddemod_tb.v 2>&1

xelab -debug typical moddemod_tb -s moddemod_tb_sim 2>&1

xsim moddemod_tb_sim -runall 2>&1
