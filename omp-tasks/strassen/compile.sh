#! /usr/bin/env bash

clang -fopenmp -DWITH_OTTER -c -I../..//common -O3   -I. -o main.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"-O3   \"" -DCFLAGS="\"-c -I../..//common -O3   -I.\""
clang -fopenmp -DWITH_OTTER -c -I../..//common -O3   -o strassen.o strassen.c
clang -fopenmp -DWITH_OTTER -c -I../..//common -O3   -o ../..//common/bots_common.o ../..//common/bots_common.c
clang -fopenmp -O3   -o ../..//bin/strassen.clang.omp-tasks main.o strassen.o  ../..//common/bots_common.o -lotter-task-graph -lotf2
# clang -fopenmp -c -I../..//common -O3   -DMANUAL_CUTOFF -I. -o main-manual.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"-O3   \"" -DCFLAGS="\"-c -I../..//common -O3   -DMANUAL_CUTOFF -I.\""
# clang -fopenmp -c -I../..//common -O3   -DMANUAL_CUTOFF -o strassen-manual.o strassen.c
# clang -fopenmp -O3   -o ../..//bin/strassen.clang.omp-tasks-manual main-manual.o strassen-manual.o  ../..//common/bots_common.o
# clang -fopenmp -c -I../..//common -O3   -DIF_CUTOFF -I. -o main-if.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"-O3   \"" -DCFLAGS="\"-c -I../..//common -O3   -DIF_CUTOFF-I.\""
# clang -fopenmp -c -I../..//common -O3   -DIF_CUTOFF -o strassen-if.o strassen.c
# clang -fopenmp -O3   -o ../..//bin/strassen.clang.omp-tasks-if_clause main-if.o strassen-if.o  ../..//common/bots_common.o
# clang -fopenmp -c -I../..//common -O3   -DFORCE_TIED_TASKS -I. -o main-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"-O3   \"" -DCFLAGS="\"-c -I../..//common -O3   -DFORCE_TIED_TASKS -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# clang -fopenmp -c -I../..//common -O3   -DFORCE_TIED_TASKS -o strassen-tied.o tied-strassen.c;\
# rm tied-strassen.c
# clang -fopenmp -O3   -o ../..//bin/strassen.clang.omp-tasks-tied main-tied.o strassen-tied.o  ../..//common/bots_common.o
# clang -fopenmp -c -I../..//common -O3   -DFORCE_TIED_TASKS -DMANUAL_CUTOFF -I. -o main-manual-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"-O3   \"" -DCFLAGS="\"-c -I../..//common -O3   -DFORCE_TIED_TASKS -DMANUAL_CUTOFF -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# clang -fopenmp -c -I../..//common -O3   -DMANUAL_CUTOFF -DFORCE_TIED_TASKS -o strassen-manual-tied.o strassen.c;\
# rm tied-strassen.c
# clang -fopenmp -O3   -o ../..//bin/strassen.clang.omp-tasks-manual-tied main-manual-tied.o strassen-manual-tied.o  ../..//common/bots_common.o
# clang -fopenmp -c -I../..//common -O3   -DFORCE_TIED_TASKS -DIF_CUTOFF -I. -o main-if-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"-O3   \"" -DCFLAGS="\"-c -I../..//common -O3   -DFORCE_TIED_TASKS -DIF_CUTOFF -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# clang -fopenmp -c -I../..//common -O3   -DIF_CUTOFF -DFORCE_TIED_TASKS -o strassen-if-tied.o strassen.c;\
# rm tied-strassen.c
# clang -fopenmp -O3   -o ../..//bin/strassen.clang.omp-tasks-if_clause-tied main-if-tied.o strassen-if-tied.o  ../..//common/bots_common.o
