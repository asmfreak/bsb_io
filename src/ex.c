#include "bsb_fastio.h"
#include <stdio.h>

int main(){
    unsigned long res=0;
    bsb_setup();
    res = bsb_direction(27,1);
    printf("%X\n",res);
    return 0;
}
