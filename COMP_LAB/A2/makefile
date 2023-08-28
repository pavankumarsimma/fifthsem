output:	a.out
	./a.out

a.out: main.o libassn2.a
	gcc -Wall main.o -L. -lassn2

main.o: main.c myl.h
	gcc -Wall -c main.c

ass2_roll.o: ass2_roll.c myl.h
	gcc -Wall -c ass2_roll.c

libassn2.a: ass2_roll.o
	ar -rcs libassn2.a ass2_roll.o

clean:
	rm a.out main.o ass2_roll.o libassn2.a
