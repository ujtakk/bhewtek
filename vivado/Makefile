conf:
	(cd ../rtl; make)
	vivado -mode batch -source conf.tcl 2>&1 | tee conf.log

clean:
	rm -f *.log *.jou
	rm -rf reports results
