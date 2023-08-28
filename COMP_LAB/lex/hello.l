%{
#include <stdio.h>
#define IF 1
#define ELSE 2
%}
%%

if {printf("IF ");}
else {printf("ELSE ");}
[0-9] {printf("INT ");}
[a-zA-Z] {printf("CHAR ");}
[a-zA-Z]+ {printf("ID ");}
[ ] {printf(" ");}
. {printf("Other ");}
[\n] {printf("\n");}
%%

int main(){
	yylex();
	return 0;
}
