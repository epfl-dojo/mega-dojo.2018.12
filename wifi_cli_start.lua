-- This connect the NodeMCU to an WIFI AP
print(" → Loading wifi_cli_start.lua\n")

local myWifiMode=wifi.getmode()
if myWifiMode == wifi.NULLMODE then
  print("  WIFI: mode STATION only")
  wifi.setmode(wifi.STATION)
elseif myWifiMode == wifi.SOFTAP then
  print("  WIFI: mode STATION AP")
  wifi.setmode(wifi.STATIONAP)
end
wifi.sta.autoconnect(1)
wifi.sta.connect()
f= "wifi_get_ip.lua" if file.exists(f) then dofile(f) end