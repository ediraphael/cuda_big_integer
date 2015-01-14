#include <stdio.h>
#include <iostream>
#include <string.h>
#include <stdlib.h> 
using namespace std;

void test_add(char* valeur1, char* valeur2, char* resultat) {
	for (int i = strlen(resultat)-1; i >= 1; --i) {
		int nouveau  = valeur1[i-1] - '0' + valeur2[i-1] - '0' + resultat[i] - '0';
		if( nouveau > 9 ) {
			resultat[i-1] += 1;
			nouveau -= 10;
		}
		resultat[i] = nouveau + '0';
	}
}

int main(int argc, char *argv[]) {

	string toto1 = "87945654674984346542165425465413215646241321654321324";
		   toto1 = "99999999999999999999999999999999999999999999999999999";
	string toto2 = "98765467465426578651654613216546132121564321321654212";
	cout << "Big integer: " << endl;
	cout << "taille toto1 :"<< toto1.length() << endl;
	char test1[toto1.length()];
	char test2[toto2.length()];
	char test3[toto2.length()+1];
	cout << "taille test1 :" << sizeof(test1) << endl;
	cout << "premiere element :" << toto1[0] << endl;
	for (int i = 0; i < sizeof(test1); ++i) {
		test1[i] = toto1[i];
		test2[i] = toto2[i];
	}
	for (int i = 0; i < sizeof(test3); ++i) {
		test3[i] = '0';
	}
	

	
	test_add(test1,test2,test3);
	cout << "0" << toto1 << endl;
	cout << "0" << toto2 << endl;
	cout << test1 << endl;
	return 0;
}
