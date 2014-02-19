#
# Copyright (C) 2012-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=ohybridproxy
PKG_SOURCE_VERSION:=49d11552ee1f8c6cf8851f12d2458b3b5e565182
PKG_VERSION:=2014-02-19-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/sbyx/ohybridproxy.git
PKG_MAINTAINER:=Markus Stenberg <fingon@iki.fi>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

# Spammy debug builds for now
CMAKE_OPTIONS += -DL_LEVEL=7

define Package/ohybridproxy
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=ohybridproxy
  URL:=https://github.com/sbyx/ohybridproxy
  DEPENDS+=+libubox +mdnsd
  DEPENDS+=+@IPV6
endef

define Package/ohybridproxy/description
 This package provides a statically configured daemon for translating DNS
 requests to Multicast DNS and back again.
endef

define Package/ohybridproxy/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ohybridproxy $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,ohybridproxy))
