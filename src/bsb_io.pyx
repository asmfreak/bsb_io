cdef extern from "bsb_fastio.h":
    int bsb_setup()
    unsigned long bsb_direction(int gpio, int direction)
    void bsb_set(int gpio, int value)
    int bsb_read(int gpio)

INPUT = 0
OUTPUT = 1
HIGH = 1
LOW = 0
ON = 1
OFF = 0

cdef class Pin:
    cdef int gpio
    def __cinit__(self, int gpio):
        cdef int res = bsb_setup()
        if res!=0:
            raise RuntimeError("Something went wrong with GPIO setup:", res)
        self.gpio = gpio

    property direction:
        def __set__(self, int direction):
            if direction in [0,1]:
                bsb_direction(self.gpio, direction)
            else:
                raise RuntimeError(
                    "Direction can only be 1 or 0, specified:"+str(direction))

    property value:
            def __get__(self): return bsb_read(self.gpio)
            def __set__(self, val):
                if val in [0,1]:
                    bsb_set(self.gpio, val)
                else:
                    raise RuntimeError("Can't assign value "+str(val))
