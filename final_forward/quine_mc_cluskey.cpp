//-------------------------------------------------------------------------------------------------------------
// Quine�McCluskey Algorithm
// =========================
//-------------------------------------------------------------------------------------------------------------
// English:
//-------------------------------------------------------------------------------------------------------------
// Description: Application to simplify boolean functions with Quine-McCluskey algorithm
// Date: 05/16/2012
// Author: Stefan Moebius (mail@stefanmoebius.de)
// Licence: Can be used freely (Public Domain)
//-------------------------------------------------------------------------------------------------------------
// German:
//-------------------------------------------------------------------------------------------------------------
// Beschreibung: Programm zur Vereinfachung von Booleschen Funktionen mit hilfe des Quine�McCluskey Verfahrens.
// Datum: 16.05.2012
// Author: Stefan Moebius (mail@stefanmoebius.de)
// Lizenz: darf frei verwendet werden (Public Domain)
//-------------------------------------------------------------------------------------------------------------
//modified by Hsu-En Lin

#include <stdio.h>
#include <stdlib.h>
#include "quine_mc_cluskey.hpp"

/*
#define TRUE 1
#define FALSE 0
#define MAXVARS 10
#define MAX 2048
*/

//Global fields: / Globale Felder:
//int minterm[MAX][MAX];
int mask[MAX][MAX];		// mask of minterm  /  Maske des Minterm
int used[MAX][MAX];		// minterm used  /  Minterm wurde verwendet
int result[MAX];		// results  /  Ergebnisse
//int prim_mask[MAX];		// mask for prime implicants  /  Maske f�r Primimplikant
//int prim[MAX];			// prime implicant  /  Primimplikant
int wprim[MAX];			// essential prime implicant (TRUE/FALSE)  /  wesentlicher Primimplikant (TRUE/FALSE)
int nwprim[MAX];		// needed not essential prime implicant  /  ben�tigter unwesentlicher Primimplikant

//Count all set bits of the integer number  /  Z�hlen der gesetzen Bits in einer Integerzahl
int popCount(unsigned x) { // Taken from book "Hackers Delight"  / Aus dem Buch "Hackers Delight" 
	x = x - ((x >> 1) & 0x55555555);
	x = (x & 0x33333333) + ((x >> 2) & 0x33333333);
	x = (x + (x >> 4)) & 0x0F0F0F0F;
	x = x + (x >> 8);
	x = x + (x >> 16);
	return x & 0x0000003F;
}

//Calculate hamming weight/distance of two integer numbers  /  Berechnung der Hammingdistanz von 2 Integerzahlen
int hammingWeight(int v1, int v2) {
	return popCount(v1 ^ v2);
} 

//Output upper part of term in console  /  Oberer Teil des Terms in der Konsole ausgeben
/*
void upperTerm(int bitfield, int mask, int num) {
	if (mask) {
		int z;
		for ( z = 0; z < num; z++) {
			if (mask & (1 << z)) {      
				if (bitfield & (1 << z))		
					printf("_");
				else
					printf(" ");
			}
		} 
	}
}

//Output lower part of term in console  /  Unterer Teil des Terms in der Konsole ausgeben
void lowerTerm(int mask, int num) {
	if (mask) {
		int z;
		for (z = 0; z < num; z++) {
			if (mask & (1 << z)) {
				printf("%c", 'z' - (num - 1) + z);
			} 
		} 
	}
}

//Output a term to console  /  Ausgabe eines Terms in der Konsole
void outputTerm(int bitfield, int mask, int num) {
	upperTerm(bitfield, mask, num);
	if (mask) printf("\n");
	lowerTerm(mask, num);
}
*/

//Determines whether "value" contains "part"  /  Bestimmt, ob "value" "part" beinhaltet
int contains(int value, int mask, int part, int partmask) {
	if ((value & partmask) == (part & partmask)) {
		if ((mask & partmask) ==  partmask)
			return TRUE;
	}   
	return FALSE;
}

void Quine_McCluskey(int num_variables, int num_minterms, 
        int minterm[MAX][MAX], int* dont_care, int* prim, int* prim_mask, int* prim_required, int& prim_count) {
	int num = 0; // Number of Variables  /  Anzahl Eing�nge
	int pos = 0;
	int cur = 0;
	int reduction = 0; //reduction step  / Reduktionsschritt
	int maderedction = FALSE;
	//int prim_count = 0;
	int term = 0;
	int termmask = 0;
	int found = 0;
	int x = 0;
	int y = 0;
	int z = 0;
	int count = 0;
	int lastprim = 0; 
	int res = 0; // actual result  /  Ist-Ausgabe

	// Fill all arrays with default values / Alle Arrays mit Standardwert auff�llen
	for (x = 0; x < MAX; x++) {
		prim_mask[x] = 0;
		prim[x] = 0;
		wprim[x] = FALSE;
		nwprim[x] = FALSE;
		result[x] = FALSE;
		nwprim[x] = TRUE; //unwesentliche Primimplikaten als ben�tigt markieren
		for (y = 0; y < MAX; y++) {
			mask[x][y] = 0;
			used[x][y] = FALSE;
		}
	}

    num = num_variables;

	if (num > MAXVARS) {
		fprintf(stderr, "ERROR: Number of variables too big!\n");
        exit(-1);
	}
	if (num < 1) {
		fprintf(stderr, "ERROR: Number of variables must be at least 1!\n");
	    exit(-1);
    }

	pos = (1 << num);  // 2 ^ num
	//printf("Please enter desired results: ( 0 or 1)\n\n");


	//cur = 0; 
	for ( x=0; x < num_minterms; x++) {
		//int value = 0;
		//outputTerm(x, pos - 1, num);
		//printf(" = ");
		//scanf(" %d", &value);
		//if (value) {
			mask[x][0] = ((1 << num)- 1);
            //if(dont_care[minterm[x][0]] == FALSE)
			    result[minterm[x][0]] = TRUE;
		//}
		//printf("\n");
	}


	for (reduction = 0; reduction < MAX; reduction++) {
		cur = 0; 
		maderedction = FALSE;
		for (y=0; y < MAX; y++) {
			for (x=0; x < MAX; x++) {   
				if ((mask[x][reduction]) && (mask[y][reduction])) {      
					if (popCount(mask[x][reduction]) > 1) { // Do not allow complete removal (problem if all terms are 1)  /  Komplette aufhebung nicht zulassen (sonst problem, wenn alle Terme = 1)
						if ((hammingWeight(minterm[x][reduction] & mask[x][reduction], minterm[y][reduction] & mask[y][reduction]) == 1) && (mask[x][reduction] == mask[y][reduction])) { // Simplification only possible if 1 bit differs  /  Vereinfachung nur m�glich, wenn 1 anderst ist 
							term = minterm[x][reduction]; // could be mintern x or y /  egal ob mintern x oder minterm y 
							//e.g.:
							//1110
							//1111
							//Should result in mask of 1110  /  Soll Maske von 1110 ergeben
							termmask = mask[x][reduction]  ^ (minterm[x][reduction] ^ minterm[y][reduction]); 
							term  &= termmask;

							found = FALSE;		
							for ( z=0; z<cur; z++) {
								if ((minterm[z][reduction+1] == term) && (mask[z][reduction+1] == termmask) ) {							
									found = TRUE;
								}
							}

							if (found == FALSE) {
								minterm[cur][reduction+1] = term;
								mask[cur][reduction+1] = termmask;
								cur++; 
							}
							used[x][reduction] = TRUE;
							used[y][reduction] = TRUE;  
							maderedction = TRUE;
						}
					}
				} 
			}    
		}
		if (maderedction == FALSE)
			break; //exit loop early (speed optimisation)  /  Vorzeitig abbrechen (Geschwindigkeitsoptimierung)
	}

	prim_count = 0;
	//printf("\nprime implicants:\n");
	for ( reduction = 0 ; reduction < MAX; reduction++) {
		for ( x=0 ;x < MAX; x++) {		
			//Determine all not used minterms  /  Alle nicht verwendeten Minterme bestimmen
			if ((used[x][reduction] == FALSE) && (mask[x][reduction]) ) {
				//Check if the same prime implicant is already in the list  /  �berpr�fen, ob gleicher Primimplikant bereits in der Liste
				found = FALSE;
				for ( z=0; z < prim_count; z++) {
					if (((prim[z] & prim_mask[z]) == (minterm[x][reduction] & mask[x][reduction])) &&  (prim_mask[z] == mask[x][reduction]) )					
						found = TRUE;
				} 
				if (found == FALSE) {
					//outputTerm(minterm[x][reduction], mask[x][reduction], num);
					//printf("\n");
					prim_mask[prim_count] = mask[x][reduction];
					prim[prim_count] = minterm[x][reduction];
					prim_count++;
				}     
			} 
		} 
	} 

	//find essential and not essential prime implicants  /  wesentliche und unwesentliche Primimplikanten finden
	//all alle prime implicants are set to "not essential" so far  /  Primimplikanten sind bisher auf "nicht wesentlich" gesetzt
    for (y=0; y < num_minterms; y++) { //for all minterms  /  alle Minterme durchgehen 	
        if(dont_care[minterm[y][0] & mask[y][0]])
            continue;
        count = 0;
		lastprim = 0;   
		if (mask[y][0]) {
			for (x=0; x < prim_count; x++ ) { //for all prime implicants  /  alle Primimplikanten durchgehen  
				if (prim_mask[x]) {
					// Check if the minterm contains prime implicant  /  the �berpr�fen, ob der Minterm den Primimplikanten beinhaltet
					if (contains(minterm[y][0], mask[y][0], prim[x], prim_mask[x])) {					
						count++;
						lastprim = x;          
					}  
				} 		
			}
			// If count = 1 then it is a essential prime implicant /  Wenn Anzahl = 1, dann wesentlicher Primimplikant
			if (count == 1) {
                wprim[lastprim] = TRUE;
			}
		}
	}

	// successively testing if it is possible to remove prime implicants from the rest matrix  /  Nacheinander testen, ob es m�gich ist, Primimplikaten der Restmatrix zu entfernen
	for ( z=0; z < prim_count; z++) {
		if (prim_mask[z] ) {
			if (wprim[z] == FALSE) { // && (rwprim[z] == TRUE))
				nwprim[z] = FALSE; // mark as "not essential" /  als "nicht ben�tigt" markiert
				for ( y=0; y < num_minterms; y++) { // for all possibilities  /  alle M�glichkeiten durchgehen 
		            if(dont_care[minterm[y][0] & mask[y][0]])
                        continue;
					res = 0;
					for ( x=0; x < prim_count; x++) {
                        if(!prim_mask[x])
                            continue;
                        if ( (wprim[x] == TRUE) || (nwprim[x] == TRUE)) {  //essential prime implicant or marked as required  /  wesentlicher Primimplikant oder als ben�tigt markiert
							if ((minterm[y][0] & prim_mask[x]) == (prim[x] & prim_mask[x])) { //All bits must be 1  /  Es m�ssen alle Bits auf einmal auf 1 sein (da And-Verkn�pfung)
                                res = 1; 
								break;
							}
						}
					}
					//printf(" %d\t%d\n", result, result[y]);
					if (res == result[minterm[y][0]]) {  // compare calculated result with input value /  Berechnetes ergebnis mit sollwert vergleichen				
						//printf("not needed\n"); //prime implicant not required  /  Primimplikant wird nicht ben�tigt
					}
					else {
						//printf("needed\n");
						nwprim[z] = TRUE; //prime implicant required  /  Primimplikant wird doch ben�tigt
					}
				}
			}
		}
	}

    //choose required PIs.
    for(x = 0; x < prim_count; x++) {
        prim_required[x] = FALSE;
        if(wprim[x] == TRUE || (nwprim[x] == TRUE)) {
            prim_required[x] = TRUE;
        }
    }

    
	// printf("\nResult:\n\n");
	// Output of essential and required prime implicants / Ausgabe der wesentlichen und restlichen ben�tigten Primimplikanten:
    
    /*
	count = 0;
	for ( x = 0 ; x < prim_count; x++) {
		if (wprim[x] == TRUE) {
			if (count > 0) printf("   ");
			upperTerm(prim[x], prim_mask[x], num);
			count++;
		}
		else if ((wprim[x] == FALSE) && (nwprim[x] == TRUE)) {
			if (count > 0) printf("   ");
			upperTerm(prim[x], prim_mask[x], num);
			count++;
		}
	}
	printf("\n");
	count = 0;
	for ( x = 0 ; x < prim_count; x++) {
		if (wprim[x] == TRUE) {
			if (count > 0) printf(" + ");
			lowerTerm(prim_mask[x], num);
			count++;
		}
		else if ((wprim[x] == FALSE) && (nwprim[x] == TRUE)) {
			if (count > 0) printf(" + ");
			lowerTerm(prim_mask[x], num);
			count++;
		}
	}
    
	//printf("\n");
    */
//	return 0;
}

