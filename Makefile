.PHONY: data dist clean

data:
	rsync -av okinawa:/home/work/takau/bhewtek/data ./

dist:
	(cd rtl; make dist)

clean:
	rm -f vivado*.log vivado*.jou vivado*.zip vivado*.str vivado*.debug
