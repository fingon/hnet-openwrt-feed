include $(TOPDIR)/rules.mk

PKG_NAME:=luavstruct
PKG_SOURCE_VERSION:=ef7cbb1744132822286148ce29711415b58c4128
PKG_VERSION:=2013-04-10-ef7cbb1744132822286148ce29711415b58c4128
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/ToxicFrog/vstruct.git
PKG_SOURCE_PROTO:=git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luavstruct
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=luavstruct
  URL:=https://github.com/ToxicFrog/vstruct
  DEPENDS:=+lua
endef

define Package/luavstruct/description
VStruct is a library for Lua 5.1. It provides functions for manipulating binary
data, in particular for unpacking binary files or byte buffers into Lua values
and for packing Lua values back into files or buffers.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luavstruct/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/vstruct
	$(CP) $(PKG_BUILD_DIR)/vstruct/*.lua $(1)/usr/lib/lua/vstruct
	$(INSTALL_DIR) $(1)/usr/lib/lua/vstruct/ast
	$(CP) $(PKG_BUILD_DIR)/vstruct/ast/*.lua $(1)/usr/lib/lua/vstruct/ast
	$(INSTALL_DIR) $(1)/usr/lib/lua/vstruct/io
	$(CP) $(PKG_BUILD_DIR)/vstruct/io/*.lua $(1)/usr/lib/lua/vstruct/io
endef

$(eval $(call BuildPackage,luavstruct))
