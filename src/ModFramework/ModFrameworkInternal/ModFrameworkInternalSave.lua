------------------------------------------------------------------------------
--- INTERNAL SAVE FUNCTIONS --------------------------------------------------
------------------------------------------------------------------------------

---Access to the functions for the Save.
---@class ModFrameworkInternalSave
local InternalSave = {}

---Access to the private functions in this file.
---@class ModFrameworkInternalSavePrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the json converter
local lunaJson = require("lunajson")
---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")
---Access to the Save functions.
local Save = require("ModFrameworkSave")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

InternalSave.RegisterBooleanSetting = Save.RegisterBooleanSetting

---Adds the mod setting data to the save file
function InternalSave.SaveData()
	local obj_content_hangar = Common.GetObjContentHanger()
	local json = lunaJson.encode(Storage.ModSettingData)
	ds_grid_set(obj_content_hangar.data_map_level, 0, 0, json)
end

---Loads the mod setting data from the save file back into storage
function InternalSave.LoadData()
	local obj_content_hangar = Common.GetObjContentHanger()
	local json = ds_grid_get(obj_content_hangar.data_map_level, 0, 0)
	local ok, jsonData = pcall(lunaJson.decode, json)
	if not ok then
		--We cannot parse the data so we will parse an empty set
		jsonData = {}
	end

	---@cast jsonData ModSettingDataJson[]
	Private.ParseModSettingData(jsonData)
	show_message(lunaJson.encode(Storage.ModSettingData))
end

---Parse the json data and set a valid dataset to storage.
---The result will be a mix of valid json data and the default values if needed.
---@param jsonData ModSettingDataJson[] The Json data that gets parsed.
function Private.ParseModSettingData(jsonData)
	---@type ModSettingData[]
	local parsedData = {}

	for _, defaults in ipairs(Storage.ModDefaultData) do
		local modName = defaults.ModName
		---@type ModSettingData
		local parsedModSetting = {
			ModName = modName,
			SettingsData = {}
		}

		local modData = Private.FindModInJsonData(modName, jsonData)
		if (modData ~= nil) then
			--When we find json data we apply the parsed data
			local parsedSettings = Private.ParseSettingDataJson(modData, defaults.DefaultSettingsData)
			parsedModSetting.SettingsData = parsedSettings
		else
			--When there is no json data we create a copy of the default values
			for _, default in ipairs(defaults.DefaultSettingsData) do
				---@type SettingData
				local setting = {
					SettingsName = default.SettingsName,
					SettingsValue = default.SettingsValue
				}
				table.insert(parsedModSetting.SettingsData, setting)
			end
		end

		--Add the setting to the return
		table.insert(parsedData, parsedModSetting)
	end

	Storage.ModSettingData = parsedData
end

---Parse the json setting data and return a valid setting dataset.
---@param jsonData SettingDataJson[] The Json data that gets parsed.
---@param defaults DefaultSettingData[] The default setting values.
---@return SettingData[] parsedData The parsed data for the settings, has the values from the json when valid, the defaults otherwise.
function Private.ParseSettingDataJson(jsonData, defaults)
	---@type SettingData[]
	local parsedData = {}

	for _, default in ipairs(defaults) do
		local settingName = default.SettingsName
		---@type SettingData
		local parsedSetting = {
			SettingsName = settingName,
			SettingsValue = default.SettingsValue
		}

		local jsonSetting = Private.FindSettingInJsonData(settingName, jsonData, default)
		if (jsonSetting ~= nil) then
			--A valid value was found so override the default value
			parsedSetting.SettingsValue = jsonSetting.SettingsValue
		end

		--Add the setting to the return
		table.insert(parsedData, parsedSetting)
	end

	--Return the updated defaults
	return parsedData
end

---Finds the settings data by mod name in the json data.
---@param name string The name of the mod.
---@param jsonData ModSettingDataJson[] The json data that will be searched.
---@return ModSettingDataJson? value The value if found, nil otherwise.
function Private.FindModInJsonData(name, jsonData)
	for _, value in ipairs(jsonData) do
		if (value.ModName == name) then
			return value
		end
	end
	return nil
end

---Finds the setting by name in the json data.
---@param name string The name of the setting.
---@param jsonData SettingDataJson[] The json data that will be searched.
---@param default DefaultSettingData The default data to compare against.
---@return SettingData? value The value if found, nil otherwise.
function Private.FindSettingInJsonData(name, jsonData, default)
	for _, jsonValue in ipairs(jsonData) do
		--TODO: Check if value is in an allowed range
		if (jsonValue.SettingsName == name and
			jsonValue.SettingsValue ~= nil and
			type(jsonValue.SettingsValue) == default.SettingType) then

			---@type SettingData SettingData
			local value = {
				SettingsName = jsonValue.SettingsName,
				SettingsValue = jsonValue.SettingsValue
			}
			return value
		end
	end
	return nil
end

------------------------------------------------------------------------------
--- EXPORT SAVE BATTLE -------------------------------------------------------
------------------------------------------------------------------------------

return InternalSave