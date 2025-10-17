

function create(q, v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument
	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("research/obj_research_panel.lua", "");
	--get the count of researches and increase it by 1
	local research_count = q.number_of_res;
	--Copy the array to the working set
	local research_array = {};
	research_array = q.mres;

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

	--------------
	--DATA CORE --
	--------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local data_core_index = research_count + 1;

	variable_global_set("data_core_research_index", research_count);
	q.number_of_res = research_count;

	research_array[data_core_index][research.position] = 130; 								--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[data_core_index][research.link_1] = -4; 									--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[data_core_index][research.link_2] = -4; 									--link 2;	--
	research_array[data_core_index][research.link_3] = -4; 									--link 3;	--
	research_array[data_core_index][research.condition] = research_conditions.researching; 	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[data_core_index][research.required_days] = 4; 							--require days
	research_array[data_core_index][research.required_staff] = 0; 							--require science staff
	research_array[data_core_index][research.icon_type] = research_icons.production; 		--research icon type (0-combat, 1-production, 2-passability)
	research_array[data_core_index][research.icon_subtype] = 2; 							--research icon subtype (see left column in the game in research menu)
	research_array[data_core_index][research.description] = 								--research text
		"DATA CORE:#The main AI is working on unlocking the combat data core. When completed it grants additional research options.";
	
	--add research sprite
	local tmp_sprite = sprite_add(current_file_path.."sprites/data_core_research.png", 0, false, false, 0, 0);	--research sprite
	local research_sprite_index = variable_global_get("research_items_spr");
	local researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id

	-------------------
	--DEEP DATA CORE --
	-------------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local deep_data_core_index = research_count + 1;

	variable_global_set("deep_data_core_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[deep_data_core_index][research.position] = 131; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[deep_data_core_index][research.link_1] = -4; 							--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[deep_data_core_index][research.link_2] = -4; 							--link 2;	--
	research_array[deep_data_core_index][research.link_3] = -4; 							--link 3;	--
	research_array[deep_data_core_index][research.condition] = research_conditions.closed; 	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[deep_data_core_index][research.required_days] = 18; 						--require days
	research_array[deep_data_core_index][research.required_staff] = 0; 						--require science staff
	research_array[deep_data_core_index][research.icon_type] = research_icons.production;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[deep_data_core_index][research.icon_subtype] = 2; 						--research icon subtype (see left column in the game in research menu)
	research_array[deep_data_core_index][research.description] = 							--research text
		"DATA CORE:#The main AI is working on unlocking the next layer of the combat data core. When completed it grants additional research options.";
	research_array[data_core_index][research.link_1] = research_count;						--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/deep_data_core_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");		--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);								--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);				--update the sprite variable
	sprite_delete(tmp_sprite);	

	-------------------
	--FINAL DATA CORE --
	-------------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local final_data_core_index = research_count + 1;

	variable_global_set("final_data_core_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[final_data_core_index][research.position] = 142; 						--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[final_data_core_index][research.link_1] = -4; 							--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[final_data_core_index][research.link_2] = -4; 							--link 2;	--
	research_array[final_data_core_index][research.link_3] = -4; 							--link 3;	--
	research_array[final_data_core_index][research.condition] = research_conditions.closed;	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[final_data_core_index][research.required_days] = 22; 					--require days
	research_array[final_data_core_index][research.required_staff] = 0; 					--require science staff
	research_array[final_data_core_index][research.icon_type] = research_icons.production;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[final_data_core_index][research.icon_subtype] = 2; 						--research icon subtype (see left column in the game in research menu)
	research_array[final_data_core_index][research.description] = 							--research text
		"DATA CORE:#The main AI is working on unlocking the last layer of the combat data core. When completed it grants additional research options.";
	research_array[deep_data_core_index][research.link_1] = research_count;					--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/final_data_core_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");		--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);								--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);				--update the sprite variable
	sprite_delete(tmp_sprite);	

	-----------------
	--NOVA MECH------
	-----------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local nova_mech_index = research_count + 1;

	variable_global_set("nova_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[nova_mech_index][research.position] = 140; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[nova_mech_index][research.link_1] = -4; 								--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[nova_mech_index][research.link_2] = -4; 								--link 2;	--
	research_array[nova_mech_index][research.link_3] = -4; 								--link 3;	--
	research_array[nova_mech_index][research.condition] = research_conditions.closed; 	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[nova_mech_index][research.required_days] = 4; 						--require days
	research_array[nova_mech_index][research.required_staff] = 120; 					--require science staff
	research_array[nova_mech_index][research.icon_type] = research_icons.production;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[nova_mech_index][research.icon_subtype] = 1; 						--research icon subtype (see left column in the game in research menu)
	research_array[nova_mech_index][research.description] = 							--research text
		"NEW MECH: NOVA#2 guns, 2 armor, 15 impact resistance, 40 water resistance. A mass produced combat mech with decent stats";
	research_array[data_core_index][research.link_2] = research_count;					--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/nova_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");	--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id

	-----------------
	--SENTINEL MECH--
	-----------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local sentinel_mech_index = research_count + 1;

	variable_global_set("sentinel_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[sentinel_mech_index][research.position] = 132; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[sentinel_mech_index][research.link_1] = -4; 								--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[sentinel_mech_index][research.link_2] = -4; 								--link 2;	--
	research_array[sentinel_mech_index][research.link_3] = -4; 								--link 3;	--
	research_array[sentinel_mech_index][research.condition] = research_conditions.closed;	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[sentinel_mech_index][research.required_days] = 6; 						--require days
	research_array[sentinel_mech_index][research.required_staff] = 160; 					--require science staff
	research_array[sentinel_mech_index][research.icon_type] = research_icons.production;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[sentinel_mech_index][research.icon_subtype] = 1; 						--research icon subtype (see left column in the game in research menu)
	research_array[sentinel_mech_index][research.description] = 							--research text
		"NEW MECH: SENTINEL#4 guns, 5 armor, 90 impact resistance, 80 water resistance. Armored assault mech with plenty of auxiliary slots.";
	research_array[deep_data_core_index][research.link_2] = research_count;					--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/sentinel_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");	--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id

	-----------------
	--BEHEMOTH MECH--
	-----------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local behemoth_mech_index = research_count + 1;

	variable_global_set("behemoth_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[behemoth_mech_index][research.position] = 143; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[behemoth_mech_index][research.link_1] = -4; 								--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[behemoth_mech_index][research.link_2] = -4; 								--link 2;	--
	research_array[behemoth_mech_index][research.link_3] = -4; 								--link 3;	--
	research_array[behemoth_mech_index][research.condition] = research_conditions.closed;	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[behemoth_mech_index][research.required_days] = 6; 						--require days
	research_array[behemoth_mech_index][research.required_staff] = 160; 					--require science staff
	research_array[behemoth_mech_index][research.icon_type] = research_icons.production;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[behemoth_mech_index][research.icon_subtype] = 1; 						--research icon subtype (see left column in the game in research menu)
	research_array[behemoth_mech_index][research.description] = 							--research text
		"NEW MECH: BEHEMOTH#14 guns, 5 armor, 95 impact resistance, 95 water resistance. A massive armored assault mech with plenty of slots.";
	research_array[final_data_core_index][research.link_1] = research_count;				--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/behemoth_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");			--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id

	-----------------
	--ECHO MECH------
	-----------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local echo_mech_index = research_count + 1;

	variable_global_set("echo_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[echo_mech_index][research.position] = 141; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[echo_mech_index][research.link_1] = -4; 								--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[echo_mech_index][research.link_2] = -4; 								--link 2;	--
	research_array[echo_mech_index][research.link_3] = -4; 								--link 3;	--
	research_array[echo_mech_index][research.condition] = research_conditions.closed; 	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[echo_mech_index][research.required_days] = 6; 						--require days
	research_array[echo_mech_index][research.required_staff] = 120; 					--require science staff
	research_array[echo_mech_index][research.icon_type] = research_icons.production;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[echo_mech_index][research.icon_subtype] = 1; 						--research icon subtype (see left column in the game in research menu)
	research_array[echo_mech_index][research.description] = 							--research text
		"NEW MECH: ECHO#3 guns, 3 armor, 30 impact resistance, 20 water resistance. A armored mech with high mobility.";
	research_array[nova_mech_index][research.link_1] = research_count;					--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/echo_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");		--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id

	----------------------
	--HIGH TECH SOLENOID--
	----------------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local high_tech_solenoid_index = research_count + 1;

	variable_global_set("high_tech_solenoid_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[high_tech_solenoid_index][research.position] = 133; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[high_tech_solenoid_index][research.link_1] = -4; 							--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[high_tech_solenoid_index][research.link_2] = -4; 							--link 2;	--
	research_array[high_tech_solenoid_index][research.link_3] = -4; 							--link 3;	--
	research_array[high_tech_solenoid_index][research.condition] = research_conditions.closed;	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[high_tech_solenoid_index][research.required_days] = 2; 						--require days
	research_array[high_tech_solenoid_index][research.required_staff] = 120; 					--require science staff
	research_array[high_tech_solenoid_index][research.icon_type] = research_icons.passability;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[high_tech_solenoid_index][research.icon_subtype] = 5; 						--research icon subtype (see left column in the game in research menu)
	research_array[high_tech_solenoid_index][research.description] = 							--research text
		"HIGH TECH SOLENOID#Using advanced metallurgy processes we can create a better solenoid for our thermonuclear reactors. Granting them better cooling characteristics.";
	research_array[final_data_core_index][research.link_2] = research_count;					--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/high_tech_solenoid_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");		--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id
	
	------------
	--HOWITZER--
	------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local howitzer_research_index = research_count + 1;

	variable_global_set("howitzer_research_index", research_count);
	q.number_of_res = research_count;
	
	research_array[howitzer_research_index][research.position] = 120; 							--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[howitzer_research_index][research.link_1] = -4; 								--link 1;	--Link to open the next research. Should contain the number of the research from the array
	research_array[howitzer_research_index][research.link_2] = -4; 								--link 2;	--
	research_array[howitzer_research_index][research.link_3] = -4; 								--link 3;	--
	research_array[howitzer_research_index][research.condition] = research_conditions.closed;	--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[howitzer_research_index][research.required_days] = 2; 						--require days
	research_array[howitzer_research_index][research.required_staff] = 40; 						--require science staff
	research_array[howitzer_research_index][research.icon_type] = research_icons.passability;	--research icon type (0-combat, 1-production, 2-passability)
	research_array[howitzer_research_index][research.icon_subtype] = 5; 						--research icon subtype (see left column in the game in research menu)
	research_array[howitzer_research_index][research.description] = 							--research text
		"HOWITZER#A large 240mm artillery weapon repurposed for use in direct fire.";
	research_array[data_core_index][research.link_3] = research_count;							--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/howitzer_research.png", 0, false, false, 0, 0);	--research sprite
	research_sprite_index = variable_global_get("research_items_spr");		--get the current sprite
	researh_sprites = "";
    if (research_sprite_index ~= -4) then
    	researh_sprites = sprite_duplicate(research_sprite_index);
    else
        research_sprite_index = asset_get_index("spr_research_items");
        researh_sprites = sprite_duplicate(research_sprite_index);
    end
    sprite_merge(researh_sprites, tmp_sprite);							--adds to the end of the subimg
	variable_global_set("research_items_spr", researh_sprites);			--update the sprite variable
	sprite_delete(tmp_sprite);											--delete only tmp_sprite. researh_sprites still contains id


	--Use for debugging to set all to researching
	--Debug flag is set in "obj_database.lua"
	local debug_unlock_research = variable_global_get("debug_unlock_research");
	if(debug_unlock_research == true) then
		for i,v in ipairs(research_array) do
			research_array[i][research.condition] = research_conditions.researching;
			research_array[i][research.required_days] = 1;
		end
	end

	--send array back
	q.mres = research_array;				
end

function step(q)	--if activated = true

end

function draw(q)	--if activated = true
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