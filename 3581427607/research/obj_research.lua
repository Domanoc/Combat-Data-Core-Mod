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

--We keep a list of all the researches the game has active. so we can check and update them later.
local research_list = {};

function create(q)--one time script when save is loaded
	--While q currently holds only default values we only need to store the reference for later.
	table.insert(research_list, q);
	variable_global_set(unique_mod_prefix.."loaded_research_list", research_list);
end

function research_done_before(q,res_number)
	--setting res_number to 0 will turn of regular research for all nodes
	--return it back later for a proper work
end;

function research_done(q, res_number)	--if research is done and when loading the game, res_number=number of research in obj_research_panel massive
	-----------------
	--NOVA MECH------
	-----------------
	if (res_number == variable_global_get(unique_mod_prefix.."nova_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local nova_mech_component_index = variable_global_get(unique_mod_prefix.."nova_component_index");
		local nova_mech_component = component_shop.comp_mech[nova_mech_component_index];
		nova_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then			--gives free mech
			q.give_item = 0;					--0=false
			AddMech(variable_global_get(unique_mod_prefix.."nova_mech_index"));
		end
	end

	-----------------
	--SENTINEL MECH--
	-----------------
	if (res_number == variable_global_get(unique_mod_prefix.."sentinel_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local sentinel_mech_component_index = variable_global_get(unique_mod_prefix.."sentinel_component_index");
		local sentinel_mech_component = component_shop.comp_mech[sentinel_mech_component_index];
		sentinel_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then				--gives free mech
			q.give_item = 0;						--0=false
			AddMech(variable_global_get(unique_mod_prefix.."sentinel_mech_index"));
		end
	end
	
	-----------------
	--BEHEMOTH MECH--
	-----------------
	if (res_number == variable_global_get(unique_mod_prefix.."behemoth_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local behemoth_mech_component_index = variable_global_get(unique_mod_prefix.."behemoth_component_index");
		local behemoth_mech_component = component_shop.comp_mech[behemoth_mech_component_index];
		behemoth_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then				--gives free mech
			q.give_item = 0;						--0=false
			AddMech(variable_global_get(unique_mod_prefix.."behemoth_mech_index"));
		end
	end

	-----------------
	--ECHO MECH------
	-----------------
	if (res_number == variable_global_get(unique_mod_prefix.."echo_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local echo_mech_component_index = variable_global_get(unique_mod_prefix.."echo_component_index");
		local echo_mech_component = component_shop.comp_mech[echo_mech_component_index];
		echo_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then			--gives free mech
			q.give_item = 0;					--0=false
			AddMech(variable_global_get(unique_mod_prefix.."echo_mech_index"));
		end
	end

	----------------------
	--HIGH TECH SOLENOID--
	----------------------
	if (res_number == variable_global_get(unique_mod_prefix.."high_tech_solenoid_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local high_tech_solenoid_component_index = variable_global_get(unique_mod_prefix.."high_tech_solenoid_component_index");
		local high_tech_solenoid_component = component_shop.comp_solenoid[high_tech_solenoid_component_index];
		high_tech_solenoid_component.researched = 1;	--1=true, opens weapon for production
		if (q.give_item == true) then					--gives free solenoid
			q.give_item = 0;							--0=false
			AddSolenoid(variable_global_get(unique_mod_prefix.."high_tech_solenoid_index"));
		end
	end

	------------
	--HOWITZER--
	------------
	if (res_number == variable_global_get(unique_mod_prefix.."howitzer_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local howitzer_component_index = variable_global_get(unique_mod_prefix.."howitzer_component_index");
		local howitzer_component = component_shop.comp_wep[howitzer_component_index];
		howitzer_component.researched = 1;	--1=true, opens weapon for production
		if (q.give_item == true) then		--gives free weapon
			q.give_item = 0;				--0=false
			AddWeapon(variable_global_get(unique_mod_prefix.."howitzer_weapon_index"));
		end
	end

	----------------------
	--LASER PULSE CANNON--
	----------------------
	if (res_number == variable_global_get(unique_mod_prefix.."laser_pulse_cannon_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local laser_pulse_cannon_component_index = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_component_index");
		local laser_pulse_cannon_component = component_shop.comp_wep[laser_pulse_cannon_component_index];
		laser_pulse_cannon_component.researched = 1;	--1=true, opens weapon for production
		if (q.give_item == true) then					--gives free weapon
			q.give_item = 0;							--0=false
			AddWeapon(variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index"));
		end
	end
end

---Adds a component of type mech
---@param mech_number number the index of the mech in the database.
function AddMech(mech_number)
	local obj_content_mechs = asset_get_index("obj_content_mechs");
	local list_mech = {};
	list_mech = obj_content_mechs.list_mech;
	local number_of_items = obj_content_mechs.number_of_items + 1;

	local obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	local added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	mech_number;
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	1;

	obj_content_mechs.list_mech = list_mech;
	obj_content_mechs.number_of_items = number_of_items;
end

---Adds a component of type solenoid
---@param solenoid_number number the index of the solenoid in the database.
function AddSolenoid(solenoid_number)
	local obj_content_solenoid = asset_get_index("obj_content_solenoid");
	local list_solenoid = {};
	list_solenoid = obj_content_solenoid.list_solenoid;
	local number_of_items = obj_content_solenoid.number_of_items + 1;

	local obj_solenoid_item = asset_get_index("obj_solenoid_item");
	list_solenoid[number_of_items] = instance_create_depth(0, 0, 0, obj_solenoid_item);
	local added_solenoid = list_solenoid[number_of_items];
	added_solenoid.my_num = 			number_of_items - 1;
	added_solenoid.solenoid_number = 	solenoid_number;
	added_solenoid.start_x = 			8;
	added_solenoid.start_y = 			266;
	added_solenoid.new_module = 		1;

	obj_content_solenoid.list_solenoid = list_solenoid;
	obj_content_solenoid.number_of_items = number_of_items;
end

---Adds a component of type weapon
---@param weapon_number number the index of the weapon in the database.
function AddWeapon(weapon_number)
	local obj_content_weapons = asset_get_index("obj_content_weapons");
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
	added_weapon.new_module = 		1;
	
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