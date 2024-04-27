
local mouse = libs.mouse;
local server = libs.server;
local timer = libs.timer;

-- Native Windows Stuff
local bit = require("bit");
local ffi = require("ffi");
ffi.cdef[[
typedef void* HDC;
typedef void* HWND;
typedef unsigned long DWORD;
typedef DWORD COLORREF;
HDC GetDC(HWND hWnd);
COLORREF GetPixel(HDC hdc, int nXPos, int nYPos);
int ReleaseDC(HWND hWnd, HDC hDC);
HWND GetDesktopWindow();
]]

--------------------------------------------------------

local tid = -1;

events.focus = function ()
	tid = timer.interval(function ()
		x1,y1 = mouse.position();
		local dc = ffi.C.GetDC(nil);
		local rgb = ffi.C.GetPixel(dc, x1, y1);
		
		local gg = bit.band(rgb, bit.tobit(0x0000ff00));
		local hex = bit.tohex(
			bit.rol(bit.band(rgb, bit.tobit(0x00ff00ff)), 16)
			+ gg 
			+ bit.tobit(0xff000000)
		);
		
		ffi.C.ReleaseDC(ffi.C.GetDesktopWindow(), dc);
		
		server.update({id = "info", text = "(" .. x1 .. ", " .. y1 .. ") => #" .. hex });
		server.update({id = "color", color = hex });
		
	end, 50);
end

events.blur = function ()
	timer.cancel(tid);
end
