onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -pli "/ram/mnt_opt/opt/xilinx/Vivado/2016.1/lib/lnx64.o/libxil_vsim.so" -lib xil_defaultlib processing_system7_0_opt

do {wave.do}

view wave
view structure
view signals

do {processing_system7_0.udo}

run -all

quit -force
