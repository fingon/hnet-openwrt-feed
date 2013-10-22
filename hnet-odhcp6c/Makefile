#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet-odhcp6c
PKG_SOURCE_VERSION:=e23448ff8edc66f1da4fcb2b4066a02d6a54306f
PKG_VERSION:=2013-08-01-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_URL:=git://github.com/sbyx/odhcp6c.git
PKG_SOURCE_PROTO:=git
PKG_MAINTAINER:=Steven Barth <steven@midlink.org>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

CMAKE_OPTIONS = -DEXT_PREFIX_CLASS=200

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/hnet-odhcp6c
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=Embedded DHCPv6-client for OpenWrt (hnet variant)
  DEPENDS:=+kmod-ipv6
endef

define Package/hnet-odhcp6c/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/odhcp6c $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,hnet-odhcp6c))
