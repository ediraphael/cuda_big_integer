all : big_integer.exe

big_integer.exe: big_integer.cpp
	g++  $< -o $@ -O2

clean:
	rm -rf *.exe
	
