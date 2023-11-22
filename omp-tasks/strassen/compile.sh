#! /usr/bin/env bash

set -v

OPT=${1:--O3}
ASAN=${2:-}   # -fsanitize=address

printf "optimisation:      %s\n" ${OPT}
printf "address sanitizer: %s\n" ${ASAN}

clang -fopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -I. -o main.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -I.\""
clang -fopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -o strassen.o strassen.c
clang -fopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -o ../..//common/bots_common.o ../..//common/bots_common.c
clang -fopenmp ${ASAN} ${OPT}   -o ../..//bin/strassen.clang.omp-tasks main.o strassen.o  ../..//common/bots_common.o -lotter-task-graph -lotf2 -lm -lstdc++
# clang -fopenmp -c -I../..//common ${OPT}   -DMANUAL_CUTOFF -I. -o main-manual.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DMANUAL_CUTOFF -I.\""
# clang -fopenmp -c -I../..//common ${OPT}   -DMANUAL_CUTOFF -o strassen-manual.o strassen.c
# clang -fopenmp ${OPT}   -o ../..//bin/strassen.clang.omp-tasks-manual main-manual.o strassen-manual.o  ../..//common/bots_common.o
# clang -fopenmp -c -I../..//common ${OPT}   -DIF_CUTOFF -I. -o main-if.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DIF_CUTOFF-I.\""
# clang -fopenmp -c -I../..//common ${OPT}   -DIF_CUTOFF -o strassen-if.o strassen.c
# clang -fopenmp ${OPT}   -o ../..//bin/strassen.clang.omp-tasks-if_clause main-if.o strassen-if.o  ../..//common/bots_common.o
clang -fopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -I. -o main-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -I.\""
cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
clang -fopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -o strassen-tied.o tied-strassen.c;\
# rm tied-strassen.c
clang -fopenmp ${ASAN} -DWITH_OTTER ${OPT}   -o ../..//bin/strassen.clang.omp-tasks-tied main-tied.o strassen-tied.o  ../..//common/bots_common.o -lotter-task-graph -lotf2 -lm -lstdc++
# clang -fopenmp -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DMANUAL_CUTOFF -I. -o main-manual-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DMANUAL_CUTOFF -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# clang -fopenmp -c -I../..//common ${OPT}   -DMANUAL_CUTOFF -DFORCE_TIED_TASKS -o strassen-manual-tied.o strassen.c;\
# rm tied-strassen.c
# clang -fopenmp ${OPT}   -o ../..//bin/strassen.clang.omp-tasks-manual-tied main-manual-tied.o strassen-manual-tied.o  ../..//common/bots_common.o
# clang -fopenmp -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DIF_CUTOFF -I. -o main-if-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"clang -fopenmp\"" -DLD="\"clang -fopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DIF_CUTOFF -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# clang -fopenmp -c -I../..//common ${OPT}   -DIF_CUTOFF -DFORCE_TIED_TASKS -o strassen-if-tied.o strassen.c;\
# rm tied-strassen.c
# clang -fopenmp ${OPT}   -o ../..//bin/strassen.clang.omp-tasks-if_clause-tied main-if-tied.o strassen-if-tied.o  ../..//common/bots_common.o
