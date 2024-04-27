local win = libs.win;
local uia = libs.uia;
local timer = libs.timer;
local utf8 = libs.utf8;
local data = libs.data;

-- Commands
local WM_COMMAND = 0x111;
local CMD_FULLSCREEN = 0x0000495E;
local CMD_PLAY_PAUSE = 0x00004978;
local CMD_STOP = 0x00004979;
local CMD_VOLUME_DOWN = 0x00004980;
local CMD_VOLUME_UP = 0x0000497F;
local CMD_VOLUME_MUTE = 0x00004981;
local CMD_NEXT = 0x0000497B;
local CMD_PREVIOUS = 0x0000497A;

local tid = -1;
local title = "";

function update ()
	local desktop = uia.desktop();
	local wmp = uia.find(desktop, "Now Playing", "children");
	
	local _title = "[Not Playing]";
	
	if (wmp ~= nil) then
		local status = uia.find(wmp, "Status and Command Bar View", "children");
		if (status ~= nil) then
			local status_group = uia.child(status, 0);
			if (status_group) then
				local status_edit = uia.child(status_group, 1);
				if (status_edit) then
					_title = uia.property(status_edit, "name");
					if (_title == "") then
						_title = "[Not Playing]";
					end
				end
			end
		end
	
		local playback = uia.find(wmp, "Playback Controls View", "children");
		if (playback ~= nil) then
			local seeker = uia.find(playback, "Seek", "subtree");
			if (seeker ~= nil) then
				_pos = uia.property(seeker, "valuevalue");
				_pos = utf8.replace(_pos, ",", ".");
				_title = _title .. " - " .. libs.data.sec2span(math.abs(_pos));
			end
		end
		
		-- local volume = uia.find(playback, "Volume", "subtree");
		-- local vol = uia.property(volume, "valuevalue");
	end
	
	if (title ~= _title) then
		title = _title;
		layout.info.text = title;
	end
end

events.focus = function ()
	tid = timer.interval(update, 500);
end

events.blur = function ()
	timer.cancel(tid);
end

--@help Launch Windows Media Player
actions.launch = function()
	os.start("wmplayer.exe");
end

--@help Send command to program
--@param cmd:number
actions.command = function(cmd)
	local hwnd = win.find("WMPlayerApp", "Windows Media Player");
	win.send(hwnd, WM_COMMAND, cmd, 0);
end

--@help Toggle fullscreen
actions.fullscreen = function()
	actions.command(CMD_FULLSCREEN);
end

--@help Mute volume
actions.volume_mute = function()
	actions.command(CMD_VOLUME_MUTE);
end

--@help Lower volume
actions.volume_down = function()
	actions.command(CMD_VOLUME_DOWN);
end

--@help Raise volume
actions.volume_up = function()
	actions.command(CMD_VOLUME_UP);
end

--@help Previous track
actions.previous = function()
	actions.command(CMD_PREVIOUS);
end

--@help Next track
actions.next = function()
	actions.command(CMD_NEXT);
end

--@help Stop playback
actions.stop = function()
	actions.command(CMD_STOP);
end

--@help Toggle play/pause
actions.play_pause = function()
	actions.command(CMD_PLAY_PAUSE);
end

