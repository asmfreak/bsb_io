bsb_io: bsb_fastio.o ex.o
	$(CC) $(LDFLAGS) ex.o bsb_fastio.o -o bsb_io
bsb_fastio.o: bsb_fastio.c
	$(CC) $(CFLAGS) -std=gnu99 -c bsb_fastio.c
ex.o: ex.c
	$(CC) $(CFLAGS) -std=gnu99 -c ex.c

.PHONY: clean
clean:
	rm -f *.o bsb_io
