

function create(q,v_modid)
	--if we add new mod weapons we need to recreate the sound tables
	--else we will be hit with an out of range error when the weapon is used
	--so we get the stored amount of weapons from the database
	--and recreate the 2 sound tables
	local obj_database = asset_get_index("obj_database");
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
	q.main_data_sound = main_data_sound;
    q.weapon_data_sound = weapon_data_sound;
end

function battle_end()
end

function battle_logic()
end

function battle_going_start(q)	--starts before map creation
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

function battle_end_scout_win(q)	--when battle ends, mechs wiin. for regular scout maps
end

function battle_end(q)
end

function battle_retreat(q)
end

function draw(q)
end

function draw_end(q)
end






--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

--Prints a messagebox with the key and values of the table
--provide the reference id to the table
--The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
function dump_struct_to_message(id)
	local values = {};
    for k, v in pairs(struct_get_names(id)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(id[v]));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end

--Prints a messagebox with the key and values of the table
--provide the reference id to the table
--The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
function dump_table_to_message(id)
	local values = {};
    for k, v in pairs(id) do
        table.insert(values, tostring(k).."::"..tostring(v));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end

--Prints a messagebox with the key and values of the ds_map
--provide the reference id to the ds_map
--The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
function dump_ds_map_to_message(id)
	local values = {};
    for k, v in pairs(ds_map_keys_to_array(id)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(id, v)));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end