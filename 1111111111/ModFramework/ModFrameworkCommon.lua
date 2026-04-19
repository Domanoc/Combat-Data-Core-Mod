--------------------------
--COMMON------------------
--------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage");

---Access to the Common functions.
local Common = {};

---Checks if this is a game loaded from a save. 
---@return boolean isLoadedGame true if this is a game loaded from a save, false otherwise.
function Common.IsLoadedGame()
	return variable_global_get("mech_engineer_load");
end

---Gets the modded component
---@param name string the name of the component
---@param type 1|2|3|4|5|6|7|8|9|10|11|95|96|97|98|99 the type of component
---@return modded_component|nil item the modded component if found, nil otherwise
function Common.GetModdedComponent(name, type)
	for _, moddedComponent in ipairs(Storage.ModdedComponentList) do
		if (moddedComponent.name == name and moddedComponent.component_type == type) then
			return moddedComponent;
		end
	end
	return nil;
end

---Gets the modded components bases on the search criteria
---@param searchCriteria component_search_criteria[] the components to search for
---@return modded_component[] components the components found, or and empty list
function Common.GetModdedComponents(searchCriteria)
	---@type modded_component[]
	local foundComponents = {};

	for _, search in ipairs(searchCriteria) do
		local component = Common.GetModdedComponent(search.Name, search.ComponentType);
		if(component ~= nil) then
			table.insert(foundComponents, component);
		end
	end

	return foundComponents;
end

---Gets the modded research item
---@param name string the name of the research item
---@return modded_research_item|nil item the modded research item if found, nil otherwise
function Common.GetModdedResearch(name)
	for _, moddedComponent in ipairs(Storage.ModdedResearchList) do
		if (moddedComponent.name == name) then
			return moddedComponent;
		end
	end
	return nil;
end

---Gets the reference for "obj_database"
---@return game_obj_database obj_database the reference for "obj_database"
function Common.GetObjDatabase()
	return asset_get_index("obj_database");
end

---Gets the reference for "obj_component_shop"
---@return game_obj_component_shop obj_component_shop the reference for "obj_component_shop"
function Common.GetObjComponentShop()
	return asset_get_index("obj_component_shop");
end

---Gets the reference for "obj_weapon_test"
---@return game_obj_weapon_test obj_weapon_test the reference for "obj_weapon_test"
function Common.GetObjWeaponTest()
	return asset_get_index("obj_weapon_test");
end

---Gets the reference for "obj_research_panel"
---@return game_obj_research_panel obj_research_panel the reference for "obj_research_panel"
function Common.GetObjResearchPanel()
	return asset_get_index("obj_research_panel");
end

---Gets the reference for "obj_content_mechs"
---@return game_obj_content_mechs obj_content_mechs the reference for "obj_content_mechs"
function Common.GetObjContentMechs()
	return asset_get_index("obj_content_mechs");
end

---Gets the reference for "obj_content_magnet"
---@return game_obj_content_magnet obj_content_magnet the reference for "obj_content_magnet"
function Common.GetObjContentMagnet()
	return asset_get_index("obj_content_magnet");
end

---Gets the reference for "obj_content_weapons"
---@return game_obj_content_weapons obj_content_weapons the reference for "obj_content_weapons"
function Common.GetObjContentWeapons()
	return asset_get_index("obj_content_weapons");
end

---Gets the reference for "obj_content_solenoid"
---@return game_obj_content_solenoid obj_content_solenoid the reference for "obj_content_solenoid"
function Common.GetObjContentSolenoid()
	return asset_get_index("obj_content_solenoid");
end

---Gets the reference for "obj_content_reactor"
---@return game_obj_content_reactor obj_content_reactor the reference for "obj_content_reactor"
function Common.GetObjContentReactor()
	return asset_get_index("obj_content_reactor");
end

---With this function you can add an image as a sprite, loading it from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg
---
---@param filepath string The filepath of the file to add.
---@param numberOfImages number Use to indicate the number of sub-images
---@param removeback boolean Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges if transparent.
---@param xOrig number Indicate the x position of the origin in the sprite.
---@param yOrig number Indicate the y position of the origin in the sprite.
---@return number spriteIndex the index for the loaded sprite 
function Common.AddSprite(filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
	local imageIndex = sprite_add(filepath, numberOfImages, removeback, smooth, xOrig, yOrig);
	if(imageIndex < 0) then
		local message = "The sprite loading from path: '"..filepath.."' failed.\n\n";
		message = message.."Make sure the filepath of the sprite is correct.";
		Common.ShowError(message);
	end
	return imageIndex;
end

---This function will merge the sprite indexed in "secondSpriteIndex" with that which is indexed in "firstSpriteIndex". 
---The images themselves are NOT merged together, but rather the image indices are merged, 
---with the sub images from sprite "secondSpriteIndex" appended onto those of sprite "firstSpriteIndex", ie: they are added on at the end. Note that if the sprites are different sizes, 
---then the appended sprites are stretched to fit the image size for "firstSpriteIndex".
---@param firstSpriteIndex number the index for the sprite to merge
---@param secondSpriteIndex number the index for the sprite to merge
function Common.MergeSprite(firstSpriteIndex, secondSpriteIndex)
	if(firstSpriteIndex < 0) then
		local message = "Cannot merge sprites the first sprite index provided was not referencing a sprite.\n\n";
		message = message.."Make sure the filepath of the sprite is correct.";
		Common.ShowError(message);
	end
	if(secondSpriteIndex < 0) then
		local message = "Cannot merge sprites the second sprite index provided was not referencing a sprite.\n\n";
		message = message.."Make sure the filepath of the sprite is correct.";
		Common.ShowError(message);
	end
	if (firstSpriteIndex < 0 or secondSpriteIndex < 0) then
		return;
	end
	sprite_merge(firstSpriteIndex, secondSpriteIndex);
end

---This function will delete a sprite from the game, freeing any memory that was reserved for it.
---@param spriteIndex number the index for the sprite to delete
function Common.DeleteSprite(spriteIndex)
	if(spriteIndex < 0) then
		local message = "Cannot delete the sprite the index provided was not referencing a sprite.";
		Common.ShowError(message);
		return;
	end
	sprite_delete(spriteIndex);
end


--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

---A debug helper function:
---Prints a message box with the value
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param value string|number the value to show
function Common.ShowMessage(value)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\");
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline;
	local prefix = callerPrint.."\n".."##############".."\n";
	show_message(prefix..tostring(value));
end

---A debug helper function:
---Prints a message box with the error message
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param message string the error message to show
function Common.ShowError(message)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\");
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline;
	local prefix = callerPrint.."\n##############\n";
	local suffix = "\n##############\n"..debug.traceback("Error", 2).."\n\n";
	show_message(prefix..message..suffix);
end

---A debug helper function:
---Prints a message box with the key and values of the gamemaker struct or table
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference or table reference
function Common.DumpObjToMessage(ref)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\");
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline;
	local prefix = callerPrint.."\n".."##############".."\n";
	local values = {};
	if(type(ref) == "table") then
		for k, v in pairs(ref) do
			table.insert(values, tostring(k).."::"..tostring(v));
		end
		local message = table.concat(values, ",\n");
		show_message(prefix..message);
	else
		for k, v in pairs(struct_get_names(ref)) do
			table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ref[v]));
		end
		local message = table.concat(values, ",\n");
		show_message(prefix..message);
	end
end

---A debug helper function:
---Prints a messagebox with the key and values of the gamemaker ds_map
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ds_map ds_map the reference to the ds_map
function Common.DsmapToMessage(ds_map)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\");
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline;
	local prefix = callerPrint.."\n".."##############".."\n";

	local values = {};
    for k, v in pairs(ds_map_keys_to_array(ds_map)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(ds_map, v)));
    end
    local message = table.concat(values, ",\n");
	show_message(prefix..message);
end

---A debug helper function:
---Prints a message box with the key and values of the gamemaker struct as a field definitions 
---This was used to convert gamemaker objects into a lua class definition
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference
function Common.ToClassTypeMessage(ref)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\");
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline;
	local prefix = callerPrint.."\n".."##############".."\n";

	local values = {};
	if(type(ref) == "table") then
		show_message(prefix.."Can't convert a table.");
	else
		table.insert(values, "---This is an auto generated class definition.");
		table.insert(values, "---");
		table.insert(values, "---Please use the found values as a starting point for your use.");
		table.insert(values, "---As not all values may be present at every point of the game.");
		table.insert(values, "---Or values could be missing from the definition.");
		table.insert(values, "---@class game_");
		for _, v in pairs(struct_get_names(ref)) do
			table.insert(values, "---@field "..tostring(v).." "..type(ref[v]));
		end
		local message = table.concat(values, "\n");
		show_message(prefix..message);
	end
end

return Common;