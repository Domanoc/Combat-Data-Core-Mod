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

--------------------------
--DEBUG HELPER FUNCTIONS--
--------------------------

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
---@param ref ds_map the reference to the ds_map
function Common.DsmapToMessage(ref)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\");
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline;
	local prefix = callerPrint.."\n".."##############".."\n";

	local values = {};
    for k, v in pairs(ds_map_keys_to_array(ref)) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(ref, v)));
    end
    local message = table.concat(values, ",\n");
	show_message(prefix..message);
end

---A debug helper function:
---Prints a message box with the key and values of the gamemaker struct as a field definitions 
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
		for _, v in pairs(struct_get_names(ref)) do
			table.insert(values, "---@field "..tostring(v).." "..type(ref[v]));
		end
		local message = table.concat(values, "\n");
		show_message(prefix..message);
	end
end

return Common;