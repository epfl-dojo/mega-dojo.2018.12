-- Start WIFI in AP mode
print(" → Loading wifi_ap_stop.lua\n")

local myWifiMode=wifi.getmode()
if myWifiMode == wifi.SOFTAP then
  wifi.setmode(wifi.NULLMODE)
  print(" ...WIFI AP stopped")
elseif myWifiMode == wifi.STATIONAP then
  wifi.setmode(wifi.STATION)
  print(" ...WIFI AP stopped")
end
