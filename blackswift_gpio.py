import os
import mmap
GPIO_ADDR = 0x18040000
GPIO_BLOCK = 48
__longsz = 4

class GPIO:
    _intd = False
    _mem = -1
    def __init__(self, num):
        if not GPIO._intd:
            mem = os.open('/dev/mem', os.O_RDWR)
            GPIO._mem = mmap.mmap(
                mem, GPIO_BLOCK, 
                prot=mmap.PROT_READ|mmap.PROT_WRITE, 
                flags=mmap.MAP_SHARED, offset=GPIO_ADDR)
        self.num = num
    
    def direction(self, dir):
        
