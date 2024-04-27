
local win = libs.win;

-- Commands
local WM_COMMAND = 33768;
local MCC_PLAY = 10001;
local MCC_VOLUME_UP = 10018;
local MCC_VOLUME_DOWN = 10019;
local MCC_VOLUME_MUTE = 10017;
local MCC_THEATER_VIEW = 22001;
local MCC_HOME = 22020;
local MCC_PLAY_PAUSE = 10000;
local MCC_STOP = 10002;
local MCC_FAST_FORWARD = 10008;
local MCC_REWIND = 10009;
local MCC_NEXT = 10003;
local MCC_PREVIOUS = 10004;
local MCC_SET_PAUSE = 10022;

events.detect = function ()
	return 
		libs.fs.exists("C:\\Program Files (x86)\\J River") or
		libs.fs.exists("C:\\Program Files\\J River");
end

--@help Send raw command to J River
--@param cmd:number
--@param param:number
actions.command = function (cmd, param)
	local hwnd = win.find("MJFrame", nil);
	win.send(hwnd, WM_COMMAND, cmd, param);
end

--@help Start playback
actions.play = function()
	actions.command(MCC_PLAY, 0);
end

--@help Pause playback
actions.pause = function()
	actions.command(MCC_SET_PAUSE, 1);
end

--@help Toggle playback state
actions.play_pause = function()
	actions.command(MCC_PLAY_PAUSE, 0);
end

--@help Previous track
actions.previous = function()
	actions.command(MCC_PREVIOUS, 0);
end

--@help Next track
actions.next = function()
	actions.command(MCC_NEXT, 0);
end

--@help Seek backward
actions.rewind = function()
	actions.command(MCC_REWIND, 0);
end

--@help Seek forward
actions.forward = function()
	actions.command(MCC_FAST_FORWARD, 0);
end

--@help Navigate home
actions.home = function()
	actions.command(MCC_HOME, 0);
end

--@help Toggle fullscreen
actions.fullscreen = function()
	actions.command(MCC_THEATER_VIEW, 0);
end

--@help Stop playback
actions.stop = function()
	actions.command(MCC_STOP, 0);
end

--@help Raise volume
actions.volume_up = function()
	actions.command(MCC_VOLUME_UP, 5);
end

--@help Lower volume
actions.volume_down = function()
	actions.command(MCC_VOLUME_DOWN, 5);
end

