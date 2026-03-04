

openofdm/
├── verilog/              # Orijinal Verilog kodları (değişmez!)
│   ├── dot11.v
│   ├── sync_short.v
│   └── ...
│
├── matlab/               # YENİ: MATLAB implementasyonu
│   ├── FixedPointLib/    # Fixed-point wrapper'lar
│   │   ├── FixedPointSignal.m
│   │   └── fi_config.m
│   │
│   ├── Modules/          # Her Verilog modülünün MATLAB karşılığı
│   │   ├── BasicModules/
│   │   │   ├── delayT.m
│   │   │   ├── complex_mult.m
│   │   │   ├── complex_to_mag.m
│   │   │   └── ...
│   │   │
│   │   ├── MainPipeline/
│   │   │   ├── power_trigger.m
│   │   │   ├── sync_short.m
│   │   │   ├── sync_long.m
│   │   │   ├── equalizer.m
│   │   │   └── ofdm_decoder.m
│   │   │
│   │   └── LUTs/
│   │       ├── rot_lut.m
│   │       ├── atan_lut.m
│   │       └── deinter_lut.m
│   │
│   ├── dot11_rx_matlab.m  # Top-level MATLAB model
│   │
│   ├── Tests/
│   │   ├── test_full_rx.m
│   │   ├── test_individual_modules.m
│   │   ├── debug_module.m
│   │   └── test_suite.m
│   │
│   ├── Utils/
│   │   ├── load_verilog_input.m
│   │   ├── load_mif_file.m
│   │   ├── compare_signals.m
│   │   └── plot_results.m
│   │
│   └── Data/
│       ├── luts_exported.mat       # Verilog'dan export edilen LUT'lar
│       ├── test_vectors.mat        # Test input/output'ları
│       └── module_specs.xlsx       # Modül spesifikasyonları
│
└── sim_out/              # Verilog simülasyon çıktıları (karşılaştırma için)
    ├── sample_in.txt
    ├── power_trigger.txt
    ├── sync_short_out.txt
    └── ...