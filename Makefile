clean:
	./nd format
	sleep 5


boot:
	./nd mput init.lua boot.lua repair.lua

wifi:
	./nd mput boot_wifi.lua wifi.lua
	./nd put credentials_giova.lua credentials.lua


init: boot wifi
	./nd mput boot_heartbeat.lua

hat:
	cd ledstripe && ../nd mput *.lua *.html
	./nd put boot_ledstripe.lua