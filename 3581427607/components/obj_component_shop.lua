--production menu
	
function create(q)--one time script when save is loaded
	--The size of the enginering shop items is always 96 pixels (width & height)
	local icon_pixel_size = 96;

	-----------------
	--MECHS----------
	-----------------
	
	--Copy the array to the working set
	local v_comp_mech = {};
	v_comp_mech = q.comp_mech;

	-----------------
	--NOVA MECH------
	-----------------
	local v_array_size = #v_comp_mech;
	local v_mech_loc_x = v_array_size % 5;
	local v_mech_loc_y = v_array_size // 5;
	local nova_mech_num = variable_global_get("nova_mech_num");
	local v_index = asset_get_index("obj_component");

	variable_global_set("nova_comp_num", v_array_size + 1);
	v_index = instance_create_depth(q.mech_start_x + icon_pixel_size * v_mech_loc_x, q.mech_start_y + icon_pixel_size * v_mech_loc_y, -500, v_index);
	v_comp_mech[v_array_size + 1] = v_index;		--lua starts with 1
	v_index.comp_type = 1;							--mech
	v_index.comp_data_type = nova_mech_num;			--number in database
	v_index.logo = -4; 								--auto assign based on obj_database info
	v_index.size = 5;								--number of slots used in construction use 1 or 5
	v_index.researched = 0;							--1 for researched or 0 for not

	-----------------
	--ECHO MECH------
	-----------------
	v_array_size = #v_comp_mech;
	v_mech_loc_x = v_array_size % 5;
	v_mech_loc_y = v_array_size // 5;
	local echo_mech_num = variable_global_get("echo_mech_num");
	v_index = asset_get_index("obj_component");

	variable_global_set("echo_comp_num", v_array_size + 1);
	v_index = instance_create_depth(q.mech_start_x + icon_pixel_size * v_mech_loc_x, q.mech_start_y + icon_pixel_size * v_mech_loc_y, -500, v_index);
	v_comp_mech[v_array_size + 1] = v_index;		--lua starts with 1
	v_index.comp_type = 1;							--mech
	v_index.comp_data_type = echo_mech_num;			--number in database
	v_index.logo = -4; 								--auto assign based on obj_database info
	v_index.size = 5;								--number of slots used in construction use 1 or 5
	v_index.researched = 0;							--1 for researched or 0 for not

	-----------------
	--SENTINEL MECH--
	-----------------
	v_array_size = #v_comp_mech;
	v_mech_loc_x = v_array_size % 5;
	v_mech_loc_y = v_array_size // 5;
	local sentinel_mech_num = variable_global_get("sentinel_mech_num");
	v_index = asset_get_index("obj_component");

	variable_global_set("sentinel_comp_num", v_array_size + 1);
	v_index = instance_create_depth(q.mech_start_x + icon_pixel_size * v_mech_loc_x, q.mech_start_y + icon_pixel_size * v_mech_loc_y, -500, v_index);
	v_comp_mech[v_array_size + 1] = v_index;		--lua starts with 1
	v_index.comp_type = 1;							--mech
	v_index.comp_data_type = sentinel_mech_num;		--number in database
	v_index.logo = -4; 								--auto assign based on obj_database info
	v_index.size = 5;								--number of slots used in construction use 1 or 5
	v_index.researched = 0;							--1 for researched or 0 for not

	-----------------
	--BEHEMOTH MECH--
	-----------------
	v_array_size = #v_comp_mech;
	v_mech_loc_x = v_array_size % 5;
	v_mech_loc_y = v_array_size // 5;
	local behemoth_mech_num = variable_global_get("behemoth_mech_num");
	v_index = asset_get_index("obj_component");

	variable_global_set("behemoth_comp_num", v_array_size + 1);
	v_index = instance_create_depth(q.mech_start_x + icon_pixel_size * v_mech_loc_x, q.mech_start_y + icon_pixel_size * v_mech_loc_y, -500, v_index);
	v_comp_mech[v_array_size + 1] = v_index;		--lua starts with 1
	v_index.comp_type = 1;							--mech
	v_index.comp_data_type = behemoth_mech_num;		--number in database
	v_index.logo = -4; 								--auto assign based on obj_database info
	v_index.size = 5;								--number of slots used in construction use 1 or 5
	v_index.researched = 0;							--1 for researched or 0 for not	

	--send array back
	q.comp_mech = v_comp_mech;

	-----------------
	--SOLENOIDS------
	-----------------
	
	--Copy the array to the working set
	local v_comp_solenoid = {};
	v_comp_solenoid = q.comp_solenoid;

	----------------------
	--HIGH TECH SOLENOID--
	----------------------

	local row = 2; 		--row 3 as its a 0 based index
	local column = 6 	--column 7  as its a 0 based index
	local solenoid_num = variable_global_get("high_tech_solenoid_num");
	v_index = asset_get_index("obj_component");


	variable_global_set("high_tech_solenoid_comp_num", #v_comp_solenoid + 1);
	v_index = instance_create_depth(q.reactor_start_x + icon_pixel_size * column, q.reactor_start_y + icon_pixel_size * row, -500, v_index);
	v_comp_solenoid[#v_comp_solenoid + 1] = v_index;
	v_index.comp_type = 11;							--solenoid
	v_index.comp_data_type = solenoid_num;			--number in database
	v_index.logo = -4; 								--auto assign based on obj_database info
	v_index.size = 1;								--number of slots used in construction use 1 or 5
	v_index.researched = 0;							--1 for researched or 0 for not	

	--send array back
	q.comp_solenoid = v_comp_solenoid;
end


function update_prices(q)	--update information when item is picked, after example code
end

function done(q, i)	--if component is read. i=number of the hangar to check (from 1 to 10) to check. checking hanger_mass 2d massive. yes, it's misspelled
end

function draw_item_text(q, cut_item_type)	--draw when item is placed on the table to watch its stats
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