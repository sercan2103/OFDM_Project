/*
 * app_config.h -- Stage 2B-2 (v2)
 *
 * Compile-time switches for the upstream AD9361 driver.
 * Same content as the bpsk-sanity-check reference -- if the driver
 * compiled there, it'll compile here.
 */
#ifndef CONFIG_H_
#define CONFIG_H_

#define HAVE_SPLIT_GAIN_TABLE   1
#define AD9361_DEVICE           1
#define AD9364_DEVICE           0
#define AD9363A_DEVICE          0

#define XILINX_PLATFORM
#define PLATFORM_ZYNQ

#define HAVE_VERBOSE_MESSAGES

/* Stage 2B-2 brings the ADC/DAC AXI cores up directly via Xil_Out32 in
 * main.c -- we don't link the no-OS axi_adc_core / axi_dac_core helpers,
 * and we don't use DMA at all. */
#define AXI_ADC_NOT_PRESENT
#define AXI_DAC_NOT_PRESENT

#endif
