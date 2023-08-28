ass3_roll.txt : a.out ass3_roll_test.c
	./a.out < ass3_roll_test.c > ass3_roll.txt

a.out : lex.yy.c
	gcc -Wall lex.yy.c 

lex.yy.c : ass3_roll.l ass3_roll.c
	flex ass3_roll.l ass3_roll.c

clean : 
	rm ass3_roll.txt a.out lex.yy.c
