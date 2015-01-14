#include <stdio.h>
#include <iostream>
#include <string.h>
#include <stdlib.h> 
using namespace std;

void test_add(char* valeur1, int taille1, char* valeur2, int taille2, char* resultat) {
	for (int i = taille1; i >0 ; --i) {
		int nouveau  = valeur1[i-1] - '0' + valeur2[i-1] - '0' + resultat[i] - '0';
		if( nouveau > 9 ) {
			resultat[i-1] += 1;
			nouveau -= 10;
		}
		resultat[i] = nouveau + '0';
	}
}

void initialiser_biginteger(char * valeur, int taille) {
	for (int i = 0; i < taille; ++i)	{
		valeur[i] = '0';
	}
}

int main(int argc, char *argv[]) {

	char* valeur1 = "8794565467498434654216542546541321564624132165432324";
	int taille1 = strlen(valeur1);
	char* valeur2 = "9876546746542657865165461321654613212156432132164212";
	int taille2 = strlen(valeur2);
	int tailleResultat = taille1+1;
	char* resultat = (char*)malloc((tailleResultat)*sizeof(char));

	initialiser_biginteger(resultat,tailleResultat);
	cout << resultat << endl;
	test_add(valeur1,taille1,valeur2,taille2,resultat);
	cout << " " << valeur1 << endl;
	cout << " " << valeur2 << endl;
	cout << resultat << endl;


	return 0;
}
