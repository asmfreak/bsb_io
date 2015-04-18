bsb_io: bsb_fastio.o ex.o
	$(CC) $(LDFLAGS) ex.o bsb_fastio.o -lm -o bsb_io
bsb_fastio.o: bsb_fastio.c
	$(CC) $(CFLAGS) -std=gnu99 -c bsb_fastio.c
ex.o: ex.c
	$(CC) $(CFLAGS) -std=gnu99 -c ex.c
clean:
	rm *.o bsb_io
