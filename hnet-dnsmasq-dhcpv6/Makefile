#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# This package provides hnet-dnsmasq-dhcpv6, which can be used to
# replace the stock dnsmasq with a more recent version and whatever
# patches we choose to add. However, it does NOT include any extra
# files, as we assume this is mostly used within the hnet-core stuff,
# which produces it's own config files, and starts and stops dnsmasq
# as needed.

include $(TOPDIR)/rules.mk

PKG_NAME:=hnet-dnsmasq-dhcpv6
PKG_SOURCE_VERSION:=8d324549c832c80e91ceeafa46c4d8030c577a07
PKG_VERSION:=2013-03-20-$(PKG_SOURCE_VERSION)
PKG_RELEASE:=1

PKG_SOURCE_URL:=git://github.com/fingon/hnet-dnsmasq.git
PKG_SOURCE_PROTO:=git

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/hnet-dnsmasq-dhcpv6
  SECTION:=net
  CATEGORY:=Base system
  TITLE:=A lightweight DNS and DHCP server (with DHCPv6 support)
  URL:=http://www.thekelleys.org.uk/dnsmasq/
  DEPENDS:=@IPV6 +kmod-ipv6
endef

define Package/hnet-dnsmasq-dhcpv6/description
It is intended to provide coupled DNS and DHCP service to a LAN.
This is a variant with DHCPv6 support for hnet case (git tracking version)
endef

TARGET_CFLAGS += \
	-ffunction-sections -fdata-sections

MAKE_FLAGS := \
	$(TARGET_CONFIGURE_OPTS) \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="-Wl,--gc-sections" \
	PREFIX="/usr"

define Package/hnet-dnsmasq-dhcpv6/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/dnsmasq $(1)/usr/sbin/hnet-dnsmasq
endef

$(eval $(call BuildPackage,hnet-dnsmasq-dhcpv6))
