.PHONY: impl data dist clean

impl:
	vivado -mode batch -source flow.tcl

data:
	rsync -av okinawa:/home/work/takau/bhewtek/data ./

dist:
	(cd rtl; make dist)

clean:
	rm -f vivado*.log vivado*.jou vivado*.zip vivado*.str vivado*.debug
