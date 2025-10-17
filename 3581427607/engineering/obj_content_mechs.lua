

function create(q,v_modid) -- one time script when save is loaded
	--Debug flag is set in "obj_database.lua"
	local debug_spawn_test_mechs = variable_global_get("debug_spawn_test_mechs");	
	if(debug_spawn_test_mechs == false) then
		return
	end

	local v_load = variable_global_get("mech_engineer_load");
	
	-- add in a echo mech on a new save
	if (v_load == false) then
		local list_mech = {};
		list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("echo_mech_index");
		oo_id.mech_name = "EchoTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = list_mech;
		q.number_of_items = v_content;
	end

	-- add in a behemoth mech on a new save
	if (v_load == false) then
		local list_mech = {};
		list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("behemoth_mech_index");
		oo_id.mech_name = "BehemothTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = list_mech;
		q.number_of_items = v_content;
	end

	-- add in a sentinel mech on a new save
	if (v_load == false) then
		local list_mech = {};
		list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("sentinel_mech_index");
		oo_id.mech_name = "SentinelTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = list_mech;
		q.number_of_items = v_content;
	end

	-- add in a nova mech on a new save
	if (v_load == false) then
		local list_mech = {};
		list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("nova_mech_index");
		oo_id.mech_name = "NovaTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = list_mech;
		q.number_of_items = v_content;
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