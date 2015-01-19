all : big_integer.exe

big_integer.exe: big_integer.cpp
	g++  $< -o big_integer.exe -O2

clean:
	rm -rf *.exe
	
