#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define REPETE 100
#define SIZE 1*1024

int main(int argc, char *argv[])
{
	FILE *fd;
	int offset=0;
	int i, ret;
	struct timespec inicio,fim;
	int buffer;

	//verifica o número de parâmetros
	if(argc < 2)
	{
		printf("Erro: deve receber o nome do arquivo para ser lido, que deve ter sido previamente criado e preenchido com dados\n");
		return(-1);
	}
	//abre o arquivo
	fd = fopen(argv[1], "r");
	if(!fd)
	{
		printf("Erro: nao conseguiu abrir o arquivo!\n");
		return(-1);
	}
	
	//lê do arquivo várias vezes, cada vez é uma coleta
	for(i=0; i< REPETE; i++)
	{
		//timestamp de inicio
		clock_gettime(CLOCK_MONOTONIC, &inicio);

		//faz a leitura
		ret = fread(&buffer, SIZE, 1, fd);
		if(ret != 1)
		{
			printf("Erro: nao conseguiu ler do arquivo!\n");
			break;
		}

		//timestamp de fim
		clock_gettime(CLOCK_MONOTONIC, &fim);

		//imprime resultado
		printf("%d;%lu\n",i+1,((fim.tv_nsec - inicio.tv_nsec) + ((fim.tv_sec - inicio.tv_sec)*1000000000L)));
	}

	//fecha o arquivo e termina
	fclose(fd);
	return 0;
}
