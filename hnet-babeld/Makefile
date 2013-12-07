#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

# Note: This is effectively a fork of babeld package, with
# s/babeld/hnet-babeld/, to cover M. Boutier's source routing babel
# branch (babels). At some point, it will be merged with babeld main
# and this package will become redundant.

PKG_NAME:=hnet-babeld
PKG_SOURCE_VERSION:=21c79fe570dedb6bd74c510e5d2d4b6c37a797ae
PKG_VERSION:=2013-12-07-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://git.wifi.pps.univ-paris-diderot.fr/babels
PKG_MAINTAINER:=Markus Stenberg <fingon@iki.fi>
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/hnet-babeld
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=A loop-free distance-vector routing protocol
  URL:=http://www.pps.univ-paris-diderot.fr/~jch/software/babel/
  MAINTAINER:=Markus Stenberg <fingon@iki.fi>
  DEPENDS:=+kmod-ipv6 +librt
endef

define Package/hnet-babeld/description
 Babel is a loop-avoiding distance-vector routing protocol roughly based
 on DSDV and AODV, but with provisions for link cost estimation and
 redistribution of routes from other routing protocols.
 While it is optimised for wireless mesh networks, Babel will also work
 efficiently on wired networks. It will generate between 1.2 and 2.4 times
 the amount of routing traffic that RIPng would generate, while
 never counting to infinity.
 This is experimental source routing branch, and should be only used if you
 know what you are doing.
endef

define Package/hnet-babeld/conffiles
/etc/babeld.conf
/etc/config/babeld
endef

MAKE_FLAGS+= \
	CFLAGS="$(TARGET_CFLAGS)" \

define Package/hnet-babeld/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/babeld $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/babeld.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/babeld.config $(1)/etc/config/babeld
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/babeld.init $(1)/etc/init.d/babeld
endef

$(eval $(call BuildPackage,hnet-babeld))
