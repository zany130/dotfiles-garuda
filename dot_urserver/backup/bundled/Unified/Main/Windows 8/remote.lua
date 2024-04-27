local keyboard = libs.keyboard;

--@help Navigate left
actions.left = function()
	keyboard.stroke("left");
end

--@help Navigate right
actions.right = function()
	keyboard.stroke("right");
end

--@help Navigate up
actions.up = function()
	keyboard.stroke("up");
end

--@help Navigate down
actions.down = function()
	keyboard.stroke("down");
end

--@help Select current item
actions.select = function()
	keyboard.stroke("return");
end

--@help Show start screen
actions.windows = function()
	keyboard.stroke("Lwin");
end

--@help Show apps
actions.apps = function()
	keyboard.stroke("Lwin", "Q");
end

--@help Show charms
actions.charms = function()
	keyboard.stroke("Lwin", "C");
end

--@help Snap app to left
actions.snap_left = function()
	keyboard.stroke("Lwin", "Lshift", "oem_period");
end

--@help Snap app to right
actions.snap_right = function()
	keyboard.stroke("Lwin", "oem_period");
end

--@help Open explorer
actions.explorer = function()
	keyboard.stroke("Lwin", "E");
end

--@help Navigate back
actions.back = function()
	keyboard.stroke("back");
end

--@help Open run
actions.run = function()
	keyboard.stroke("Lwin", "R");
end

--@help Zoom in
actions.zoom_in = function()
	keyboard.stroke("Lwin", "oem_plus");
end

--@help Zoom out
actions.zoom_out = function()
	keyboard.stroke("Lwin", "oem_minus");
end

