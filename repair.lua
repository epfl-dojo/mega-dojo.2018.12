-- Scripts de seconde chance pour réparer une boucle dans le restart

print(" → Loading repair.lua\n")

ledcounts=300

function RGB_clear()
  ws2812.init()
  buffer = ws2812.newBuffer(ledcounts, 3)
  buffer:fill(0, 0, 0)
  ws2812.write(buffer)
end

print("Initializing LED strip...")
RGB_clear()
print("   ...done")