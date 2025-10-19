

function create(q)--one time script when save is loaded
	--Debug flag is set in "obj_database.lua"
	local debug_spawn_test_weapons = variable_global_get("debug_spawn_test_weapons");	
	if(debug_spawn_test_weapons == false) then
		return
	end
	
	--if the mech_engineer_load is set its not a new game
	local is_loaded_game = variable_global_get("mech_engineer_load");
	if(is_loaded_game == true) then
		return
	end

	--add a howitzer weapon on a new save
	AddWeapon(variable_global_get("howitzer_weapon_index"), false);
	--add a howitzer weapon (huge) on a new save
	AddWeapon(variable_global_get("howitzer_weapon_index"), true);

	--add a exp weapon on a new save
	AddWeapon(variable_global_get("laser_pulse_cannon_weapon_index"), false);
	--add a exp weapon (huge) on a new save
	AddWeapon(variable_global_get("laser_pulse_cannon_weapon_index"), true);
end

function AddWeapon(weapon_number, huge)
	local obj_content_weapons = asset_get_index("obj_content_weapons");

	--Copy the array to the working set
	local list_weapon = {};
	list_weapon = obj_content_weapons.list_weapon;

	local number_of_items = obj_content_weapons.number_of_items + 1;
	local obj_weapon_item = asset_get_index("obj_weapon_item");
	list_weapon[number_of_items] = instance_create_depth(0, 0, 0, obj_weapon_item);
	local added_weapon = list_weapon[number_of_items];
	added_weapon.my_num = 			number_of_items - 1;
	added_weapon.weapon_number = 	weapon_number;
	added_weapon.start_x = 			8;
	added_weapon.start_y = 			266;
	added_weapon.size_huge = 		huge;

	--return new data
	obj_content_weapons.list_weapon = list_weapon;
	obj_content_weapons.number_of_items = number_of_items;
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