include $(TOPDIR)/rules.mk

PKG_NAME:=luamd5
PKG_SOURCE_VERSION:=def7fa6343e359f2b3a2dbddf3a3463a6b9643d3
PKG_VERSION:=2012-11-04-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/keplerproject/md5.git
PKG_SOURCE_PROTO:=git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/luamd5
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Luamd5
  URL:=http://www.keplerproject.org/md5/
  DEPENDS:=+lua
endef

define Package/luamd5/description
MD5 offers basic cryptographic facilities for Lua 5.1: a hash (digest) function,
a pair crypt/decrypt based on MD5 and CFB, and a pair crypt/decrypt based on DES
with 56-bit keys.
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		LIBDIR="$(TARGET_LDFLAGS)" \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -std=gnu99" \
		LD="$(TARGET_CROSS)ld -shared" \
		all
endef


define Package/luamd5/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/md5
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/core.so $(1)/usr/lib/lua/md5
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/md5.lua $(1)/usr/lib/lua
endef

# XXX - figure where the src/core.so, and the assorted .lua files
# should be placed!

$(eval $(call BuildPackage,luamd5))
