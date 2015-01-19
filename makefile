all : big_integer.exe

big_integer.exe: big_integer.cu
	nvcc  $< -o $@ -lglut -lGL --compiler-options -O2

clean:
	rm -rf *.exe
	
