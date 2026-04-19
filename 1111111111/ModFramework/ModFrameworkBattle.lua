--------------------------
--Battle                --
--------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon");

---Access to the functions for the Battle.
local Battle = {};

---Use in the create function of obj_battle_map.lua
---if we add new mod weapons we need to recreate the sound tables
---else we will be hit with an out of range error when the weapon is used
---so we get the stored amount of weapons from the database
---and recreate the 2 sound tables
---@param obj_battle_map game_obj_battle_map the reference to the "obj_battle_map"
function Battle.FixAudioTable(obj_battle_map)
	local obj_database = Common.GetObjDatabase();
	local amount_of_weapons = #obj_database.weapon_stat;

	--recreate: main_data_sound
	local main_data_sound = {};
	for i = 1, amount_of_weapons, 1 do
		main_data_sound[i] = {};
		for j = 1, 2, 1 do
			main_data_sound[i][j] = 0.0;
		end
	end

	--recreate: weapon_data_sound
	local weapon_data_sound = {};
	for i = 1, amount_of_weapons, 1 do
		weapon_data_sound[i] = {};
		for j = 1, 4, 1 do
			weapon_data_sound[i][j] = 0.0;
		end
	end

	--return the new sound tables
	obj_battle_map.main_data_sound = main_data_sound;
    obj_battle_map.weapon_data_sound = weapon_data_sound;
	--We update main_sounds_amount as some mods,
	--use this a a starting point to update the sound table.
	--Amount seems to based on a 0 based index so 1 less that the amount_of_weapons
	obj_battle_map.main_sounds_amount = #main_data_sound - 1;
end

return Battle;