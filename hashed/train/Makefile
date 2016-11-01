epoch=20
comp=0.2

all:
	make norm
	make hash
	make lhconv

norm:
	th conv.lua -maxEpoch ${epoch} -compression ${comp} | tee norm${comp}.log

hash:
	th conv.lua -hash -maxEpoch ${epoch} -compression ${comp} | tee hash${comp}.log

lhconv:
	th conv.lua -hash -xi -lhconv -maxEpoch ${epoch} -compression ${comp} | tee lhconv${comp}.log

graph:
	jupyter nbconvert --to notebook -ExecutePreprocessor.timeout=-1 --execute hash_learn.ipynb --inplace

convert:
	gcc -o convert.out -lm -std=gnu11 convert.c
