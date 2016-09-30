.PHONY: impl data dist clean

run:
	(cd zedboard/zedboard.sdk/cnn/Debug; \
		make)
	xsdk -batch -source scripts/run.tcl

impl:
	vivado -mode batch -source scripts/impl.tcl

data:
	rsync -av okinawa:/home/work/takau/bhewtek/data ./

dist:
	(cd rtl; make dist)

clean:
	rm -f vivado*.log vivado*.jou vivado*.zip vivado*.str vivado*.debug
