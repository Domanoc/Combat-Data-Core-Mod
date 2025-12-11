--------------------------------------------
--Documentation for used mod functions -----
--------------------------------------------
---@alias ds_map userdata

---This function is used to create a new, empty DS map and will return a Handle to it which is then used to access the data structure in all other DS map functions.
---@type fun(): ds_map
ds_map_create = ds_map_create;
---This function should be used to add sets of key/value pairs into the specified DS map.
---@type fun(map: ds_map, key: string, value: any)
ds_map_add = ds_map_add;
---With this function you can retrieve all of the keys that a DS map contains.
---@type fun(id: ds_map) : table
ds_map_keys_to_array = ds_map_keys_to_array;
---With this function you can get the value from a specified key.
---@type fun(id: ds_map, key: string) : any|nil
ds_map_find_value = ds_map_find_value;
---This function returns an array with the variable names from a struct.
---@type fun(id: table) : table
struct_get_names = struct_get_names;
---With this function you can set the value of a given global variable.
---@type fun(key: string, value: any)
variable_global_set = variable_global_set;
---With this function you can get the value from a given named global variable
---@type fun(key: string): value: any
variable_global_get = variable_global_get;
---This function will add an image as a sprite
---@type fun(filepath: string, number_of_images: number, removeback: boolean, smooth: boolean, xorig: number, yorig: number): value: number
sprite_add = sprite_add;
---This function will merge the sprite indexed in argument 1 ("ind2") with that which is indexed in argument 0 ("ind1").
---@type fun(ind1: number, ind2: number)
sprite_merge = sprite_merge;
---This function gets the unique identifying index for a game asset from its name.
---@type fun(name: string): any
asset_get_index = asset_get_index;
---This function creates a pop-up message box which displays the given string and a button marked "Ok" to close it.
---@type fun(message: string)
show_message = show_message;
--------------------------------------------
--------------------------------------------

--To prevent collisions of global variables between mods.
--I have prefixed global variables of this mod.
--If copying code please change the prefix to something unique for your mod.
local unique_mod_prefix = "CDC_";


function create(q)--one time script when save is loaded
	--Debug flag is set in "obj_database.lua"
	local debug_spawn_test_weapons = variable_global_get(unique_mod_prefix.."debug_spawn_test_weapons");	
	if(debug_spawn_test_weapons == false) then
		return
	end
	
	--if the mech_engineer_load is set its not a new game
	local is_loaded_game = variable_global_get("mech_engineer_load"); --this is a game variable so no prefix
	if(is_loaded_game == true) then
		return
	end

	--add a howitzer weapon on a new save
	AddWeapon(variable_global_get(unique_mod_prefix.."howitzer_weapon_index"), false);
	--add a howitzer weapon (huge) on a new save
	AddWeapon(variable_global_get(unique_mod_prefix.."howitzer_weapon_index"), true);

	--add a laser pulse cannon weapon on a new save
	AddWeapon(variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index"), false);
	--add a laser pulse cannon weapon (huge) on a new save
	AddWeapon(variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index"), true);
end

---Adds a component of type weapon
---@param weapon_number number the index of the weapon in the database.
---@param huge boolean if the weapon is huge/+sized or not.
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

---Prints a messagebox with the key and values of the gamemaker struct or table
---provide the reference id to the table
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference or table reference
function dump_obj_to_message(ref)
	if(type(ref) == "table") then
		local values = {};
		for k, v in pairs(ref) do
			table.insert(values, tostring(k).."::"..tostring(v));
		end
		local message = table.concat(values, ",\n");
		show_message(message);
	else
		local values = {};
		for k, v in pairs(struct_get_names(ref)) do
			table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ref[v]));
		end
		local message = table.concat(values, ",\n");
		show_message(message);
	end
end

--Prints a messagebox with the key and values of the gamemaker ds_map
--provide the reference id to the ds_map
--The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the reference to the ds_map
function dump_ds_map_to_message(ref)
	local values = {};
    for k, v in pairs(ds_map_keys_to_array(ref)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(ref, v)));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end