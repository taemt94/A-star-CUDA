FLAGS=-std=c++14 -g
ifeq ($(wildcard /opt/cuda/bin/nvcc),)
	NVCC=nvcc
else
	NVCC=/opt/cuda/bin/nvcc
endif

astar_gpu: main.cpp astar_gpu.o heap.o list.o
	$(NVCC) $(FLAGS) main.cpp astar_gpu.o heap.o list.o -o astar_gpu

astar_gpu.o: astar_gpu.cu astar_gpu.h
	$(NVCC) $(FLAGS) -c astar_gpu.cu -o astar_gpu.o

heap.o: heap.cu heap.h
	$(NVCC) $(FLAGS) -c heap.cu -o heap.o

list.o: list.cu list.h
	$(NVCC) $(FLAGS) -c list.cu -o list.o

.PHONY: clean
clean:
	rm *.o
	rm astar_gpu
