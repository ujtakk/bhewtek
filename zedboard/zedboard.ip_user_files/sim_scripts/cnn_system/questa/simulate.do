onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -pli "/ram/mnt_opt/opt/xilinx/Vivado/2016.2/lib/lnx64.o/libxil_vsim.so" -lib xil_defaultlib cnn_system_opt

do {wave.do}

view wave
view structure
view signals

do {cnn_system.udo}

run -all

quit -force
