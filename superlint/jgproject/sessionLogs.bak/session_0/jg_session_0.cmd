# ----------------------------------------
# Jasper Version Info
# tool      : Jasper 2023.09
# platform  : Linux 4.19.0-20-amd64
# version   : 2023.09 FCS 64 bits
# build date: 2023.09.27 19:40:18 UTC
# ----------------------------------------
# started   : 2025-05-08 21:36:42 UTC
# hostname  : joc044.(none)
# pid       : 34043
# arguments : '-label' 'session_0' '-console' '//127.0.0.1:42349' '-style' 'windows' '-data' 'AAAAxHicY2RgYLCp////PwMYMFcBCQEGHwZfhiAGVyDpzxAGpBkYzBjMGUyA0IHBkMGAQQ+MzYHYFMi3wiMHBowPIDSDDSMDMmAMbEChGRhYYQrhSoBYiqGYoZShgCGVoYghhyGTIY+hBGh6CUMykAcCANCSFME=' '-proj' '/home/joc/dd_C1_25/FP_mult-div_class24-25/superlint/jgproject/sessionLogs/session_0' '-init' '-hidden' '/home/joc/dd_C1_25/FP_mult-div_class24-25/superlint/jgproject/.tmp/.initCmds.tcl' 'superlint.tcl'
clear -all
set design_top mul_div

analyze -sv -f superlint_list 
config_rtlds -rule -load superlint_Verilog_SystemVerilog.def
