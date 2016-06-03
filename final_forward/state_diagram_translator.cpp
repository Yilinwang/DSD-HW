#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstdio>
#include <cmath>

#define MAXN 100000;
#define MAXS 20;

using namespace std;

int main(int argc, char** argv) {
 
    /* instruction for making the input file. */
    cout << "=================================" << endl;
    cout << "-------input filename-------" << endl;
    cout << "input.txt" << endl;
    cout << "-------expression-------" << endl;
    cout << "state = 010, input = 11 ==> [state+input] = decimal(01011) = 11,";
    cout << " [next_state] and [output] are the same as [state+input]." << endl;
    cout << "-------input file format-------" << endl;
    cout << "[#input] [#state]" << endl;
    cout << "[state+input] [next_state] [output]" << endl;
    cout << "..." << endl;
    cout << "[state+input] [next_state] [output]" << endl;
    cout << "=================================" << endl;
   

    /* read the input file. */
    int n;
    
    int num_input;
    int num_state;

    bool tbl_output[MAXN];
    bool tbl_state[MAXN][MAXS];

    FILE* fp = fopen("input.txt", "r");
    
    fscanf(fp, "%d %d\n", &num_input, &num_state);
    n = (int)pow(2, num_input + num_state);
    
    for(int i = 0; i < n; i++) {
        
        int this_state_input, next_state, output;
        fscanf(fp, "%d %d\n", &this_state_input, &next_state, &output);

        tbl_output[this_state_input] = output;

        for(int j = 0; j < num_state; j++) {
            tbl_state[this_state_input][j] = (next_state & 1 == 1);
            next_state >>= 1;
        }
    }
    
    /* TODO: 
     * 1. make FF excitation tables. 
     * 2. implement Quine-McCluskey algorithm. */
}
