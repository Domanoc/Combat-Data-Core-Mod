
---One time script when the game is started
---@param q game_obj_battle_map
---@param v_modid string
function create(q,v_modid)
	--load the mod framework as a global for use within this file
	Mod = require("ModFrameworkModule");

	Mod.Battle.FixAudioTable(q);
end

function battle_end()
end

function battle_logic()
end

---run while the battle is active
---@param q any
function battle_going_start(q)	--starts before map creation
	for _, mech in ipairs(q.mech_id) do 					--Loop all the mechs
		if(mech ~= -4 and mech ~= 0) then 					--Filter nil values
			for _, weapon in ipairs(mech.mass_gun_id) do 	--loop all the weapons of the mech
				if(weapon ~= -4) then 						--Filter nil values
					Mod.Production.SetWeaponRange(weapon);
				end
			end
		end
	end
end

function map_progression(q)	--an alarm that activates if mechs are inside the extraction zone
end

function creating_map_start(q)	--one time trigger before the battle start
end

function creating_phy_mechs(q,q_pm,q_om)	--q_pm = obj_ally(mech in the battle),   q_om = obj_mech_item(mech card, contains IDs of all components and settings)
end

function creating_map_middle(q)
end

function drawing_surf_gen_map(q)
end

function creating_map_end(q)	--one time trigger before the battle
end

function battle_going_end(q)	--starts after map creation
end

function battle_logic(q)
end

function battle_end_scout_mechs_dead(q)	--when battle ends, mechs dead. for regular scout maps
end

function battle_end_scout_win(q)	--when battle ends, mechs win. for regular scout maps
end

function battle_end(q)
end

function battle_retreat(q)
end

function draw(q)
end

function draw_end(q)
end