#
# Copyright (C) 2012 cisco Systems, Inc.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

# Netkit integration package -> no need to specially build new image.

include $(TOPDIR)/rules.mk

PKG_NAME:=netkit
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/netkit
  TITLE:=NetKit integration for OpenWRT
  MAINTAINER:=Markus Stenberg <markus.stenberg@iki.fi>
  PKGARCH:=uml
endef

define Package/netkit/description
Provides NetKit phase1- and phase2 base scripts.
endef

define Build/Compile
endef

define Build/Configure
endef

define Package/netkit/install
	$(INSTALL_DIR) $(1)/lib/netkit
	$(INSTALL_BIN) files/netkit-phase1 $(1)/lib/netkit/netkit-phase1
	$(INSTALL_BIN) files/netkit-phase2 $(1)/lib/netkit/netkit-phase2
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/netkit-phase1.init $(1)/etc/init.d/netkit-phase1
	$(INSTALL_BIN) files/netkit-phase2.init $(1)/etc/init.d/netkit-phase2
endef

$(eval $(call BuildPackage,netkit))
