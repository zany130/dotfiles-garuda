local keyboard = libs.keyboard;

events.detect = function ()
	return libs.fs.exists("C:\\Windows\\ehome");
end

--@help Launch WMC application
actions.launch = function()
	os.start("%windir%\\ehome\\ehshell.exe");
end

--@help Lower volume
actions.volume_down = function()
	keyboard.stroke("F9");
end

--@help Mute volume
actions.volume_mute = function()
	keyboard.stroke("F8");
end

--@help Raise volume
actions.volume_up = function()
	keyboard.stroke("F10");
end

--@help Pause playback
actions.pause = function()
	keyboard.stroke("control", "P");
end

--@help Navigate up
actions.up = function()
	keyboard.stroke("up");
end

--@help Start playback
actions.play = function()
	keyboard.stroke("control", "shift", "P");
end

--@help Navigate left
actions.left = function()
	keyboard.stroke("left");
end

--@help Select current item
actions.select = function()
	keyboard.stroke("return");
end

--@help Navigate right
actions.right = function()
	keyboard.stroke("right");
end

--@help Stop playback
actions.stop = function()
	keyboard.stroke("control", "shift", "S");
end

--@help Navigate down
actions.down = function()
	keyboard.stroke("down");
end

--@help Navigate back
actions.back = function()
	keyboard.stroke("back");
end

--@help Previous item
actions.previous = function()
	keyboard.stroke("control", "B");
end

--@help Go home
actions.windows = function()
	keyboard.stroke("Lwin", "Lmenu", "return");
end

--@help Record
actions.record = function ()
	keyboard.stroke("control", "R");
end

--@help Next item
actions.next = function()
	keyboard.stroke("control", "F");
end

--@help Previous channel
actions.previous_channel = function ()
	keyboard.stroke("prior");
end

--@help Next channel
actions.next_channel = function ()
	keyboard.stroke("next");
end
