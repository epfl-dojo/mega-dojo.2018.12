-- Scripts loaded by init.lua, after the bootstrap

print("\n ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ ↓↓ \n")
print("\n → Loading boot.lua\n")

function heartbeat()
    boottimer1= tmr.create()
    tmr.alarm(boottimer1, 1*1000, tmr.ALARM_AUTO, function()
  end)
end

f= "wifi_ap_stop.lua" if file.exists(f) then dofile(f) end
f= "wifi_cli_conf.lua" if file.exists(f) then dofile(f) end
f= "wifi_cli_start.lua" if file.exists(f) then dofile(f) end
f= "webleds.lua" if file.exists(f) then dofile(f) end

heartbeat()
