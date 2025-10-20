

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

	--add a nova mech on a new save
	AddMech(variable_global_get("nova_mech_index"), "NovaTest")
	--add a echo mech on a new save
	AddMech(variable_global_get("echo_mech_index"), "EchoTest")
	--add a sentinel mech on a new save
	AddMech(variable_global_get("sentinel_mech_index"), "SentinelTest")
	--add a behemoth mech on a new save
	AddMech(variable_global_get("behemoth_mech_index"), "BehemothTest")
end

---Adds a component of type mech
---@param mech_number number the index of the mech in the database.
---@param name string the name of the new mech.
function AddMech(mech_number, name)
	local obj_content_mechs = asset_get_index("obj_content_mechs");

	--Copy the array to the working set
	local list_mech = {};
	list_mech = obj_content_mechs.list_mech;

	local number_of_items = obj_content_mechs.number_of_items + 1;
	local obj_mech_item = asset_get_index("obj_mech_item");
	list_mech[number_of_items] = instance_create_depth(0, 0, 0, obj_mech_item);
	local added_mech = list_mech[number_of_items];
	added_mech.my_num = 		number_of_items - 1;
	added_mech.mech_number = 	mech_number;
	added_mech.mech_name = 		name
	added_mech.start_x = 		8;
	added_mech.start_y = 		266;
	added_mech.new_module = 	0;

	--return new data
	obj_content_mechs.list_mech = list_mech;
	obj_content_mechs.number_of_items = number_of_items;
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