print("\n giovanni.lua gc181214.1907 \n")

-- Effect specific stuff ----------------------------------------------

local NBLEDS=LEDSTRIPE:size()

local ADDSTAR_RATE=200
local ANIMATE_RATE=300
local FADE_MIN=0.5
local FADE_MAX=0.8
local INT_AVE=180
local INT_VAR=20
local COL_VAR=40

local fader_shift=0
local fader_fac = {}

local function set_fader()
  for i=0,NBLEDS,1 do
    f=FADE_MIN + (FADE_MAX - FADE_MIN) * node.random()
    fader_fac[i] = f
  end
end

local function shift_fader()
  fader_shift = node.random(NBLEDS)
end

local function add_star()
    pos=node.random(NBLEDS)
    c0 = INT_AVE - INT_VAR + node.random(2*INT_VAR)
    cr = c0 + node.random(2*COL_VAR)
    cg = c0 + node.random(2*COL_VAR)
    cb = c0 + node.random(2*COL_VAR)
    LEDSTRIPE:set(pos, cr, cg, cb)
end

local function animate_star()
  for i=1,NBLEDS,1 do
    r,g,b = LEDSTRIPE:get(i)
    f = fader_fac[(i+fader_shift)%NBLEDS]
    r = math.floor(r * f)
    g = math.floor(g * f)
    b = math.floor(b * f)
    LEDSTRIPE:set(i, r, g, b)
  end
  ledstripe_write()
end

-- API functions ------------------------------------------------------

local function start()
  star_anim_timer=tmr.create()
  star_crea_timer=tmr.create()
  ledstripe_clear()
  set_fader()
  tmr.alarm(star_crea_timer, ADDSTAR_RATE, tmr.ALARM_AUTO, add_star)
  tmr.alarm(star_anim_timer, ANIMATE_RATE, tmr.ALARM_AUTO, animate_star)  
end

local function pause()
  tmr.unregister(star_crea_timer)
  tmr.unregister(star_anim_timer)
end

local function stop()
  pause()
  ledstripe_clear()
end

local function update(g)
  k=g.k
  v=g.v
  print("Old Params:")
  print("addrate:   " + ADDSTAR_RATE)
  print("faderate:  " + ANIMATE_RATE)
  print("intensity: " + INT_AVE)
  print("color:     " + COL_VAR)
  stop()
  if (k=="addrate") then
    if (v=="inc") then
      ADDSTAR_RATE = ADDSTAR_RATE - 10
    else
      ADDSTAR_RATE = ADDSTAR_RATE + 10
    end
  end
  if (k=="faderate") then
    if (v=="inc") then
      ANIMATE_RATE = ANIMATE_RATE - 10
    else
      ANIMATE_RATE = ANIMATE_RATE + 10
    end
  end
  if (k=="intensity") then
    if (v=="inc") then
      INT_AVE = INT_AVE + 10
    else
      INT_AVE = INT_AVE - 10
    end
  end
  if (k=="color") then
    if (v=="inc") then
      COL_VAR = COL_VAR + 2
    else
      COL_VAR = COL_VAR - 2
    end
  end
  start()
  print("New Params:")
  print("addrate:   " + ADDSTAR_RATE)
  print("faderate:  " + ANIMATE_RATE)
  print("intensity: " + INT_AVE)
  print("color:     " + COL_VAR)

end

-- Register this effect in the list of effects ------------------------
local DEMO_NAME="giovanni1"
LEDSTRIPE_EFFECTS[DEMO_NAME] = {
  name  = function() return DEMO_NAME end,
  start = function() start() end,
  stop  = function() stop()  end,
  pause = function() pause()  end,
  update = function() update() end,
}