#ifndef BSB_IOH
#define BSB_IOH
int bsb_setup();
unsigned long bsb_direction(int gpio, int direction);
void bsb_set(int gpio, int value);
int bsb_read(int gpio);
#endif
