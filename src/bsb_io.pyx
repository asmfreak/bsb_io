cdef extern from "bsb_fastio.h":
    int bsb_setup()
    unsigned long bsb_direction(int gpio, int direction)
    void bsb_set(int gpio, int value)
    int bsb_read(int gpio)


cdef class Pin:
    cdef int gpio
    def __cinit__(self, int gpio):
        int res = bsb_setup()
        if res!=0:
            raise RuntimeError("Something went wrong with GPIO setup:", res)
        self.gpio = gpio

    def setDirection(self, int direction):
        if direction in [0,1]:
            bsb_direction(self.gpio, direction)
        else:
            raise RuntimeError(
                "Direction can only be 1 or 0, specified:"+str(direction))

    property value:
            def __get__(self): return bsb_read(self.gpio)
            def __set__(self, val): bsb_set(self.gpio, val)
