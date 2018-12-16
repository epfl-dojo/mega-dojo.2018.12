-- Main script for hat led stripe effects

print("\n ledstripe.lua gc181214.1919 \n")


-- global variables for all led stripes -------------------------------

LEDSTRIPE_NBLEDS=36
LEDSTRIPE = ws2812.newBuffer(LEDSTRIPE_NBLEDS, 3)

-- common functions
function ledstripe_write()
  ws2812.write(LEDSTRIPE)
end

function ledstripe_clear()
  LEDSTRIPE:fill(0, 0, 0)
  ws2812.write(LEDSTRIPE)
end

function ledstripe_list()
  print("Available effects")
  for name, effect in pairs(LEDSTRIPE_EFFECTS) do
    print(name)
  end
end

function ledstripe_set(effect_name)
  if LEDSTRIPE_EFFECTS[effect_name] ~= nil
    if LEDSTRIPE_CURRENT != nil then
      LEDSTRIPE_CURRENT:stop()
    end
      LEDSTRIPE_CURRENT = LEDSTRIPE_EFFECTS[effect_name]
      LEDSTRIPE_CURRENT:start()
    end
  else
    print("Effect with name '" .. effect_name .. "' is NOT available")
  end
end

-- start current effect
function ledstripe_resume()
  if LEDSTRIPE_CURRENT != nil then
    CURRENT_EFFECT.start()
  else
    print("No effect to resume")
  end
end

function ledstripe_pause()
  if LEDSTRIPE_CURRENT != nil then
    CURRENT_EFFECT.stop()
  else
    print("No effect to pause")
  end
end

function ledstripe_update(_GET)
  if LEDSTRIPE_CURRENT != nil then
    CURRENT_EFFECT.update(_GET)
  else
    print("No effect to update")
  end
end

-- main ---------------------------------------------------------------
-- initialize the led stripe and load effects from ledstripe_*.lua
-- each will contain one or more effect and will have
-- to append to global LEDSTRIPE_EFFECTS
-- a dictionary of 4 functions:
-- start()    to start the effect
-- pause()    to pause the effect (but keep buffers in memory)
-- stop()     to stop the effect and freeup buffers
-- update(D)  to update the effect with new parameters from get request

ws2812.init()

LEDSTRIPE_CURRENT = nil
LEDSTRIPE_EFFECTS = {}

for f in file.list("ledstripe_.*%.lua") do
  if file.exists(f) then 
    dofile(f)
  end
end

ledstripe_set("giovanni1")