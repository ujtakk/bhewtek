#### notice, don't forget update Makefile.dep
#### (make compile.all USE_CACHE=0; ...; rm -f Makefile.dep; make Makefile.dep)
# SIMULATOR=vcs
SIMULATOR=iverilog
IOC_DIR=.
TARGET=test_linebuf
DIST=../dist

include Makefile.dep
include $(IOC_DIR)/VERBMakefile

.PHONY: all sim clean
all: $(TARGET).com
sim: $(TARGET).log
clean:
	make clean-common
	rm -f log.txt

diff:
	vimdiff $(TARGET).dat ../$(TARGET)_pix.dat

log:
	vim $(TARGET).log

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
