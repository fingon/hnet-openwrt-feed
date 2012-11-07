include $(TOPDIR)/rules.mk

PKG_NAME:=hnet
PKG_SOURCE_VERSION:=7325f401151963e8d71586826d9d43bd1f982788
PKG_VERSION:=2012-11-07-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=$(PKG_VERSION)

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
  DEPENDS:=+lua +ip +luasocket +luavstruct +luamd5 +bird6-elsa
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
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(CP) $(PKG_BUILD_DIR)/thirdparty/*.lua $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/share/hnet
	$(CP) $(PKG_BUILD_DIR)/openwrt/*.sh $(1)/usr/share/hnet
	chmod a+x $(1)/usr/share/hnet/*.sh
endef

$(eval $(call BuildPackage,hnet))
