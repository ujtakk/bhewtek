#### notice, don't forget update Makefile.dep
#### (make compile.all USE_CACHE=0; ...; rm -f Makefile.dep; make Makefile.dep)

# SIMULATOR=vcs
# SIMULATOR=iverilog
IOC_DIR=.

TARGET=test_top

all: $(TARGET).com

sim: $(TARGET).log

include Makefile.dep
include $(IOC_DIR)/Makefile.common

clean:
	make clean-common
	rm -f log.txt
