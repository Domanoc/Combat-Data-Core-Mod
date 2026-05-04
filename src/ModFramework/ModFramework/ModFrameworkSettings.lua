------------------------------------------------------------------------------
--- SETTINGS FUNCTIONS -------------------------------------------------------
------------------------------------------------------------------------------

---Access to the Settings functions.
---@type ModFrameworkSettings
local Settings = {}

---Access to the private functions in this file.
---@class ModFrameworkSettingsPrivate
local Private = {}

------------------------------------------------------------------------------

---Access to the Common functions.
local Common = require("ModFrameworkCommon")
---Access to the Storage of mod framework variables.
local Storage = require("ModFrameworkStorage")

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

---Register a boolean setting for the mod.
---
---Settings are stored per mod.
---Will override settings with the same name.
---@param settingsName string The name of the setting.
---@param default boolean The default value.
function Settings.RegisterBooleanSetting(settingsName, default)
	local modName = Common.GetModName()
	local defaults = Private.GetModDefaultSettings(modName)

	local settingsPath = Common.GetModSettingsPath()
	ini_open(settingsPath)
	local iniValue = ini_read_string("ModSettings", settingsName, tostring(default))
	ini_close()

	--Override the given default with the ini setting if present
	if (iniValue == "true") then
		default = true
	else
		default = false
	end

	if (defaults == nil) then
		---@type DefaultModSettingData
		local newDefaults = {
			ModName = modName,
			DefaultSettingsData = {
				{ SettingsName = settingsName, SettingsValue = default, SettingType = "boolean" }
			}
		}
		table.insert(Storage.ModDefaultData, newDefaults)

		Private.SetCurrentSettingsToDefaults()
		return
	end

	for _, setting in ipairs(defaults.DefaultSettingsData) do
		if (setting.SettingsName == settingsName) then
			setting.SettingsValue = default
			setting.SettingType = "boolean"

			Private.SetCurrentSettingsToDefaults()
			return
		end
	end

	---@type DefaultSettingData
	local newDefault = {
		SettingsName = settingsName,
		SettingsValue = default,
		SettingType = "boolean"
	}
	table.insert(defaults.DefaultSettingsData, newDefault)

	Private.SetCurrentSettingsToDefaults()
end

---Update a boolean setting value for the mod.
---@param settingsName string The name of the setting.
---@param value boolean The value to be set.
function Settings.UpdateBooleanSetting(settingsName, value)
	local modName = Common.GetModName()
	local settings = Private.GetModSettings(modName)
	if (settings == nil) then
		local message = "Trying to set a settings value to a mod setting but it failed.\n"
		message = message.."Check if the setting was correctly registered and of the same type. \n\n"
		message = message.."Debug info:\nMod: "..modName.."\nSetting name: "..settingsName.."\nType: "..type(value)
		Common.ShowError(message)
		return
	end

	for _, setting in ipairs(settings.SettingsData) do
		if (setting.SettingsName == settingsName and
			type(setting.SettingsValue) == type(value)) then
			setting.SettingsValue = value
			return
		end
	end

	local message = "Trying to set a settings value to a mod setting but it failed.\n"
	message = message.."Check if the setting was correctly registered and of the same type. \n\n"
	message = message.."Debug info:\nMod: "..modName.."\nSetting name: "..settingsName.."\nType: "..type(value)
	Common.ShowError(message)
end

---Get a boolean setting value for the mod.
---@param settingsName string The name of the setting.
---@return boolean value The value of the setting
function Settings.GetBooleanSettingValue(settingsName)
	local modName = Common.GetModName()
	local settings = Private.GetModSettings(modName)
	if (settings == nil) then
		local message = "Trying to get a settings value to a mod setting but it failed.\n"
		message = message.."Check if the setting was correctly registered and of the same type. \n\n"
		message = message.."Debug info:\nMod: "..modName.."\nSetting name: "..settingsName..
		Common.ShowError(message)
		return false
	end

	for _, setting in ipairs(settings.SettingsData) do
		if (setting.SettingsName == settingsName and
			type(setting.SettingsValue) == "boolean") then
			local value = setting.SettingsValue
			---@cast value boolean
			return value
		end
	end

	local message = "Trying to get a settings value to a mod setting but it failed.\n"
	message = message.."Check if the setting was correctly registered and of the same type. \n\n"
	message = message.."Debug info:\nMod: "..modName.."\nSetting name: "..settingsName..
	Common.ShowError(message)
	return false
end

---Gets the mod default settings.
---@param modName string The mod name to look for.
---@return DefaultModSettingData? value The value if found, nil otherwise.
function Private.GetModDefaultSettings(modName)
	for _, value in ipairs(Storage.ModDefaultData) do
		if (value.ModName == modName) then
			return value
		end
	end

	return nil
end

---Gets the current mod settings.
---@param modName string The mod name to look for.
---@return ModSettingData? value The value if found, nil otherwise.
function Private.GetModSettings(modName)
	for _, value in ipairs(Storage.ModSettingData) do
		if (value.ModName == modName) then
			return value
		end
	end

	return nil
end

---Sets the current mod settings to the default values.
---Only works for new games as the default set is handled by the save parser instead.
function Private.SetCurrentSettingsToDefaults()
	if (Common.IsLoadedGame() == true) then
		return
	end

	--Clear data
	Storage.ModSettingData = {}

	for _, defaults in ipairs(Storage.ModDefaultData) do
		---@type ModSettingData
		local modSetting = {
			ModName = defaults.ModName,
			SettingsData = {}
		}

		for _, default in ipairs(defaults.DefaultSettingsData) do
			---@type SettingData
			local setting = {
				SettingsName = default.SettingsName,
				SettingsValue = default.SettingsValue
			}
			table.insert(modSetting.SettingsData, setting)
		end
		table.insert(Storage.ModSettingData, modSetting)
	end
end

------------------------------------------------------------------------------
--- EXPORT SETTINGS ----------------------------------------------------------
------------------------------------------------------------------------------

return Settings