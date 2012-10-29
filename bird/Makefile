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

PKG_NAME:=bird
PKG_SOURCE_VERSION:=377935663df70f108f736e5a31cceb6f689205ca
PKG_VERSION:=2012-10-29-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=$(PKG_VERSION)


PKG_SOURCE_URL:=git://github.com/fingon/bird-ext-lsa.git
PKG_SOURCE_PROTO:=git
PKG_BUILD_DEPENDS:=libncurses libreadline

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/bird/Default
  TITLE:=The BIRD Internet Routing Daemon
  URL:=http://bird.network.cz/
  DEPENDS:= +liblua
endef

# These dependencies are in separate LUA package
# +ip +luasocket

define Package/birdc/Default
  TITLE:=The BIRD command-line client
  URL:=http://bird.network.cz/
  DEPENDS:= +libreadline +libncurses
endef

define Package/bird/Default/description1
BIRD is an internet routing daemon which manages TCP/IP routing tables
with support of modern routing protocols, easy to use configuration
interface and powerful route filtering language. It is lightweight and
efficient and therefore appropriate for small embedded routers.

endef

define Package/bird/Default/description2
In BGP, BIRD supports communities, multiprotocol extensions, MD5
authentication, 32bit AS numbers and could act as a route server or a
route reflector. BIRD also supports multiple RIBs, multiple kernel
routing tables and redistribution between the protocols with a powerful
configuration syntax.

endef

define Package/bird/Default/description3
This is a BIRD command-line client. It is used to send commands to BIRD,
commands can perform simple actions such as enabling/disabling of
protocols, telling BIRD to show various information, telling it to show
a routing table filtered by a filter, or asking BIRD to reconfigure.

Unless you can't afford dependency on ncurses and readline, you
should install BIRD command-line client together with BIRD.

endef

define Package/bird6
$(call Package/bird/Default)
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE+= (IPv6)
endef

define Package/birdc6
$(call Package/birdc/Default)
  SECTION:=ipv6
  CATEGORY:=IPv6
  TITLE+= (IPv6)
  DEPENDS+= +bird6
endef

define Package/bird6/description
$(call Package/bird/Default/description1)
This is IPv6 version of BIRD, it supports OSPFv3, RIPng and BGP
protocols.

$(call Package/bird/Default/description2)
endef

define Package/birdc6/description
$(call Package/bird/Default/description1)
$(call Package/bird/Default/description3)
endef

CONFIGURE_ARGS += --with-linux-headers="$(LINUX_DIR)"

define Build/Template

$(STAMP_BUILT)-$(2): $(STAMP_PREPARED)
	( cd $(PKG_BUILD_DIR); autoconf )
	$(call Build/Configure/Default,$(3))
	$(call Build/Compile/Default,)
	( cd $(PKG_BUILD_DIR); mv -f bird bird$(2); mv -f birdc birdc$(2) )
	-$(MAKE) -C $(PKG_BUILD_DIR) clean
	touch $$@

$(STAMP_BUILT): $(STAMP_BUILT)-$(2)

define Package/bird$(2)/install
	$(INSTALL_DIR)  $$(1)/usr/sbin
	$(INSTALL_BIN)  $$(PKG_BUILD_DIR)/bird$(2) $$(1)/usr/sbin/
	$(INSTALL_BIN)  ./files/bird$(2)loop $$(1)/usr/sbin/
	$(INSTALL_DIR)  $$(1)/etc
	$(INSTALL_DATA) ./files/bird$(2).conf $$(1)/etc/
	$(INSTALL_DIR)  $$(1)/etc/init.d
	$(INSTALL_BIN)  ./files/bird$(2).init $$(1)/etc/init.d/bird$(2)
	$(INSTALL_DIR)  $$(1)/usr/share/bird
	$(INSTALL_DATA) $$(PKG_BUILD_DIR)/elsa.lua $$(1)/usr/share/bird/
endef

define Package/bird$(2)/conffiles
/etc/bird$(2).conf
endef

define Package/birdc$(2)/install
	$(INSTALL_DIR) $$(1)/usr/sbin
	$(INSTALL_BIN) $$(PKG_BUILD_DIR)/birdc$(2) $$(1)/usr/sbin/
endef

endef


$(eval $(call Build/Template,bird6,6, --enable-ipv6))

$(eval $(call BuildPackage,bird6))
$(eval $(call BuildPackage,birdc6))
