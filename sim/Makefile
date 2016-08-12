cnn:
	gcc -o cnn.out -lm cnn.c
	./cnn.out 2 4

conv:
	gcc -o conv.out -lm -std=c11 conv.c
	./conv.out

rand:
	ocamlopt -o rand.out rand.ml
	./rand.out

bpmap:
	gcc -o bpmap.out -lm -std=c11 bpmap.c -DCALC
	for i in `seq 0 9`; do \
		mkdir -p /home/work/takau/bhewtek/data/mnist/binput/$$i; \
		mkdir -p /home/work/takau/bhewtek/data/mnist/ipmap1_true/$$i; \
		mkdir -p /home/work/takau/bhewtek/data/mnist/bpmap1_true/$$i; \
		for j in `seq 1 10`; do \
			./bpmap.out $$i $$j; \
		done; \
	done
