onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib myip_0_opt

do {wave.do}

view wave
view structure
view signals

do {myip_0.udo}

run -all

quit -force
