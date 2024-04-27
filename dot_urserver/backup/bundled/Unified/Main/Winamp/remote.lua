local win = libs.win;
local keyboard = libs.keyboard;
local timer = libs.timer
local utf8 = libs.utf8;
local server = libs.server;

events.detect = function ()
	return 
		libs.fs.exists("C:\\Program Files (x86)\\Winamp") or
		libs.fs.exists("C:\\Program Files\\Winamp");
end

-- Commands
local WM_COMMAND 			= 0x111;
local WA_NOTHING            = 0; 
local WINAMP_OPTIONS_PREFS  = 40012; -- pops up the preferences
local WINAMP_OPTIONS_AOT    = 40019; -- toggles always on top
local WINAMP_FILE_PLAY      = 40029; -- pops up the load file(s) box
local WINAMP_OPTIONS_EQ     = 40036; -- toggles the EQ window
local WINAMP_OPTIONS_PLEDIT = 40040; -- toggles the playlist window
local WINAMP_HELP_ABOUT     = 40041; -- pops up the about box
local WA_PREVTRACK          = 40044; -- plays previous track
local WA_PLAY               = 40045; -- plays selected track
local WA_PAUSE              = 40046; -- pauses/unpauses currently playing track
local WA_STOP               = 40047; -- stops currently playing track
local WA_NEXTTRACK          = 40048; -- plays next track
local WA_VOLUMEUP           = 40058; -- turns volume up
local WA_VOLUMEDOWN         = 40059; -- turns volume down
local WINAMP_FFWD5S         = 40060; -- fast forwards 5 seconds
local WINAMP_REW5S          = 40061; -- rewinds 5 seconds
local WINAMP_BUTTON1_SHIFT  = 40144; -- fast-rewind 5 seconds
local WINAMP_BUTTON2_SHIFT  = 40145;
local WINAMP_BUTTON3_SHIFT  = 40146;
local WINAMP_BUTTON4_SHIFT  = 40147; -- stop after current track
local WINAMP_BUTTON5_SHIFT  = 40148; -- fast-forward 5 seconds
local WINAMP_BUTTON1_CTRL   = 40154; -- start of playlist
local WINAMP_BUTTON2_CTRL   = 40155; -- open URL dialog
local WINAMP_BUTTON3_CTRL   = 40156;
local WINAMP_BUTTON4_CTRL   = 40157; -- fadeout and stop
local WINAMP_BUTTON5_CTRL   = 40158; -- end of playlist
local WINAMP_FILE_DIR       = 40187; -- pops up the load directory box
local ID_MAIN_PLAY_AUDIOCD1 = 40323; -- starts playing the audio CD in the first CD reader
local ID_MAIN_PLAY_AUDIOCD2 = 40323; -- plays the 2nd
local ID_MAIN_PLAY_AUDIOCD3 = 40323; -- plays the 3rd
local ID_MAIN_PLAY_AUDIOCD4 = 40323; -- plays the 4th

local tid = -1;
local playing = false;
local title = "";

events.focus = function ()
	tid = timer.interval(actions.update, 500);
end

events.blur = function ()
	timer.cancel(tid);
end

--@help Update status information
actions.update = function ()
	local hwnd = win.find("Winamp v1.x", nil);
	local _title = win.title(hwnd);
	local _playing = true;
	
	if (utf8.endswith(_title, " - Winamp [Paused]")) then
		_playing = false;
		_title = utf8.replace(_title, " - Winamp [Paused]", "");
	elseif (utf8.endswith(_title, " - Winamp [Stopped]")) then
		_playing = false;
		_title = utf8.replace(_title, " - Winamp [Stopped]", "");
	elseif (utf8.endswith(_title, " - Winamp")) then
		_playing = true;
		_title = utf8.replace(_title, " - Winamp", "");
	else
		_playing = false;
		_title = "[Not Playing]";
	end
	
	if (_title ~= title) then
		title = _title;
		server.update({ id = "info", text = title });
	end
	
	if (_playing ~= playing) then
		playing = _playing;
		if (playing) then
			server.update({ id = "p", icon = "pause" });
		else
			server.update({ id = "p", icon = "play" });
		end
	end
end

--@help Send raw command to Winamp
--@param cmd:number Raw winamp command number
actions.command = function(cmd)
	local hwnd = win.find("Winamp v1.x", nil);
	win.send(hwnd, WM_COMMAND, cmd, 0);
	actions.update();
end

--@help Launcher Winamp application
actions.launch = function()
	os.start("winamp.exe");
end

--@help Lower volume
actions.volume_down = function()
	actions.command(WA_VOLUMEDOWN);
end

--@help Mute volume
actions.volume_mute = function()
	keyboard.stroke("volume_mute");
end

--@help Raise volume
actions.volume_up = function()
	actions.command(WA_VOLUMEUP);
end

--@help Previous track
actions.previous = function()
	actions.command(WA_PREVTRACK);
end

--@help Next track
actions.next = function()
	actions.command(WA_NEXTTRACK);
end

--@help Stop playback
actions.stop = function()
	actions.command(WA_STOP);
end

--@help Start playback
actions.play = function()
	actions.command(WA_PLAY);
end

--@help Pause or unpause playback
actions.pause = function()
	actions.command(WA_PAUSE);
end

--@help Toggle play/pause state
actions.play_pause = function()
	if (playing) then
		actions.pause();
	else
		actions.play();
	end
end

--@help Jump back 5 seconds
actions.small_back = function ()
	actions.command(WINAMP_REW5S);
end

--@help Jump forward 5 seconds
actions.small_forward = function ()
	actions.command(WINAMP_FFWD5S);
end
