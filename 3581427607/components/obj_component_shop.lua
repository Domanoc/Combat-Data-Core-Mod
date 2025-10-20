--The size of the enginering shop items is always 96 pixels (width & height)
local icon_pixel_size = 96;

--Component types
local comp_types = {
	mech = 1,
	cabin = 2,
	motor = 3,
	weapon = 4,
	reactor = 5,
	injector = 6,
	piston = 7,
	kernel = 8,
	safety = 9,
	magnet = 10,
	solenoid = 11,
	armor_layer_middle = 95,
	armor_layer_end = 96,
	rocket = 97,
	beacon = 98,
	city_parts = 99
};

--component sizes
---@class comp_sizes
---@field small 1
---@field large 5
local comp_sizes = {
	small = 1, --1 construction slot
	large = 5  --5 construction slots, a full hanger
}
---@alias ComponentSize 1|5

function create(q)--one time script when save is loaded

	----------------------
	--MECHS---------------
	----------------------
	--NOVA MECH-----------
	----------------------
	local nova_mech_index = variable_global_get("nova_mech_index");
	local nova_component_index = AddMechComponent(nova_mech_index, comp_sizes.large, 0);
	variable_global_set("nova_component_index", nova_component_index);
	----------------------
	--ECHO MECH-----------
	----------------------
	local echo_mech_index = variable_global_get("echo_mech_index");
	local echo_component_index = AddMechComponent(echo_mech_index, comp_sizes.large, 0);
	variable_global_set("echo_component_index", echo_component_index);
	----------------------
	--SENTINEL MECH-------
	----------------------
	local sentinel_mech_index = variable_global_get("sentinel_mech_index");
	local sentinel_component_index = AddMechComponent(sentinel_mech_index, comp_sizes.large, 0);
	variable_global_set("sentinel_component_index", sentinel_component_index);
	----------------------
	--BEHEMOTH MECH-------
	----------------------
	local behemoth_mech_index = variable_global_get("behemoth_mech_index");
	local behemoth_component_index = AddMechComponent(behemoth_mech_index, comp_sizes.large, 0);
	variable_global_set("behemoth_component_index", behemoth_component_index);


	----------------------
	--SOLENOIDS-----------
	----------------------
	--HIGH TECH SOLENOID--
	----------------------
	local high_tech_solenoid_index = variable_global_get("high_tech_solenoid_index");
	local high_tech_solenoid_component_index = AddSolenoidComponent(high_tech_solenoid_index, comp_sizes.large, 0);
	variable_global_set("high_tech_solenoid_component_index", high_tech_solenoid_component_index);


	----------------------
	--WEAPONS-------------
	----------------------
	--HOWITZER------------
	----------------------
	local howitzer_weapon_index = variable_global_get("howitzer_weapon_index");
	local howitzer_component_index = AddWeaponComponent(howitzer_weapon_index, comp_sizes.large, 0);
	variable_global_set("laser_pulse_cannonhowitzer_component_index_component_index", howitzer_component_index);
	----------------------
	--LASER PULSE CANNON--
	----------------------
	local laser_pulse_cannon_weapon_index = variable_global_get("laser_pulse_cannon_weapon_index");
	local laser_pulse_cannon_component_index = AddWeaponComponent(laser_pulse_cannon_weapon_index, comp_sizes.large, 0);
	variable_global_set("laser_pulse_cannon_component_index", laser_pulse_cannon_component_index);

	
end

function update_prices(q)	--update information when item is picked, after example code
end

function done(q, i)	--if component is read. i=number of the hangar to check (from 1 to 10) to check. checking hanger_mass 2d massive. yes, it's misspelled
end

function draw_item_text(q, cut_item_type)	--draw when item is placed on the table to watch its stats
end

---Adds a component of type mech
---@param mech_number number the index of the mech in the database
---@param component_size ComponentSize the size of the component when constructing it. use 1 or 5.
---@param researched 1|0 set to 1 if its pre researched. else leave it 0.
---@return number index the index to the newly created component
function AddMechComponent(mech_number, component_size, researched)
	local obj_component_shop = asset_get_index("obj_component_shop");

	--Copy the array to the working set
	local comp_mech = {};
	comp_mech = obj_component_shop.comp_mech;

	local array_size = #comp_mech;
	local mech_location_x = obj_component_shop.mech_start_x + icon_pixel_size * (array_size % 5);
	local mech_location_y = obj_component_shop.mech_start_y + icon_pixel_size * (array_size // 5);
	local obj_component = asset_get_index("obj_component");

	local component_item_index = array_size + 1;
	local added_mech_component = instance_create_depth(mech_location_x, mech_location_y, -500, obj_component);
	comp_mech[array_size + 1] = added_mech_component;	--lua starts with 1
	added_mech_component.comp_type = comp_types.mech;	--mech
	added_mech_component.comp_data_type = mech_number;	--number in database
	added_mech_component.logo = -4; 					--auto assign based on obj_database info
	added_mech_component.size = component_size;			--number of slots used in construction
	added_mech_component.researched = researched;		--1 for researched or 0 for not	

	--send array back
	obj_component_shop.comp_mech = comp_mech;

	return component_item_index;
end

---Adds a component of type solenoid
---@param solonoid_number number the index of the solonoid in the database
---@param component_size ComponentSize the size of the component when constructing it. use 1 or 5.
---@param researched 1|0 set to 1 if its pre researched. else leave it 0.
---@return number index the index to the newly created component
function AddSolenoidComponent(solonoid_number, component_size, researched)
	local obj_component_shop = asset_get_index("obj_component_shop");

	--Copy the array to the working set
	local comp_solenoid = {};
	comp_solenoid = obj_component_shop.comp_solenoid;

	local row = 2; 		--row 3 as its a 0 based index, solonoids are in row 3 of the reactor box
	local column = 4 	--column 5 as its a 0 based index, solonoids start at column 5 of the reactor box
	local column_offset = column * icon_pixel_size;

	local array_size = #comp_solenoid;
	local solenoid_location_x = obj_component_shop.reactor_start_x + column_offset + icon_pixel_size * array_size;
	local solenoid_location_y = obj_component_shop.reactor_start_y + icon_pixel_size * row;
	local obj_component = asset_get_index("obj_component");

	local component_item_index = array_size + 1;
	local added_solenoid_component = instance_create_depth(solenoid_location_x, solenoid_location_y, -500, obj_component);
	comp_solenoid[array_size + 1] = added_solenoid_component;	--lua starts with 1
	added_solenoid_component.comp_type = comp_types.solenoid;	--solenoid
	added_solenoid_component.comp_data_type = solonoid_number;	--number in database
	added_solenoid_component.logo = -4; 						--auto assign based on obj_database info
	added_solenoid_component.size = component_size;				--number of slots used in construction
	added_solenoid_component.researched = researched;			--1 for researched or 0 for not	

	--send array back
	obj_component_shop.comp_solenoid = comp_solenoid;

	return component_item_index;
end

---Adds a component of type weapon
---@param weapon_number number the index of the mech in the database
---@param component_size ComponentSize the size of the component when constructing it. use 1 or 5.
---@param researched 1|0 set to 1 if its pre researched. else leave it 0.
---@return number index the index to the newly created component
function AddWeaponComponent(weapon_number, component_size, researched)
	local obj_component_shop = asset_get_index("obj_component_shop");

	--Copy the array to the working set
	local comp_wep = {};
	comp_wep = obj_component_shop.comp_wep;

	local array_size = #comp_wep;
	local producible_weapons = array_size - 87;		--number of producible weapons, vanilla is 12 but there are a total of 99 vanilla weapons in comp_wep, so must reduce it.
	local weapon_location_x = obj_component_shop.weapon_start_x + icon_pixel_size * (producible_weapons // 3);
	local weapon_location_y = obj_component_shop.weapon_start_y + icon_pixel_size * (producible_weapons % 3);
	local obj_component = asset_get_index("obj_component");

	local component_item_index = array_size + 1;
	local added_weapon_component = instance_create_depth(weapon_location_x, weapon_location_y, -500, obj_component);
	comp_wep[array_size + 1] = added_weapon_component;		--lua starts with 1
	added_weapon_component.comp_type = comp_types.weapon;		--weapon
	added_weapon_component.comp_data_type = weapon_number;	--number in database
	added_weapon_component.logo = -4; 						--auto assign based on obj_database info
	added_weapon_component.size = component_size;				--number of slots used in construction
	added_weapon_component.researched = researched;			--1 for researched or 0 for not	

	--send array back
	obj_component_shop.comp_wep = comp_wep;

	return component_item_index;
end






--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

---Prints a messagebox with the key and values of the gamemaker struct
---provide the reference id to the table
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference
function dump_struct_to_message(ref)
	local values = {};
    for k, v in pairs(struct_get_names(ref)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ref[v]));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end

--Prints a messagebox with the key and values of the table
--provide the reference id to the table
--The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the reference to the table
function dump_table_to_message(ref)
	local values = {};
    for k, v in pairs(ref) do
        table.insert(values, tostring(k).."::"..tostring(v));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
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