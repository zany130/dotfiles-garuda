local kb = libs.keyboard;
local timer = libs.timer;
local server = libs.server;
local log = libs.log;
local dev = libs.device;

local tid = -1;
local title = "";

events.detect = function ()
	return libs.fs.exists("/Applications/MPlayerX.app");
end

events.focus = function ()
tid = timer.interval(actions.update, 500);
end

events.blur = function ()
timer.cancel(tid);
end

--@help Update status information
actions.update = function ()
	local _title = os.script("tell application \"System Events\"",
	"set frontApp to first application process whose frontmost is true",
	"set frontAppName to \"MPlayerX\"",
	"tell process frontAppName",
		"tell (1st window whose value of attribute \"AXMain\" is true)",
			"value of attribute \"AXTitle\"",
		"end tell",
	"end tell",
"end tell");
	print("asd");
	print(_title);
	if (_title == "") then
		_title = "[Not Playing]";
	end
	if (_title ~= title) then
		title = _title;
		server.update({ id = "info", text = title });
	end
end

--@help Launch MPlayerX application
actions.launch = function()
	os.script("tell application \"MPlayerX\"",
		"activate",
	"end tell");
end

--@help Lower volume
actions.volume_down = function()
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\"",
	"keystroke \"-\"",
	"end tell");
end

--@help Mute volume
actions.volume_mute = function()
	os.script("tell application \"MPlayerX\"",
		"mute",
	"end tell");
end

--@help Raise volume
actions.volume_up = function()
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\"",
	"keystroke \"=\"",
	"end tell");

end

--@help Previous track
actions.previous = function()
	os.script("tell application \"MPlayerX\"",
		"goto previous episode",
	"end tell");
end

--@help Next track
actions.next = function()
	os.script("tell application \"MPlayerX\"",
		"goto next episode",
	"end tell");
end

--@help Skip forward 10 secs
actions.forward = function()
	local time = os.script("tell application \"MPlayerX\"",
		"current time",
	"end tell") + 10;
	os.script("tell application \"MPlayerX\"",
		"seekto "..time,
	"end tell");
end

--@help Skip backward 10 secs
actions.backward = function()
	local time = os.script("tell application \"MPlayerX\"",
		"current time",
	"end tell") - 10;
	os.script("tell application \"MPlayerX\"",
		"seekto "..time,
	"end tell");
end

--@help Stop playback
actions.stop = function()
	os.script("tell application \"MPlayerX\"",
		"stop",
	"end tell");
end

--@help Start playback
actions.play = function()
	os.script("tell application \"MPlayerX\"",
		"play",
	"end tell");
end

--@help Pause or unpause playback
actions.pause = function()
	os.script("tell application \"MPlayerX\"",
		"pause",
	"end tell");
end

--@help Toggle play/pause state
actions.play_pause = function()
	os.script("tell application \"MPlayerX\"",
		"playpause",
	"end tell");
end

--@help Switch subtitle
actions.subtitle = function()
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\" to keystroke \"s\"");
end

--@help Toggle fullscreen
actions.fullscreen = function()
os.script("tell application \"MPlayerX\" to activate", 
	"tell application \"System Events\" to keystroke \"f\"");
end

--@help Increase subtitle delay
actions.subtitle_delay_down = function()
	--Cmd+Down
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\" to key code 125 using command down");
end

--@help Decrease subtitle delay
actions.subtitle_delay_up = function()
	--Cmd+Up
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\" to key code 126 using command down")
end

--@help Increase audio delay
actions.audio_delay_down = function()
	--Alt+Down
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\" to key code 125 using option down");
end

--@help Decrease audio delay
actions.audio_delay_up = function()
	--Alt+Up
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\" to key code 126 using option down")
end

--@help Show inspector
actions.info = function()
os.script("tell application \"MPlayerX\" to activate",
	"tell application \"System Events\" to keystroke \"i\"")
end

--@help Open file manager
actions.file_manager = function()
dev.switch("Unified.FileManager");
end