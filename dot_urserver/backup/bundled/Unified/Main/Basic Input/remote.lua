
dragging = false;

local mouse = libs.mouse;

function update (r)
	--server.update({id = "touch", text = r });
end

actions.down = function ()
	update("down");
end

actions.up = function ()
	update("up");
end

actions.tap = function ()
	update("tap");
	if (dragging) then
		dragging = false;
		mouse.dragend();
		mouse.up();
	else
		mouse.click("left");
	end
end

actions.double = function ()
	update("double");
	mouse.double("left");
end

actions.hold = function ()
	update("hold");
	mouse.down();
	mouse.dragbegin();
	dragging = true;
end

actions.delta = function  (id, x, y)
	update("delta: " .. x .. " " .. y);
	mouse.moveraw(x, y);
end

actions.left = function ()
	mouse.click("left");
end

actions.right = function ()
	mouse.click("right");
end
