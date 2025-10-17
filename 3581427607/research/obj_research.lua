

function create(q)--one time script when save is loaded
end

function research_done_before(q,res_number)
	--setting res_number to 0 will turn of regular research for all nodes
	--return it back later for a proper work
end;

function research_done(q, res_number)	--if research is done and when loading the game, res_number=number of research in obj_research_panel massive
	
	-----------------
	--NOVA MECH------
	-----------------
	if (res_number == variable_global_get("nova_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local nova_mech_component_index = variable_global_get("nova_component_index");
		local nova_mech_component = component_shop.comp_mech[nova_mech_component_index];
		nova_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then			--gives free mech
			q.give_item = 0;					--0=false
			local obj_content_mechs = asset_get_index("obj_content_mechs");
			local list_mech = {};
			list_mech = obj_content_mechs.list_mech;
			local number_of_items = obj_content_mechs.number_of_items + 1;

			local obj_mech_item = asset_get_index("obj_mech_item");
			list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
			local added_mech = list_mech[number_of_items];
			added_mech.my_num = 		number_of_items - 1;
			added_mech.mech_number = 	variable_global_get("nova_mech_index");
			added_mech.start_x = 		8;
			added_mech.start_y = 		266;
			added_mech.new_module = 	1;

			obj_content_mechs.list_mech = list_mech;
			obj_content_mechs.number_of_items = number_of_items;
		end
	end

	-----------------
	--SENTINEL MECH--
	-----------------
	if (res_number == variable_global_get("sentinel_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local sentinel_mech_component_index = variable_global_get("sentinel_component_index");
		local sentinel_mech_component = component_shop.comp_mech[sentinel_mech_component_index];
		sentinel_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then				--gives free mech
			q.give_item = 0;						--0=false
			local obj_content_mechs = asset_get_index("obj_content_mechs");
			local list_mech = {};
			list_mech = obj_content_mechs.list_mech;
			local number_of_items = obj_content_mechs.number_of_items + 1;

			local obj_mech_item = asset_get_index("obj_mech_item");
			list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
			local added_mech = list_mech[number_of_items];
			added_mech.my_num = 		number_of_items - 1;
			added_mech.mech_number = 	variable_global_get("sentinel_mech_index");
			added_mech.start_x = 		8;
			added_mech.start_y = 		266;
			added_mech.new_module = 	1;

			obj_content_mechs.list_mech = list_mech;
			obj_content_mechs.number_of_items = number_of_items;
		end
	end
	
	-----------------
	--BEHEMOTH MECH--
	-----------------
	if (res_number == variable_global_get("behemoth_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local behemoth_mech_component_index = variable_global_get("behemoth_component_index");
		local behemoth_mech_component = component_shop.comp_mech[behemoth_mech_component_index];
		behemoth_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then				--gives free mech
			q.give_item = 0;						--0=false
			local obj_content_mechs = asset_get_index("obj_content_mechs");
			local list_mech = {};
			list_mech = obj_content_mechs.list_mech;
			local number_of_items = obj_content_mechs.number_of_items + 1;

			local obj_mech_item = asset_get_index("obj_mech_item");
			list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
			local added_mech = list_mech[number_of_items];
			added_mech.my_num = 		number_of_items - 1;
			added_mech.mech_number = 	variable_global_get("behemoth_mech_index");
			added_mech.start_x = 		8;
			added_mech.start_y = 		266;
			added_mech.new_module = 	1;

			obj_content_mechs.list_mech = list_mech;
			obj_content_mechs.number_of_items = number_of_items;
		end
	end

	-----------------
	--ECHO MECH------
	-----------------
	if (res_number == variable_global_get("echo_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local echo_mech_component_index = variable_global_get("echo_component_index");
		local echo_mech_component = component_shop.comp_mech[echo_mech_component_index];
		echo_mech_component.researched = 1;		--1=true, opens weapon for production
		if (q.give_item == true) then			--gives free mech
			q.give_item = 0;					--0=false
			local obj_content_mechs = asset_get_index("obj_content_mechs");
			local list_mech = {};
			list_mech = obj_content_mechs.list_mech;
			local number_of_items = obj_content_mechs.number_of_items + 1;

			local obj_mech_item = asset_get_index("obj_mech_item");
			list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
			local added_mech = list_mech[number_of_items];
			added_mech.my_num = 		number_of_items - 1;
			added_mech.mech_number = 	variable_global_get("echo_mech_index");
			added_mech.start_x = 		8;
			added_mech.start_y = 		266;
			added_mech.new_module = 	1;

			obj_content_mechs.list_mech = list_mech;
			obj_content_mechs.number_of_items = number_of_items;
		end
	end

	----------------------
	--HIGH TECH SOLENOID--
	----------------------
	if (res_number == variable_global_get("high_tech_solenoid_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local high_tech_solenoid_component_index = variable_global_get("high_tech_solenoid_component_index");
		local high_tech_solenoid_component = component_shop.comp_solenoid[high_tech_solenoid_component_index];
		high_tech_solenoid_component.researched = 1;	--1=true, opens weapon for production
		if (q.give_item == true) then					--gives free mech
			q.give_item = 0;							--0=false
			local obj_content_solenoid = asset_get_index("obj_content_solenoid");
			local list_solenoid = {};
			list_solenoid = obj_content_solenoid.list_solenoid;
			local number_of_items = obj_content_solenoid.number_of_items + 1;

			local obj_solenoid_item = asset_get_index("obj_solenoid_item");
			list_solenoid[number_of_items] = instance_create_depth(0, 0, 0, obj_solenoid_item);
			local added_solenoid = list_solenoid[number_of_items];
			added_solenoid.my_num = 			number_of_items - 1;
			added_solenoid.solenoid_number = 	variable_global_get("high_tech_solenoid_index");
			added_solenoid.start_x = 			8;
			added_solenoid.start_y = 			266;
			added_solenoid.new_module = 		1;

			obj_content_solenoid.list_solenoid = list_solenoid;
			obj_content_solenoid.number_of_items = number_of_items;
		end
	end

	------------
	--HOWITZER--
	------------
	if (res_number == variable_global_get("howitzer_research_index")) then
		local component_shop = asset_get_index("obj_component_shop");
		local howitzer_component_index = variable_global_get("howitzer_component_index");
		local howitzer_component = component_shop.comp_wep[howitzer_component_index];
		howitzer_component.researched = 1;	--1=true, opens weapon for production
		if (q.give_item == true) then		--gives free mech
			q.give_item = 0;				--0=false
			local obj_content_weapons = asset_get_index("obj_content_weapons");
			local list_weapon = {};
			list_weapon = obj_content_weapons.list_weapon;
			local number_of_items = obj_content_weapons.number_of_items + 1;

			local obj_weapon_item = asset_get_index("obj_weapon_item");
			list_weapon[number_of_items] = instance_create_depth(0, 0, 0, obj_weapon_item);
			local added_weapon = list_weapon[number_of_items];
			added_weapon.my_num = 			number_of_items - 1;
			added_weapon.weapon_number = 	variable_global_get("howitzer_weapon_index");
			added_weapon.start_x = 			8;
			added_weapon.start_y = 			266;
			added_weapon.new_module = 		1;
			
			obj_content_weapons.list_weapon = list_weapon;
			obj_content_weapons.number_of_items = number_of_items;
		end
	end
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