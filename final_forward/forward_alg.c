#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 100

int main(){
	int input_N = 1;
	int FF_N = 2;
	int FF_type = 3;
	char str[N][N] = {"120 211", "212", "210", "002 110"};
	//#input = 1
	//#FF = 2
	//type of FF-> 1:D 2:T 3:JK 4:SR
	//J1=102 210 -> y2 * x' + y1 * x
	//K1=212 
	//J2=210 
	//K2=002 110
	FILE* fp = fopen("output_forwardAlg.txt", "w");
	fprintf(fp, "%d\n", input_N);
	fprintf(fp, "%d\n", FF_N);
	fprintf(fp, "%d\n", FF_type);
	for(int i = 0; i < 4; i++){
		fwrite(str[i], strlen(str[i]), 1, fp);
	}
	fclose(fp);
	printf("%d\n%d\n%d\n%s\n%s\n%s\n%s\n", input_N, FF_N, FF_type, str[0], str[1], str[2], str[3]);
}
