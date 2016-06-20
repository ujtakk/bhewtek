#### notice, don't forget update Makefile.dep
#### (make compile.all USE_CACHE=0; ...; rm -f Makefile.dep; make Makefile.dep)
include Makefile.dep
include $(IOC_DIR)/Makefile.common

# SIMULATOR=vcs
# SIMULATOR=iverilog
IOC_DIR=.
TARGET=test_top
DIST=../dist

.PHONY: all sim clean
all: $(TARGET).com
sim: $(TARGET).log
clean:
	make clean-common
	rm -f log.txt
