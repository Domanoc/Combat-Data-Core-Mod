--[[
Growable structure and array for LUA scripts to use within the current object
st_lua=
{
	a_st:10
};
array_lua[0]=5;
array_lua[1]=9;
]]

function create(q,v_modid) -- one time script when save is loaded
	local v_load = variable_global_get("mech_engineer_load");
	
	local debug = false;
	if(debug == false) then
		return
	end

	-- add in a behemoth mech on a new save
	if (v_load == false) then
		local v_list_mech = {};
		v_list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = v_list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("behemoth_mech_num");
		oo_id.mech_name = "BehemothTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = v_list_mech;
		q.number_of_items = v_content;
	end

	-- add in a sentinel mech on a new save
	if (v_load == false) then
		local v_list_mech = {};
		v_list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = v_list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("sentinel_mech_num");
		oo_id.mech_name = "SentinelTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = v_list_mech;
		q.number_of_items = v_content;
	end

	-- add in a nova mech on a new save
	if (v_load == false) then
		local v_list_mech = {};
		v_list_mech = q.list_mech;
		local v_content = q.number_of_items + 1;

		local v_index = asset_get_index("obj_mech_item");
		v_list_mech[v_content] = instance_create_depth(0,0,0,v_index);
		local oo_id = v_list_mech[v_content];
		oo_id.my_num = v_content - 1;
		oo_id.mech_number = variable_global_get("nova_mech_num");
		oo_id.mech_name = "NovaTest"
		oo_id.start_x = 8;
		oo_id.start_y = 266;
		oo_id.new_module = 0;

		q.list_mech = v_list_mech;
		q.number_of_items = v_content;
	end
end