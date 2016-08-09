cnn:
	gcc -o cnn.out -lm cnn.c -DIPMAP2
	./cnn.out 8 5 | tee test_top_true.dat

conv:
	gcc -o conv.out -lm -std=c11 conv.c
	./conv.out

rand:
	ocamlopt -o rand.out rand.ml
	./rand.out
