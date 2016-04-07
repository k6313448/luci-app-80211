#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-80211
PKG_VERSION:=1.0
PKG_RELEASE:=0

PKG_LICENSE:=GPLv3 
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=maoky <maoky@bellnett.com> 

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-80211
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  $(call Package/luci/webtemplate)
  DEPENDS+=+luci
  TITLE:=80211 luci control interface
endef

define Package/luci-app-80211/description
  LuCI Support for bellnett 80211
endef

define Build/Prepare
  #mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-80211/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then 
	chmod 755 /etc/init.d/set_ssid >/dev/null 2>&1
	/etc/init.d/set_ssid enable >/dev/null 2>&1
fi
exit 0
endef

define Package/luci-app-80211/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/luci/controller/80211_ctrl.lua $(1)/usr/lib/lua/luci/controller/80211_ctrl.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/luci/model/cbi/80211_cbi.lua $(1)/usr/lib/lua/luci/model/cbi/80211_cbi.lua

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/root/etc/config/network $(1)/etc/config/network
	$(INSTALL_DATA) ./files/root/etc/config/wireless $(1)/etc/config/wireless

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/root/etc/init.d/set_ssid $(1)/etc/init.d/set_ssid	
endef

$(eval $(call BuildPackage,luci-app-80211))
