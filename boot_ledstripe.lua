if file.exists("ledstripe.lua") then
  print("Loading ledstripe")
  dofile("ledstripe.lua")
  tmr.alarm(tmr.create(), 5*1000, tmr.ALARM_SINGLE, function() ledstripe_set("giovanni1") end)
  if file.exists("webleds.lua") then
    print("Loading webleds")
    dofile("webleds.lua")
    tmr.alarm(tmr.create(), 4*1000, tmr.ALARM_SINGLE, boot_webleds)
  end
end
