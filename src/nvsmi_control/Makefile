CXX=g++
CXXFLAGS= -fopenmp
NVCC=nvcc
NVCCFLAGS=
LDFLAGS= -L/usr/local/cuda/lib64 -lcuda -lcudart
EXE=nvsmi_control


all: ${EXE}
${EXE}: control.o kernel.o
	${CXX} ${CXXFLAGS} control.o kernel.o -o ${EXE} ${LDFLAGS}
control.o: control.cpp
	${CXX} ${CXXFLAGS} -c control.cpp -o control.o
kernel.o: kernel.cu
	${NVCC} ${NVCCFLAGS} -c kernel.cu -o kernel.o

clean:
	rm ${EXE} control.o kernel.o
