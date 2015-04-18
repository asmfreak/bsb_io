# bsb_io
Simole python module to interact with BlackSwift GPIO. Based on articles by BlackSwift developers: [on wiki](http://www.black-swift.ru/wiki/index.php?title=%D0%A0%D0%B0%D0%B1%D0%BE%D1%82%D0%B0_%D1%81_GPIO) and [on habrahabr](habrahabr.ru/company/blackswift/blog/247925/).
This module uses "direct gpio access" method. 

##Installing
1. Download .ipk from releases tab or build it for yourself (see section below)
2. Copy it to your BlackSwift
3. Run `opkg install bsb_io`

##Building.
1. Download and install OpenWrt SDK from the second article
2. Clone this repo to `packages` directory of OpenWrt SDK.
3. In `make menuconfig` section `Languages->` in subsetion `Python->` select `bsb_io`
4. Run `make` if you want to build whole distribution or `make package/bsb_io/install` to build only bsb_io
5. Locate .ipk in `bin/ar71xx/packages/base/`

**N.B.** This module is built can with Cython 0.11 (Used by current OpenWrt BarrierBreaker Buildroot). If version of Cython in your Buildroot is higher, you would probably need to change `setup.py`.

##TODO
* Implement simple, yet configurable soft PWM.
* Implement _slow_ gpio method via SysFs
