--production menu
	
function create(q)--one time script when save is loaded
	local v_comp_mech = {};							--create table
	v_comp_mech = q.comp_mech;						--copy array, because we can't work with it directly.

	-----------------
	--NOVA MECH------
	-----------------
	local v_array_size = #v_comp_mech;
	local v_mech_loc_x = v_array_size % 5;
	local v_mech_loc_y = v_array_size // 5;
	local nova_mech_num = variable_global_get("nova_mech_num");
	local v_index = asset_get_index("obj_component");

	variable_global_set("nova_comp_num", v_array_size + 1);
	v_index = instance_create_depth(q.mech_start_x + 96 * v_mech_loc_x, q.mech_start_y + 96 * v_mech_loc_y, -500, v_index);
	v_comp_mech[v_array_size + 1] = v_index;		--lua starts with 1
	v_index.comp_type = 1;							--mech
	v_index.comp_data_type = nova_mech_num;			--number in database
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
	v_index = instance_create_depth(q.mech_start_x + 96 * v_mech_loc_x, q.mech_start_y + 96 * v_mech_loc_y, -500, v_index);
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
	v_index = instance_create_depth(q.mech_start_x + 96 * v_mech_loc_x, q.mech_start_y + 96 * v_mech_loc_y, -500, v_index);
	v_comp_mech[v_array_size + 1] = v_index;		--lua starts with 1
	v_index.comp_type = 1;							--mech
	v_index.comp_data_type = behemoth_mech_num;		--number in database
	v_index.logo = -4; 								--auto assign based on obj_database info
	v_index.size = 5;								--number of slots used in construction use 1 or 5
	v_index.researched = 0;							--1 for researched or 0 for not
	
	--send array back
	q.comp_mech = v_comp_mech;					
end


function update_prices(q)	--update information when item is picked, after example code
end

function done(q, i)	--if component is read. i=number of the hangar to check (from 1 to 10) to check. checking hanger_mass 2d massive. yes, it's misspelled
end

function draw_item_text(q, cut_item_type)	--draw when item is placed on the table to watch its stats
end