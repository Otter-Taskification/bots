#! /usr/bin/env bash

set -v

OPT=${1:--O3}
ASAN=${2:-}   # -fsanitize=address

printf "optimisation:      %s\n" ${OPT}
printf "address sanitizer: %s\n" ${ASAN}

icx -fiopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -I. -o main.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"icx -fiopenmp\"" -DLD="\"icx -fiopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -I.\""
icx -fiopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -o strassen.o strassen.c
icx -fiopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -o ../..//common/bots_common.o ../..//common/bots_common.c
icx -fiopenmp ${ASAN} ${OPT}   -o ../..//bin/strassen.icx.omp-tasks main.o strassen.o  ../..//common/bots_common.o -lotter-task-graph -lotf2 -lm -lstdc++
# icx -fiopenmp -c -I../..//common ${OPT}   -DMANUAL_CUTOFF -I. -o main-manual.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"icx -fiopenmp\"" -DLD="\"icx -fiopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DMANUAL_CUTOFF -I.\""
# icx -fiopenmp -c -I../..//common ${OPT}   -DMANUAL_CUTOFF -o strassen-manual.o strassen.c
# icx -fiopenmp ${OPT}   -o ../..//bin/strassen.icx.omp-tasks-manual main-manual.o strassen-manual.o  ../..//common/bots_common.o
# icx -fiopenmp -c -I../..//common ${OPT}   -DIF_CUTOFF -I. -o main-if.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"icx -fiopenmp\"" -DLD="\"icx -fiopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DIF_CUTOFF-I.\""
# icx -fiopenmp -c -I../..//common ${OPT}   -DIF_CUTOFF -o strassen-if.o strassen.c
# icx -fiopenmp ${OPT}   -o ../..//bin/strassen.icx.omp-tasks-if_clause main-if.o strassen-if.o  ../..//common/bots_common.o
icx -fiopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -I. -o main-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"icx -fiopenmp\"" -DLD="\"icx -fiopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -I.\""
cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
icx -fiopenmp ${ASAN} -DWITH_OTTER -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -o strassen-tied.o tied-strassen.c;\
# rm tied-strassen.c
icx -fiopenmp ${ASAN} -DWITH_OTTER ${OPT}   -o ../..//bin/strassen.icx.omp-tasks-tied main-tied.o strassen-tied.o  ../..//common/bots_common.o -lotter-task-graph -lotf2 -lm -lstdc++
# icx -fiopenmp -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DMANUAL_CUTOFF -I. -o main-manual-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"icx -fiopenmp\"" -DLD="\"icx -fiopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DMANUAL_CUTOFF -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# icx -fiopenmp -c -I../..//common ${OPT}   -DMANUAL_CUTOFF -DFORCE_TIED_TASKS -o strassen-manual-tied.o strassen.c;\
# rm tied-strassen.c
# icx -fiopenmp ${OPT}   -o ../..//bin/strassen.icx.omp-tasks-manual-tied main-manual-tied.o strassen-manual-tied.o  ../..//common/bots_common.o
# icx -fiopenmp -c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DIF_CUTOFF -I. -o main-if-tied.o ../..//common/bots_main.c -DCDATE="\"2023/11/14;09:56\"" -DCC="\"icx -fiopenmp\"" -DLD="\"icx -fiopenmp\"" -DCMESSAGE="\"\"" -DLDFLAGS="\"${OPT}   \"" -DCFLAGS="\"-c -I../..//common ${OPT}   -DFORCE_TIED_TASKS -DIF_CUTOFF -I.\""
# cat strassen.c | sed -e "s/task \{1,\}untied/task/g" > tied-strassen.c ;\
# icx -fiopenmp -c -I../..//common ${OPT}   -DIF_CUTOFF -DFORCE_TIED_TASKS -o strassen-if-tied.o strassen.c;\
# rm tied-strassen.c
# icx -fiopenmp ${OPT}   -o ../..//bin/strassen.icx.omp-tasks-if_clause-tied main-if-tied.o strassen-if-tied.o  ../..//common/bots_common.o
