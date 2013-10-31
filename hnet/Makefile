#
# Copyright (C) 2012-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet
PKG_SOURCE_VERSION:=112301324125ad87ff53bf8b6ae5a89d5e9903ad
PKG_VERSION:=2013-10-29-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/Oryon/hnet-core.git
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
  # These we should get rid of at some point (replace servers with
  # dnsmasq, and client's with something - busybox?)
  #DEPENDS+=+radvd
  #DEPENDS+=+isc-dhcp-server-ipv4
  #DEPENDS+=+isc-dhcp-server-ipv6
  DEPENDS+=+isc-dhcp-client-ipv4
  #DEPENDS+=+isc-dhcp-client-ipv6

  # Require rdisc6 just so that network gets set up bit faster
  DEPENDS+=+rdisc6

  DEPENDS+=+hnet-dnsmasq-dhcpv6
  DEPENDS+=+hnet-odhcp6c

  # uclibc does not do RFC4007 getnameinfo (and some other things)
  # See e.g. https://bugs.busybox.net/show_bug.cgi?id=6062
  DEPENDS+=+@USE_EGLIBC

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
	$(CP) files/bird6.conf  $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/hnet.init $(1)/etc/init.d/hnet
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) files/disable-hnet $(1)/etc/uci-defaults/hnet
endef

$(eval $(call BuildPackage,hnet))
