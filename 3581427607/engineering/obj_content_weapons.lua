--[[
Growable structure and array for LUA scripts to use within the current object
st_lua=
{
	a_st:10
};
array_lua[0]=5;
array_lua[1]=9;
]]

--		v_array[v_items_num-1]=instance_create_depth(0,0,0,v_index);
--        v_index=v_array[v_items_num];								--get id of the object, to change values in it
--		v_index.my_num=v_items_num-1;

function create(q)--one time script when save is loaded
	--getting global value to create weapon at the start of a new save
	local v_load = variable_global_get("mech_engineer_load");
	if (v_load == false) then
		-- Replace two missile launchers with autocannons instead, to prevent my mod from giving players too many free resources.
		local v_items_num = q.number_of_items;
		v_array = {};									--create table
		v_array = q.list_weapon;						--12 is the last position, but we are using 13 instead of 12 because lua starts tables with 1, not 0
		
		local v_index = asset_get_index("obj_weapon_item");
		v_index = v_array[6];												--get id of the object, to change values in it
		v_index.my_num = 5;													--last weapon in the list
		v_index.weapon_number = variable_global_get("long_laser_num");		--position in list from obj_database
		v_index.start_x = 8;
		v_index.start_y = 266;
		
		local v_index = asset_get_index("obj_weapon_item");
		v_index = v_array[7];												--get id of the object, to change values in it
		v_index.my_num = 6;													--last weapon in the list
		v_index.weapon_number = variable_global_get("mining_laser_num");	--position in list from obj_database
		v_index.start_x = 8;
		v_index.start_y = 266;
		
		q.number_of_items = v_items_num;
		q.list_weapon = v_array;			--send array back
	end
		

end