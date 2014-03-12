#
# Copyright (C) 2012-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet
PKG_RELEASE:=1

PKG_MAINTAINER:=Markus Stenberg <fingon@iki.fi>

PKG_CONFIG_DEPENDS:=CONFIG_PACKAGE_hnet-setup-network
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-setup-hostname
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-hostname
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-setup-disdnsmasq
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-dhcpv4-clientid
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-dhcpv6-clientid

include $(INCLUDE_DIR)/package.mk

define Package/hnet
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=hnet
  URL:=https://github.com/fingon/openwrt-hnet-feed
  DEPENDS+=+hnetd +ohybridproxy
  DEPENDS+=+@IPV6
endef

define Package/hnet/description
This package provides configuration glue for hnetd + ohybridproxy.
endef

define Package/hnet/config
	source "$(SOURCE)/Config.in"
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/hnet/install
# Custom hnet configuration options
	$(INSTALL_DIR) $(1)/usr/share/hnet
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) files/setup-conf.sh $(1)/etc/uci-defaults/30_hnet-conf

ifeq ($(CONFIG_TARGET_ar71xx),y)
	$(INSTALL_BIN) files/setup-network/ar71xx.sh $(1)/usr/share/hnet/netconf.sh
else
	$(INSTALL_BIN) files/setup-network/not-available.sh $(1)/usr/share/hnet/netconf.sh
endif

ifeq ($(CONFIG_PACKAGE_hnet-setup-network),y)
	ln -s /usr/share/hnet/netconf.sh $(1)/etc/uci-defaults/20_hnet-net
endif

ifeq ($(CONFIG_PACKAGE_hnet-setup-hostname),y)
	echo HNET_SETUP_HOSTNAME=$(firstword $(CONFIG_PACKAGE_hnet-hostname)) >> $(1)/usr/share/hnet/setupconf
endif

endef

define Package/hnet/postinst
#!/bin/sh
if [ -e /etc/uci-defaults/20_hnet-net ]
then
	/etc/uci-defaults/20_hnet-net
	rm -f /etc/uci-defaults/20_hnet-net
	/etc/init.d/network reload
fi
/etc/uci-defaults/30_hnet-conf
rm -f /etc/uci-defaults/30_hnet-conf
exit 0
endef

$(eval $(call BuildPackage,hnet))
