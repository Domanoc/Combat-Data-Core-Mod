--To prevent collisions of global variables between mods.
--I have prefixed global variables of this mod.
--If copying code please change the prefix to something unique for your mod.
local unique_mod_prefix = "CDC_";

--Reseach index identifiers
local research = {
	position = 1, 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	link_1 = 2,			--link 1, Link to open the next research. Should contain the number of the research from the array
	link_2 = 3,			--link 2, Link to open the next research. Should contain the number of the research from the array
	link_3 = 4,			--link 3, Link to open the next research. Should contain the number of the research from the array
	condition = 5,		--condition (0-closed, 1-opened, 2-researching, 3-researched)
	required_days = 6,	--the required days to complete the research
	required_staff = 7,	--the required available staff to start the research
	icon_type = 8,		--research icon type (0-combat, 1-production, 2-passability)
	icon_subtype = 9, 	--research icon subtype (see left column in the game in research menu)
	description = 10	--the description text for the research
};

---@class research_item
---@field position number position number on the research tree. You can see positions in the game with f6 (debug mode)
---@field prerequisite_research number|-4 the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
---@field condition 0|1|2|3 condition (0-closed, 1-opened, 2-researching, 3-researched)
---@field required_days number the required days to complete the research
---@field required_staff number the required available staff to start the research
---@field icon_type 0|1|2 research icon type (0-combat, 1-production, 2-passability)
---@field icon_subtype number research icon subtype (see left column in the game in research menu)
---@field description string the description text for the research
---@field spritepath string path to the sprite used for the research
local research_item = {};


function create(q, v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("research/obj_research_panel.lua", "");

	--We store a list of all the researches we add so we can check them later.
	local modded_research_list = {};

	--Research conditions
	local research_conditions = {
		closed = 0,
		opened = 1,
		researching = 2,
		researched = 3
	};
	--Research icons
	local research_icons = {
		combat = 0,
		production = 1,
		passability = 2
	};

	-------------
	--DATA CORE--
	-------------
	local data_core_research_index = AddResearch({
		position = 130,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = -4,								--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.researching,			--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 4,										--the required days to complete the research
		required_staff = 0,										--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 2,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"DATA CORE:#The main AI is working on unlocking the combat data core. When completed it grants additional research options.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/data_core_research.png"
	});
	variable_global_set(unique_mod_prefix.."data_core_research_index", data_core_research_index);
	table.insert(modded_research_list, data_core_research_index);

	------------------
	--DEEP DATA CORE--
	------------------
	local deep_data_core_research_index = AddResearch({
		position = 131,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = data_core_research_index,		--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 18,										--the required days to complete the research
		required_staff = 0,										--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 2,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"DATA CORE:#The main AI is working on unlocking the next layer of the combat data core. When completed it grants additional research options.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/deep_data_core_research.png"
	});
	variable_global_set(unique_mod_prefix.."deep_data_core_research_index", deep_data_core_research_index);
	table.insert(modded_research_list, deep_data_core_research_index);

	-------------------
	--FINAL DATA CORE--
	-------------------
	local final_data_core_research_index = AddResearch({
		position = 142,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = deep_data_core_research_index,	--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 22,										--the required days to complete the research
		required_staff = 0,										--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 2,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"DATA CORE:#The main AI is working on unlocking the last layer of the combat data core. When completed it grants additional research options.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/final_data_core_research.png"
	});
	variable_global_set(unique_mod_prefix.."final_data_core_research_index", final_data_core_research_index);
	table.insert(modded_research_list, final_data_core_research_index);
	
	-----------------
	--NOVA MECH------
	-----------------
	local nova_research_index = AddResearch({
		position = 140,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = data_core_research_index,		--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 4,										--the required days to complete the research
		required_staff = 120,									--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 1,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"NEW MECH: NOVA#2 guns, 2 armor, 15 impact resistance, 40 water resistance. A mass produced combat mech with decent stats.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/nova_research.png"
	});
	variable_global_set(unique_mod_prefix.."nova_research_index", nova_research_index);
	table.insert(modded_research_list, nova_research_index);

	-----------------
	--SENTINEL MECH--
	-----------------
	local sentinel_research_index = AddResearch({
		position = 132,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = deep_data_core_research_index,	--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 6,										--the required days to complete the research
		required_staff = 160,									--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 1,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"NEW MECH: SENTINEL#4 guns, 5 armor, 90 impact resistance, 80 water resistance. Armored assault mech with plenty of auxiliary slots.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/sentinel_research.png"
	});
	variable_global_set(unique_mod_prefix.."sentinel_research_index", sentinel_research_index);
	table.insert(modded_research_list, sentinel_research_index);

	-----------------
	--BEHEMOTH MECH--
	-----------------
	local behemoth_research_index = AddResearch({
		position = 143,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = final_data_core_research_index,	--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 6,										--the required days to complete the research
		required_staff = 160,									--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 1,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"NEW MECH: BEHEMOTH#14 guns, 5 armor, 95 impact resistance, 95 water resistance. A massive armored assault mech with plenty of slots.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/behemoth_research.png"
	});
	variable_global_set(unique_mod_prefix.."behemoth_research_index", behemoth_research_index);
	table.insert(modded_research_list, behemoth_research_index);

	-----------------
	--ECHO MECH------
	-----------------
	local echo_research_index = AddResearch({
		position = 141,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = nova_research_index,			--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 6,										--the required days to complete the research
		required_staff = 120,									--the required available staff to start the research
		icon_type = research_icons.production,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 1,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"NEW MECH: ECHO#3 guns, 3 armor, 30 impact resistance, 20 water resistance. A armored mech with high mobility.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/echo_research.png"
	});
	variable_global_set(unique_mod_prefix.."echo_research_index", echo_research_index);
	table.insert(modded_research_list, echo_research_index);

	----------------------
	--HIGH TECH SOLENOID--
	----------------------
	local high_tech_solenoid_research_index = AddResearch({
		position = 133,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = final_data_core_research_index,	--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 2,										--the required days to complete the research
		required_staff = 120,									--the required available staff to start the research
		icon_type = research_icons.passability,					--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 5,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"HIGH TECH SOLENOID#Using advanced metallurgy processes we can create a better solenoid for our thermonuclear reactors. Granting them better cooling characteristics.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/high_tech_solenoid_research.png"
	});
	variable_global_set(unique_mod_prefix.."high_tech_solenoid_research_index", high_tech_solenoid_research_index);
	table.insert(modded_research_list, high_tech_solenoid_research_index);

	------------
	--HOWITZER--
	------------
	local howitzer_research_index = AddResearch({
		position = 120,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = data_core_research_index,		--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 2,										--the required days to complete the research
		required_staff = 40,									--the required available staff to start the research
		icon_type = research_icons.combat,						--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 0,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"HOWITZER#A large 240mm artillery weapon repurposed for use in direct fire.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/howitzer_research.png"
	});
	variable_global_set(unique_mod_prefix.."howitzer_research_index", howitzer_research_index);
	table.insert(modded_research_list, howitzer_research_index);

	----------------------
	--LASER PULSE CANNON--
	----------------------
	local laser_pulse_cannon_research_index = AddResearch({
		position = 144,											--position number on the research tree. You can see positions in the game with f6 (debug mode)
		prerequisite_research = final_data_core_research_index,	--the prerequisite research that unlocks this research, each research can only be the prerequisite for 3 other researches. leave -4 for no prerequisite.
		condition = research_conditions.closed,					--condition (0-closed, 1-opened, 2-researching, 3-researched)
		required_days = 8,										--the required days to complete the research
		required_staff = 160,									--the required available staff to start the research
		icon_type = research_icons.combat,						--research icon type (0-combat, 1-production, 2-passability)
		icon_subtype = 0,										--research icon subtype (see left column in the game in research menu)
		description = 											--the description text for the research
			"AUXILIARY POWER UNIT Able to provide portable power for high energy draw weapons without overloading the reactor connections. Enabling the production of the EXTENDED RANGE LASER PULSE CANNON.",
		spritepath = 											--path to the sprite used for the research
			current_file_path.."sprites/laser_pulse_cannon_research.png"
	});
	variable_global_set(unique_mod_prefix.."laser_pulse_cannon_research_index", laser_pulse_cannon_research_index);
	table.insert(modded_research_list, laser_pulse_cannon_research_index);

	--Save the modded list to a global
	variable_global_set(unique_mod_prefix.."modded_research_list", modded_research_list);

	--Use for debugging to set all to researching
	--Debug flag is set in "obj_database.lua"
	local debug_unlock_research = variable_global_get(unique_mod_prefix.."debug_unlock_research");
	if(debug_unlock_research == true) then
		--Copy the array to the working set
		local research_array = {};
		research_array = q.mres;

		for i,v in ipairs(research_array) do
			research_array[i][research.condition] = research_conditions.researching;
			research_array[i][research.required_days] = 1;
		end

		--send array back
		q.mres = research_array;
	end
end

function step(q)	--if activated = true
end

function draw(q)	--if activated = true
end

---comment
---@param item research_item
---@return unknown
function AddResearch(item)
	local obj_research_panel = asset_get_index("obj_research_panel");

	--Copy the array to the working set
	local research_array = {};
	research_array = obj_research_panel.mres;
	--get the count of researches and increase it by 1
	local research_count = obj_research_panel.number_of_res + 1;

	--index for the new item, +1 because lua arrays start with 1
	local research_item_index = research_count + 1;
	research_array[research_item_index][research.position] = item.position; 				--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[research_item_index][research.link_1] = -4; 								--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[research_item_index][research.link_2] = -4; 								--link 2;	--
	research_array[research_item_index][research.link_3] = -4; 								--link 3;	--
	research_array[research_item_index][research.condition] = item.condition;				--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[research_item_index][research.required_days] = item.required_days; 		--require days
	research_array[research_item_index][research.required_staff] = item.required_staff; 	--require science staff
	research_array[research_item_index][research.icon_type] = item.icon_type;				--research icon type (0-combat, 1-production, 2-passability)
	research_array[research_item_index][research.icon_subtype] = item.icon_subtype; 		--research icon subtype (see left column in the game in research menu)
	research_array[research_item_index][research.description] = item.description;			--research text
	
	if(item.prerequisite_research ~= -4) then
		local prerequisite_research = research_array[item.prerequisite_research + 1];		--offset the research_index to match the aqual index in the array
		if(prerequisite_research[research.link_1] == -4) then
			prerequisite_research[research.link_1] = research_count;
		elseif(prerequisite_research[research.link_2] == -4)  then
			prerequisite_research[research.link_2] = research_count;
		elseif(prerequisite_research[research.link_3] == -4)  then
			prerequisite_research[research.link_3] = research_count;
		else
			show_message("Mod error:\nTrying to set a prerequisite research to a research that already has 3 linked researches.\n\nDetails: error on research position:"..item.position);
		end
	end
	
	--add research sprite
	local tmp_sprite = sprite_add(item.spritepath, 0, false, false, 0, 0);		--research sprite
	local research_sprite_index = variable_global_get("research_items_spr");	--get the current sprite, we dont add the mod prefix here since it's a game variable
	local researh_sprites = -1;
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable, we dont add the mod prefix here since it's a game variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id

	--send array back
	obj_research_panel.mres = research_array;
	obj_research_panel.number_of_res = research_count;

	return research_item_index - 1; --the research index is 1 less than the aqual index in the array
end






--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

---Prints a messagebox with the key and values of the gamemaker struct or table
---provide the reference id to the table
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference or table reference
function dump_obj_to_message(ref)
	if(type(ref) == "table") then
		local values = {};
		for k, v in pairs(ref) do
			table.insert(values, tostring(k).."::"..tostring(v));
		end
		local message = table.concat(values, ",\n");
		show_message(message);
	else
		local values = {};
		for k, v in pairs(struct_get_names(ref)) do
			table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ref[v]));
		end
		local message = table.concat(values, ",\n");
		show_message(message);
	end
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