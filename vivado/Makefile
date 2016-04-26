conf:
	(cd ../rtl; make)
	vivado -mode batch -source conf.tcl

sdk:
	xsdk -batch -source sdk.tcl 2>&1 | tee sdk.log

clean:
	rm -f *.log *.jou *.str
	rm -rf top reports results
	rm -f usage_*
