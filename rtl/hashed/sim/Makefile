CFLAGS ?= -O3
#CFLAGS += -std=c99 -Wall -Wextra -Wcast-qual -Wcast-align -Wshadow -Wstrict-aliasing=1 -Wswitch-enum -Wdeclaration-after-statement -Wstrict-prototypes -Wundef -pedantic
CFLAGS += -std=c++11 -Wall -Wextra -Wcast-qual -Wcast-align -Wshadow -Wstrict-aliasing=1 -Wswitch-enum -Wdeclaration-after-statement -Wstrict-prototypes -Wundef -pedantic
LDFLAGS = -lstdc++
FLAGS  := $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(MOREFLAGS)
CC = clang

execTest: hashFunc.cpp my_xxhash.cpp
	$(CC)      $(FLAGS) $^ -o $@

clean:
	rm -f execTest
