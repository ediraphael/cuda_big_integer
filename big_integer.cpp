#include <stdio.h>
#include <iostream>
#include <string.h>
#include <stdlib.h> 
using namespace std;

struct BigInteger {
	char* valeur;
	int taille;
	bool est_positif;
};

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

	BigInteger bigInteger1;
	bigInteger1.valeur = "8794565467498434654216542546541321564624132165432324";
	bigInteger1.taille = strlen(bigInteger1.valeur);
	bigInteger1.est_positif = true;
	BigInteger bigInteger2;
	bigInteger2.valeur = "9876546746542657865165461321654613212156432132164212";
	bigInteger2.taille = strlen(bigInteger1.valeur);
	bigInteger2.est_positif = true;
	BigInteger resultat;
	resultat.taille = bigInteger1.taille+1;
	resultat.valeur = (char*)malloc((resultat.taille)*sizeof(char));
	resultat.est_positif = true;
	initialiser_biginteger(resultat.valeur,resultat.taille);

	//cout << sizeof(resultat) << endl;
	//cout << resultat.valeur << endl;
	test_add(bigInteger1.valeur,bigInteger1.taille,bigInteger2.valeur,bigInteger2.taille,resultat.valeur);
	cout << " " << bigInteger1.valeur << endl;
	cout << " " << bigInteger2.valeur << endl;
	cout << resultat.valeur << endl;


	return 0;
}
