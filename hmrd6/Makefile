#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=hmrd6
PKG_SOURCE_VERSION:=46093914a5f95f50c9aef088b7172d6774d204cb
PKG_VERSION:=2014-03-10-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/Oryon/mrd6.git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/hmrd6
  SECTION:=net
  CATEGORY:=Network
  TITLE:=IPv6 multicast routing daemon - Homenet fork
  URL:=http://fivebits.net/proj/mrd6
  DEPENDS:=+kmod-ipv6 +libstdcpp
endef

define Package/hmrd6/description
 Multicast is becoming a major component in next generation networks, used 
 in several scenarios, from video broadcasting to multimedia conferencing. 
 In order to be implemented, new technology needs supporting hardware and 
 software across a set of devices and systems. MRD6 is an implementation of 
 a modular IPv6 Multicast Routing Framework for the Linux operating system 
 and provides MLDv2 (as well as MLDv1), PIM-SM and MBGP support.
endef

MRD6_MAKEFLAGS:= \
	$(TARGET_CONFIGURE_OPTS) \
	OPTIMIZE=yes \
	SPACE_OPTIMIZE=yes \
	FULL_STATIC=no \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -DNO_INET6_OPTION -fno-builtin -fno-rtti" \
	LDFLAGS="$(TARGET_LDFLAGS) -ldl -lm" \
	MODULE_CXX="\$$$$(CC) -shared \$$$$(CXXFLAGS) \$$$$(LDFLAGS)" \
	DESTDIR="$(PKG_INSTALL_DIR)" \
	PREFIX="/usr"

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)/src $(MRD6_MAKEFLAGS) all
endef

define Build/Install
	$(MAKE) -C $(PKG_BUILD_DIR)/src $(MRD6_MAKEFLAGS) install
endef

define Package/hmrd6/conffiles
/etc/mrd6.conf
endef

define Package/hmrd6/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_CONF) ./files/mrd6.conf $(1)/etc
	$(INSTALL_BIN) ./files/mrd6.init $(1)/etc/init.d/mrd6
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/firewall.sh $(1)/etc/uci-defaults/30_mrd6-firewall
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/mrd $(1)/usr/sbin/mrd6
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mrd6sh $(1)/usr/bin/mrd6sh
	$(INSTALL_DIR) $(1)/usr/lib/mrd6
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/mrd6/bgp.so $(1)/usr/lib/mrd6/bgp.so
endef

$(eval $(call BuildPackage,hmrd6))
