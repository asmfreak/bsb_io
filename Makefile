include $(TOPDIR)/rules.mk

# Задаём имя пакета, версию, номер сборки. Имена переменных PKG_* - стандартные.
PKG_NAME:=bsb_io
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

# Задаём каталог, в котором будет производиться сборка пакета. Здесь особой фантазии не надо
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
# Теперь пошли описания пакета
# Наш в меню пакетов OpenWRT попадёт в категорию утилит, в основную секцию, по умолчанию собираться не будет,
# называться в меню будет "Christmas tree lights controller", URL у него понятно какой
# Переменная DEPENDS тут приведена для примера - в ней надо перечислить пакеты, от которых ваш зависит
# Так как я пишу на простом C, на самом деле мне сейчас библиотека libstdc++ нужна не будет
define Package/bsb_io
    SUBMENU:=Python
    SECTION:=lang
    CATEGORY:=Utilities
    DEFAULT:=n
    TITLE:=BlackSwift GPIO python module
    URL:=http://black-swift.com
    DEPENDS:=+python +libstdcpp
endef

# Описание пакета. Тут можно внутри блока написать про него что-нибудь длинное, на пару строк
define Package/bsb_io/description
    BlackSwift GPIO python module
endef

# Действия перед сборкой пакета
# 1. Создаём каталог для сборки
# 2. Копируем в него исходники из нашего подкаталога src
define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

# Действия по сборке, ничего особенного нам не надо
define Build/Configure
	$(call Build/Configure/Default,--with-linux-headers=$(LINUX_DIR))
endef

define Build/Compile
        $(call Build/Compile/Default,)
	$(call Build/Compile/PyMod,, build_ext )
	$(call Build/Compile/PyMod,, install --prefix="$(PKG_INSTALL_DIR)/usr")
endef


# Действия по установке
# 1. Указываем каталог для установки (если его в системе нет, он будет создан)
# 2. Фактически ручками копируем в него исполняемые файлы
# Если файлов для установки много (несколько исполняемых, конфиг какой-нибудь) - их все
# надо перечислить отдельными строками
define Package/bsb_io/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bsb_io $(1)/usr/bin/
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,bsb_io))
