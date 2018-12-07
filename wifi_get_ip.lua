-- When connected, this script print the NodeMCU's IP
print(" → Loading wifi_get_ip.lua\n")

wifitimer1=tmr.create()
print("   Initializing connection to access point... (wifi_get_ip.lua)\n")
tmr.alarm(wifitimer1, 1000, tmr.ALARM_AUTO , function()
  if wifi.sta.getip() == nil then
    print("     ... connection new attempt ...")
  else
    tmr.stop(wifitimer1)
    f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
  end
end)
