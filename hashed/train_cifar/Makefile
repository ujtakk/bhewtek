epoch=20
comp=1.0

all:
	make norm
	make hash
	make lhconv

norm:
	th conv_cifar.lua -maxEpoch ${epoch} -compression ${comp} | tee norm${comp}.log

hash:
	th conv_cifar.lua -hash -maxEpoch ${epoch} -compression ${comp} | tee hash${comp}.log

lhconv:
	th conv_cifar.lua -hash -xi -lhconv -maxEpoch ${epoch} -compression ${comp} | tee lhconv${comp}.log

graph:
	jupyter nbconvert --to notebook -ExecutePreprocessor.timeout=-1 --execute hash_learn.ipynb --inplace

convert:
	gcc -o convert.out -lm -std=gnu11 convert.c
