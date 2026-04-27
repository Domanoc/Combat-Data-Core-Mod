------------------------------------------------------------------------------
--- COMMON FUNCTIONS ---------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Common functions.
---@class ModFrameworkCommon
local Common = {}

---Access to the private functions in this file.
---@class ModFrameworkCommonPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Generates Localization files based on the values requested by the registered components
function Common.GenerateLocalizationFiles()
	Storage.GenerateLocalization = true

	Common.ShowMessage("Now generating localization files, dont forget to remove this before releasing your mod.")
end

---Gets the filepath to the mod folder
---@param name string the name of the mod folder
---@return string? filepath the filepath to the mod folder or nil if the mod was not found
function Common.GetModPath(name)
	for _, mod in pairs(Storage.ModRegistrations) do
		if (mod.Name == name) then
			return mod.Path
		end
	end

	Common.DumpObjToMessage(Storage.ModRegistrations)
	return nil
end

---Checks if this is a game loaded from a save. 
---@return boolean isLoadedGame true if this is a game loaded from a save, false otherwise.
function Common.IsLoadedGame()
	return variable_global_get("mech_engineer_load")
end

---Selects the string based on the games current language setting,
---When not found will default to english,
---When english is not found will default to the first value
---When no values where provided will return a error value
---@param localizedStrings LocalizedString[] the localized strings dataset
---@return string
function Common.SelectCorrectLocalizedString(localizedStrings)
	local englishValue = nil

	--Find the correct language
	for _, localizedString in pairs(localizedStrings) do
		if (localizedString.LanguageFile == Storage.SelectedLanguage) then
			return localizedString.Value
		end

		if (localizedString.LanguageFile == "loc_english.ini") then
			englishValue = localizedString.Value
		end
	end

	--if not found fall back to english
	if (englishValue ~= nil) then
		return englishValue
	end

	--if not found fall back to the first value
	local firstValue = localizedStrings[1]
	if (firstValue ~= nil) then
		return firstValue.Value
	end

	--return an error message
	return "failed to find localized string"
end

---Gets the phrase number for a given voice
---@param voice PilotVoices the voice type
---@return number phraseNumber the corresponding phrase number 
function Common.GetPhraseNumber(voice)
    local obj_database = Common.GetObjDatabase();

    for _, pilot in pairs(obj_database.pilot_stat) do
        local soundIndex = ds_map_find_value(pilot, "sound_index")
        if (soundIndex == voice) then
            return ds_map_find_value(pilot, "phrase_num")
        end
    end

    local default = obj_database.pilot_stat[1]
    return ds_map_find_value(default, "phrase_num")
end

---Get the index for a pilot template
---@param name string the name for the pilot template to look for
---@return number? index the index if found nil otherwise
function Common.GetPilotTemplateIndex(name)
	local obj_database = Common.GetObjDatabase();

    for index, pilot in pairs(obj_database.pilot_stat) do
        local templateName = ds_map_find_value(pilot, "name")
        if (templateName == name) then
            return index
        end
    end

	return nil
end

------------------------------------------------------------------------------
--- FRAMEWORK OBJECT GETTERS -------------------------------------------------
------------------------------------------------------------------------------

---Gets the modded component
---@param name string the name of the component
---@param type ComponentType the type of component
---@return ModdedComponent? item the modded component if found, nil otherwise
function Common.GetModdedComponent(name, type)
	for _, moddedComponent in ipairs(Storage.ModdedComponentList) do
		if (moddedComponent.Name == name and moddedComponent.ComponentType == type) then
			return moddedComponent
		end
	end
	return nil
end

---Gets the modded components based on the search criteria
---@param searchCriteria ModdedComponentSearchCriteria[] the components to search for
---@return ModdedComponent[] components the components found, or and empty list
function Common.GetModdedComponents(searchCriteria)
	---@type ModdedComponent[]
	local foundComponents = {}

	for _, search in ipairs(searchCriteria) do
		local component = Common.GetModdedComponent(search.Name, search.ComponentType)
		if(component ~= nil) then
			table.insert(foundComponents, component)
		end
	end

	return foundComponents
end

---Gets the modded research item
---@param name string the name of the research item
---@return ModdedResearch? item the modded research item if found, nil otherwise
function Common.GetModdedResearch(name)
	for _, moddedComponent in ipairs(Storage.ModdedResearchList) do
		if (moddedComponent.Name == name) then
			return moddedComponent
		end
	end
	return nil
end

------------------------------------------------------------------------------
--- GAME OBJECT GETTERS ------------------------------------------------------
------------------------------------------------------------------------------

---Gets the reference for "obj_database"
---@return game_obj_database obj_database the reference for "obj_database"
function Common.GetObjDatabase()
	return asset_get_index("obj_database")
end

---Gets the reference for "obj_component_shop"
---@return game_obj_component_shop obj_component_shop the reference for "obj_component_shop"
function Common.GetObjComponentShop()
	return asset_get_index("obj_component_shop")
end

---Gets the reference for "obj_component"
---@return game_obj_component obj_component the reference for "obj_component"
function Common.GetObjComponent()
	return asset_get_index("obj_component")
end

---Gets the reference for "obj_weapon_test"
---@return game_obj_weapon_test obj_weapon_test the reference for "obj_weapon_test"
function Common.GetObjWeaponTest()
	return asset_get_index("obj_weapon_test")
end

---Gets the reference for "obj_research_panel"
---@return game_obj_research_panel obj_research_panel the reference for "obj_research_panel"
function Common.GetObjResearchPanel()
	return asset_get_index("obj_research_panel")
end

---Gets the reference for "obj_content_cabins"
---@return game_obj_content_cabins obj_content_cabins the reference for "obj_content_cabins"
function Common.GetObjContentCabins()
	return asset_get_index("obj_content_cabins")
end

---Gets the reference for "obj_content_motors"
---@return game_obj_content_motors obj_content_motors the reference for "obj_content_motors"
function Common.GetObjContentMotors()
	return asset_get_index("obj_content_motors")
end

---Gets the reference for "obj_content_mechs"
---@return game_obj_content_mechs obj_content_mechs the reference for "obj_content_mechs"
function Common.GetObjContentMechs()
	return asset_get_index("obj_content_mechs")
end

---Gets the reference for "obj_content_weapons"
---@return game_obj_content_weapons obj_content_weapons the reference for "obj_content_weapons"
function Common.GetObjContentWeapons()
	return asset_get_index("obj_content_weapons")
end

---Gets the reference for "obj_content_reactor"
---@return game_obj_content_reactor obj_content_reactor the reference for "obj_content_reactor"
function Common.GetObjContentReactor()
	return asset_get_index("obj_content_reactor")
end

---Gets the reference for "obj_content_piston"
---@return game_obj_content_piston obj_content_piston the reference for "obj_content_piston"
function Common.GetObjContentPiston()
	return asset_get_index("obj_content_piston")
end

---Gets the reference for "obj_content_injector"
---@return game_obj_content_injector obj_content_injector the reference for "obj_content_injector"
function Common.GetObjContentInjector()
	return asset_get_index("obj_content_injector")
end

---Gets the reference for "obj_content_kernel"
---@return game_obj_content_kernel obj_content_kernel the reference for "obj_content_kernel"
function Common.GetObjContentKernel()
	return asset_get_index("obj_content_kernel")
end

---Gets the reference for "obj_content_safety"
---@return game_obj_content_safety obj_content_safety the reference for "obj_content_safety"
function Common.GetObjContentSafety()
	return asset_get_index("obj_content_safety")
end

---Gets the reference for "obj_content_magnet"
---@return game_obj_content_magnet obj_content_magnet the reference for "obj_content_magnet"
function Common.GetObjContentMagnet()
	return asset_get_index("obj_content_magnet")
end

---Gets the reference for "obj_content_solenoid"
---@return game_obj_content_solenoid obj_content_solenoid the reference for "obj_content_solenoid"
function Common.GetObjContentSolenoid()
	return asset_get_index("obj_content_solenoid")
end

---Gets the reference for "obj_content_pilots"
---@return game_obj_content_pilots obj_content_pilots the reference for "obj_content_pilots"
function Common.GetObjContentPilots()
	return asset_get_index("obj_content_pilots")
end

------------------------------------------------------------------------------
--- SPRITE FUNCTION WRAPPERS -------------------------------------------------
------------------------------------------------------------------------------

---With this function you can add an image as a sprite, loading it from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg
---
---Use this instead of calling sprite_add directly to prevent crashes when incorrect sprite data is passed.
---@param filepath string The filepath of the file to add.
---@param numberOfImages number Use to indicate the number of sub-images
---@param removeback boolean Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges if transparent.
---@param xOrig number Indicate the x position of the origin in the sprite.
---@param yOrig number Indicate the y position of the origin in the sprite.
---@return number spriteIndex the index for the loaded sprite 
function Common.AddSprite(filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
	local imageIndex = sprite_add(filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
	if(imageIndex < 0) then
		local message = "The sprite loading from path: '"..filepath.."' failed.\n\n"
		message = message.."Make sure the filepath of the sprite is correct."
		Common.ShowError(message)
	end
	return imageIndex
end

---This function will merge the sprite indexed in "secondSpriteIndex" with that which is indexed in "firstSpriteIndex". 
---The images themselves are NOT merged together, but rather the image indices are merged, 
---with the sub images from sprite "secondSpriteIndex" appended onto those of sprite "firstSpriteIndex", ie: they are added on at the end. Note that if the sprites are different sizes, 
---then the appended sprites are stretched to fit the image size for "firstSpriteIndex".
---
---Use this instead of calling sprite_merge directly to prevent crashes when incorrect sprite data is passed.
---@param firstSpriteIndex number the index for the sprite to merge
---@param secondSpriteIndex number the index for the sprite to merge
function Common.MergeSprite(firstSpriteIndex, secondSpriteIndex)
	if(firstSpriteIndex < 0) then
		local message = "Cannot merge sprites the first sprite index provided was not referencing a sprite.\n\n"
		message = message.."Make sure the filepath of the sprite is correct."
		Common.ShowError(message)
	end
	if(secondSpriteIndex < 0) then
		local message = "Cannot merge sprites the second sprite index provided was not referencing a sprite.\n\n"
		message = message.."Make sure the filepath of the sprite is correct."
		Common.ShowError(message)
	end
	if (firstSpriteIndex < 0 or secondSpriteIndex < 0) then
		return
	end
	sprite_merge(firstSpriteIndex, secondSpriteIndex)
end

---This function will delete a sprite from the game, freeing any memory that was reserved for it.
---
---Use this instead of calling sprite_delete directly to prevent crashes when incorrect sprite data is passed.
---@param spriteIndex number the index for the sprite to delete
function Common.DeleteSprite(spriteIndex)
	if(spriteIndex < 0) then
		local message = "Cannot delete the sprite the index provided was not referencing a sprite."
		Common.ShowError(message)
		return
	end
	sprite_delete(spriteIndex)
end

---With this function you can replace a sprite with a new image, loading from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg
---
---Use this instead of calling sprite_replace directly to prevent crashes when incorrect sprite data is passed.
---@param spriteIndex number the index for the sprite that will be replaced 
---@param filepath string The filepath of the file to add.
---@param numberOfImages number Use to indicate the number of sub-images
---@param removeback boolean Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent.
---@param smooth boolean Indicates whether to smooth the edges if transparent.
---@param xOrig number Indicate the x position of the origin in the sprite.
---@param yOrig number Indicate the y position of the origin in the sprite.
function Common.ReplaceSprite(spriteIndex, filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
	local srpiteName = sprite_get_name(spriteIndex)
	if(srpiteName == "<undefined>") then
		local message = "Replacing the sprite with index: '"..spriteIndex.."' failed.\n\n"
		message = message.."Make sure the index of the sprite is correct."
		Common.ShowError(message)
		return
	end
	sprite_replace(spriteIndex, filepath, numberOfImages, removeback, smooth, xOrig, yOrig)
end

------------------------------------------------------------------------------
--- DEBUG HELPER FUNCTIONS ---------------------------------------------------
------------------------------------------------------------------------------

---A spacerLine for the print functions
local spacerLine = "\n###################################################\n"

---A debug helper function:
---Prints a message box with the value
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param value string|number the value to show
function Common.ShowMessage(value)
	local prefix = "MOD FRAMEWORK MESSAGE"..spacerLine
	local suffix = "\n"..Private.Traceback(3)
	show_message(prefix..tostring(value)..suffix)
end

---A debug helper function:
---Prints a message box with the error message
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param message string the error message to show
function Common.ShowError(message)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\")
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
	local prefix = "MOD FRAMEWORK ERROR"..spacerLine
	local suffix = spacerLine..callerPrint..spacerLine..debug.traceback("Error", 2).."\n\n"
	show_message(prefix..message..suffix)
end

---A debug helper function:
---Prints a message box with the key and values of the gamemaker struct or table
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference or table reference
function Common.DumpObjToMessage(ref)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\")
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
	local prefix = callerPrint..spacerLine
	local values = {}

	if(ref == nil) then
		local message = "This is a nil value"
		show_message(prefix..message)
		return
	end

	if(type(ref) == "string") then
		show_message(prefix..ref)
		return
	end

	if(type(ref) == "boolean") then
		show_message(prefix..tostring(ref))
		return
	end

	if(type(ref) == "table") then
		prefix = prefix.."TABLE"..spacerLine
		local keys = {}
		for k in pairs(ref) do
			table.insert(keys, k)
		end
		table.sort(keys)
		for _, key in ipairs(keys) do
			local refValue = ref[key]
			local refValueString = tostring(refValue)
			if (type(refValue) == "table") then
				refValueString = Private.TableToString(refValue)
			end
			table.insert(values, tostring(key).."::"..refValueString)
		end
		local message = table.concat(values, ",\n")
		show_message(prefix..message)
		return
	end

	prefix = prefix.."GAMEMAKER STRUCT"..spacerLine
	local sortedKeyNames = struct_get_names(ref)
	table.sort(sortedKeyNames)
	for key, keyName in pairs(sortedKeyNames) do
		local refValueString = tostring(ref[keyName])
		if (type(ref[keyName]) == "table") then
			refValueString = Private.TableToString(ref[keyName])
		end
		table.insert(values, tostring(key).."::"..tostring(keyName).."::"..refValueString)
	end
	local message = table.concat(values, ",\n")
	show_message(prefix..message)
end

---Convert a table into a single line of key value pairs
---@param ref table the table to convert
---@return string value the string value with key value pairs, truncated to 120 chars
function Private.TableToString(ref)
	local values = {}
	for key, refValue in pairs(ref) do
		table.insert(values, tostring(key).."="..tostring(refValue))
	end
	local value = table.concat(values, ", ")
	value = Private.Truncate(value, 120)
	return "TABLE:: { ".. value.." }"
end

---Truncate a string to a max lenght
---@param value string the string to truncate
---@param lenght number the max lenght
---@return string value returns the string truncated to the max lenght and adds ... if truncated
function Private.Truncate(value, lenght)
    if #value > lenght then
        return value:sub(1, lenght - 3).."..."
    end
    return value
end

---A debug helper function:
---Prints a messagebox with the key and values of the gamemaker ds_map
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ds_map ds_map the reference to the ds_map
function Common.DsmapToMessage(ds_map)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\")
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
	local prefix = callerPrint..spacerLine

	local values = {}
	local sortedKeyNames = ds_map_keys_to_array(ds_map)
	table.sort(sortedKeyNames)
    for k, v in pairs(sortedKeyNames) do
        table.insert(values, tostring(k).."::"..tostring(v).."::"..tostring(ds_map_find_value(ds_map, v)))
    end
    local message = table.concat(values, ",\n")
	show_message(prefix..message)
end

---A debug helper function:
---Prints a message box with the key and values of the gamemaker struct as a field definitions 
---This was used to convert gamemaker objects into a lua class definition
---The message box freezes the game for de duration it is opened allowing it to be used as a breakpoint for debugging
---The message box can be copied be selecting it and using ctrl+c and then dump in a text editor of choice
---@param ref any the Gamemaker struct reference
function Common.ToClassTypeMessage(ref)
	local info = debug.getinfo(2, "Sl")
	local caller = info.short_src:gsub("/","\\")
	local callerPrint = "Called from: " .. caller .. " line: " .. info.currentline
	local prefix = callerPrint..spacerLine

	local values = {}
	if(type(ref) == "table") then
		show_message(prefix.."Can't convert a table.")
	else
		table.insert(values, "---This is an auto generated class definition.")
		table.insert(values, "---")
		table.insert(values, "---Please use the found values as a starting point for your use.")
		table.insert(values, "---As not all values may be present at every point of the game.")
		table.insert(values, "---Or values could be missing from the definition.")
		table.insert(values, "---@class game_")

		local sortedKeyNames = struct_get_names(ref)
		table.sort(sortedKeyNames)
		for _, keyName in pairs(sortedKeyNames) do
			table.insert(values, "---@field "..tostring(keyName).." "..type(ref[keyName]))
		end
		local message = table.concat(values, "\n")
		show_message(prefix..message)
	end
end

---Gets a traceback suffix for a message
---@param level number? sets the level to any value more then 2 to skip util funcs
---@return string traceback the traceback suffix for a message
function Private.Traceback(level)
	if(level == nil or level < 2) then
		level = 2
	end
    local lines = {"Traceback:"}

    while true do
        local info = debug.getinfo(level, "nSl")
        if not info then break end

        table.insert(lines, string.format(
            ">> %s (%s:%d)",
            info.name or "anonymous",
            info.short_src:gsub("/","\\"):gsub("[\r\n]+", " "),
            info.currentline
        ))

        level = level + 1
    end

	local traceback = table.concat(lines, "\n")
    return spacerLine..traceback..spacerLine
end

------------------------------------------------------------------------------
--- EXPORT COMMON ------------------------------------------------------------
------------------------------------------------------------------------------

return Common