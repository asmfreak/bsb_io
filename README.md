# bsb_io
Simple python module to interact with BlackSwift GPIO. Based on articles by BlackSwift developers: [on wiki](http://www.black-swift.ru/wiki/index.php?title=%D0%A0%D0%B0%D0%B1%D0%BE%D1%82%D0%B0_%D1%81_GPIO) and [on habrahabr](http://habrahabr.ru/company/blackswift/blog/247925/).
This module uses _fast_ "direct gpio register access" method. It means that this library is working with AR9331's registers directly. Use it with care.

##Installing
1. Download .ipk from releases tab or build it yourself (see section below)
2. Copy it to your BlackSwift
3. Run `opkg install bsb_io`

##Building.
1. Download and install OpenWrt SDK from the second article
2. Clone this repo to `packages` directory of OpenWrt SDK.
3. In `make menuconfig` section `Languages->` in subsection `Python->` select `bsb_io`
4. Run `make` if you want to build whole distribution or `make package/bsb_io/install` to build only bsb_io with dependencies.
5. Locate .ipk in `bin/ar71xx/packages/base/`

**N.B.** This module can be built with Cython 0.11 (Used by current OpenWrt BarrierBreaker Buildroot). If version of Cython in your Buildroot is higher, you would probably need to change `setup.py`.

##Usage
There is only one class `Pin`. It's constructor accepts GPIO number.
You can change GPIO direction (input or output) by writing `direction` property.
You can read and write GPIO using `value`  property.
You can modify pin state i.e. both value and direction using `state` propery.

This code toggles GPIO1 every 2 seconds:
```
import time
from bsb_io import *

p1 = Pin(1)
p1.direction = OUTPUT
v = 1
while True:
    if v==1:
        v = OFF
        print "[OFF]\r"
    else:
        v = ON
        print "[ON ]\r"
    p1.value = v
    time.sleep(2)
```

##TODO
* Implement simple, yet configurable soft PWM.
* Implement _slow_ gpio method via SysFs
