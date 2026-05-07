------------------------------------------------------------------------------
--- INTERNAL DEBUG FUNCTIONS ------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Debugger.
---@class ModFrameworkInternalDebug
local Debug = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Prints debug text lines next to the cursor.
---
---Used in the draw_gui function of obj_FUI_render.lua
function Debug.DrawDebugCursor()
    local lines = Storage.CursorDebuggerLines
    if (#lines == 0) then
        return
    end
	local mx = window_mouse_get_x()
	local my = window_mouse_get_y()
	local xOffset = 6
	local yOffset = 10
	local row = 1
	local rowHeight = 20

	local xCoord = string.format("%g", mx)
	local yCoord = string.format("%g", my)

	local labelColor = make_colour_rgb(204, 165, 118)
	local valueColor = make_colour_rgb(114, 165, 204)

	draw_set_halign(2)
	draw_set_color(labelColor)
	draw_text_transformed(mx - xOffset, my + yOffset, "x, y", 2, 2, 0)

	draw_set_halign(0)
	draw_set_color(valueColor)
	draw_text_transformed(mx, my + yOffset, xCoord..", "..yCoord, 2, 2, 0)

	for _, line in ipairs(lines) do
		local y = my + yOffset + (rowHeight * row)

		draw_set_halign(2)
		draw_set_color(labelColor)
		draw_text_transformed(mx - xOffset, y, tostring(line.Label), 2, 2, 0)

		draw_set_halign(0)
		draw_set_color(valueColor)
		draw_text_transformed(mx, y, tostring(line.Value), 2, 2, 0)
		row = row + 1
	end

    Storage.CursorDebuggerLines = {}
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL DEBUG ---------------------------------------------------
------------------------------------------------------------------------------

return Debug