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

-- construction table in the engineering menu
-- module's id is in "cur_item"
-- most submenus are inside obj_small_holder

function create(q,v_modid)--one time script when save is loaded
end

function save_mech(q)	--saves mech blueprint event. uses "data/f_mech_construction_slot"
end

function load_mech(q)	--loads mech blueprint event. uses "data/f_mech_construction_slot"
end

function activate_menu(q)	--inside mouse_check_button_pressed(mb_left)
end


function draw_mechs(q,cur_item)		--draws buttons and some info, cur_item contains id of the installed module
	--since we cant modify the range of laser weapons during the creation we need to update it when its used
	if (cur_item ~= -4) then
		if(cur_item.weapon_number == variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index")) then
			cur_item.blue_length = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_range");
		end
	end
end

function draw_reactors(q,cur_item)		--draws buttons and some info, cur_item contains id of the installed module
end

function draw_weapons(q,cur_item)		--draws buttons and some info, cur_item contains id of the installed module
	--since we cant modify the range of laser weapons during the creation we need to update it when its used
	if (cur_item ~= -4) then
		if(cur_item.weapon_number == variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index")) then
			cur_item.blue_length = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_range");
		end
	end
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