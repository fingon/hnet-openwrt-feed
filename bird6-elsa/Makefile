#
# Copyright (C) 2009-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

# Lots of snipping from the original packages/net/bird/ package; we
# provide only bird6, with LUA support, but no batteries (=no init
# scripts/conf).
#
# This division is ~natural as the bird changes to support Lua are
# minimal, but as the Lua repository used is not strictly tied to
# bird, keeping them separated is sensible.

include $(TOPDIR)/rules.mk

PKG_NAME:=bird6-elsa
PKG_SOURCE_VERSION:=f260f48808f717f9802fdcaa4c57acda6ca156f7
PKG_VERSION:=2012-11-20-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_URL:=git://github.com/fingon/bird-ext-lsa.git
PKG_SOURCE_PROTO:=git
PKG_BUILD_DEPENDS:=libncurses libreadline

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/bird6-elsa
  TITLE:=The BIRD Internet Routing Daemon (IPv6)
  URL:=http://bird.network.cz/
  DEPENDS:= +liblua +libncurses +libreadline
  SECTION:=ipv6
  CATEGORY:=IPv6
endef

define Package/bird6-elsa/description
  BIRD is an internet routing daemon which manages TCP/IP routing tables
  with support of modern routing protocols, easy to use configuration
  interface and powerful route filtering language. It is lightweight and
  efficient and therefore appropriate for small embedded routers.
  This is a variant which supports external LSAs, and is assumed to be
  zeroconf after the initial configuration file has been fed in.
  Even birdc is skipped, although normal birdc6 should be usable as there are
  no changes to the interface.
endef

CONFIGURE_ARGS += --with-linux-headers="$(LINUX_DIR)"
CONFIGURE_ARGS += --enable-ipv6

define Build/Prepare
$(call Build/Prepare/Default)
	( cd $(PKG_BUILD_DIR) ; \
		[ -f ./configure ] || { \
			ln -sf configure.in configure.ac ; \
			autoconf ; \
		} \
	)
endef

define Package/bird6-elsa/install
	$(INSTALL_DIR)  $(1)/usr/sbin
	$(INSTALL_BIN)  $(PKG_BUILD_DIR)/bird $(1)/usr/sbin/bird6-elsa
	$(INSTALL_BIN)  $(PKG_BUILD_DIR)/birdc $(1)/usr/sbin/birdc6-elsa
#	$(INSTALL_BIN)  ./files/bird$(2)loop $(1)/usr/sbin/
#	$(INSTALL_DIR)  $(1)/etc
#	$(INSTALL_DATA) ./files/bird$(2).conf $(1)/etc/
#	$(INSTALL_DIR)  $(1)/etc/init.d
#	$(INSTALL_BIN)  ./files/bird$(2).init $(1)/etc/init.d/bird$(2)
	$(INSTALL_DIR)  $(1)/usr/share/bird
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/elsa.lua $(1)/usr/share/bird/
endef

$(eval $(call BuildPackage,bird6-elsa))
