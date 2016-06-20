onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+processing_system7_0 -pli "/ram/mnt_opt/opt/xilinx/Vivado/2016.1/lib/lnx64.o/libxil_vsim.so" -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -O5 xil_defaultlib.processing_system7_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {processing_system7_0.udo}

run -all

endsim

quit -force
