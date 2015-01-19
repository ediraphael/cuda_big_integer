#include <stdio.h>
#include <iostream>
#include <string.h>
#include <stdlib.h> 
#include <cuda.h>
using namespace std;

#define CUDA_CHECK(value) {											\
		cudaError_t _m_cudaStat = value;										\
		if (_m_cudaStat != cudaSuccess) {										\
			fprintf(stderr, "Error %s at line %d in file %s\n",					\
					cudaGetErrorString(_m_cudaStat), __LINE__, __FILE__);		\
					exit(1);															\
		} }

struct BigInteger {
	char* valeur;
	int taille;
	bool est_positif;
};

__global__ void test_add(char* d1_v, int* d1_t, bool d1_b,char* d2_v, int* d2_t, bool d2_b,char* dr_v, int* dr_t, bool dr_b) {

	for (int i = *d1_t; i >0 ; --i) {
		int nouveau  = d1_v[i-1] - '0' + d2_v[i-1] - '0' + dr_v[i] - '0';
		if( nouveau > 9 ) {
			dr_v[i-1] += 1;
			nouveau -= 10;
		}
		dr_v[i] = nouveau + '0';
	}
}

void initialiser_biginteger(char * valeur, int taille) {
	for (int i = 0; i < taille; ++i)	{
		valeur[i] = '0';
	}
}

int main(int argc, char *argv[]) {

	dim3 grid(1);
	dim3 block(1);

	BigInteger bigInteger1;
	bigInteger1.valeur = "8794565467498434654216542546541321564624132165432324";
	bigInteger1.taille = strlen(bigInteger1.valeur);
	bigInteger1.est_positif = true;
	char* d1_v;
	int* d1_t;
	bool* d1_b;
	CUDA_CHECK(cudaMalloc( (void**) &d1_v, sizeof(char)*bigInteger1.taille));
	CUDA_CHECK(cudaMalloc( (void**) &d1_t, sizeof(int)));
	CUDA_CHECK(cudaMalloc( (void**) &d1_b, sizeof(bool)));
	CUDA_CHECK(cudaMemcpy(d1_v, bigInteger1.valeur, sizeof(char)*bigInteger1.taille, cudaMemcpyHostToDevice));
	CUDA_CHECK(cudaMemcpy(d1_t, &bigInteger1.taille, sizeof(int), cudaMemcpyHostToDevice));
	CUDA_CHECK(cudaMemcpy(d1_b, &bigInteger1.est_positif, sizeof(bool), cudaMemcpyHostToDevice));



	BigInteger bigInteger2;
	bigInteger2.valeur = "9876546746542657865165461321654613212156432132164212";
	bigInteger2.taille = strlen(bigInteger1.valeur);
	bigInteger2.est_positif = true;
	char* d2_v;
	int* d2_t;
	bool* d2_b;
	CUDA_CHECK(cudaMalloc( (void**) &d2_v, sizeof(char)*bigInteger1.taille));
	CUDA_CHECK(cudaMalloc( (void**) &d2_t, sizeof(int)));
	CUDA_CHECK(cudaMalloc( (void**) &d2_b, sizeof(bool)));
	CUDA_CHECK(cudaMemcpy(d2_v, bigInteger2.valeur, sizeof(char)*bigInteger2.taille, cudaMemcpyHostToDevice));
	CUDA_CHECK(cudaMemcpy(d2_t, &bigInteger2.taille, sizeof(int), cudaMemcpyHostToDevice));
	CUDA_CHECK(cudaMemcpy(d2_b, &bigInteger2.est_positif, sizeof(bool), cudaMemcpyHostToDevice));

	BigInteger resultat;
	resultat.taille = bigInteger1.taille+1;
	resultat.valeur = (char*)malloc((resultat.taille)*sizeof(char));
	resultat.est_positif = true;
	initialiser_biginteger(resultat.valeur,resultat.taille);
	char* dr_v;
	int* dr_t;
	bool* dr_b;
	CUDA_CHECK(cudaMalloc( (void**) &dr_v, sizeof(char)*resultat.taille));
	CUDA_CHECK(cudaMalloc( (void**) &dr_t, sizeof(int)));
	CUDA_CHECK(cudaMalloc( (void**) &dr_b, sizeof(bool)));
	CUDA_CHECK(cudaMemcpy(dr_v, resultat.valeur, sizeof(char)*resultat.taille, cudaMemcpyHostToDevice));
	CUDA_CHECK(cudaMemcpy(dr_t, &resultat.taille, sizeof(int), cudaMemcpyHostToDevice));
	CUDA_CHECK(cudaMemcpy(dr_b, &resultat.est_positif, sizeof(bool), cudaMemcpyHostToDevice));


	test_add<<<grid, block>>>(d1_v,d1_t,d1_b,d2_v,d2_t,d2_b,dr_v,dr_t,dr_b);
	CUDA_CHECK(cudaMemcpy(resultat.valeur, dr_v, sizeof(char)*resultat.taille, cudaMemcpyDeviceToHost));
		//initialiser_biginteger(resultat.valeur,resultat.taille);

	//cout << sizeof(BigInteger) << endl;
	//cout << resultat.valeur << endl;
	//test_add(bigInteger1.valeur,bigInteger1.taille,bigInteger2.valeur,bigInteger2.taille,resultat.valeur);
	cout << " " << bigInteger1.valeur << endl;
	cout << " " << bigInteger2.valeur << endl;
	cout << resultat.valeur << endl;


	return 0;
}
