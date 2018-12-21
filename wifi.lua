local wifitimer1=tmr.create()

function wifi_cli_conf(f)
  f = f or "credentials.lua"

  --credentials par défaut
  cli_ssid="3g-s7"
  cli_pwd="12234567"
  
  if file.exists(f) then dofile(f) end

  wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, save=true}
end

function wifi_info()
  local zmodewifi=wifi.getmode()
  if zmodewifi == wifi.NULLMODE then
      print("WIFI OFF")
  elseif zmodewifi == wifi.STATION then
      print("WIFI mode CLI")
      print("Connected IP:\n",wifi.sta.getip())
      do
          local sta_config=wifi.sta.getconfig(true)
          print(string.format("Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
      end
  elseif zmodewifi == wifi.SOFTAP then
      print("WIFI mode AP")
      print("AP MAC:\n",wifi.ap.getmac())
      print("AP IP:\n",wifi.ap.getip())
      print("AP Connect:\n",wifi.ap.getconfig())
  elseif zmodewifi == wifi.STATIONAP then
      print("WIFI mode CLI+AP")
      print("Connected IP:\n",wifi.sta.getip())
      do
          local sta_config=wifi.sta.getconfig(true)
          print(string.format("Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
      end
      print("AP MAC: "..wifi.ap.getmac())
      print("AP IP: "..wifi.ap.getip())
  end
end

function wifi_get_ip()
  tmr.alarm(wifitimer1, 1000, tmr.ALARM_AUTO , function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        tmr.stop(wifitimer1)
        wifi_info()
    end
  end)
end

function wifi_cli_start()
  local zmodewifi=wifi.getmode()
  if zmodewifi == wifi.NULLMODE then
      print("WIFI mode CLI only")
      wifi.setmode(wifi.STATION)
  elseif zmodewifi == wifi.SOFTAP then
      print("WIFI mode AP+CLI")
      wifi.setmode(wifi.STATIONAP)
  end
  wifi.sta.autoconnect(1)
  wifi.sta.connect()
  wifi_get_ip()
end

function wifi_ap_stop()
  local zmodewifi=wifi.getmode()
  if zmodewifi == wifi.SOFTAP then
    wifi.setmode(wifi.NULLMODE)
  elseif zmodewifi == wifi.STATIONAP then
    wifi.setmode(wifi.STATION)
  end
end