
---Gets the ModFramework.
---Makes sure the require exception is handled is the framework cant be found.
---
---When the framework cant be found, a message is shown and then the game is close by forcing an error. This to prevent error message spam.
---@return ModFramework
function GetModFramework()
	local isLoaded = variable_global_get("IsModFrameworkLoaded")
    local ok, mod = pcall(require, "ModFramework")
    if (not ok or isLoaded ~= true) then
        local spacerLine = "\n###################################################\n"
		local info = debug.getinfo(2, "Sl")
		local caller = info.short_src:gsub("/","\\")
		local callerPrint = "Called from: " ..caller.." line: "..info.currentline
		local prefix = "MOD FRAMEWORK ERROR"..spacerLine
		local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
		local message = "Cannot find the ModFramework!!\n"
		message = message.."The ModFramework should be the first in the mod load order, please check and correct the mod load order."
		message = message..spacerLine.."The mod will now purposefully make the game crash to prevent error message spam."
		show_message(prefix..message..suffix)

		--We force the game to crash
		--if not the game will spam messages for every call it can make
		sprite_merge(-999, -999)
    end
    return mod
end

---One time script when the game is started
---construction table in the engineering menu
---module's id is in "cur_item"
---most submenus are inside obj_small_holder
---@param q game_obj_big_holder
---@param v_modid string
function create(q,v_modid)--one time script when save is loaded
end

---saves mech blueprint event. uses "data/f_mech_construction_slot"
---@param q any
function save_mech(q)
end

---loads mech blueprint event. uses "data/f_mech_construction_slot"
---@param q any
function load_mech(q)
end

---Triggers when the left mouse button is pressed
---@param q any
function activate_menu(q)
end

---draws buttons and some info
---@param q game_obj_big_holder
---@param cur_item game_obj_big_holder_mech
function draw_mechs(q,cur_item)
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
end