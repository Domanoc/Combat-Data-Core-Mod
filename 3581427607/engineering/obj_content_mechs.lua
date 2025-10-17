

function create(q,v_modid) -- one time script when save is loaded
	--Debug flag is set in "obj_database.lua"
	local debug_spawn_test_mechs = variable_global_get("debug_spawn_test_mechs");	
	if(debug_spawn_test_mechs == false) then
		return
	end

	--if the mech_engineer_load is set its not a new game
	local is_loaded_game = variable_global_get("mech_engineer_load");
	if(is_loaded_game == true) then
		return
	end

	--Copy the array to the working set
	local list_mech = {};
	list_mech = q.list_mech;

	
	-- add a echo mech on a new save
	local number_of_items = q.number_of_items + 1;
	local obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	local added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	variable_global_get("echo_mech_index");
	added_mech.mech_name = 		"EchoTest"
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	0;

	-- add a behemoth mech on a new save
	number_of_items = number_of_items + 1;
	obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	variable_global_get("behemoth_mech_index");
	added_mech.mech_name = 		"BehemothTest"
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	0;

	-- add a sentinel mech on a new save
	number_of_items = number_of_items + 1;
	obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	variable_global_get("sentinel_mech_index");
	added_mech.mech_name = 		"SentinelTest"
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	0;

	-- add a nova mech on a new save
	number_of_items = number_of_items + 1;
	obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	variable_global_get("nova_mech_index");
	added_mech.mech_name = 		"NovaTest"
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	0;


	--return new data
	q.list_mech = list_mech;
	q.number_of_items = number_of_items;
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