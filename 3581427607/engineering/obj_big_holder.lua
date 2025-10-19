

-- construction table in the engineering menu
-- module's id is in "cur_item"
-- most submenus are inside obj_small_holder

function create(q,v_modid)--one time script when save is loaded
end

function save_mech(q)	--saves mech blueprint event. uses "data/f_mech_construction_slot"
end

function load_mech(q)	--loads mech blueprint event. uses "data/f_mech_construction_slot"
end

function activate_menu(q)	--inside mouse_check_button_pressed(mb_left)
end


function draw_mechs(q,cur_item)		--draws buttons and some info, cut_item contains id of the installed module
	if (cur_item ~= -4) then
		
	end
end

function draw_reactors(q,cur_item)		--draws buttons and some info, cut_item contains id of the installed module
end

local once = true;

function draw_weapons(q,cur_item)		--draws buttons and some info, cut_item contains id of the installed module
	if (cur_item ~= -4) then
		--cur_item.homing_power = 1.3;

		if(once == true) then
			--dump_struct_to_message(cur_item);
			once = false;
			return
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