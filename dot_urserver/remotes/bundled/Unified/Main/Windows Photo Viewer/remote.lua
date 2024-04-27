local keyboard = libs.keyboard;

--@help Start slide show
actions.show_start = function()
	keyboard.stroke("F11");
end

--@help Rotate photo counter-clockwise
actions.rotate_left = function()
	keyboard.stroke("control", "oem_period");
end

--@help Rotate photo clockwise
actions.rotate_right = function()
	keyboard.stroke("control", "oem_comma");
end

--@help Zoom out
actions.zoom_out = function()
	keyboard.stroke("oem_minus");
end

--@help Zoom in
actions.zoom_in = function()
	keyboard.stroke("oem_plus");
end

--@help End slide show
actions.show_end = function()
	keyboard.stroke("escape");
end

--@help Previous photo
actions.previous = function()
	keyboard.stroke("left");
end

--@help Next photo
actions.next = function()
	keyboard.stroke("right");
end

