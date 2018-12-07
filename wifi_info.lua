-- Print the IP and some WIFI information, usefull to get the IP of the webserver
print(" → Loading wifi_info.lua\n")

local myWifiMode=wifi.getmode()

-- wifi.NULLMODE, wifi.STATION, wifi.SOFTAP, wifi.STATIONAP

if myWifiMode == wifi.NULLMODE then
  print("  WIFI: OFF")
elseif myWifiMode == wifi.STATION then
  print("  WIFI: mode STATION")
  print("  WIFI: Connected")
  print("  WIFI: IP:\n",wifi.sta.getip())
  do
    local sta_config=wifi.sta.getconfig(true)
    print(string.format("  Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
  end
elseif myWifiMode == wifi.SOFTAP then
  print("  WIFI: mode AP")
  print("  WIFI: AP MAC:\n",wifi.ap.getmac())
  print("  WIFI: AP IP:\n",wifi.ap.getip())
  print("  WIFI: AP Connect:\n",wifi.ap.getconfig())
elseif myWifiMode == wifi.STATIONAP then
  print("  WIFI: WIFI mode CLI+AP")
  print("  WIFI: Connected IP:\n",wifi.sta.getip())
  do
    local sta_config=wifi.sta.getconfig(true)
    print(string.format("Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
  end
  print("  WIFI: AP MAC: "..wifi.ap.getmac())
  print("  WIFI: AP IP: "..wifi.ap.getip())
end
