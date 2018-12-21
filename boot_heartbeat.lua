local zLED=0
local zTm_On_LED = 50    --> en ms
local zTm_Off_LED = 100    --> en ms
local nbfois = 0
local ztmr_Flash_LED = tmr.create()

local function init_LED()
  gpio.write(zLED, gpio.HIGH)
  gpio.mode(zLED, gpio.OUTPUT)
end

local function blink_LED()
  if nbfois > 0 then
    if gpio.read(zLED)==gpio.HIGH then
      gpio.write(zLED, gpio.LOW)
      tmr.alarm(ztmr_Flash_LED, zTm_Off_LED, tmr.ALARM_SINGLE, blink_LED)
    else 
      gpio.write(zLED, gpio.HIGH)
      nbfois = nbfois-1
      tmr.alarm(ztmr_Flash_LED, zTm_On_LED, tmr.ALARM_SINGLE, blink_LED)
    end
  end
end

nbfois=2
local boottimer1=tmr.create()
tmr.alarm(boottimer1, 1*1000,  tmr.ALARM_AUTO, blink_LED)

-- function heartbeat()
--   f= "flash_led_xfois.lua"
--   if file.exists() then
--     dofile(f)
--     boottimer1=tmr.create()
--     tmr.alarm(boottimer1, 1*1000,  tmr.ALARM_AUTO, function()
--         xfois=2
--         blink_LED()
--     end)
--     print("\nHeartbeat LED should start blinking.")
--   else
--     print("\nHeartbeat LED blinking disabled (missing file " .. f .. ").")
--   end
-- end
