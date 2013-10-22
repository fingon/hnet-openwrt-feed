#
# Copyright (C) 2012-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet
PKG_SOURCE_VERSION:=4dabd54ca8fe93df75f56c86151a928b3ea58ad9
PKG_VERSION:=2013-10-22-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/fingon/hnet-core.git
PKG_MAINTAINER:=Markus Stenberg <fingon@iki.fi>

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/hnet
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=hnet
  URL:=https://github.com/fingon/hnet-core
  # These are 'core depends' that we need to function at all
  DEPENDS:=+lua +ip +lualfs +hnet-luasocket +luavstruct +luamd5 +bird6-elsa
  # These are sometime replaceable ones, but in principle they are helpful too
  # (Used to provide services / get configuration)
  DEPENDS+=+bird4

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

define Build/Configure
endef

define Build/Compile
endef

define Package/hnet/install
	$(INSTALL_DIR) $(1)/usr/share/lua
	$(CP) $(PKG_BUILD_DIR)/*.lua $(1)/usr/share/lua
	$(CP) $(PKG_BUILD_DIR)/stress/*_raw.lua $(1)/usr/share/lua
	$(INSTALL_DIR) $(1)/usr/sbin
	ln -s /usr/share/lua/skvtool.lua $(1)/usr/sbin/skvtool
	chmod a+x $(1)/usr/share/lua/{pm,hp,skvtool}.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(CP) $(PKG_BUILD_DIR)/thirdparty/*.lua $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/share/hnet
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/openwrt/*.sh $(1)/usr/share/hnet
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
	$(INSTALL_DIR) $(1)/lib/netifd/proto
	$(INSTALL_BIN) files/hnet.sh $(1)/lib/netifd/proto
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) files/disable-hnet $(1)/etc/uci-defaults/hnet
endef

$(eval $(call BuildPackage,hnet))
