#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <fcntl.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/un.h>

#define GPIO_ADDR 0x18040000 // base address
#define GPIO_BLOCK 48 // memory block size

volatile unsigned long *gpioAddress;

int bsb_setup();
unsigned long bsb_direction(int gpio, int direction);
void bsb_set(int gpio, int value);
int bsb_read(int gpio);
