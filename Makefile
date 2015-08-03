include $(TOPDIR)/rules.mk

PKG_NAME:=bsb_io
PKG_VERSION:=0.0.3
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/bsb_io
    SUBMENU:=Python
    SECTION:=lang
    CATEGORY:=Languages
    DEFAULT:=n
    TITLE:=BlackSwift GPIO python module
    URL:=http://black-swift.com
    DEPENDS:=+python +libstdcpp
    PKG_BUILD_DEPENDS:=+cython
endef

define Package/bsb_io/description
    BlackSwift GPIO python module
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
	$(call Build/Configure/Default,--with-linux-headers=$(LINUX_DIR))
endef

define Build/Compile
        $(call Build/Compile/Default,)
	$(call Build/Compile/PyMod,, build_ext )
	$(call Build/Compile/PyMod,, install --prefix="$(PKG_INSTALL_DIR)/usr")
endef


define Package/bsb_io/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bsb_io $(1)/usr/bin/
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,bsb_io))

