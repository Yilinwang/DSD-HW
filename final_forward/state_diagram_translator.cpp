#include <iostream>
#include <string>
#include <cstdlib>
#include <cstdio>
#include "quine_mc_cluskey.hpp"

#define SR 0
#define JK 1
#define D 2
#define T 3

#define d -1

using namespace std;

int excitation_SR[4][2] = {{0, 1, 0, d}, {d, 0, 1, 0}};
int excitation_JK[4][2] = {{0, 1, d, d}, {d, d, 1, 0}};
int excitation_D[4] = {0, 1, 0, 1};
int excitation_T[4] = {0, 0, 1, 1};

int getFFId(string s) {
    if(s == "SR")
        return SR;
    if(s == "JK")
        return JK;
    if(s == "D")
        return D;
    if(s == "T")
        return T;

    cout << "error: no such ff_type." << endl;
    exit(-1);
}

int excitation(int ff_type, int transition, int param) {
    if(ff_type == SR)
        return excitation_SR[transition][param];
    if(ff_type == JK)
        return excitation_JK[transition][param];
    if(ff_type == D)
        return excitation_D[transition][param];
    if(ff_type == T)
        return excitation_T[transition][param];

    cout << "error: no such ff_type." << endl;
    exit(-1);
}

void printTerms(int* prim, int* prim_mask, int* prim_required, int prim_cnt, int num_var) {
    bool space_flag = false;

    for(int i = 0; i < prim_cnt; i++) {
        if(prim_required[i]) {
            if(space_flag)
                cout << " ";
            space_flag = true;
            for(int s = num_var - 1; s >= 0; s--) {
                if(!(prim_mask[i] & (1 << s)))
                    cout << 2;
                else {
                    if(prim[i] & (1 << s))
                        cout << 1;
                    else
                        cout << 0;
                }
            }
        }
    }
}


int main(int argc, char** argv) {
    /* read inputs. */
    int N;

    int num_input;
    int num_state;

    char ff_type_c[3];

    scanf("%d %d %s\n", &num_input, &num_state, ff_type_c);

    string ff_type_s = string(ff_type_c);
    int ff_type = getFFId(ff_type_s);

    N = (1 << (num_input + num_state));
    
    /* data structure for Quine_McCluskey, implemented by Stefan Moebius. */
    int prim[MAX];
    int prim_mask[MAX];
    int prim_required[MAX] = {0};
    int prim_cnt;
    int terms_dont_care[MAX] = {0};
    
    int terms_out[MAX][MAX];
    int num_terms_out = 0;

    for(int i = 0; i < N; i++) {
        int this_state_input, next_state, output;
        scanf("%d%d%d", &this_state_input, &next_state, &output);

        if(output) {
            terms_out[num_terms_out++][0] = i;
        }

        state_transition[this_state_input] = next_state;
    }
    
    /* simplified the output expression. */
    Quine_McCluskey(num_state + num_input, num_terms_out, terms_out, terms_dont_care, prim, prim_mask, prim_required, prim_cnt);
    
    /* print output terms. */
    printTerms(prim, prim_mask, prim_required, prim_cnt, num_state + num_input);
    cout << endl;

    int num_terms_ff = 0;
    int terms_ff[MAX][MAX];

    /* deal with the state expression. */
    for(int s = 0; s < num_state; s++) {
        for(int param = 0; i < (ff_type == SR || ff_type == JK) ? 2 : 1; param++) {
            for(int i = 0; i < N; i++) {
                bool now = (i & (1 << (s + num_input)) != 0);
                bool next = (state_transition[i] & (1 << s) != 0);

                int transition = (now ? 2 : 0) + (next ? 1 : 0);

                int e = excitation(ff_type, transition, param);
                
                if(e != 0)
                    terms_ff[num_terms_ff++][0] = i;

                if(e == d)
                    terms_dont_care[i] = TRUE;
            }
            /* simplified the state expression. */
            Quine_McCluskey(num_state + num_input, num_terms_ff, terms_ff, terms_dont_care, prim, prim_mask, prim_required, prim_cnt);
            
            /* print state terms. */
            printTerms(prim, prim_mask, prim_required, prim_cnt, num_state + num_input);
            if(!(s == num_state - 1 && param == ((ff_type == SR || ff_type == JK) ? 1 : 0))
                cout << endl;
        }
    }
}
