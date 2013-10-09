#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lualfs
PKG_SOURCE_VERSION:=2fd989cd6c777583be1c93616018c55b2cbb1bcf
PKG_VERSION:=2013-10-09-$(PKG_SOURCE_VERSION)
PKG_RELEASE=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/keplerproject/luafilesystem.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/lualfs
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LuaFileSystem
  URL:=http://keplerproject.github.com/luafilesystem/
  DEPENDS:=+lua
endef

define Package/lualfs/description
LuaFileSystem is a Lua library developed to complement the set of functions
related to file systems offered by the standard Lua distribution. It offers a
portable way to access the underlying directory structure and file attributes.
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -fPIC" \
		lib
endef

define Package/lualfs/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/lfs.so $(1)/usr/lib/lua
endef

$(eval $(call BuildPackage,lualfs))
