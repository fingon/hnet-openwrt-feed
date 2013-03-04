include $(TOPDIR)/rules.mk

PKG_NAME:=hnet
PKG_SOURCE_VERSION:=522dd3ec208bb61884833c61859f3af0c1187cfc
PKG_VERSION:=2013-03-04-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/fingon/hnet-core.git
PKG_SOURCE_PROTO:=git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/hnet
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE:=hnet
  URL:=https://github.com/fingon/hnet-core
  # These are 'core depends' that we need to function at all
  DEPENDS:=+lua +ip +hnet-luasocket +luavstruct +luamd5 +bird6-elsa
  # These are sometime replaceable ones, but in principle they are helpful too
  # (Used to provide services / get configuration)
  DEPENDS+=+bird4
  DEPENDS+=+radvd
  # These we should get rid of at some point (replace servers with
  # dnsmasq, and client's with something - busybox?)
  DEPENDS+=+isc-dhcp-server-ipv4
  DEPENDS+=+isc-dhcp-server-ipv6
  DEPENDS+=+isc-dhcp-client-ipv4
  DEPENDS+=+isc-dhcp-client-ipv6
  # Require rdisc6 just so that network gets set up bit faster
  DEPENDS+=+rdisc6
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
	chmod a+x $(1)/usr/share/lua/{pm,mdns,skvtool}.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(CP) $(PKG_BUILD_DIR)/thirdparty/*.lua $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/share/hnet
	$(CP) $(PKG_BUILD_DIR)/openwrt/*.sh $(1)/usr/share/hnet
	chmod a+x $(1)/usr/share/hnet/*.sh
	$(INSTALL_DIR) $(1)/sbin
	$(CP) files/dhclient-script $(1)/sbin
	$(INSTALL_DIR) $(1)/etc/dhcp/dhclient-exit-hooks.d
	chmod a+x $(1)/sbin/dhclient-script
	$(CP) files/dhclient-exit-hooks  $(1)/etc
	$(CP) files/dhclient.conf $(1)/etc/dhcp/dhclient6-hnet.conf
	$(CP) files/use-pd  $(1)/etc/dhcp/dhclient-exit-hooks.d
	$(CP) files/use-v4  $(1)/etc/dhcp/dhclient-exit-hooks.d
	$(CP) files/bird6.conf  $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/hnet.init $(1)/etc/init.d/hnet
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) files/disable-hnet $(1)/etc/uci-defaults/hnet
endef

$(eval $(call BuildPackage,hnet))
