#!/usr/bin/env python3
"""
OFDM Transceiver GUI  ─  ZedBoard + FMCOMMS3 (AD9361)
Port: /dev/ttyACM0   Baud: 115200

Requires : pyserial              (pip install pyserial)
Optional : matplotlib + numpy    (pip install matplotlib numpy)

Run:  python3 ofdm_gui.py
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import threading
import queue
import re
import time
from datetime import datetime
from collections import deque

try:
    import serial
    import serial.tools.list_ports
    HAS_SERIAL = True
except ImportError:
    HAS_SERIAL = False

try:
    import matplotlib
    matplotlib.use('TkAgg')
    from matplotlib.figure import Figure
    from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
    import numpy as np
    HAS_MPL = True
except ImportError:
    HAS_MPL = False

# ── Rate labels ────────────────────────────────────────────────────────────────
LEGACY_LABELS = [
    "0 –  6.0 Mbps BPSK  1/2",
    "1 –  9.0 Mbps BPSK  3/4",
    "2 – 12.0 Mbps QPSK  1/2",
    "3 – 18.0 Mbps QPSK  3/4",
    "4 – 24.0 Mbps 16QAM 1/2",
    "5 – 36.0 Mbps 16QAM 3/4",
    "6 – 48.0 Mbps 64QAM 2/3",
    "7 – 54.0 Mbps 64QAM 3/4",
]
HT_LABELS = [
    "0 –  6.5 Mbps BPSK  1/2",
    "1 – 13.0 Mbps QPSK  1/2",
    "2 – 19.5 Mbps QPSK  3/4",
    "3 – 26.0 Mbps 16QAM 1/2",
    "4 – 39.0 Mbps 16QAM 3/4",
    "5 – 52.0 Mbps 64QAM 2/3",
    "6 – 58.5 Mbps 64QAM 3/4",
    "7 – 65.0 Mbps 64QAM 5/6",
]

# MCS colours for plot
MCS_COLORS = ['#e41a1c','#377eb8','#4daf4a','#984ea3',
              '#ff7f00','#a65628','#f781bf','#999999']

IQ_MAXPTS      = 8192   # max scatter points for constellation view
IQ_STREAM_MAX  = 16384  # rolling time-domain buffer depth (samples per channel)
                        # NOTE: hardware delivers 32 samples per packet via GPIO.
                        # To capture a full OFDM packet (~3000+ samples) in one shot,
                        # the HDL capture buffer must be widened (block RAM + AXI).

DEFAULT_PORT = '/dev/ttyACM0'
DEFAULT_BAUD = 115200


# ── Helpers ────────────────────────────────────────────────────────────────────
def parse_kv(line):
    """Parse 'key=val key2=val2 ...' into a dict."""
    d = {}
    for m in re.finditer(r'(\w+)=([^\s]+)', line):
        d[m.group(1)] = m.group(2)
    return d


# ══════════════════════════════════════════════════════════════════════════════
class OFDMGui:

    def __init__(self):
        self.root = tk.Tk()
        self.root.title("OFDM Transceiver Controller  –  ZedBoard + AD9361")
        self.root.minsize(1100, 740)

        self.ser    = None
        self.rxq    = queue.Queue()
        self._rxthd = None
        self.busy   = False          # True while a command is running

        # BER plot data: {(mcs, ht): {'snr': [], 'per_x10': [], 'ber': []}}
        self.plot_data = {}
        self.sweep_mcs_label = {}

        # IQ constellation (accumulated I/Q scatter points)
        self.iq_tx_pts  = []
        self.iq_rx_pts  = []

        # IQ time-domain rolling stream (deque drops oldest when full)
        self.iq_tx_i = deque(maxlen=IQ_STREAM_MAX)
        self.iq_tx_q = deque(maxlen=IQ_STREAM_MAX)
        self.iq_rx_i = deque(maxlen=IQ_STREAM_MAX)
        self.iq_rx_q = deque(maxlen=IQ_STREAM_MAX)
        # absolute sample counters (for continuous x-axis across packets)
        self.iq_tx_total = 0
        self.iq_rx_total = 0

        self._iq_dirty  = False

        # Packet data log
        self.tx_ref_bytes = []
        self.pkt_log      = []   # list of {num, fcs, hdr, bytes}

        self._build_ui()
        self._poll_queue()           # start 50-ms queue poller

        if not HAS_SERIAL:
            self._log("ERROR: pyserial not installed.  Run:  pip install pyserial",
                      tag='err')
        if not HAS_MPL:
            self._log("NOTE: matplotlib not installed – plot disabled.  "
                      "Run:  pip install matplotlib numpy", tag='warn')

    # ── UI construction ────────────────────────────────────────────────────────

    def _build_ui(self):
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(2, weight=1)
        self.root.rowconfigure(3, weight=0)

        self._build_conn_bar()         # row 0
        self._build_status_bar()       # row 1
        self._build_main_area()        # row 2 (paned: controls + plot)
        self._build_log()              # row 3

    def _build_conn_bar(self):
        f = ttk.Frame(self.root, padding=(6, 4))
        f.grid(row=0, column=0, sticky='ew')

        ttk.Label(f, text="Port:").pack(side='left')
        self.var_port = tk.StringVar(value=DEFAULT_PORT)
        self.cmb_port = ttk.Combobox(f, textvariable=self.var_port, width=18)
        self.cmb_port.pack(side='left', padx=(2, 8))
        ttk.Button(f, text="↻", width=2,
                   command=self._refresh_ports).pack(side='left', padx=(0, 8))

        ttk.Label(f, text="Baud:").pack(side='left')
        self.var_baud = tk.StringVar(value=str(DEFAULT_BAUD))
        ttk.Entry(f, textvariable=self.var_baud, width=8).pack(side='left', padx=(2, 8))

        self.btn_conn = ttk.Button(f, text="Connect", command=self._toggle_conn)
        self.btn_conn.pack(side='left', padx=(0, 12))

        self.lbl_conn = ttk.Label(f, text="● DISCONNECTED", foreground='gray')
        self.lbl_conn.pack(side='left')

        self._refresh_ports()

    def _build_status_bar(self):
        f = ttk.Frame(self.root, padding=(6, 2), relief='groove')
        f.grid(row=1, column=0, sticky='ew')

        self.lbl_sys = ttk.Label(f, text="System: --", width=70)
        self.lbl_sys.pack(side='left')
        self.lbl_op  = ttk.Label(f, text="IDLE", foreground='green', width=20,
                                 anchor='e')
        self.lbl_op.pack(side='right')

    def _build_main_area(self):
        pw = ttk.PanedWindow(self.root, orient='horizontal')
        pw.grid(row=2, column=0, sticky='nsew', padx=4, pady=4)

        # Left: control notebook
        left = ttk.Frame(pw, width=400)
        left.pack_propagate(False)
        pw.add(left, weight=0)
        self._build_controls(left)

        # Right: tabbed view (BER, IQ, Packet Data)
        right = ttk.Frame(pw)
        pw.add(right, weight=1)
        self._build_right_notebook(right)

    def _build_controls(self, parent):
        nb = ttk.Notebook(parent)
        nb.pack(fill='both', expand=True, padx=4, pady=4)

        self._build_tab_tx(nb)
        self._build_tab_rx(nb)
        self._build_tab_xcvr(nb)
        self._build_tab_loop(nb)
        self._build_tab_tools(nb)

    def _make_mode_frame(self, parent):
        """Shared Legacy/HT radio + MCS combo frame."""
        f = ttk.LabelFrame(parent, text="Signal", padding=6)
        var_ht = tk.IntVar(value=0)
        ttk.Radiobutton(f, text="Legacy 802.11a", variable=var_ht,
                        value=0, command=lambda: self._update_mcs_combo(cmb, var_ht)
                        ).grid(row=0, column=0, sticky='w')
        ttk.Radiobutton(f, text="HT  802.11n",    variable=var_ht,
                        value=1, command=lambda: self._update_mcs_combo(cmb, var_ht)
                        ).grid(row=0, column=1, sticky='w')
        ttk.Label(f, text="MCS:").grid(row=1, column=0, sticky='w', pady=2)
        var_mcs = tk.IntVar(value=0)
        cmb = ttk.Combobox(f, values=LEGACY_LABELS, width=28, state='readonly')
        cmb.current(0)
        cmb.grid(row=1, column=1, sticky='w', pady=2)
        cmb.bind("<<ComboboxSelected>>",
                 lambda e: var_mcs.set(cmb.current()))
        return f, var_ht, var_mcs, cmb

    def _update_mcs_combo(self, cmb, var_ht):
        idx = cmb.current()
        cmb['values'] = HT_LABELS if var_ht.get() else LEGACY_LABELS
        cmb.current(min(idx, 7))

    # ── Tab: Transmit ─────────────────────────────────────────────────────────

    def _build_tab_tx(self, nb):
        f = ttk.Frame(nb, padding=8)
        nb.add(f, text=" Transmit ")

        mf, self.tx_ht, self.tx_mcs, self.tx_cmb = self._make_mode_frame(f)
        mf.pack(fill='x', pady=(0, 6))

        cf = ttk.LabelFrame(f, text="Parameters", padding=6)
        cf.pack(fill='x', pady=(0, 6))
        ttk.Label(cf, text="Packets:").grid(row=0, column=0, sticky='w')
        self.tx_n = tk.IntVar(value=10)
        ttk.Spinbox(cf, from_=1, to=9999, textvariable=self.tx_n,
                    width=8).grid(row=0, column=1, sticky='w', padx=6)

        bf = ttk.Frame(f)
        bf.pack(fill='x')
        self.btn_tx_start = ttk.Button(bf, text="▶  Start TX",
                                       command=self._start_tx)
        self.btn_tx_start.pack(side='left', padx=(0, 6))
        ttk.Button(bf, text="■  Stop", command=self._stop).pack(side='left')

        # Results
        rf = ttk.LabelFrame(f, text="Last run", padding=6)
        rf.pack(fill='x', pady=(8, 0))
        self.lbl_tx_res = ttk.Label(rf, text="--")
        self.lbl_tx_res.pack(anchor='w')

    # ── Tab: Receive ─────────────────────────────────────────────────────────

    def _build_tab_rx(self, nb):
        f = ttk.Frame(nb, padding=8)
        nb.add(f, text=" Receive ")

        mf, self.rx_ht, self.rx_mcs, self.rx_cmb = self._make_mode_frame(f)
        mf.pack(fill='x', pady=(0, 6))

        bf = ttk.Frame(f)
        bf.pack(fill='x')
        self.btn_rx = ttk.Button(bf, text="▶  Start RX", command=self._start_rx)
        self.btn_rx.pack(side='left', padx=(0, 6))
        ttk.Button(bf, text="■  Stop", command=self._stop).pack(side='left')

        rf = ttk.LabelFrame(f, text="Reception", padding=6)
        rf.pack(fill='x', pady=(8, 0))
        self.lbl_rx_cnt = ttk.Label(rf, text="Waiting...")
        self.lbl_rx_cnt.pack(anchor='w')
        self._rx_ok = self._rx_hdr = self._rx_miss = 0

    # ── Tab: Transceiver ─────────────────────────────────────────────────────

    def _build_tab_xcvr(self, nb):
        f = ttk.Frame(nb, padding=8)
        nb.add(f, text=" Transceiver ")

        mf, self.xcvr_ht, self.xcvr_mcs, self.xcvr_cmb = self._make_mode_frame(f)
        mf.pack(fill='x', pady=(0, 6))

        ttk.Label(f, text="Phase 3: true data relay via AXI BRAM.",
                  foreground='gray').pack(anchor='w', pady=2)

        bf = ttk.Frame(f)
        bf.pack(fill='x', pady=4)
        self.btn_xcvr = ttk.Button(bf, text="▶  Start XCVR", command=self._start_xcvr)
        self.btn_xcvr.pack(side='left', padx=(0, 6))
        ttk.Button(bf, text="■  Stop", command=self._stop).pack(side='left')

        rf = ttk.LabelFrame(f, text="Relay status", padding=6)
        rf.pack(fill='x', pady=(8, 0))
        self.lbl_xcvr = ttk.Label(rf, text="--")
        self.lbl_xcvr.pack(anchor='w')
        self._xcvr_ok = self._xcvr_total = 0

    # ── Tab: Loopback / BER ──────────────────────────────────────────────────

    def _build_tab_loop(self, nb):
        f = ttk.Frame(nb, padding=8)
        nb.add(f, text=" Loopback ")

        mf, self.lp_ht, self.lp_mcs_var, self.lp_cmb = self._make_mode_frame(f)
        mf.pack(fill='x', pady=(0, 4))

        # MCS all option
        self.lp_all = tk.BooleanVar(value=False)
        ttk.Checkbutton(f, text="Sweep all MCS 0–7 in sequence",
                        variable=self.lp_all).pack(anchor='w', pady=2)

        # Sweep type
        sf = ttk.LabelFrame(f, text="Sweep type", padding=6)
        sf.pack(fill='x', pady=(0, 4))
        self.lp_sweep = tk.IntVar(value=1)
        ttk.Radiobutton(sf, text="Adaptive (stop on errors or cap)",
                        variable=self.lp_sweep, value=1,
                        command=self._lp_sweep_toggle).grid(row=0, column=0,
                                                             columnspan=2, sticky='w')
        ttk.Radiobutton(sf, text="Fixed SNR",
                        variable=self.lp_sweep, value=0,
                        command=self._lp_sweep_toggle).grid(row=1, column=0,
                                                             columnspan=2, sticky='w')

        # Adaptive params
        self.frm_adap = ttk.Frame(sf)
        self.frm_adap.grid(row=2, column=0, columnspan=2, sticky='ew', pady=2)
        ttk.Label(self.frm_adap, text="Shift start:").grid(row=0, column=0, sticky='w')
        self.lp_ss = tk.IntVar(value=7)
        ttk.Spinbox(self.frm_adap, from_=0, to=15, textvariable=self.lp_ss,
                    width=4).grid(row=0, column=1, padx=4)
        ttk.Label(self.frm_adap, text="Shift end:").grid(row=0, column=2, sticky='w')
        self.lp_se = tk.IntVar(value=15)
        ttk.Spinbox(self.frm_adap, from_=0, to=15, textvariable=self.lp_se,
                    width=4).grid(row=0, column=3, padx=4)

        # Fixed params
        self.frm_fixed = ttk.Frame(sf)
        self.frm_fixed.grid(row=3, column=0, columnspan=2, sticky='ew', pady=2)
        ttk.Label(self.frm_fixed, text="Shift:").grid(row=0, column=0, sticky='w')
        self.lp_fs = tk.IntVar(value=10)
        ttk.Spinbox(self.frm_fixed, from_=0, to=15, textvariable=self.lp_fs,
                    width=4).grid(row=0, column=1, padx=4)
        ttk.Label(self.frm_fixed, text="Packets:").grid(row=0, column=2, sticky='w')
        self.lp_fn = tk.IntVar(value=1000)
        ttk.Spinbox(self.frm_fixed, from_=1, to=9999, textvariable=self.lp_fn,
                    width=6).grid(row=0, column=3, padx=4)
        self.frm_fixed.grid_remove()   # hidden by default (adaptive mode)

        # Buttons
        bf = ttk.Frame(f)
        bf.pack(fill='x', pady=4)
        self.btn_lp_start = ttk.Button(bf, text="▶  Start Sweep",
                                       command=self._start_loop)
        self.btn_lp_start.pack(side='left', padx=(0, 6))
        ttk.Button(bf, text="■  Stop", command=self._stop).pack(side='left')
        ttk.Button(bf, text="Clear Plot", command=self._plot_clear,
                   ).pack(side='right')

        # Progress
        self.lbl_lp_prog = ttk.Label(f, text="--", foreground='gray')
        self.lbl_lp_prog.pack(anchor='w')

    def _lp_sweep_toggle(self):
        if self.lp_sweep.get() == 1:
            self.frm_adap.grid()
            self.frm_fixed.grid_remove()
        else:
            self.frm_fixed.grid()
            self.frm_adap.grid_remove()

    # ── Tab: Tools ───────────────────────────────────────────────────────────

    def _build_tab_tools(self, nb):
        f = ttk.Frame(nb, padding=8)
        nb.add(f, text=" Tools ")

        ttk.Button(f, text="↻  Refresh Status",
                   command=self._req_status).pack(fill='x', pady=2)
        ttk.Button(f, text="⊕  Re-align RF (legacy MCS 0)",
                   command=self._req_align).pack(fill='x', pady=2)
        ttk.Button(f, text="≡  BIST Verify (digital loopback)",
                   command=self._req_bist).pack(fill='x', pady=2)

        ttk.Separator(f, orient='horizontal').pack(fill='x', pady=8)

        ttk.Label(f, text="System Information", font=('', 10, 'bold')).pack(anchor='w')
        self.lbl_info = tk.Text(f, height=10, width=44, relief='flat',
                                background=self.root.cget('bg'), state='disabled')
        self.lbl_info.pack(anchor='w', pady=4)

    # ── Plot ──────────────────────────────────────────────────────────────────

    def _build_plot(self, parent):
        if not HAS_MPL:
            ttk.Label(parent,
                      text="Install matplotlib + numpy\nfor live BER plot.\n\n"
                           "pip install matplotlib numpy",
                      justify='center', foreground='gray').pack(expand=True)
            self.canvas = None
            return

        self.fig = Figure(figsize=(5, 4), dpi=96)
        self.ax  = self.fig.add_subplot(111)
        self._plot_init_axes()

        self.canvas = FigureCanvasTkAgg(self.fig, master=parent)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(fill='both', expand=True, padx=4, pady=4)

        tb_frame = ttk.Frame(parent)
        tb_frame.pack(fill='x')
        NavigationToolbar2Tk(self.canvas, tb_frame)

    # ── Right-side notebook ───────────────────────────────────────────────────

    def _build_right_notebook(self, parent):
        nb = ttk.Notebook(parent)
        nb.pack(fill='both', expand=True)

        tab_ber  = ttk.Frame(nb)
        nb.add(tab_ber,  text='  BER/PER  ')
        self._build_plot(tab_ber)

        tab_iq   = ttk.Frame(nb)
        nb.add(tab_iq,   text='  IQ View  ')
        self._build_iq_panel(tab_iq)

        tab_fft  = ttk.Frame(nb)
        nb.add(tab_fft,  text='  Frequency Domain  ')
        self._build_fft_tab(tab_fft)

        tab_data = ttk.Frame(nb)
        nb.add(tab_data, text='  Packet Data  ')
        self._build_data_panel(tab_data)

    # ── IQ View panel ─────────────────────────────────────────────────────────

    def _build_iq_panel(self, parent):
        if not HAS_MPL:
            ttk.Label(parent, text="Install matplotlib for IQ plots.",
                      foreground='gray', justify='center').pack(expand=True)
            self.canvas_iq = None
            return

        # 2×2: top = constellations, bottom = time-domain waveforms
        self.fig_iq   = Figure(figsize=(7, 5.5), dpi=96)
        self.ax_iq_tx = self.fig_iq.add_subplot(221)   # TX constellation
        self.ax_iq_rx = self.fig_iq.add_subplot(222)   # RX constellation
        self.ax_td_tx = self.fig_iq.add_subplot(223)   # TX time-domain
        self.ax_td_rx = self.fig_iq.add_subplot(224)   # RX time-domain
        self._iq_axes_init()

        self.canvas_iq = FigureCanvasTkAgg(self.fig_iq, master=parent)
        self.canvas_iq.draw()
        self.canvas_iq.get_tk_widget().pack(fill='both', expand=True, padx=4, pady=4)

        tb_iq = ttk.Frame(parent)
        tb_iq.pack(fill='x')
        NavigationToolbar2Tk(self.canvas_iq, tb_iq)

        ctrl = ttk.Frame(parent)
        ctrl.pack(fill='x', padx=4, pady=(2, 4))
        ttk.Button(ctrl, text='Clear IQ', command=self._iq_clear).pack(side='left')

        ttk.Separator(ctrl, orient='vertical').pack(side='left', fill='y',
                                                    padx=6, pady=2)
        ttk.Label(ctrl, text='Capture size:').pack(side='left')
        self.var_capiq_n = tk.IntVar(value=4096)
        ttk.Spinbox(ctrl, from_=32, to=4096, increment=32,
                    textvariable=self.var_capiq_n,
                    width=6).pack(side='left', padx=4)
        self.btn_capiq = ttk.Button(ctrl, text='Full Capture (CAPIQ)',
                                    command=self._send_capiq)
        self.btn_capiq.pack(side='left', padx=(4, 0))
        ttk.Label(ctrl,
                  text='  ← requires rebuilt bitstream',
                  foreground='gray').pack(side='left')

        self.lbl_iq_info = ttk.Label(ctrl, text='No IQ data yet.', foreground='gray')
        self.lbl_iq_info.pack(side='right', padx=8)

    def _iq_axes_init(self):
        for ax, title in [(self.ax_iq_tx, 'TX Constellation  (I vs Q)'),
                          (self.ax_iq_rx, 'RX Constellation — demod input')]:
            ax.clear()
            ax.set_xlabel('I', fontsize=8)
            ax.set_ylabel('Q', fontsize=8)
            ax.set_title(title, fontsize=9)
            ax.axhline(0, color='#555', linewidth=0.5)
            ax.axvline(0, color='#555', linewidth=0.5)
            ax.grid(True, alpha=0.2)
            ax.set_aspect('equal', adjustable='datalim')
        for ax, title in [
            (self.ax_td_tx, 'TX  I & Q  vs sample  (rolling stream)'),
            (self.ax_td_rx, 'RX  I & Q  vs sample  (demod input, rolling stream)'),
        ]:
            ax.clear()
            ax.set_xlabel('Sample #  (absolute, 20 MSPS)', fontsize=8)
            ax.set_ylabel('Amplitude', fontsize=8)
            ax.set_title(title, fontsize=9)
            ax.axhline(0, color='#555', linewidth=0.3)
            ax.grid(True, alpha=0.15)
        self.fig_iq.tight_layout(pad=1.2)

    def _iq_clear(self):
        self.iq_tx_pts.clear()
        self.iq_rx_pts.clear()
        self.iq_tx_i.clear();  self.iq_tx_q.clear()
        self.iq_rx_i.clear();  self.iq_rx_q.clear()
        self.iq_tx_total = 0;  self.iq_rx_total = 0
        if HAS_MPL and hasattr(self, 'canvas_iq') and self.canvas_iq:
            self._iq_axes_init()
            self.canvas_iq.draw()
        if HAS_MPL and hasattr(self, 'canvas_fft') and self.canvas_fft:
            self._fft_axes_init()
            self.canvas_fft.draw()
        if hasattr(self, 'lbl_iq_info'):
            self.lbl_iq_info.configure(text='No IQ data yet.')
        if hasattr(self, 'lbl_fft_info'):
            self.lbl_fft_info.configure(text='No data yet.')

    def _iq_refresh(self):
        if not HAS_MPL or not hasattr(self, 'canvas_iq') or self.canvas_iq is None:
            return
        self._iq_axes_init()

        # ── Constellation scatter ──
        if self.iq_tx_pts:
            i_t = [p[0] for p in self.iq_tx_pts]
            q_t = [p[1] for p in self.iq_tx_pts]
            self.ax_iq_tx.scatter(i_t, q_t, s=1, alpha=0.35,
                                  color='#377eb8', linewidths=0)
            self.ax_iq_tx.set_title(
                f'TX Constellation  ({len(self.iq_tx_pts)} pts)', fontsize=9)
        if self.iq_rx_pts:
            i_r = [p[0] for p in self.iq_rx_pts]
            q_r = [p[1] for p in self.iq_rx_pts]
            self.ax_iq_rx.scatter(i_r, q_r, s=1, alpha=0.35,
                                  color='#e41a1c', linewidths=0)
            self.ax_iq_rx.set_title(
                f'RX Constellation — demod input  ({len(self.iq_rx_pts)} pts)',
                fontsize=9)

        # ── Time-domain rolling stream ──
        if self.iq_tx_i:
            n   = len(self.iq_tx_i)
            x0  = self.iq_tx_total - n
            x   = list(range(x0, self.iq_tx_total))
            self.ax_td_tx.plot(x, list(self.iq_tx_i), color='#377eb8',
                               linewidth=0.7, label='I')
            self.ax_td_tx.plot(x, list(self.iq_tx_q), color='#4daf4a',
                               linewidth=0.7, linestyle='--', label='Q')
            self.ax_td_tx.legend(fontsize=7, loc='upper right')
            self.ax_td_tx.set_title(
                f'TX  I & Q  —  {n} samples  (total {self.iq_tx_total})',
                fontsize=9)
        if self.iq_rx_i:
            n   = len(self.iq_rx_i)
            x0  = self.iq_rx_total - n
            x   = list(range(x0, self.iq_rx_total))
            self.ax_td_rx.plot(x, list(self.iq_rx_i), color='#e41a1c',
                               linewidth=0.7, label='I')
            self.ax_td_rx.plot(x, list(self.iq_rx_q), color='#ff7f00',
                               linewidth=0.7, linestyle='--', label='Q')
            self.ax_td_rx.legend(fontsize=7, loc='upper right')
            self.ax_td_rx.set_title(
                f'RX  I & Q  (demod input)  —  {n} samples  (total {self.iq_rx_total})',
                fontsize=9)

        self.canvas_iq.draw()
        if hasattr(self, 'lbl_iq_info'):
            self.lbl_iq_info.configure(
                text=f'TX stream: {self.iq_tx_total} samples  |  '
                     f'RX stream: {self.iq_rx_total} samples  '
                     f'(window {IQ_STREAM_MAX})')

    # ── Frequency Domain (FFT) panel ──────────────────────────────────────────

    def _build_fft_tab(self, parent):
        if not HAS_MPL:
            ttk.Label(parent, text="Install matplotlib + numpy for FFT.",
                      foreground='gray', justify='center').pack(expand=True)
            self.canvas_fft = None
            return

        self.fig_fft  = Figure(figsize=(7, 5), dpi=96)
        self.ax_fft_tx = self.fig_fft.add_subplot(211)
        self.ax_fft_rx = self.fig_fft.add_subplot(212)
        self._fft_axes_init()

        self.canvas_fft = FigureCanvasTkAgg(self.fig_fft, master=parent)
        self.canvas_fft.draw()
        self.canvas_fft.get_tk_widget().pack(fill='both', expand=True, padx=4, pady=4)

        tb_fft = ttk.Frame(parent)
        tb_fft.pack(fill='x')
        NavigationToolbar2Tk(self.canvas_fft, tb_fft)

        ctrl = ttk.Frame(parent)
        ctrl.pack(fill='x', padx=4, pady=(2, 4))
        ttk.Label(ctrl, text='FFT size:').pack(side='left')
        self.var_fft_size = tk.StringVar(value='64')
        cmb = ttk.Combobox(ctrl, textvariable=self.var_fft_size,
                           values=['64', '128', '256', '512', '1024'],
                           width=6, state='readonly')
        cmb.pack(side='left', padx=(2, 8))
        cmb.bind('<<ComboboxSelected>>', lambda e: self._fft_refresh())

        self.lbl_fft_info = ttk.Label(ctrl, text='No data yet.', foreground='gray')
        self.lbl_fft_info.pack(side='left', padx=4)

        ttk.Label(ctrl,
                  text='  802.11a @ 20 MSPS: 64-pt FFT = 312.5 kHz/bin = one OFDM symbol  ',
                  foreground='#6a9fb5').pack(side='right')

    def _fft_axes_init(self):
        for ax, title, color in [
            (self.ax_fft_tx, 'TX  Power Spectrum', '#377eb8'),
            (self.ax_fft_rx, 'RX  Power Spectrum  (demod input)', '#e41a1c'),
        ]:
            ax.clear()
            ax.set_xlabel('Frequency  (MHz)', fontsize=8)
            ax.set_ylabel('Power  (dB)', fontsize=8)
            ax.set_title(title, fontsize=9, color=color)
            ax.set_xlim(-11, 11)
            ax.grid(True, alpha=0.18)
            # 802.11a used-band edges (subcarriers ±26 × 312.5 kHz = ±8.125 MHz)
            ax.axvline(-8.125, color='#4daf4a', linewidth=0.7, linestyle='--',
                       alpha=0.7, label='band edge ±8.125 MHz')
            ax.axvline(+8.125, color='#4daf4a', linewidth=0.7, linestyle='--',
                       alpha=0.7)
            # DC null subcarrier
            ax.axvline(0, color='#f0c674', linewidth=0.7, linestyle=':',
                       alpha=0.8, label='DC null')
        self.fig_fft.tight_layout(pad=1.4)

    def _fft_refresh(self):
        if not HAS_MPL or not hasattr(self, 'canvas_fft') or self.canvas_fft is None:
            return

        try:
            fft_n = int(self.var_fft_size.get())
        except (ValueError, AttributeError):
            fft_n = 128

        self._fft_axes_init()

        def avg_spectrum(i_dq, q_dq):
            """Average-power spectrum of all complete fft_n-sample segments."""
            n = len(i_dq)
            if n < fft_n:
                return None, None, 0
            iq  = np.array(list(i_dq)) + 1j * np.array(list(q_dq))
            win = np.hanning(fft_n)
            n_segs = n // fft_n
            pwr = np.zeros(fft_n)
            for s in range(n_segs):
                blk  = iq[s * fft_n:(s + 1) * fft_n] * win
                pwr += np.abs(np.fft.fftshift(np.fft.fft(blk))) ** 2
            pwr /= n_segs
            pwr_db = 10 * np.log10(pwr + 1e-12)
            freqs  = np.fft.fftshift(np.fft.fftfreq(fft_n)) * 20.0  # MHz at 20 MSPS
            return freqs, pwr_db, n_segs

        info_parts = []

        if len(self.iq_tx_i) >= fft_n:
            freqs, pwr, n_segs = avg_spectrum(self.iq_tx_i, self.iq_tx_q)
            if freqs is not None:
                self.ax_fft_tx.plot(freqs, pwr, color='#377eb8', linewidth=0.8)
                self.ax_fft_tx.legend(fontsize=7, loc='upper right')
                self.ax_fft_tx.set_title(
                    f'TX  Power Spectrum  '
                    f'(FFT={fft_n}, {n_segs} segs averaged, Hann window)',
                    fontsize=9, color='#377eb8')
                info_parts.append(f'TX {len(self.iq_tx_i)} samples')

        if len(self.iq_rx_i) >= fft_n:
            freqs, pwr, n_segs = avg_spectrum(self.iq_rx_i, self.iq_rx_q)
            if freqs is not None:
                self.ax_fft_rx.plot(freqs, pwr, color='#e41a1c', linewidth=0.8)
                self.ax_fft_rx.legend(fontsize=7, loc='upper right')
                self.ax_fft_rx.set_title(
                    f'RX  Power Spectrum  (demod input)  '
                    f'(FFT={fft_n}, {n_segs} segs averaged, Hann window)',
                    fontsize=9, color='#e41a1c')
                info_parts.append(f'RX {len(self.iq_rx_i)} samples')

        self.canvas_fft.draw()
        if hasattr(self, 'lbl_fft_info'):
            bin_khz = 20_000 / fft_n
            self.lbl_fft_info.configure(
                text=(', '.join(info_parts) + f'  |  {bin_khz:.1f} kHz/bin'
                      if info_parts else 'No data yet.'))

    # ── Packet Data panel ─────────────────────────────────────────────────────

    def _build_data_panel(self, parent):
        parent.columnconfigure(0, weight=1)
        parent.rowconfigure(1, weight=1)

        ref_frm = ttk.LabelFrame(parent, text='TX Reference  (known pattern sent by firmware)',
                                 padding=4)
        ref_frm.grid(row=0, column=0, sticky='ew', padx=4, pady=(4, 2))
        self.txt_tx_ref = tk.Text(ref_frm, height=4, wrap='word', state='disabled',
                                  font=('Courier', 8),
                                  background='#1a2a3a', foreground='#6a9fb5')
        self.txt_tx_ref.pack(fill='x')

        log_frm = ttk.LabelFrame(parent, text='Received Packets  (hex, errors highlighted)',
                                 padding=4)
        log_frm.grid(row=1, column=0, sticky='nsew', padx=4, pady=(2, 2))
        log_frm.columnconfigure(0, weight=1)
        log_frm.rowconfigure(0, weight=1)
        self.data_txt = scrolledtext.ScrolledText(
            log_frm, wrap='none', state='disabled',
            font=('Courier', 8), background='#1e1e1e', foreground='#d4d4d4')
        self.data_txt.grid(row=0, column=0, sticky='nsew')
        self.data_txt.tag_config('pkt_hdr', foreground='#f0c674',
                                 font=('Courier', 8, 'bold'))
        self.data_txt.tag_config('rx_ok',   foreground='#b5bd68')
        self.data_txt.tag_config('rx_err',  foreground='#ff8888',
                                 background='#3d1111')
        self.data_txt.tag_config('rx_miss', foreground='#666666')
        self.data_txt.tag_config('addr',    foreground='#6a9fb5')

        ctrl = ttk.Frame(parent)
        ctrl.grid(row=2, column=0, sticky='ew', padx=4, pady=(2, 4))
        ttk.Button(ctrl, text='Clear Data Log',
                   command=self._data_clear).pack(side='left')
        self.lbl_data_info = ttk.Label(ctrl, text='', foreground='gray')
        self.lbl_data_info.pack(side='left', padx=8)

    def _data_set_ref(self, ref_bytes):
        self.tx_ref_bytes = list(ref_bytes)
        if not hasattr(self, 'txt_tx_ref'):
            return
        self.txt_tx_ref.configure(state='normal')
        self.txt_tx_ref.delete('1.0', 'end')
        for i in range(0, len(ref_bytes), 16):
            chunk = ref_bytes[i:i+16]
            self.txt_tx_ref.insert('end', ' '.join(f'{b:02X}' for b in chunk) + '\n')
        self.txt_tx_ref.configure(state='disabled')

    def _data_clear(self):
        self.pkt_log.clear()
        self.tx_ref_bytes.clear()
        if hasattr(self, 'data_txt'):
            self.data_txt.configure(state='normal')
            self.data_txt.delete('1.0', 'end')
            self.data_txt.configure(state='disabled')
        if hasattr(self, 'txt_tx_ref'):
            self.txt_tx_ref.configure(state='normal')
            self.txt_tx_ref.delete('1.0', 'end')
            self.txt_tx_ref.configure(state='disabled')
        if hasattr(self, 'lbl_data_info'):
            self.lbl_data_info.configure(text='')

    def _data_append_pkt(self, pkt_num, fcs_ok, hdr_ok, rx_bytes):
        if not hasattr(self, 'data_txt'):
            return
        tx  = self.tx_ref_bytes
        n   = len(rx_bytes)
        n_errors = sum(bin(rx_bytes[b] ^ tx[b]).count('1')
                       for b in range(min(n, len(tx)))) if tx else 0
        result = 'FCS=OK' if fcs_ok else ('HDR-only' if hdr_ok else 'MISS')

        self.data_txt.configure(state='normal')
        hdr = f'\n── Pkt #{pkt_num}  {result}'
        if fcs_ok or hdr_ok:
            hdr += f'  {n_errors} bit error{"s" if n_errors != 1 else ""}'
        hdr += ' ' + '─' * max(2, 44 - len(hdr)) + '\n'
        self.data_txt.insert('end', hdr, 'pkt_hdr')

        if not rx_bytes:
            self.data_txt.insert('end', 'MISS — no data captured\n', 'rx_miss')
        else:
            for row in range(0, n, 16):
                chunk = rx_bytes[row:row+16]
                self.data_txt.insert('end', f'{row:02X}: ', 'addr')
                for bi, byte in enumerate(chunk):
                    pos    = row + bi
                    hx     = f'{byte:02X} '
                    is_err = (tx and pos < len(tx) and byte != tx[pos])
                    self.data_txt.insert('end', hx, 'rx_err' if is_err else 'rx_ok')
                self.data_txt.insert('end', '\n')

        self.data_txt.configure(state='disabled')
        self.data_txt.see('end')
        self.pkt_log.append({'num': pkt_num, 'fcs': fcs_ok,
                             'hdr': hdr_ok, 'bytes': rx_bytes})
        if hasattr(self, 'lbl_data_info'):
            self.lbl_data_info.configure(
                text=f'{len(self.pkt_log)} packets  |  last: {result}')

    def _plot_init_axes(self):
        self.ax.clear()
        self.ax.set_xlabel("SNR  (dB)")
        self.ax.set_ylabel("PER  (%)")
        self.ax.set_title("BER / PER vs SNR")
        self.ax.set_yscale('log')
        self.ax.set_ylim(0.01, 105)
        self.ax.set_xlim(-10, 40)
        self.ax.grid(True, which='both', alpha=0.3)
        self.ax.axhline(5, color='gray', linestyle='--', linewidth=0.8,
                        label='PER=5%')
        self.fig.tight_layout()

    def _plot_clear(self):
        self.plot_data.clear()
        if HAS_MPL:
            self._plot_init_axes()
            self.canvas.draw()

    def _plot_refresh(self):
        if not HAS_MPL or self.canvas is None:
            return
        self._plot_init_axes()
        for (mcs, ht), d in self.plot_data.items():
            if not d['snr']:
                continue
            label = f"{'HT' if ht else 'L'} MCS{mcs}"
            color = MCS_COLORS[mcs % len(MCS_COLORS)]
            ls    = '-' if not ht else '--'
            per_pct = [p / 10.0 for p in d['per_x10']]
            snr_arr = d['snr']
            self.ax.plot(snr_arr, per_pct, marker='o', markersize=4,
                         color=color, linestyle=ls, label=label, linewidth=1.5)
        if self.plot_data:
            self.ax.legend(fontsize=7, loc='upper right')
        self.canvas.draw()

    # ── Log ──────────────────────────────────────────────────────────────────

    def _build_log(self):
        f = ttk.Frame(self.root, padding=(4, 0, 4, 4))
        f.grid(row=3, column=0, sticky='nsew')
        f.columnconfigure(0, weight=1)
        f.rowconfigure(1, weight=1)
        self.root.rowconfigure(3, weight=1)

        hdr = ttk.Frame(f)
        hdr.grid(row=0, column=0, sticky='ew')
        ttk.Label(hdr, text="Log", font=('', 9, 'bold')).pack(side='left')
        ttk.Button(hdr, text="Clear", command=self._log_clear).pack(side='right')

        self.log_txt = scrolledtext.ScrolledText(
            f, height=10, wrap='word', state='disabled',
            font=('Courier', 8), background='#1e1e1e', foreground='#d4d4d4')
        self.log_txt.grid(row=1, column=0, sticky='nsew')

        # Tags for colour coding
        self.log_txt.tag_config('ts',   foreground='#6a9fb5')
        self.log_txt.tag_config('emit', foreground='#86c1b9')
        self.log_txt.tag_config('err',  foreground='#cc6666')
        self.log_txt.tag_config('warn', foreground='#f0c674')
        self.log_txt.tag_config('ok',   foreground='#b5bd68')

    def _log(self, text, tag=''):
        ts = datetime.now().strftime('%H:%M:%S')
        self.log_txt.configure(state='normal')
        self.log_txt.insert('end', f'[{ts}] ', 'ts')
        self.log_txt.insert('end', text + '\n', tag if tag else '')
        self.log_txt.configure(state='disabled')
        self.log_txt.see('end')

    def _log_clear(self):
        self.log_txt.configure(state='normal')
        self.log_txt.delete('1.0', 'end')
        self.log_txt.configure(state='disabled')

    # ── Connection ────────────────────────────────────────────────────────────

    def _refresh_ports(self):
        if not HAS_SERIAL:
            return
        ports = [p.device for p in serial.tools.list_ports.comports()]
        if DEFAULT_PORT not in ports:
            ports.insert(0, DEFAULT_PORT)
        self.cmb_port['values'] = ports

    def _toggle_conn(self):
        if self.ser is None:
            self._connect()
        else:
            self._disconnect()

    def _connect(self):
        if not HAS_SERIAL:
            messagebox.showerror("Error", "pyserial not installed.")
            return
        port = self.var_port.get()
        try:
            baud = int(self.var_baud.get())
        except ValueError:
            baud = DEFAULT_BAUD

        try:
            self.ser = serial.Serial(port, baud, timeout=1)
        except serial.SerialException as e:
            messagebox.showerror("Serial Error", str(e))
            return

        self.lbl_conn.configure(text="● CONNECTING...", foreground='orange')
        self.btn_conn.configure(text="Disconnect")
        self._log(f"Connected to {port} @ {baud} baud", tag='ok')

        # Start RX thread
        self._rxthd = threading.Thread(target=self._rx_thread, daemon=True)
        self._rxthd.start()

        # Send STOP first (in case board is mid-operation), then STATUS
        self.root.after(300, self._initial_handshake)

    def _initial_handshake(self):
        self._send_raw("STOP\n")
        self.root.after(400, lambda: self._send_raw("STATUS\n"))

    def _disconnect(self):
        if self.ser:
            try:
                self.ser.close()
            except Exception:
                pass
            self.ser = None
        self.lbl_conn.configure(text="● DISCONNECTED", foreground='gray')
        self.btn_conn.configure(text="Connect")
        self._set_busy(False)
        self._log("Disconnected.", tag='warn')

    def _send_raw(self, text):
        if self.ser and self.ser.is_open:
            try:
                self.ser.write(text.encode('ascii'))
            except Exception as e:
                self._log(f"Send error: {e}", tag='err')

    def send_cmd(self, cmd):
        """Send a command (adds \\n) and mark system as busy."""
        if not self.ser or not self.ser.is_open:
            messagebox.showwarning("Not connected", "Connect to the board first.")
            return False
        if self.busy:
            messagebox.showwarning("Busy", "An operation is already running.\n"
                                   "Click Stop first.")
            return False
        self._log(f"→ {cmd}", tag='emit')
        self._send_raw(cmd + '\n')
        self._set_busy(True)
        return True

    def _stop(self):
        """Send a single byte to signal the board to stop."""
        if self.ser and self.ser.is_open:
            self._log("→ STOP", tag='warn')
            self._send_raw("X")   # any byte triggers g_stop in C
        self._set_busy(False)

    def _set_busy(self, busy):
        self.busy = busy
        state = 'disabled' if busy else 'normal'
        for w in [self.btn_tx_start, self.btn_rx, self.btn_xcvr,
                  self.btn_lp_start]:
            try:
                w.configure(state=state)
            except Exception:
                pass
        self.lbl_op.configure(
            text="RUNNING..." if busy else "IDLE",
            foreground='orange' if busy else 'green')

    # ── Background RX thread ──────────────────────────────────────────────────

    def _rx_thread(self):
        while self.ser and self.ser.is_open:
            try:
                raw = self.ser.readline()
                if raw:
                    line = raw.decode('ascii', errors='replace').rstrip()
                    self.rxq.put(line)
            except Exception:
                break

    def _poll_queue(self):
        """Called every 50 ms from main thread to drain the RX queue."""
        try:
            while True:
                line = self.rxq.get_nowait()
                self._handle_line(line)
        except queue.Empty:
            pass
        if self._iq_dirty:
            self._iq_refresh()
            self._fft_refresh()
            self._iq_dirty = False
        self.root.after(50, self._poll_queue)

    def _handle_line(self, line):
        if not line:
            return

        if line.startswith('##'):
            body = line[2:]
            # IQ/data bulk lines go to GUI only — don't flood the log
            if body.startswith('IQ_BURST') or body.startswith('PKT_DATA') \
                    or body.startswith('TX_REF'):
                self._parse_emit(body)
                return
            self._parse_emit(body)
            self._log(line, tag='emit')
            return
        elif 'FATAL' in line or 'ERR' in line.upper():
            tag = 'err'
        elif 'WARN' in line or 'warn' in line:
            tag = 'warn'
        elif 'OK' in line or 'PASS' in line or 'ALIGNED' in line:
            tag = 'ok'
        else:
            tag = ''

        self._log(line, tag=tag)

    def _parse_emit(self, body):
        """Parse ##-prefixed structured lines from the board."""
        kv = parse_kv(body)

        if body.startswith('READY'):
            self.lbl_conn.configure(text="● READY", foreground='#00aa00')
            self._set_busy(False)

        elif body.startswith('STATUS'):
            fcs  = kv.get('fcs_ok', '?')
            bad  = kv.get('bad', '?')
            hdr  = kv.get('hdr', '?')
            rate = kv.get('rate', '?')
            lclk = kv.get('lclk', '?')
            skip = kv.get('skip', '?')
            pol  = kv.get('pol',  '?')
            ensm = kv.get('ensm', '?')
            hz   = int(lclk) if lclk.isdigit() else 0
            self.lbl_sys.configure(
                text=f"FCS_OK={fcs} BAD={bad} HDR={hdr} | "
                     f"rate={rate} | l_clk={hz//1_000_000}.{(hz//100_000)%10}MHz | "
                     f"Align: pol={pol},skip={skip} | ENSM={ensm}")
            self._update_info_box(kv)
            self._set_busy(False)

        elif body.startswith('ALIGNED'):
            skip = kv.get('skip', '?'); pol = kv.get('pol', '?')
            self.lbl_sys.configure(
                text=self.lbl_sys.cget('text')
                     .split('Align:')[0] + f"Align: pol={pol},skip={skip}"
                     + (self.lbl_sys.cget('text').split('Align:')[1]
                        [self.lbl_sys.cget('text').split('Align:')[1].find(' '):]
                        if 'Align:' in self.lbl_sys.cget('text') else ''))

        elif body.startswith('BIST_DONE'):
            self._set_busy(False)

        elif body.startswith('TX_DONE'):
            sent = kv.get('sent', '?'); ok   = kv.get('ok',   '?')
            hdr  = kv.get('hdr',  '?'); miss = kv.get('miss', '?')
            self.lbl_tx_res.configure(
                text=f"Sent {sent}  |  OK {ok}  |  Hdr-only {hdr}  |  Miss {miss}")
            self._set_busy(False)

        elif body.startswith('TX_PKT'):
            pass   # individual packet results go to log only

        elif body.startswith('PKT_DATA'):
            pkt_num = int(kv.get('pkt', '0'))
            fcs_ok  = int(kv.get('fcs', '0'))
            hdr_ok  = int(kv.get('hdr', '0'))
            hex_raw = body.split('hex=', 1)[-1] if 'hex=' in body else ''
            rx_bytes = [int(h, 16) for h in hex_raw.split() if h]
            self._data_append_pkt(pkt_num, fcs_ok, hdr_ok, rx_bytes)

        elif body.startswith('PKT'):
            fcs  = int(kv.get('fcs',  '0'))
            hdr  = int(kv.get('hdr',  '0'))
            miss = int(kv.get('miss', '0'))
            ber  = kv.get('ber_ppm', '--')
            if fcs:   self._rx_ok   += 1
            elif hdr: self._rx_hdr  += 1
            else:     self._rx_miss += 1
            total = self._rx_ok + self._rx_hdr + self._rx_miss
            self.lbl_rx_cnt.configure(
                text=f"Pkts: {total} total  |  {self._rx_ok} FCS-OK  |  "
                     f"{self._rx_hdr} hdr-only  |  {self._rx_miss} miss  |  "
                     f"last BER: {ber} ppm")

        elif body.startswith('RELAY'):
            total = int(kv.get('relay', 0))
            ok    = int(kv.get('relay_ok', 0))
            ber   = kv.get('ber_ppm', '--')
            self._xcvr_total  = total
            if ok: self._xcvr_ok += 1
            self.lbl_xcvr.configure(
                text=f"Relay #{total}  |  Success: {self._xcvr_ok}/{total}  |  "
                     f"BER: {ber} ppm")

        elif body.startswith('SWEEP_PT'):
            mcs      = int(kv.get('mcs',      '0'))
            ht       = int(kv.get('ht',        '0'))
            snr      = int(kv.get('snr',       '0'))
            per_x10  = int(kv.get('per_x10',   '0'))
            ber_ppm  = int(kv.get('ber_ppm',   '0'))
            shift    = int(kv.get('shift',     '0'))
            key = (mcs, ht)
            if key not in self.plot_data:
                self.plot_data[key] = {'snr': [], 'per_x10': [], 'ber': []}
            self.plot_data[key]['snr'].append(snr)
            self.plot_data[key]['per_x10'].append(per_x10)
            self.plot_data[key]['ber'].append(ber_ppm)
            self._plot_refresh()
            per_pct = per_x10 / 10.0
            self.lbl_lp_prog.configure(
                text=f"MCS {mcs} {'HT' if ht else 'L'}  |  "
                     f"shift={shift}  SNR={snr} dB  |  "
                     f"PER={per_pct:.1f}%  BER={ber_ppm} ppm")

        elif body.startswith('SWEEP_DONE'):
            mcs   = kv.get('mcs', '?')
            thr   = kv.get('thresh_snr', '--')
            self.lbl_lp_prog.configure(
                text=f"Done MCS {mcs}  |  Waterfall SNR ≈ {thr} dB")

        elif body.startswith('DONE'):
            self._set_busy(False)

        elif body.startswith('ERR'):
            self._set_busy(False)

        elif body.startswith('CAPIQ_DONE'):
            n = int(kv.get('n', '0'))
            self._log(f"CAPIQ done — {n} samples captured", tag='ok')
            self._set_busy(False)

        elif body.startswith('ALIGN_FAILED'):
            messagebox.showwarning("Alignment Failed",
                                   "RF alignment failed.\n"
                                   "Check: SMA cable TX1A→RX1A, RF gains, FDD state.")
            self._set_busy(False)

        elif body.startswith('IQ_BURST'):
            is_tx    = int(kv.get('is_tx', '0'))
            data_str = kv.get('data', '')
            if data_str:
                try:
                    vals = [int(x) for x in data_str.split(',') if x]
                    pts  = list(zip(vals[0::2], vals[1::2]))
                    if is_tx:
                        # constellation (capped)
                        self.iq_tx_pts.extend(pts)
                        if len(self.iq_tx_pts) > IQ_MAXPTS:
                            self.iq_tx_pts = self.iq_tx_pts[-IQ_MAXPTS:]
                        # rolling time-domain stream
                        self.iq_tx_i.extend(p[0] for p in pts)
                        self.iq_tx_q.extend(p[1] for p in pts)
                        self.iq_tx_total += len(pts)
                    else:
                        self.iq_rx_pts.extend(pts)
                        if len(self.iq_rx_pts) > IQ_MAXPTS:
                            self.iq_rx_pts = self.iq_rx_pts[-IQ_MAXPTS:]
                        self.iq_rx_i.extend(p[0] for p in pts)
                        self.iq_rx_q.extend(p[1] for p in pts)
                        self.iq_rx_total += len(pts)
                    self._iq_dirty = True
                except (ValueError, TypeError):
                    pass

        elif body.startswith('TX_REF'):
            hex_raw   = body.split('hex=', 1)[-1] if 'hex=' in body else ''
            ref_bytes = [int(h, 16) for h in hex_raw.split() if h]
            self._data_clear()
            self._iq_clear()
            self._data_set_ref(ref_bytes)

    def _update_info_box(self, kv):
        lines = [
            f"FCS OK   : {kv.get('fcs_ok','?')}",
            f"Bad pkts : {kv.get('bad','?')}",
            f"Hdr OK   : {kv.get('hdr','?')}",
            f"Last rate: {kv.get('rate','?')}",
            f"Last len : {kv.get('len','?')}",
            f"l_clk    : {kv.get('lclk','?')} Hz",
            f"Align    : pol={kv.get('pol','?')}  skip={kv.get('skip','?')}",
            f"ENSM     : {kv.get('ensm','?')}",
        ]
        self.lbl_info.configure(state='normal')
        self.lbl_info.delete('1.0', 'end')
        self.lbl_info.insert('end', '\n'.join(lines))
        self.lbl_info.configure(state='disabled')

    # ── Command senders ───────────────────────────────────────────────────────

    def _req_status(self):
        if self.ser and self.ser.is_open:
            self._log("→ STATUS", tag='emit')
            self._send_raw("STATUS\n")

    def _req_align(self):
        if self.send_cmd("ALIGN"):
            pass

    def _req_bist(self):
        if self.send_cmd("BIST"):
            pass

    def _start_tx(self):
        ht  = self.tx_ht.get()
        mcs = self.tx_cmb.current()
        n   = self.tx_n.get()
        self.send_cmd(f"TX {ht} {mcs} {n}")

    def _start_rx(self):
        ht  = self.rx_ht.get()
        mcs = self.rx_cmb.current()
        self._rx_ok = self._rx_hdr = self._rx_miss = 0
        self.lbl_rx_cnt.configure(text="Waiting for packets...")
        self.send_cmd(f"RX {ht} {mcs}")

    def _start_xcvr(self):
        ht  = self.xcvr_ht.get()
        mcs = self.xcvr_cmb.current()
        self._xcvr_ok = self._xcvr_total = 0
        self.lbl_xcvr.configure(text="Starting relay...")
        self.send_cmd(f"XCVR {ht} {mcs}")

    def _send_capiq(self):
        n = self.var_capiq_n.get()
        if self.send_cmd(f"CAPIQ {n}"):
            self._log(f"Full IQ capture requested: {n} samples "
                      f"(~{n * 9 / 11520:.1f}s transfer)", tag='warn')

    def _start_loop(self):
        ht    = self.lp_ht.get()
        mcs   = -1 if self.lp_all.get() else self.lp_cmb.current()
        sweep = self.lp_sweep.get()
        ss    = self.lp_ss.get()
        se    = self.lp_se.get()
        fs    = self.lp_fs.get()
        fn    = self.lp_fn.get()
        if sweep and se < ss:
            messagebox.showwarning("Range", "Shift end must be ≥ shift start.")
            return
        self.lbl_lp_prog.configure(text="Starting sweep...")
        self.send_cmd(f"LOOP {ht} {mcs} {sweep} {ss} {se} {fs} {fn}")

    # ── Run ───────────────────────────────────────────────────────────────────

    def run(self):
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)
        self.root.mainloop()

    def _on_close(self):
        self._disconnect()
        self.root.destroy()


# ── Entry point ────────────────────────────────────────────────────────────────
if __name__ == '__main__':
    OFDMGui().run()
