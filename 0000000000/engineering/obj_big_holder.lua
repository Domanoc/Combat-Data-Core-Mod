
---construction table in the engineering menu
---module's id is in "cur_item"
---most submenus are inside obj_small_holder
---@param q any
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");
end

function save_mech(q)	--saves mech blueprint event. uses "data/f_mech_construction_slot"
end

function load_mech(q)	--loads mech blueprint event. uses "data/f_mech_construction_slot"
end

function activate_menu(q)	--inside mouse_check_button_pressed(mb_left)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_mech
function draw_mechs(q,cur_item)
	for _, weapon in ipairs(cur_item.mass_gun_id) do
		if(weapon ~= -4) then --Filter nil values
			Mod.Production.SetWeaponRange(weapon);
		end
	end
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_reactor
function draw_reactors(q,cur_item)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_weapon
function draw_weapons(q,cur_item)
	Mod.Production.SetWeaponRange(cur_item);
end