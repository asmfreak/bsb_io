import os
import mmap
import struct
GPIO_ADDR = 0x18040000
GPIO_BLOCK = 48


class GPIO:
    _intd = False
    _mem = -1
    _longsz = 4

    @staticmethod
    def initMem():
        if not GPIO._intd:         
            mem = os.open('/dev/mem', os.O_RDWR)
            GPIO._mem = mmap.mmap(              
                mem, GPIO_BLOCK,                
                prot=mmap.PROT_READ | mmap.PROT_WRITE,
                flags=mmap.MAP_SHARED, offset=GPIO_ADDR)
            GPIO._intd = True

    @staticmethod
    def getMemRegBytes(addr):
        start = GPIO._longsz * addr
        stop = GPIO._longsz * (addr + 1)
        return GPIO._mem[start:stop]

    @staticmethod
    def getMemReg(addr):
        return struct.unpack('L',GPIO.getMemRegBytes(addr))

    def __init__(self, num):
        GPIO.initMem()
        self.num = num

    def direction(self, dir):
        v = struct.unpack(
            "l",
            GPIO._mem[GPIO._longsz*2:GPIO._longsz*3])

GPIO.initMem()