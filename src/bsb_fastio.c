#include "bsb_fastio.h"
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define GPIO_ADDR 0x18040000 // base address
#define GPIO_BLOCK 48 // memory block size
 
static volatile unsigned long *gpioAddress;
int bsb_setup()
{ 
    int  m_mfd;
    if ((m_mfd = open("/dev/mem", O_RDWR)) < 0)
    {
        return -1;
    }
    gpioAddress = (unsigned long*)mmap(NULL, GPIO_BLOCK, PROT_READ|PROT_WRITE, MAP_SHARED, m_mfd, GPIO_ADDR);
    close(m_mfd);

    if (gpioAddress == MAP_FAILED)
    {
        return -2;
    }

    return 0;
}

unsigned long bsb_direction(int gpio, int direction)
{
    unsigned long value = *(gpioAddress + 0); // obtain current settings
    if (direction == 1)
    {
        value |= (1 << gpio); // set bit to 1
    }
    else
    {
        value &= ~(1 << gpio); // clear bit
    }
    *(gpioAddress + 0) = value;
    return value;
}


void bsb_set(int gpio, int value)
{
    if (value == 0)
    {
        *(gpioAddress + 4) = (1 << gpio);
    }
    else
    {
        *(gpioAddress + 3) = (1 << gpio);
    }
}

int bsb_read(int gpio)
{
    unsigned long value = *(gpioAddress + 1);
    return (value & (1 < gpio));
}
