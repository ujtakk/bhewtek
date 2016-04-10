#### notice, don't forget update Makefile.dep
#### (make compile.all USE_CACHE=0; ...; rm -f Makefile.dep; make Makefile.dep)

# SIMULATOR=vcs
# SIMULATOR=iverilog
IOC_DIR=.

TARGET=test_top

all: $(TARGET).com

include Makefile.dep
include $(IOC_DIR)/Makefile.common

################################################################
# clean targets
################################################################

clean: clean-common

saif:
	vcs -full64 -R -debug_all -PP -timescale=1ns/1ps +v2k +neg_tchk *.v | tee vcslog
	vcd2saif -64 -input vcdplus.vpd -output $(TARGET).saif
