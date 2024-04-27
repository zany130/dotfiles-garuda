
local keyboard = libs.keyboard;

--@help Lower system volume
actions.volume_down = function()
	keyboard.press("volumedown");
end

--@help Mute system volume
actions.volume_mute = function()
	keyboard.press("volumemute");
end

--@help Raise system volume
actions.volume_up = function()
	keyboard.press("volumeup");
end

--@help Previous track
actions.previous = function()
	keyboard.press("mediaprevious"); 
end

--@help Next track
actions.next = function()
	keyboard.press("medianext");
end

--@help Stop playback
actions.stop = function()
	keyboard.press("mediastop");
end

--@help Toggle playback state
actions.play_pause = function()
	keyboard.press("mediaplaypause");
end
