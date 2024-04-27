
local server = libs.server;
local http = libs.http;
local utf8 = libs.utf8;
local timer = libs.timer;
local state = {};
local tid = -1;

function send (parameter)
	local host = server.get("host");
	local port = server.get("port");
	local url = "http://" .. host .. ":" .. port .. "/xbmcCmds/xbmcHttp?command=" .. parameter;
	local ok, resp = pcall(http.get, url);
	if (ok) then
		resp = utf8.replace(resp, "<html>", "");
		resp = utf8.replace(resp, "<li>", "");
		resp = utf8.replace(resp, "</html>", "");
		resp = utf8.replace(resp, "</li>", "");
	else
		resp = nil;
	end
	return resp;
end

function update ()	
	local resp = send("GetCurrentlyPlaying");
	if (resp == nil) then
		state = nil;
		return;
	else
		state = {};
	end
	
	-- Parse state values
	local lines = utf8.split(resp, "\n");
	for i,line in ipairs(lines) do
		local p = utf8.indexof(line, ":");
		if (p > -1) then
			local key = utf8.sub(line, 0, p);
			local value = utf8.sub(line, p+1);
			state[key] = value;
		end
	end
	
	-- Check title
	if (state.Title == nil) then
		if (state.Show ~= nil) then
			state.Title = state.Show;
			if (state.Season ~= nil and state.Episode ~= nil) then
				state.Title = state.Title .. " " .. state.Season .. "x" .. state.Episode;
			end
		elseif (state.Plot ~= nil) then
			state.Title = state.Plot;
		elseif (state.Filename ~= nil) then
			state.Title = state.Filename;
		else
			state.Title = "[Not Playing]";
		end
	end
	
	-- Check volume
	local vol = send("GetVolume");
	vol = utf8.replace(vol, "\n", "");
	vol = tonumber(vol);
	state.Volume = vol;
	
	-- Check position
	local pos = tonumber(state.Percentage);
	
	-- Check playing status
	local icon = "play";
	if (state.PlayStatus == "Playing") then
		icon = "pause";
	end
	
	server.update(
		{ id = "title", text = state.Title },
		{ id = "vol", progress = vol },
		{ id = "play", icon = icon },
		{ id = "pos", progress = pos }
	);
	
	tid = timer.timeout(update, 500);
end

function info ()
	server.update({
		id = "title",
		text = "[Not Connected]"
	},{
		type = "dialog",
		title = "Boxee Connection",
		text = "Boxee Connection", Text = "A connection to Boxee could not be established. " ..
			"We recommend version 0.9.23 for PC or a Boxee Box.\n\n" .. 
			"1. Make sure Boxee is running on your computer or your Boxee Box is powered on.\n\n" .. 
			"2. Enable webserver in Boxee > Settings > Network > Servers. Unified Remote is pre-configured to use port 8800 and no password.\n\n" .. 
			"3. If you are using a Boxee Box you must enter the IP address or hostname in Unified Remote Server Settings > Remotes > Boxee (Web) > Configure.",
		children = { { type = "button", text = "ok" } }
	});
end

events.focus = function ()
	update();
	if (state == nil) then
		info();
	end
end

events.blur = function ()
	timer.cancel(tid);
end

actions.launch = function ()
	if OS_WINDOWS then
		os.start("%programfiles(x86)%/Boxee/BOXEE.exe");
	end
end

--@help Toggle playback state
actions.play_pause = function ()
	send("Pause");
end

--@help Start playback
actions.play = function ()
	if (state.PlayStatus ~= "Playing") then
		actions.play_pause();
	end
end

--@help Pause playback
actions.pause = function ()
	if (state.PlayStatus == "Playing") then
		actions.play_pause();
	end
end

--@help Stop playback
actions.stop = function ()
	send("Stop");
end

--@help Fast forward
actions.forward = function ()
	send("895");
end

--@help Rewind
actions.rewind = function ()
	send("894");
end

--@help Navigate up
actions.up = function ()
	send("SendKey(270)");
end

--@help Navigate down
actions.down = function ()
	send("SendKey(271)");
end

--@help Navigate left
actions.left = function ()
	send("SendKey(272)");
end

--@help Navigate right
actions.right = function ()
	send("SendKey(273)");
end

--@help Select current item
actions.select = function ()
	send("SendKey(256)");
end

--@help Navigate back
actions.back = function ()
	send("SendKey(275)");
end

--@help Leave DVD
actions.dvd_leave = function ()
	send("SendKey(934)");
end

--@help Set volume
--@param volume:number Set volume
actions.volume = function (volume)
	send("SetVolume(" .. volume .. ")");
end

--@help Raise volume
actions.volume_up = function ()
	actions.volume(math.min(state.Volume + 10, 100));
end

--@help Lower volume
actions.volume_down = function ()
	actions.volume(math.max(state.Volume - 10, 0));
end

--@help Set position
--@param position:number Set position
actions.position = function (position)
	send("SeekPercentage(" .. position .. ")");
end

--@help Mute volume
actions.volume_mute = function ()
	send("Mute");
end

--@help Toggle fullscreen
actions.fullscreen = function ()
	send("830");
end

--@help Previous media
actions.previous = function ()
	send("PlayPrev");
end

--@help Next media
actions.next = function ()
	send("PlayNext");
end

