-- Bootstraping the server
-- Try to restart while x seconds if the failure if the reason is power or IDE
-- Source: https://nodemcu.readthedocs.io/en/master/en/modules/node/#nodebootreason

print(" → Loading init.lua\n")

function second_chance()
  print("Second chance...")
  f= "repair.lua" if file.exists(f) then dofile(f) end
  initalarme=tmr.create()
  tmr.alarm(initalarme, 8*1000, tmr.ALARM_SINGLE, function()
    f= "boot.lua"if file.exists(f) then dofile(f) end
  end)
end

_, reset_reason = node.bootreason()
print("  Reset_reason:", reset_reason)
if reset_reason == 0 then
  print("   - Power on")
  second_chance()
elseif reset_reason == 4 then
  print("   - node.restart()")
  f= "boot.lua" if file.exists(f) then dofile(f) end
elseif reset_reason == 6 then
  print("   - Reset")
  second_chance()
else
  print("   - Other")
end

