local keyboard = libs.keyboard;

--@help Open Explorer
actions.explorer = function ()
	keyboard.stroke("lwin", "e");
end

--@help Open Run Window
actions.run = function ()
	keyboard.stroke("lwin", "r");
end

--@help Minimize all Windows
actions.minimize_all = function ()
	keyboard.stroke("lwin", "m");
end

--@help Minimize Window
actions.minimize = function ()
	keyboard.stroke("lwin", "down");
end

--@help Maximize Window
actions.maximize = function ()
	keyboard.stroke("lwin", "up");
end

--@help Maximize Window to Left
actions.maximize_left = function ()
	keyboard.stroke("lwin", "left");
end

--@help Maximize Window to Right
actions.maximize_right = function ()
	keyboard.stroke("lwin", "right");
end
