---------------
m = Map("wireless", translate("Mesh_80211_wireless"),translate("Configure Mesh_80211_wireless"))
m:chain("network")
s2 = m:section(TypedSection, "wifi-iface", "")
function s2.filter(self, section)
return self.map:get(section, "mode") == "ap"
end
s2.anonymous=true
s2.addremove=false
ssid = s2:option(Value, "ssid", translate("SSID"))

s = m:section(TypedSection, "wifi-iface", "")
function s.filter(self, section)
return self.map:get(section, "mode") == "mesh"
end
s.addremove=false
s.anonymous=true
mesh_id = s:option(Value, "mesh_id", translate("Mesh ID"))
---------------
m1 = Map("network", translate("Mesh_80211_network"),translate("Configure Mesh_80211_network"))
s1 = m1:section(NamedSection, "wan", "interface", "")
proto = s1:option(ListValue, "proto",translate("Protocol"))                                                                                                       
proto:value("dhcp")                                                                                                           
proto:value("static")          

static_ipaddr = s1:option(Value, "ipaddr", translate("IP Address"))     
static_ipaddr:depends({proto="static"})
static_netmask = s1:option(Value, "netmask", translate("Netmask"))     
static_netmask:depends({proto="static"})
static_gateway = s1:option(Value, "gateway", translate("Gateway"))     
static_gateway:depends({proto="static"})
static_dns = s1:option(Value, "dns", translate("DNS"))     
static_dns:depends({proto="static"})
---------------
local apply = luci.http.formvalue("cbi.apply")
if apply then
io.popen("/etc/init.d/network restart")
end

return m,m1
