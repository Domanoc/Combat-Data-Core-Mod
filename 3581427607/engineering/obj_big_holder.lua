--To prevent collisions of global variables between mods.
--I have prefixed global variables of this mod.
--If copying code please change the prefix to something unique for your mod.
local unique_mod_prefix = "CDC_";

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


function draw_mechs(q,cur_item)		--draws buttons and some info, cur_item contains id of the installed module
	--since we cant modify the range of laser weapons during the creation we need to update it when its used
	if (cur_item ~= -4) then
		if(cur_item.weapon_number == variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index")) then
			cur_item.blue_length = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_range");
		end
	end
end

function draw_reactors(q,cur_item)		--draws buttons and some info, cur_item contains id of the installed module
end

function draw_weapons(q,cur_item)		--draws buttons and some info, cur_item contains id of the installed module
	--since we cant modify the range of laser weapons during the creation we need to update it when its used
	if (cur_item ~= -4) then
		if(cur_item.weapon_number == variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_index")) then
			cur_item.blue_length = variable_global_get(unique_mod_prefix.."laser_pulse_cannon_weapon_range");
		end
	end
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