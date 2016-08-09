#### notice, don't forget update Makefile.dep
#### (make compile.all USE_CACHE=0; ...; rm -f Makefile.dep; make Makefile.dep)
# SIMULATOR=vcs
# SIMULATOR=iverilog
IOC_DIR=.
TARGET=test_top
DIST=../dist

include Makefile.dep
include $(IOC_DIR)/Makefile.common

.PHONY: all sim clean
all: $(TARGET).com
sim: $(TARGET).log
clean:
	make clean-common
	rm -f log.txt

diff:
	vimdiff $(TARGET).dat $(TARGET)_true.dat
