module("luci.controller.80211_ctrl", package.seeall)
function index()
	entry({"admin", "network", "mesh_80211"}, cbi("80211_cbi"), _("Mesh_80211"), 100)
end

