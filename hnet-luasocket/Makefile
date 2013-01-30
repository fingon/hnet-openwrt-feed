#
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# This is a derived version of the core packages luasocket file;
# instead if using distributed version from luaforge, we use a version
# with working IPv6 multicast join/leave from github.

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet-luasocket

PKG_SOURCE_VERSION:=8b56df87c5ab50c537acc86e2275c15374dd2868
PKG_VERSION:=2013-01-28-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

# Sub-shared library versions
SOCKET_VERSION:=2.1
MIME_VERSION:=1.0.3

PKG_SOURCE_URL:=https://github.com/fingon/luasocket.git
PKG_SOURCE_PROTO:=git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LuaSocket
  URL:=http://luasocket.luaforge.net/
  DEPENDS:=+lua
endef

define Package/$(PKG_NAME)/description
  LuaSocket is the most comprehensive networking support
  library for the Lua language. It provides easy access to
  TCP, UDP, DNS, SMTP, FTP, HTTP, MIME and much more.
  This is hnet-only variant, with better working IPv6 bits..
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


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/{ltn12,mime,socket}.lua $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/mime.so.$(MIME_VERSION) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/socket.so.$(SOCKET_VERSION) $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/mime
	ln -sf ../mime.so.$(MIME_VERSION) $(1)/usr/lib/lua/mime/core.so
	$(INSTALL_DIR) $(1)/usr/lib/lua/socket
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/{ftp,http,smtp,tp,url}.lua $(1)/usr/lib/lua/socket
	ln -sf ../socket.so.$(SOCKET_VERSION) $(1)/usr/lib/lua/socket/core.so
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
