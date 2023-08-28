#include "./myl.h"

// main function
int main(){
    int w, x;
    printStr("\n___________________________________________________\n");
    printStr("All strings(prompts) are printed using printStr(char*) from created library");
	printStr("\n___________________________________________________\n");
    printStr("(input using readInt(int*) and output using printInt(int) from created library)\nEnter the integer value : ");
    int m=0;
    w=readInt(&m);
    printStr("Return value of readInt (0-> ERR, 1->OK) : ");
    printInt(w);
    printStr("===> ENTERED INTEGER : ");
    x=printInt(m);
    printStr("Return value of printInt ");
    printInt(x);
    printStr("___________________________________________________\n");
    printStr("(input using readFlt(float*) and output using printFlt(float) from created library)\nEnter the float value : ");
    float f=0;
    w=readFlt(&f);
    printStr("Return value of readFlt (0-> ERR, 1->OK) : ");
    printInt(w);
    printStr("===> ENTERED FLOAT : ");
    x=printFlt(f);
    printStr("Return value of printFlt ");
    printInt(x);
	return 0;
}