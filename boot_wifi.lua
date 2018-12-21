local f="wifi.lua"
if file.exists(f) then
  dofile(f)
  wifi_ap_stop()
  wifi_cli_conf()
  wifi_cli_start()
end
