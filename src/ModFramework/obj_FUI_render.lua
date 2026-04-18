
---One time script when the game is started
---@param q game_obj_fui_render
---@param v_modid string
function create(q,v_modid)
	--Only needed in the framework setup, is not needed for mods
	Internal = require("ModFrameworkInternal")
end

--- draws on top of everything
---@param q game_obj_fui_render
function draw_gui(q)
	Internal.ComponentShop.ShopDraw()
end

---player won the game
---win_true and win_animation scripts are inside WITH(obj_content_hangar), so q = id of obj_content_hangar
---@param q game_obj_fui_render
function win_true(q)
end

---winning animation after collecting the last part
---@param q game_obj_fui_render
function win_animation(q)
end