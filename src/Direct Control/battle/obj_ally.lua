
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

---Triggers per mech that is created in battle
---@param q game_obj_ally_ext
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = GetModFramework()

	local obj_battle_map = Mod.Common.GetObjBattleMap()
	---@cast obj_battle_map game_obj_battle_map_ext

	local newAllies = obj_battle_map.Allies
	table.insert(newAllies, q)
	obj_battle_map.Allies = newAllies

	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	--Set the default selection to false
	q.selected = false

	--Setting the defaults for the modded fields
	q.IsControlled = false
	q.IsShooting = false
	q.DesiredSquadPosX = nil
	q.DesiredSquadPosY = nil
	q.RedAmmoStillLoaded = 0
	q.WhiteAmmoStillLoaded = 0
	q.YellowAmmoStillLoaded = 0
end

---Triggers per mech per frame even when the battle is paused
---@param q game_obj_ally_ext
function step_before_ai(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	q.selected = q.IsControlled
	if (q.IsControlled == false) then
		if (q.DesiredSquadPosX ~= nil and q.DesiredSquadPosY ~= nil) then
			q.finish_x = q.DesiredSquadPosX
			q.finish_y = q.DesiredSquadPosY
		end
		return
	end
	--We set swallowed to disable the default mech ai
	q.swallowed = true;

	DirectControlShooting(q)
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after step_before_ai
---if not overheated and not time x2, after command set, before behavior. if battle not on pause
---@param q game_obj_ally_ext
function command(q)
	--[[
	command=""; will turn off regular AI
	states: avoid,move,wait,defence
	]]
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after command
---Bullet creation script
---@param q game_obj_ally_ext
function shoot(q)
	--dist_to_en>16 and shoot_in_melee>= 61 will turn off bullet creation
end

---Triggers per mech per frame even when the battle is paused
---Triggers after shoot
---@param q game_obj_ally_ext
function step_after_ai(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	q.selected = q.IsControlled
	if (q.IsControlled == false) then
		return
	end

	--We reset swallowed to allow the normal actions to continue
	q.swallowed = false;
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after step_after_ai
---end_step after rotation code, if battle not on pause
---@param q game_obj_ally_ext
function rotation(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	if (q.IsControlled == false) then
		return
	end
	local v_mouse_x = window_view_mouse_get_x(2);
	local v_mouse_y = window_view_mouse_get_y(2);
	q.mirror_dir = point_direction(q.x, q.y, v_mouse_x, v_mouse_y);
end

---Triggers per mech per frame when the battle is unpaused
---Triggers after rotation
---@param q game_obj_ally_ext
function draw(q)
	if (Mod.Settings.GetBooleanSettingValue("DirectControl") == false) then
		--Mod is disabled
		return
	end

	q.selected = q.IsControlled
end


------------------------------------------------------------------------------
--- MOD FUNCTIONS ------------------------------------------------------------
------------------------------------------------------------------------------

---Handles the shooting for direct controlled mechs
---@param mech game_obj_ally_ext
function DirectControlShooting(mech)
	if (mech.IsShooting == false) then
		return
	end

	local v_obj_battle_map_id = Mod.Common.GetObjBattleMap()
	if (v_obj_battle_map_id.fullscreen_battle == true) then
		lua_create_bullet()
		return
	end

	--Check if the camera is in the battle port window
	local mx = window_views_mouse_get_x()
	local my = window_views_mouse_get_y()
	local battlePortCenterX = 604 * 2
	local battlePortCenterY = 318 * 2
	local portCenterDistance = point_distance(battlePortCenterX, battlePortCenterY, mx, my)
	local maxDistance = 430
	if (portCenterDistance < maxDistance) then
		lua_create_bullet();
	end
end