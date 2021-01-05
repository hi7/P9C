#!/bin/bash
set -euo pipefail

echo "Simulate p9c.v icarus verilog"
iverilog -o p9c_tb.vvp p9c_tb.v
vvp p9c_tb.vvp

echo "open GTKWave"
gtkwave p9c_tb.vcd p9c_tb.gtkw
