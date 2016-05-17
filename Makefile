data:
	rsync -av okinawa:/home/work/takau/bhewtek/data ./

.PHONY: clean

clean:
	rm -f vivado*.log vivado*.jou vivado*.zip vivado*.str vivado*.debug
