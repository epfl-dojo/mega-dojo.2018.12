-- Scripts juste pour tester l'effet train
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_train3.lua zf181205.1919 \n")

-- Effect specific stuff ----------------------------------------------

local nbleds=LEDSTRIPE:size()

local fade1=0.05
local fade2=0.2
local fade3=0.4
local fade4=1
local R1=16
local G1=16
local B1=0
local R2=16
local G2=16
local B2=0
local train_speed=100

local myLedStrip1 = nil
local myLedStrip2 = nil 

local function train1_fill()
    myLedStrip1:fill(0,0,0)
    myLedStrip1:set(1, G1*fade1, R1*fade1, B1*fade1)
    myLedStrip1:set(2, G1*fade2, R1*fade2, B1*fade2)
    myLedStrip1:set(3, G1*fade3, R1*fade3, B1*fade3)
    myLedStrip1:set(4, G1*fade4, R1*fade4, B1*fade4)
end

local function train2_fill()
    myLedStrip2:fill(0,0,0)
    myLedStrip2:set(nbleds, G2*fade1, R2*fade1, B2*fade1)
    myLedStrip2:set(nbleds-1, G2*fade2, R2*fade2, B2*fade2)
    myLedStrip2:set(nbleds-2, G2*fade3, R2*fade3, B2*fade3)
    myLedStrip2:set(nbleds-3, G2*fade4, R2*fade4, B2*fade4)
end

local function train_mix()
    LEDSTRIPE:mix(255, myLedStrip1, 255, myLedStrip2)
end

local function train_shift()
    myLedStrip1:shift(1, ws2812.SHIFT_CIRCULAR)
    myLedStrip2:shift(-1, ws2812.SHIFT_CIRCULAR)
end

local function setup()
    if myLedStrip1 == nil
        myLedStrip1 = ws2812.newBuffer(nbleds, 3) 
        myLedStrip1 = ws2812.newBuffer(nbleds, 3) 
        train1_fill()
        train2_fill()
    end
end

-- API functions ------------------------------------------------------

local function start()
    setup()
    train3timer1=tmr.create()
    tmr.alarm(train3timer1, train_speed,  tmr.ALARM_AUTO, function()
        train_shift()
        train_mix()
        train_write()
    end)
end

local function pause()
    tmr.unregister(train3timer1)
    RGB_clear()
end

local function stop()
    pause()
    myLedStrip1 = nil
    myLedStrip1 = nil
end

local function update(_GET)
    if (_GET.set == "speed") then
        train_stop()
        if (_GET.speed == "inc") then
            train_speed=train_speed*0.8
        else
            train_speed=train_speed*1.2
        end
        train_start()
    end    
 
    if (_GET.set == "color") then
        print("setting color (RGB)", _GET.R1, _GET.G1, _GET.B1)
        train_stop()
        R1=_GET.R1   G1=_GET.G1   B1=_GET.B1
        R2=_GET.R2   G2=_GET.G2   B2=_GET.B2
        train1_fill()
        train2_fill()
        train_start()
    end
end

-- Register this effect in the list of effects ------------------------

LEDSTRIPE_EFFECTS[DEMO_NAME] = {
  name  = "giovanni1",
  start = function() start() end,
  stop  = function() stop()  end,
  pause = function() pause()  end,
  update = function() update() end,
}