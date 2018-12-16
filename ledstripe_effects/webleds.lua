-- Petit script de serveur WEB pour piloter les effets des LED RGB
-- source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/webap_toggle_pin.lua

print("\n webleds.lua   zf181205.2101   \n")

if LEDSTRIPE == nil then


-- send a file from memory to the client; max. line length = 1024 bytes!
local function send_file(client, filename)
  if file.open(filename, "r") then
    repeat
      local line=file.read('\n')
      if line then
        client:send(line)
      end
    until not line    
    file.close()
  end
end

local function render(client)
    send_file(client, 'header.html')
    if LEDSTRIPE_CURRENT != nil then
        local n = LEDSTRIPE_CURRENT:name
        local f = "ledstripe_" .. n .. ".html"
        client:send("<h2>Current Effect is " .. n)
        if (file.exists(f)) send_file(client, f)
    end
    client:send("<h2>Available Effects</h2>")
    client:send("<ul>")
    for name, effect in pairs(LEDSTRIPE_EFFECTS) do
        client:send("<li><a href='/?fonction=select&name="..name.."'>"..name.."</a></li>")
    end
end

local function on_receive(client, request)
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")

    -- drop requests for favicon
    if string.find(request, "/favicon.ico") then
        return
    end

    if (method == nil) then
     _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end

    _GET = {}
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
        print(k..": "..v)
      end
    end

    if (_GET.fonction == "start") then
        ledstripe_resume()
    end

    if (_GET.fonction == "stop") then
        ledstripe_pause()
    end

    if (_GET.fonction == "update") then
        ledstripe_update(_GET)
    end




    if (_GET.set == "giova") then
        print("Calling giovanni_web")
        giovanni_web(_GET)
    end

    if (_GET.restart == "1") then
        restarttimer1=tmr.create()
        tmr.alarm(restarttimer1, 2*1000,  tmr.ALARM_SINGLE, function()
            node.restart()
        end)
    end

    render(client)
  end
end

local function on_sent(c) 
    c:close()
end


-- web server
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
    conn:on("receive", on_receive)
    conn:on("sent", on_sent)
end)
