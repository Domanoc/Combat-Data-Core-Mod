--[[
Growable structure and array for LUA scripts to use within the current object
st_lua=
{
	a_st:10
};
array_lua[0]=5;
array_lua[1]=9;
]]

function create(q, v_modid)  --mod_info[] is global, v_modid can be accessed in any create event as a second argument

	--path to the current file
	local current_file_path = (mod_info[v_modid]):gsub("research/obj_research_panel.lua", "");
	--get the count of researches and increase it by 1
	local research_count = q.number_of_res;
	--Copy the array to the working set
	local research_array = {};
	research_array = q.mres;

	--Module identifiers
	local research_position = 1;
	local research_link_1 = 2;
	local research_link_2 = 3;
	local research_link_3 = 4;
	local research_condition = 5;
	local research_require_days = 6;
	local research_require_staff = 7;
	local research_type = 8;
	local research_subtybe = 9;
	local research_text = 10;
	

	--------------
	--DATA CORE --
	--------------
	research_count = research_count + 1
	--index for v_array, +1 because lua arrays start with 1
	local data_core_index = research_count + 1;

	variable_global_set("data_core_res_num", research_count);
	q.number_of_res = research_count;

	research_array[data_core_index][research_position] = 130; 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[data_core_index][research_link_1] = -4; 			--link 1;	--Link to open next research. Should contain number of the research from the array
	research_array[data_core_index][research_link_2] = -4; 			--link 2;	--
	research_array[data_core_index][research_link_3] = -4; 			--link 3;	--
	research_array[data_core_index][research_condition] = 2; 		--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[data_core_index][research_require_days] = 4; 	--require days
	research_array[data_core_index][research_require_staff] = 0; 	--require science staff
	research_array[data_core_index][research_type] = 1; 			--research type (0-combat, 1-production, 2-passability)
	research_array[data_core_index][research_subtybe] = 2; 			--research subtype (see left column in the game in research menu)
	research_array[data_core_index][research_text] = 				--research text
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

	variable_global_set("deep_data_core_res_num", research_count);
	q.number_of_res = research_count;
	
	research_array[deep_data_core_index][research_position] = 131; 			--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[deep_data_core_index][research_link_1] = -4; 			--link 1;	--Link to open next research. Should contain number of the research from the array
	research_array[deep_data_core_index][research_link_2] = -4; 			--link 2;	--
	research_array[deep_data_core_index][research_link_3] = -4; 			--link 3;	--
	research_array[deep_data_core_index][research_condition] = 0; 			--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[deep_data_core_index][research_require_days] = 18; 		--require days
	research_array[deep_data_core_index][research_require_staff] = 0; 		--require science staff
	research_array[deep_data_core_index][research_type] = 1; 				--research type (0-combat, 1-production, 2-passability)
	research_array[deep_data_core_index][research_subtybe] = 2; 			--research subtype (see left column in the game in research menu)
	research_array[deep_data_core_index][research_text] = 					--research text
		"DATA CORE:#The main AI is working on unlocking the next layer of the combat data core. When completed it grants additional research options.";
	research_array[data_core_index][research_link_1] = research_count;		--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
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

	variable_global_set("final_data_core_res_num", research_count);
	q.number_of_res = research_count;
	
	research_array[final_data_core_index][research_position] = 142; 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[final_data_core_index][research_link_1] = -4; 			--link 1;	--Link to open next research. Should contain number of the research from the array
	research_array[final_data_core_index][research_link_2] = -4; 			--link 2;	--
	research_array[final_data_core_index][research_link_3] = -4; 			--link 3;	--
	research_array[final_data_core_index][research_condition] = 0; 			--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[final_data_core_index][research_require_days] = 22; 		--require days
	research_array[final_data_core_index][research_require_staff] = 0; 		--require science staff
	research_array[final_data_core_index][research_type] = 1; 				--research type (0-combat, 1-production, 2-passability)
	research_array[final_data_core_index][research_subtybe] = 2; 			--research subtype (see left column in the game in research menu)
	research_array[final_data_core_index][research_text] = 					--research text
		"DATA CORE:#The main AI is working on unlocking the last layer of the combat data core. When completed it grants additional research options.";
	research_array[deep_data_core_index][research_link_1] = research_count;	--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
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

	variable_global_set("nova_res_num", research_count);
	q.number_of_res = research_count;
	
	research_array[nova_mech_index][research_position] = 140; 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[nova_mech_index][research_link_1] = -4; 			--link 1;	--Link to open next research. Should contain number of the research from the array
	research_array[nova_mech_index][research_link_2] = -4; 			--link 2;	--
	research_array[nova_mech_index][research_link_3] = -4; 			--link 3;	--
	research_array[nova_mech_index][research_condition] = 0; 		--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[nova_mech_index][research_require_days] = 4; 	--require days
	research_array[nova_mech_index][research_require_staff] = 120; 	--require science staff
	research_array[nova_mech_index][research_type] = 1; 			--research type (0-combat, 1-production, 2-passability)
	research_array[nova_mech_index][research_subtybe] = 1; 			--research subtype (see left column in the game in research menu)
	research_array[nova_mech_index][research_text] = 				--research text
		"NEW MECH: NOVA#2 guns, 2 armor, 15 impact resistance, 40 water resistance. A mass produced combat mech with decent stats";
	research_array[data_core_index][research_link_2] = research_count;	--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
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

	variable_global_set("sentinel_res_num", research_count);
	q.number_of_res = research_count;
	
	research_array[sentinel_mech_index][research_position] = 141; 		--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[sentinel_mech_index][research_link_1] = -4; 			--link 1;	--Link to open next research. Should contain number of the research from the array
	research_array[sentinel_mech_index][research_link_2] = -4; 			--link 2;	--
	research_array[sentinel_mech_index][research_link_3] = -4; 			--link 3;	--
	research_array[sentinel_mech_index][research_condition] = 0; 		--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[sentinel_mech_index][research_require_days] = 6; 	--require days
	research_array[sentinel_mech_index][research_require_staff] = 160; 	--require science staff
	research_array[sentinel_mech_index][research_type] = 1; 			--research type (0-combat, 1-production, 2-passability)
	research_array[sentinel_mech_index][research_subtybe] = 1; 			--research subtype (see left column in the game in research menu)
	research_array[sentinel_mech_index][research_text] = 				--research text
		"NEW MECH: SENTINEL#4 guns, 5 armor, 90 impact resistance, 80 water resistance. Armored assault mech with plenty of auxiliary slots.";
	research_array[deep_data_core_index][research_link_2] = research_count;	--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
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

	variable_global_set("behemoth_res_num", research_count);
	q.number_of_res = research_count;
	
	research_array[behemoth_mech_index][research_position] = 143; 				--position number on the research tree. You can see positions in the game with f6 (debug mode)
	research_array[behemoth_mech_index][research_link_1] = -4; 					--link 1;	--Link to open next research. Should contain number of the research from the array
	research_array[behemoth_mech_index][research_link_2] = -4; 					--link 2;	--
	research_array[behemoth_mech_index][research_link_3] = -4; 					--link 3;	--
	research_array[behemoth_mech_index][research_condition] = 0; 				--condition (0-closed, 1-opened, 2-researching, 3-researched)
	research_array[behemoth_mech_index][research_require_days] = 6; 			--require days
	research_array[behemoth_mech_index][research_require_staff] = 160; 			--require science staff
	research_array[behemoth_mech_index][research_type] = 1; 					--research type (0-combat, 1-production, 2-passability)
	research_array[behemoth_mech_index][research_subtybe] = 1; 					--research subtype (see left column in the game in research menu)
	research_array[behemoth_mech_index][research_text] = 						--research text
		"NEW MECH: BEHEMOTH#14 guns, 5 armor, 95 impact resistance, 95 water resistance. A massive armored assault mech with plenty of slots.";
	research_array[final_data_core_index][research_link_1] = research_count;	--set link from other research, add 1 to the research number shown in debug mode, as lua starts lists with 1. For the second number, use either link 1,2 or 3
	
	--add research sprite
	tmp_sprite = sprite_add(current_file_path.."sprites/behemoth_research.png", 0, false, false, 0, 0);	--research sprite
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
	

	--Use for debugging to set all to researching
	local debug = false;
	if(debug == true) then
		for i,v in ipairs(research_array) do
			research_array[i][research_condition] = 2;
			research_array[i][research_require_days] = 1;
		end
	end

	--send array back
	q.mres = research_array;				
end

function step(q)	--if activated = true

end

function draw(q)	--if activated = true
end