include $(TOPDIR)/rules.mk

PKG_NAME:=lualfs
PKG_SOURCE_VERSION:=9c2679f9d78f773471f2a9e58d02d8d6b29a2aa1
PKG_VERSION:=2013-04-10-9c2679f9d78f773471f2a9e58d02d8d6b29a2aa1
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/keplerproject/luafilesystem.git
PKG_SOURCE_PROTO:=git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/lualfs
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LuaLFS
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
	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		LIBDIR="$(TARGET_LDFLAGS)" \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -std=gnu99" \
		LD="$(TARGET_CROSS)ld -shared" \
		lib
endef


define Package/lualfs/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/lfs.so $(1)/usr/lib/lua
endef

$(eval $(call BuildPackage,lualfs))
