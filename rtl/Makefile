#### notice, don't forget update Makefile.dep
#### (make compile.all USE_CACHE=0; ...; rm -f Makefile.dep; make Makefile.dep)
# SIMULATOR=vcs
# SIMULATOR=iverilog
# SIMULATOR=xsim
IOC_DIR=.
# TARGET=test_top_first
TARGET=test_top
# DIST=../ip_repo/copro_1.0/src/
DIST=../dist

include Makefile.dep
include VERBMakefile

.PHONY: all file sim clean
sim: $(TARGET).log
file: $(TARGET).com

all:
	make clean
	make sim

clean:
	make clean-common
	rm -f log.txt
	rm -f vish_stacktrace.vstf
	rm -f $(TARGET)

log:
	vim $(TARGET).log

edit:
	vim -O $(TARGET).v.erb `echo $(TARGET) | awk -F "test_" '{print $$2 ".v.erb"}'`

diff:
	vimdiff $(TARGET).dat $(TARGET)_true.dat

define DEP_IN
## -*- text -*-
## ignore list

ignore_file {
    rdpb18_128x16_g1.v.erb
    rdpb18_128x16_g1_behave.v.erb
    rspb18_16kx16m16_g1.v.erb
    rspb18_1kx16m8_g1.v.erb
    rspb18_2kx16m8_g1.v.erb
    rspb18_4kx16m8_g1.v.erb
    rspb18_512x16m8_g1.v.erb
    rspb18_8kx16m16_g1.v.erb
    rdpb18_128x16_g1.v.erb
    rdpb18_128x16_g1_behave.v.erb
}

ignore_com {
}
endef
export DEP_IN
