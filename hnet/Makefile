#
# Copyright (C) 2012-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet
PKG_SOURCE_VERSION:=de32bf94b4f9787ce83f42eac7272b0dc44f72da
PKG_VERSION:=2013-12-13-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/fingon/hnet-core.git
PKG_MAINTAINER:=Markus Stenberg <fingon@iki.fi>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_CONFIG_DEPENDS:=CONFIG_PACKAGE_hnet-setup-network
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-setup-hostname
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-hostname
PKG_CONFIG_DEPENDS+=CONFIG_PACKAGE_hnet-setup-disdnsmasq

include $(INCLUDE_DIR)/package.mk

define Package/hnet
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=hnet
  URL:=https://github.com/fingon/hnet-core
  # These are 'core depends' that we need to function at all
  DEPENDS:=+lua +ip +luasocket +luavstruct +luamd5 +bird6-elsa
  # These are sometime replaceable ones, but in principle they are helpful too
  # (Used to provide services / get configuration)
  DEPENDS+=+bird4 +odhcpd
  # This is needed for interaction with OWRT
  DEPENDS+=+libubus-lua

  # uclibc does not do RFC4007 getnameinfo (and some other things)
  # See e.g. https://bugs.busybox.net/show_bug.cgi?id=6062
  # sbyx said he'd take care of it ~20131001

  # UML kernel doesn't seem to work either for some reason with uclibc
  # (But guess it doesn't really force us to have strict dependency,
  # but instead just build UML builds with eglibc).
  #DEPENDS+=+@USE_EGLIBC

  # We're also IPv6-only
  DEPENDS+=+@IPV6
endef

define Package/hnet/description
This package provides implementation of IP routing, prefix assignment and
service discovery for a home network consisting of multiple routers connected
to multiple service providers
endef

define Package/hnet/config
	source "$(SOURCE)/Config.in"
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/hnet/install
	$(INSTALL_DIR) $(1)/usr/share/lua
	$(CP) $(PKG_BUILD_DIR)/{codec,dns*,elsa_pa,hp*,ipv*,j*,l*,m*,o*,pa*,per*,pm,pm_core,pm_handler,pm_bird4,pm_led,pm_memory,pm_netifd*,s*}.lua $(1)/usr/share/lua
	$(INSTALL_DIR) $(1)/usr/sbin
	ln -s /usr/share/lua/skvtool.lua $(1)/usr/sbin/skvtool
	chmod a+x $(1)/usr/share/lua/{pm,hp,skvtool}.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(CP) $(PKG_BUILD_DIR)/thirdparty/*.lua $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/share/hnet
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/openwrt/{bird*,led*}.sh $(1)/usr/share/hnet
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) files/dhclient-script $(1)/sbin
	$(INSTALL_DIR) $(1)/etc/dhcp/dhclient-exit-hooks.d
	$(CP) files/dhclient-exit-hooks  $(1)/etc
	$(CP) files/dhclient.conf $(1)/etc/dhcp/dhclient6-hnet.conf
	$(CP) files/use-v4  $(1)/etc/dhcp/dhclient-exit-hooks.d
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) files/hotplug.sh $(1)/etc/hotplug.d/iface/90-hnet
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/hnet.init $(1)/etc/init.d/hnet
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/hnet.config $(1)/etc/config/hnet
	$(INSTALL_DIR) $(1)/lib/netifd/proto
	$(INSTALL_BIN) files/hnet.sh $(1)/lib/netifd/proto

# Custom hnet configuration options
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

ifeq ($(CONFIG_PACKAGE_hnet-setup-disdnsmasq),y)
	echo HNET_SETUP_DISDNSMASQ="1" >> $(1)/usr/share/hnet/setupconf
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
/etc/init.d/hnet start
exit 0
endef

$(eval $(call BuildPackage,hnet))
