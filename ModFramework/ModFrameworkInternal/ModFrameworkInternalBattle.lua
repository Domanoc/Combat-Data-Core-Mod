------------------------------------------------------------------------------
--- INTERNAL BATTLE FUNCTIONS ------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Battle.
---@class ModFrameworkInternalBattle
local Battle = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the internal functions for the Engineering tab.
local Engineering = require("ModFrameworkInternalEngineering")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


---Use in the create function of obj_battle_map.lua
---
---if we add new mod weapons we need to recreate the sound tables
---else we will be hit with an out of range error when the weapon is used
---so we get the stored amount of weapons from the database
---and recreate the 2 sound tables
---@param obj_battle_map game_obj_battle_map the reference to the "obj_battle_map"
function Battle.FixAudioTable(obj_battle_map)
	local obj_database = Common.GetObjDatabase()
	local weaponCount = #obj_database.weapon_stat

	--recreate: main_data_sound
	local mainDataSound = {}
	for i = 1, weaponCount, 1 do
		mainDataSound[i] = {}
		for j = 1, 2, 1 do
			mainDataSound[i][j] = 0.0
		end
	end

	--recreate: weapon_data_sound
	local weaponDataSound = {}
	for i = 1, weaponCount, 1 do
		weaponDataSound[i] = {}
		for j = 1, 4, 1 do
			weaponDataSound[i][j] = 0.0
		end
	end

	--return the new sound tables
	obj_battle_map.main_data_sound = mainDataSound
    obj_battle_map.weapon_data_sound = weaponDataSound
	--We update main_sounds_amount as some mods,
	--use this a a starting point to update the sound table.
	--Amount seems to based on a 0 based index so 1 less that the amount_of_weapons
	obj_battle_map.main_sounds_amount = #mainDataSound - 1
end

---Use in the battle_going_start function of obj_battle_map.lua
---
---Updates the modded weapons with the modded range if applicable
---@param q game_obj_battle_map the battle map reference
function Battle.SetWeaponRange(q)
	for _, mech in ipairs(q.mech_id) do 					--Loop all the mechs
		if(mech ~= -4 and mech ~= 0) then 					--Filter nil values
			for _, weapon in ipairs(mech.mass_gun_id) do 	--loop all the weapons of the mech
				if(weapon ~= -4) then 						--Filter nil values
					Engineering.SetWeaponRange(weapon)
				end
			end
		end
	end
end

------------------------------------------------------------------------------
--- EXPORT INTERNAL BATTLE ---------------------------------------------------
------------------------------------------------------------------------------

return Battle