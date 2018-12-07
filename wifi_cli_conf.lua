-- This configure the WIFI client

print(" → Loading wifi_cli_conf.lua\n")

cli_ssid="KeyloRenIsShirtLess"
cli_pwd="ponsfrilus"

wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, save=true}
