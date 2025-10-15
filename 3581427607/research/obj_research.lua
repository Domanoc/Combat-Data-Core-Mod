--[[
Growable structure and array for LUA scripts to use within the current object
st_lua=
{
	a_st:10
};
array_lua[0]=5;
array_lua[1]=9;
]]

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
	if (res_number == variable_global_get("nova_res_num")) then
		local v_shop = asset_get_index("obj_component_shop");
		local v_item_loc = variable_global_get("nova_comp_num");
		local v_item = v_shop.comp_mech[v_item_loc];
		v_item.researched = 1;			--1=true, opens weapon for production
		if (q.give_item==true) then		--gives free mech
			q.give_item=0;				--0=false
			local v_content_mechs = asset_get_index("obj_content_mechs");
			local v_list_mech = {};
			v_list_mech = v_content_mechs.list_mech;
			local v_content = v_content_mechs.number_of_items + 1;

			local v_index = asset_get_index("obj_mech_item");
			v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
			local oo_id = v_list_mech[v_content];
			oo_id.my_num = v_content - 1;
			oo_id.mech_number = variable_global_get("nova_mech_num");
			oo_id.start_x = 8;
			oo_id.start_y = 266;
			oo_id.new_module = 1;

			v_content_mechs.list_mech = v_list_mech;
			v_content_mechs.number_of_items = v_content;
		end
	end

	-----------------
	--SENTINEL MECH--
	-----------------
	if (res_number == variable_global_get("sentinel_res_num")) then
		local v_shop = asset_get_index("obj_component_shop");
		local v_item_loc = variable_global_get("sentinel_comp_num");
		local v_item = v_shop.comp_mech[v_item_loc];
		v_item.researched = 1;			--1=true, opens weapon for production
		if (q.give_item==true) then		--gives free mech
			q.give_item=0;				--0=false
			local v_content_mechs = asset_get_index("obj_content_mechs");
			local v_list_mech = {};
			v_list_mech = v_content_mechs.list_mech;
			local v_content = v_content_mechs.number_of_items + 1;

			local v_index = asset_get_index("obj_mech_item");
			v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
			local oo_id = v_list_mech[v_content];
			oo_id.my_num = v_content - 1;
			oo_id.mech_number = variable_global_get("sentinel_mech_num");
			oo_id.start_x = 8;
			oo_id.start_y = 266;
			oo_id.new_module = 1;

			v_content_mechs.list_mech = v_list_mech;
			v_content_mechs.number_of_items = v_content;
		end
	end
	
	-----------------
	--BEHEMOTH MECH--
	-----------------
	if (res_number == variable_global_get("behemoth_res_num")) then
		local v_shop = asset_get_index("obj_component_shop");
		local v_item_loc = variable_global_get("behemoth_comp_num");
		local v_item = v_shop.comp_mech[v_item_loc];
		v_item.researched = 1;			--1=true, opens weapon for production
		if (q.give_item==true) then		--gives free mech
			q.give_item=0;				--0=false
			local v_content_mechs = asset_get_index("obj_content_mechs");
			local v_list_mech = {};
			v_list_mech = v_content_mechs.list_mech;
			local v_content = v_content_mechs.number_of_items + 1;

			local v_index = asset_get_index("obj_mech_item");
			v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
			local oo_id = v_list_mech[v_content];
			oo_id.my_num = v_content - 1;
			oo_id.mech_number = variable_global_get("behemoth_mech_num");
			oo_id.start_x = 8;
			oo_id.start_y = 266;
			oo_id.new_module = 1;

			v_content_mechs.list_mech = v_list_mech;
			v_content_mechs.number_of_items = v_content;
		end
	end

	-----------------
	--ECHO MECH------
	-----------------
	if (res_number == variable_global_get("echo_res_num")) then
		local v_shop = asset_get_index("obj_component_shop");
		local v_item_loc = variable_global_get("echo_comp_num");
		local v_item = v_shop.comp_mech[v_item_loc];
		v_item.researched = 1;			--1=true, opens weapon for production
		if (q.give_item==true) then		--gives free mech
			q.give_item=0;				--0=false
			local v_content_mechs = asset_get_index("obj_content_mechs");
			local v_list_mech = {};
			v_list_mech = v_content_mechs.list_mech;
			local v_content = v_content_mechs.number_of_items + 1;

			local v_index = asset_get_index("obj_mech_item");
			v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
			local oo_id = v_list_mech[v_content];
			oo_id.my_num = v_content - 1;
			oo_id.mech_number = variable_global_get("echo_mech_num");
			oo_id.start_x = 8;
			oo_id.start_y = 266;
			oo_id.new_module = 1;

			v_content_mechs.list_mech = v_list_mech;
			v_content_mechs.number_of_items = v_content;
		end
	end

	----------------------
	--HIGH TECH SOLENOID--
	----------------------
	if (res_number == variable_global_get("high_tech_solenoid_res_num")) then
		local v_shop = asset_get_index("obj_component_shop");
		local v_item_loc = variable_global_get("high_tech_solenoid_comp_num");
		local v_item = v_shop.comp_solenoid[v_item_loc];
		v_item.researched = 1;			--1=true, opens weapon for production
		if (q.give_item==true) then		--gives free mech
			q.give_item=0;				--0=false
			local v_content_solenoids = asset_get_index("obj_content_solenoid");
			local v_list_solenoid = {};
			v_list_solenoid = v_content_solenoids.list_solenoid;
			local v_content = v_content_solenoids.number_of_items + 1;

			local v_index = asset_get_index("obj_solenoid_item");
			v_list_solenoid[v_content] = instance_create_depth(0,0,0,v_index);
			local oo_id = v_list_solenoid[v_content];
			oo_id.my_num = v_content - 1;
			oo_id.solenoid_number = variable_global_get("high_tech_solenoid_num");
			oo_id.start_x = 8;
			oo_id.start_y = 266;
			oo_id.new_module = 1;

			v_content_solenoids.list_solenoid = v_list_solenoid;
			v_content_solenoids.number_of_items = v_content;
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
	--dump_table_to_message(ds_map_keys_to_array(id));
	--show_message(tostring(ds_map_find_value(map, "price_staff")));
	local values = {};
    for k, v in pairs(ds_map_keys_to_array(id)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(id, v)));
    end
    local message = table.concat(values, ",\n");
	show_message(message);
end