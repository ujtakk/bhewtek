RTL_DIR=$(PWD)/../rtl
TARGET=rtl_top_hash

all:
	make link
	./auto.sh $(TARGET).v
	./sim.sh | tee log

link:
	ln -s $(RTL_DIR)/*.v .
	ln -s $(RTL_DIR)/*.vh .
	ln -s $(RTL_DIR)/*.rb .
	rm -f dep.rb

auto:
	make link
	./auto.sh $(TARGET).v

clean:
	rm -f *.v *.vh *.rb
	rm -rf saif*/ tb/ maborosi.sh log
