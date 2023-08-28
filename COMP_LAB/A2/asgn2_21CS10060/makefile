output:	a.out
	./a.out

a.out: main.o libassn2.a
	gcc -Wall main.o -L. -lassn2

main.o: main.c myl.h
	gcc -Wall -c main.c

ass2_21CS10060.o: ass2_21CS10060.c myl.h
	gcc -Wall -c ass2_21CS10060.c

libassn2.a: ass2_21CS10060.o
	ar -rcs libassn2.a ass2_21CS10060.o

clean:
	rm a.out main.o ass2_21CS10060.o libassn2.a
